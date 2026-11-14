//! Tallies that move between threads. The parallel reader
//! ([`parallel_read`](crate::input::parallel_read)) tallies each part of a
//! large top-level array on a thread of its own, and appends the parts'
//! trees, in order, to the sample's tree on the thread that reads it. A
//! tree's string attributes hold `Rc`s, so a part's tree crosses threads
//! as a [`PortableTree`]: the same nodes, moved out of the part's tallies,
//! its keys and cases as ids into its own string table (which it brings
//! along), and the string attributes as plain values. [`Tallies::import`]
//! moves it into other tallies, mapping each id to the id of the same text
//! there: the result is the part's tree with the same texts, which
//! [`Tallies::merge`] then appends as it appends any other tree (see
//! `docs/STREAMING-INFERENCE.md`, "Reading on several threads").

use std::collections::VecDeque;
use std::mem::size_of;
use std::rc::Rc;

use indexmap::IndexMap;

use super::{KeyTally, KindOrder, Node, NodeId, ObjectTally, Tallies, alloc, map_size};
use crate::attributes::string_types::StringTypes;
use crate::attributes::type_attributes::{TypeAttributeValue, TypeAttributes};
use crate::attributes::uri_attributes::UriAttributes;
use crate::input::compressed_json::{Strings, vec_size};
use crate::messages::Result;
use crate::support::fast_hash::BuildHasher;
use crate::support::support::{defined, panic};

/// A tree of tallies that can move to another thread: see the module.
pub(crate) struct PortableTree {
    /// The text of its keys and cases, by the ids it knows them by.
    strings: Strings,
    /// Its nodes; the first is the root.
    nodes: Vec<PortableNode>,
    /// About how many bytes it holds.
    bytes: usize,
}

/// A [`Node`], with nodes as indexes into [`PortableTree::nodes`]: the
/// node's object tally, moved, with its keys' and `__proto__`'s nodes as
/// such indexes.
#[derive(Default)]
struct PortableNode {
    kinds: KindOrder,
    items: Option<u32>,
    strings: Option<PortableStrings>,
    object: Option<Box<ObjectTally>>,
}

/// A [`StringTally`](super::StringTally): its cases, moved, and its
/// attributes as plain values.
struct PortableStrings {
    cases: IndexMap<u32, u64, BuildHasher>,
    with_enums: Option<PortableAttributes>,
    without_enums: Option<PortableAttributes>,
    not_interned: bool,
    absorbed: [u32; 2],
}

/// String attributes as plain values, in order: string types and URI
/// attributes, the only kinds that strings add.
struct PortableAttributes(Vec<PortableAttribute>);

enum PortableAttribute {
    StringTypes(StringTypes),
    Uri(UriAttributes),
}

impl PortableAttributes {
    fn new(attributes: &TypeAttributes) -> Result<Self> {
        let mut values = Vec::with_capacity(attributes.len());
        for value in attributes.iter() {
            values.push(match value {
                TypeAttributeValue::StringTypes(st) => {
                    PortableAttribute::StringTypes((**st).clone())
                }
                TypeAttributeValue::UriAttributes(uri) => PortableAttribute::Uri((**uri).clone()),
                _ => return panic("A string tally with an attribute strings do not add"),
            });
        }
        Ok(PortableAttributes(values))
    }

    /// The attributes, equal to those made portable, kinds in their order.
    fn into_attributes(self) -> TypeAttributes {
        let mut attributes = TypeAttributes::new();
        for value in self.0 {
            attributes.insert(match value {
                PortableAttribute::StringTypes(st) => TypeAttributeValue::StringTypes(Rc::new(st)),
                PortableAttribute::Uri(uri) => TypeAttributeValue::UriAttributes(Rc::new(uri)),
            });
        }
        attributes
    }
}

