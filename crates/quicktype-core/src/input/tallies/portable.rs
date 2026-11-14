//! Tallies that move between threads. The parallel reader
//! ([`parallel_read`](crate::input::parallel_read)) tallies each part of a
//! large top-level array on a thread of its own, and appends the parts'
//! trees, in order, to the sample's tree on the thread that reads it. A
//! tree's string attributes hold `Rc`s, so a part's tree crosses threads
//! as a [`PortableTree`]: the same nodes, its keys and cases as ids into
//! its own string table (which it brings along), and the string attributes
//! as plain values. [`Tallies::import`] copies it into other tallies,
//! mapping each id to the id of the same text there: the copy is the
//! part's tree with the same texts, which [`Tallies::merge`] then appends
//! as it appends any other tree (see `docs/STREAMING-INFERENCE.md`,
//! "Reading on several threads").

use std::collections::VecDeque;
use std::rc::Rc;

use indexmap::IndexMap;

use super::{KeyTally, KindOrder, Node, NodeId, StringTally, Tallies, alloc};
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

/// A [`Node`], with nodes as indexes into [`PortableTree::nodes`].
#[derive(Default)]
struct PortableNode {
    kinds: KindOrder,
    items: Option<u32>,
    strings: Option<PortableStrings>,
    object: Option<PortableObject>,
}

/// A [`StringTally`], with portable attributes.
struct PortableStrings {
    cases: Vec<(u32, u64)>,
    with_enums: Option<PortableAttributes>,
    without_enums: Option<PortableAttributes>,
    not_interned: bool,
    absorbed: [u32; 2],
}

/// An [`ObjectTally`]: each key's id, count and node.
struct PortableObject {
    count: u64,
    keys: Vec<(u32, u64, u32)>,
    proto_runs: Vec<(u32, u64)>,
    proto: Option<u32>,
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
    fn to_attributes(&self) -> TypeAttributes {
        let mut attributes = TypeAttributes::new();
        for value in &self.0 {
            attributes.insert(match value {
                PortableAttribute::StringTypes(st) => {
                    TypeAttributeValue::StringTypes(Rc::new(st.clone()))
                }
                PortableAttribute::Uri(uri) => {
                    TypeAttributeValue::UriAttributes(Rc::new(uri.clone()))
                }
            });
        }
        attributes
    }
}