impl PortableTree {
    /// The tree at `root` of `tallies`, whose keys and cases are ids into
    /// `strings`, moved out of them (only the few attribute sets are
    /// copied).
    pub(crate) fn new(mut tallies: Tallies, strings: Strings, root: NodeId) -> Result<Self> {
        let mut nodes = vec![PortableNode::default()];
        let mut pending = VecDeque::from([(root, 0usize)]);
        while let Some((id, at)) = pending.pop_front() {
            let node = std::mem::take(defined(tallies.nodes.get_mut(id as usize))?);
            // Each child gets the next index, filled in when it is reached.
            let mut place = |child: NodeId| {
                let index = nodes.len();
                nodes.push(PortableNode::default());
                pending.push_back((child, index));
                index as u32
            };
            let items = node.items.map(&mut place);
            let object = node.object.map(|mut o| {
                for key in o.keys.values_mut() {
                    key.node = place(key.node);
                }
                o.proto = o.proto.map(&mut place);
                o
            });
            let strings = match node.strings {
                Some(mut s) => Some(PortableStrings {
                    cases: std::mem::take(&mut s.cases),
                    with_enums: s
                        .with_enums
                        .as_ref()
                        .map(PortableAttributes::new)
                        .transpose()?,
                    without_enums: s
                        .without_enums
                        .as_ref()
                        .map(PortableAttributes::new)
                        .transpose()?,
                    not_interned: s.not_interned,
                    absorbed: s.absorbed,
                }),
                None => None,
            };
            nodes[at] = PortableNode {
                kinds: node.kinds,
                items,
                strings,
                object,
            };
        }
        let bytes = strings.heap_size()
            + vec_size(&nodes)
            + nodes
                .iter()
                .map(|n| {
                    n.strings.as_ref().map_or(0, |s| map_size(&s.cases))
                        + n.object.as_ref().map_or(0, |o| {
                            size_of::<ObjectTally>() + map_size(&o.keys) + vec_size(&o.proto_runs)
                        })
                })
                .sum::<usize>();
        Ok(PortableTree {
            strings,
            nodes,
            bytes,
        })
    }

    /// About how many bytes it holds (its buffers, not the few attribute
    /// sets of each place's strings).
    pub(crate) fn heap_size(&self) -> usize {
        self.bytes
    }
}

impl Tallies {
    /// Moves `tree` into these tallies, its keys and cases as ids into
    /// `strings` (whose texts it adds as needed); returns its root here.
    /// If this fails, the tallies are as they were (but for the texts
    /// added).
    pub(crate) fn import(&mut self, strings: &mut Strings, tree: PortableTree) -> Result<NodeId> {
        let mut nodes = Vec::with_capacity(tree.nodes.len());
        let imported = self.import_into(strings, tree, &mut nodes);
        if imported.is_err() {
            // Nothing refers to the nodes taken but each other: freed,
            // with whatever they were given.
            for id in nodes {
                self.nodes[id as usize] = Node::default();
                self.free.push(id);
            }
        }
        imported
    }

    /// [`import`](Self::import), with the nodes it takes in `nodes`.
    fn import_into(
        &mut self,
        strings: &mut Strings,
        tree: PortableTree,
        nodes: &mut Vec<NodeId>,
    ) -> Result<NodeId> {
        let PortableTree {
            strings: texts,
            nodes: portable,
            ..
        } = tree;
        // The ids of the tree's strings here, found once each.
        let mut ids = vec![u32::MAX; texts.len()];
        let mut id = |strings: &mut Strings, local: u32| -> Result<u32> {
            let slot = defined(ids.get_mut(local as usize))?;
            if *slot == u32::MAX {
                *slot = strings.intern_text(defined(texts.get(local as usize))?);
            }
            Ok(*slot)
        };
        // A node's children come after it: all nodes first.
        for _ in &portable {
            nodes.push(alloc(&mut self.nodes, &mut self.free)?);
        }
        let node = |index: u32| defined(nodes.get(index as usize)).copied();
        for (portable, &at) in portable.into_iter().zip(nodes.iter()) {
            let strings_tally = match portable.strings {
                Some(s) => {
                    let mut tally = self.spare_strings.pop().unwrap_or_default();
                    tally.cases.reserve(s.cases.len());
                    for (local, count) in s.cases {
                        tally.cases.insert(id(strings, local)?, count);
                    }
                    tally.with_enums = s.with_enums.map(PortableAttributes::into_attributes);
                    tally.without_enums = s.without_enums.map(PortableAttributes::into_attributes);
                    tally.not_interned = s.not_interned;
                    tally.absorbed = s.absorbed;
                    Some(tally)
                }
                None => None,
            };
            let object = match portable.object {
                Some(mut o) => {
                    let keys = std::mem::take(&mut o.keys);
                    o.keys = IndexMap::with_capacity_and_hasher(keys.len(), BuildHasher::default());
                    for (local, key) in keys {
                        let key = KeyTally {
                            count: key.count,
                            node: node(key.node)?,
                        };
                        o.keys.insert(id(strings, local)?, key);
                    }
                    o.proto = o.proto.map(node).transpose()?;
                    Some(o)
                }
                None => None,
            };
            self.nodes[at as usize] = Node {
                kinds: portable.kinds,
                items: portable.items.map(node).transpose()?,
                strings: strings_tally,
                object,
            };
        }
        defined(nodes.first().copied())
    }
}