impl PortableTree {
    /// The tree at `root` of `tallies`, whose keys and cases are ids into
    /// `strings`. The tallies keep the tree.
    pub(crate) fn new(tallies: &Tallies, strings: Strings, root: NodeId) -> Result<Self> {
        let mut nodes = vec![PortableNode::default()];
        let mut pending = VecDeque::from([(root, 0usize)]);
        while let Some((id, at)) = pending.pop_front() {
            let node = tallies.node(id)?;
            // Each child gets the next index, filled in when it is reached.
            let mut place = |child: NodeId| {
                let index = nodes.len();
                nodes.push(PortableNode::default());
                pending.push_back((child, index));
                index as u32
            };
            let items = node.items.map(&mut place);
            let object = node.object.as_deref().map(|o| PortableObject {
                count: o.count,
                keys: o
                    .keys
                    .iter()
                    .map(|(&id, key)| (id, key.count, place(key.node)))
                    .collect(),
                proto_runs: o.proto_runs.clone(),
                proto: o.proto.map(&mut place),
            });
            let strings = match node.strings.as_deref() {
                Some(s) => Some(PortableStrings {
                    cases: s.cases.iter().map(|(&id, &count)| (id, count)).collect(),
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
                    n.strings.as_ref().map_or(0, |s| vec_size(&s.cases))
                        + n.object
                            .as_ref()
                            .map_or(0, |o| vec_size(&o.keys) + vec_size(&o.proto_runs))
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
    /// Copies `tree` into these tallies, its keys and cases as ids into
    /// `strings` (whose texts it adds as needed); returns the copy's root.
    pub(crate) fn import(&mut self, strings: &mut Strings, tree: &PortableTree) -> Result<NodeId> {
        // The ids of the tree's strings here, found once each.
        let mut ids = vec![u32::MAX; tree.strings.len()];
        let mut id = |strings: &mut Strings, local: u32| -> Result<u32> {
            let slot = defined(ids.get_mut(local as usize))?;
            if *slot == u32::MAX {
                *slot = strings.intern_text(defined(tree.strings.get(local as usize))?);
            }
            Ok(*slot)
        };
        let mut nodes = Vec::with_capacity(tree.nodes.len());
        for _ in &tree.nodes {
            nodes.push(alloc(&mut self.nodes, &mut self.free)?);
        }
        let node = |index: u32| defined(nodes.get(index as usize)).copied();
        for (portable, &at) in tree.nodes.iter().zip(&nodes) {
            let strings_tally = match &portable.strings {
                Some(s) => {
                    let mut tally = self.spare_strings.pop().unwrap_or_default();
                    let mut cases =
                        IndexMap::with_capacity_and_hasher(s.cases.len(), BuildHasher::default());
                    for &(local, count) in &s.cases {
                        cases.insert(id(strings, local)?, count);
                    }
                    *tally = StringTally {
                        cases,
                        with_enums: s.with_enums.as_ref().map(PortableAttributes::to_attributes),
                        without_enums: s
                            .without_enums
                            .as_ref()
                            .map(PortableAttributes::to_attributes),
                        not_interned: s.not_interned,
                        absorbed: s.absorbed,
                    };
                    Some(tally)
                }
                None => None,
            };
            let object = match &portable.object {
                Some(o) => {
                    let mut tally = self.spare_objects.pop().unwrap_or_default();
                    tally.count = o.count;
                    tally.keys.reserve(o.keys.len());
                    for &(local, count, child) in &o.keys {
                        let key = KeyTally {
                            count,
                            node: node(child)?,
                        };
                        tally.keys.insert(id(strings, local)?, key);
                    }
                    tally.proto_runs.extend_from_slice(&o.proto_runs);
                    tally.proto = o.proto.map(node).transpose()?;
                    Some(tally)
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
        Ok(nodes[0])
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
        PortableTree::new(&tallies, strings, tree).unwrap()
    }

    const SAMPLES: [&str; 6] = [
        r##"{"a":[1,"x",1.5,"2020-01-01T00:00:00Z",null,true],"$ref":"#/a","u":"http://h/x.png","__proto__":"__proto__"}"##,
        r#"{"__proto__":[{"b":"0123"}],"e":{},"f":[[]],"g":"7","a":[{"b":"__proto__"}],"__proto__":{"p":1}}"#,
        r#"[{"b":{"e":true,"__proto__":[2]}},"http://h/x.PNG",{"a":[]},"6ba7b810-9dad-11d1-80b4-00c04fd430c8"]"#,
        r#"{"z":{"y":1},"a":[{"q":1.5}],"b":{"c":"s","__proto__":"t"},"d":"https://h/y.jpg","x":"x","x":2}"#,
        r#""long string, long string, long string, long string, long string, too""#,
        r##"{"$ref":"#/z","$ref":"2020-01-01","a":{"$ref":"https://h/r"},"c":"false","t":"12:00:00Z"}"##,
    ];

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
                    .import(&mut into.strings, &portable(&config, sample))
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
                    .import(&mut into.strings, &portable(&config, sample))
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
        let config = config(true);
        let mut one = RunningTallies::new();
        let all = format!("[{}]", SAMPLES.join(","));
        let root = parse_stream_into(
            &mut TallyBuilder::new(&mut one, &config),
            all.as_bytes(),
            Framing::Value,
        )
        .unwrap();
        let expected = one.dump(root);
        for split in 1..SAMPLES.len() {
            for second in split + 1..=SAMPLES.len() {
                let groups = [
                    &SAMPLES[..split],
                    &SAMPLES[split..second],
                    &SAMPLES[second..],
                ];
                let mut merged = RunningTallies::new();
                let mut root = None;
                for group in groups.iter().filter(|g| !g.is_empty()) {
                    let part = portable(&config, &format!("[{}]", group.join(",")));
                    let imported = merged.tallies.import(&mut merged.strings, &part).unwrap();
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