#[cfg(test)]
impl PortableTree {
    /// Gives the last node with keys a key whose text is not in the
    /// tree's string table (for tests).
    fn break_last_key(&mut self) {
        let bad = self.strings.len() as u32 + 7;
        let object = self
            .nodes
            .iter_mut()
            .rev()
            .find_map(|n| n.object.as_mut().filter(|o| !o.keys.is_empty()))
            .unwrap();
        let (_, key) = object.keys.pop().unwrap();
        object.keys.insert(bad, key);
    }
}

/// Whether `object` is empty, as a spare object tally is.
#[cfg(test)]
fn is_empty(object: &super::ObjectTally) -> bool {
    object.count == 0
        && object.keys.is_empty()
        && object.proto_runs.is_empty()
        && object.proto.is_none()
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::date_time::DefaultDateTimeRecognizer;
    use crate::input::compressed_json::{CompressedJson, Framing};
    use crate::input::compressed_json_from_stream::parse_stream_into;
    use crate::input::tallies::{RunningTallies, TallyBuilder};

    fn config(handle_refs: bool) -> CompressedJson {
        CompressedJson::with_int64_range(Box::new(DefaultDateTimeRecognizer), handle_refs)
    }

    /// Reads `sample` into fresh tallies and makes its tree portable.
    fn portable(config: &CompressedJson, sample: &str) -> PortableTree {
        let mut part = RunningTallies::new();
        let tree = parse_stream_into(
            &mut TallyBuilder::new(&mut part, config),
            sample.as_bytes(),
            Framing::Value,
        )
        .expect("valid JSON");
        let RunningTallies {
            tallies, strings, ..
        } = part;
        PortableTree::new(tallies, strings, tree).unwrap()
    }

    const SAMPLES: [&str; 6] = [
        r##"{"a":[1,"x",1.5,"2020-01-01T00:00:00Z",null,true],"$ref":"#/a","u":"http://h/x.png","__proto__":"__proto__"}"##,
        r#"{"__proto__":[{"b":"0123"}],"e":{},"f":[[]],"g":"7","a":[{"b":"__proto__"}],"__proto__":{"p":1}}"#,
        r#"[{"b":{"e":true,"__proto__":[2]}},"http://h/x.PNG",{"a":[]},"6ba7b810-9dad-11d1-80b4-00c04fd430c8"]"#,
        r#"{"z":{"y":1},"a":[{"q":1.5}],"b":{"c":"s","__proto__":"t"},"d":"https://h/y.jpg","x":"x","x":2}"#,
        r#""long string, long string, long string, long string, long string, too""#,
        r##"{"$ref":"#/z","$ref":"2020-01-01","a":{"$ref":"https://h/r"},"c":"false","t":"12:00:00Z"}"##,
    ];

    /// Samples with places whose strings come to absorb every string
    /// partway (as `tallies.rs`' own tests have them): `s` and `t`'s
    /// elements get a string of more than 64 units after cases and before
    /// more of them (and URIs), the top-level in the eighth sample, `u`
    /// only in the last.
    const ABSORBING: [&str; 11] = [
        r#"{"a":[1,"x"],"b":{"__proto__":1,"c":null},"d":"2020-01-01","s":"a"}"#,
        r#"[{"b":{"e":true,"__proto__":[2]}},"http://h/x.PNG",{"a":[]}]"#,
        r#"{"z":{"y":1},"a":[{"q":1.5}],"b":{"c":"s","__proto__":"t"},"d":"https://h/y.jpg","t":["a","b"]}"#,
        r#"{"s":"b","t":["c","long text long text long text long text long text long text long text","d","a"]}"#,
        r#"{"s":"long text long text long text long text long text long text long text","t":["e"],"u":"a"}"#,
        r#"{"s":"c","t":["ftp://h/z.gz","f"],"u":"b","d":"2020-01-02"}"#,
        r#""short""#,
        r#""long string, long string, long string, long string, long string, too""#,
        r#""after""#,
        r#"{"s":"https://h/w.png","t":["a"],"u":"c"}"#,
        r#"{"s":"d","u":"long text long text long text long text long text long text long text"}"#,
    ];

    /// An import that fails part way (here at a key whose text is not in
    /// the tree's string table) leaves the tallies as they were: no node
    /// taken, the trees there unchanged; the next import goes as usual.
    #[test]
    fn a_failed_import_changes_nothing() {
        let config = config(false);
        let mut into = RunningTallies::new();
        let existing = parse_stream_into(
            &mut TallyBuilder::new(&mut into, &config),
            SAMPLES[0].as_bytes(),
            Framing::Value,
        )
        .unwrap();
        let before = (into.dump(existing), into.tallies.live_nodes());
        let mut broken = portable(&config, SAMPLES[1]);
        broken.break_last_key();
        assert!(into.tallies.import(&mut into.strings, broken).is_err());
        assert_eq!((into.dump(existing), into.tallies.live_nodes()), before);
        let root = into
            .tallies
            .import(&mut into.strings, portable(&config, SAMPLES[1]))
            .unwrap();
        let mut read = RunningTallies::new();
        let tree = parse_stream_into(
            &mut TallyBuilder::new(&mut read, &config),
            SAMPLES[1].as_bytes(),
            Framing::Value,
        )
        .unwrap();
        assert_eq!(into.dump(root), read.dump(tree));
    }

    /// A tree made portable and imported into other tallies is the same
    /// tree, with the same texts, whatever those tallies held before.
    #[test]
    fn imported_trees_are_the_trees_read() {
        for handle_refs in [false, true] {
            let config = config(handle_refs);
            for sample in SAMPLES {
                let mut read = RunningTallies::new();
                let tree = parse_stream_into(
                    &mut TallyBuilder::new(&mut read, &config),
                    sample.as_bytes(),
                    Framing::Value,
                )
                .unwrap();
                let expected = read.dump(tree);
                // Into empty tallies, and into tallies that know other
                // texts under other ids already.
                let mut into = RunningTallies::new();
                let root = into
                    .tallies
                    .import(&mut into.strings, portable(&config, sample))
                    .unwrap();
                assert_eq!(into.dump(root), expected);
                let other = parse_stream_into(
                    &mut TallyBuilder::new(&mut into, &config),
                    br#"{"zz":["q","x","c","__proto__"],"x":1}"#,
                    Framing::Value,
                )
                .unwrap();
                let root = into
                    .tallies
                    .import(&mut into.strings, portable(&config, sample))
                    .unwrap();
                assert_eq!(into.dump(root), expected);
                into.tallies.free_tree(other);
            }
        }
    }

    /// Samples read on their own, made portable, imported and merged in
    /// order, give the tree of reading them all in one tree, however they
    /// are grouped.
    #[test]
    fn merging_imported_trees_is_reading_on() {
        for samples in [&SAMPLES[..], &ABSORBING[..]] {
            for handle_refs in [false, true] {
                merging_imported_trees_of(samples, handle_refs);
            }
        }
    }

    /// [`merging_imported_trees_is_reading_on`] for `samples`, split in
    /// three groups every way.
    fn merging_imported_trees_of(samples: &[&str], handle_refs: bool) {
        let config = config(handle_refs);
        let mut one = RunningTallies::new();
        let all = format!("[{}]", samples.join(","));
        let root = parse_stream_into(
            &mut TallyBuilder::new(&mut one, &config),
            all.as_bytes(),
            Framing::Value,
        )
        .unwrap();
        let expected = one.dump(root);
        for split in 1..samples.len() {
            for second in split + 1..=samples.len() {
                let groups = [
                    &samples[..split],
                    &samples[split..second],
                    &samples[second..],
                ];
                let mut merged = RunningTallies::new();
                let mut root = None;
                for group in groups.iter().filter(|g| !g.is_empty()) {
                    let part = portable(&config, &format!("[{}]", group.join(",")));
                    let imported = merged.tallies.import(&mut merged.strings, part).unwrap();
                    match root {
                        None => root = Some(imported),
                        Some(root) => merged.tallies.merge(root, imported).unwrap(),
                    }
                }
                let root = root.unwrap();
                assert_eq!(merged.dump(root), expected, "split at {split}, {second}");
                assert_eq!(merged.tallies.live_nodes(), one.tallies.live_nodes());
                // Spare tallies are empty.
                assert!(merged.tallies.spare_objects.iter().all(|o| is_empty(o)));
            }
        }
    }
}
