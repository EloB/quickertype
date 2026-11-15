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

use crate::support::fast_hash::{IndexMap, IndexSet, index_map_with_capacity};

use super::{KINDS, KeyTally, KindOrder, Node, NodeId, ObjectTally, Tallies, alloc, map_size};
use crate::attributes::string_types::StringTypes;
use crate::attributes::type_attributes::{TypeAttributeValue, TypeAttributes};
use crate::attributes::uri_attributes::UriAttributes;
use crate::input::compressed_json::{Strings, vec_size};
use crate::messages::Result;
use crate::support::support::{defined, panic};
use crate::ty::transformed_string_type::TRANSFORMED_STRING_TYPE_KINDS;

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
    cases: IndexMap<u32, u64>,
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
        let bytes = tree_size(&strings, &nodes);
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

    /// The tree as bytes, which [`from_bytes`](Self::from_bytes) reads back:
    /// for the WebAssembly engine, whose instances (one per Web Worker)
    /// share no memory. Everything in it is in its order (the string
    /// table, the nodes, each map's entries), so nothing depends on how an
    /// instance hashes.
    pub(crate) fn to_bytes(&self) -> Vec<u8> {
        let mut out = Writer(Vec::with_capacity(self.bytes / 2 + 64));
        out.0.extend_from_slice(MAGIC);
        out.len(self.strings.len());
        for i in 0..self.strings.len() {
            out.text(self.strings.get(i).unwrap_or_default());
        }
        out.len(self.nodes.len());
        for node in &self.nodes {
            out.number(u64::from(node.kinds.0));
            let flags = u8::from(node.items.is_some())
                | u8::from(node.strings.is_some()) << 1
                | u8::from(node.object.is_some()) << 2;
            out.0.push(flags);
            if let Some(items) = node.items {
                out.number(u64::from(items));
            }
            if let Some(s) = &node.strings {
                out.len(s.cases.len());
                for (&id, &count) in &s.cases {
                    out.number(u64::from(id));
                    out.number(count);
                }
                out.attributes(s.with_enums.as_ref());
                out.attributes(s.without_enums.as_ref());
                out.0.push(u8::from(s.not_interned));
                out.number(u64::from(s.absorbed[0]));
                out.number(u64::from(s.absorbed[1]));
            }
            if let Some(o) = &node.object {
                out.number(o.count);
                out.len(o.keys.len());
                for (&id, key) in &o.keys {
                    out.number(u64::from(id));
                    out.number(key.count);
                    out.number(u64::from(key.node));
                }
                out.len(o.proto_runs.len());
                for &(position, count) in &o.proto_runs {
                    out.number(u64::from(position));
                    out.number(count);
                }
                out.number(o.proto.map_or(0, |p| u64::from(p) + 1));
            }
        }
        out.0
    }

    /// The tree [`to_bytes`](Self::to_bytes) made `bytes` of; an error for
    /// bytes it did not make. What is read is checked as far as using the
    /// tree needs: a tree (each node but the root the child of one node
    /// before it), kinds that are kinds, string ids in its table and texts
    /// that are UTF-8; so bytes made otherwise give an error or some tree,
    /// never a panic or a cycle.
    pub(crate) fn from_bytes(bytes: &[u8]) -> Result<Self> {
        let Some(rest) = bytes.strip_prefix(MAGIC) else {
            return panic("Not the bytes of a tree of tallies");
        };
        let mut read = Reader(rest);
        let mut strings = Strings::new();
        let texts = read.count(MIN_TEXT)?;
        for i in 0..texts {
            // A part's table has each text once ("__proto__" too: keys
            // and cases are interned by their text).
            if strings.intern_text(read.text()?) as usize != i {
                return panic("A tree of tallies with a text twice");
            }
        }
        let count = read.count(MIN_NODE)?;
        let mut nodes: Vec<PortableNode> = Vec::with_capacity(room(count));
        // Whether each node is some node's child yet.
        let mut reached = vec![false; count];
        let mut child = |parent: usize, index: u64| -> Result<u32> {
            let index = usize::try_from(index).unwrap_or(usize::MAX);
            match reached.get_mut(index) {
                Some(seen) if index > parent && !*seen => {
                    *seen = true;
                    Ok(index as u32)
                }
                _ => panic("A tree of tallies that is not a tree"),
            }
        };
        let id = |id: u64| match u32::try_from(id) {
            Ok(id) if (id as usize) < texts => Ok(id),
            _ => panic("A tree of tallies with a text it does not have"),
        };
        for at in 0..count {
            let kinds = kind_order(read.number()?)?;
            let flags = read.byte()?;
            if flags & !7 != 0 {
                return panic("A tree of tallies with a node it does not know");
            }
            let items = if flags & 1 != 0 {
                Some(child(at, read.number()?)?)
            } else {
                None
            };
            let strings = if flags & 2 != 0 {
                let n = read.count(2 * MIN_NUMBER)?;
                let mut cases = index_map_with_capacity(room(n));
                for _ in 0..n {
                    let key = id(read.number()?)?;
                    if cases.insert(key, read.number()?).is_some() {
                        return panic("A tree of tallies with a case twice");
                    }
                }
                Some(PortableStrings {
                    cases,
                    with_enums: read.attributes()?,
                    without_enums: read.attributes()?,
                    not_interned: read.flag()?,
                    absorbed: [read.number32()?, read.number32()?],
                })
            } else {
                None
            };
            let object = if flags & 4 != 0 {
                let mut object = Box::<ObjectTally>::default();
                object.count = read.number()?;
                let n = read.count(3 * MIN_NUMBER)?;
                object.keys.reserve(room(n));
                for _ in 0..n {
                    let key = id(read.number()?)?;
                    let tally = KeyTally {
                        count: read.number()?,
                        node: child(at, read.number()?)?,
                    };
                    if object.keys.insert(key, tally).is_some() {
                        return panic("A tree of tallies with a key twice");
                    }
                }
                let runs = read.count(2 * MIN_NUMBER)?;
                object.proto_runs.reserve(room(runs));
                for _ in 0..runs {
                    object.proto_runs.push((read.number32()?, read.number()?));
                }
                object.proto = match read.number()? {
                    0 => None,
                    p => Some(child(at, p - 1)?),
                };
                Some(object)
            } else {
                None
            };
            nodes.push(PortableNode {
                kinds,
                items,
                strings,
                object,
            });
        }
        if nodes.is_empty() || !read.0.is_empty() {
            return panic("Not the bytes of a tree of tallies");
        }
        let bytes = tree_size(&strings, &nodes);
        Ok(PortableTree {
            strings,
            nodes,
            bytes,
        })
    }
}

/// About how many bytes a tree of `nodes` with `strings` holds.
fn tree_size(strings: &Strings, nodes: &Vec<PortableNode>) -> usize {
    strings.heap_size()
        + vec_size(nodes)
        + nodes
            .iter()
            .map(|n| {
                n.strings.as_ref().map_or(0, |s| map_size(&s.cases))
                    + n.object.as_ref().map_or(0, |o| {
                        size_of::<ObjectTally>() + map_size(&o.keys) + vec_size(&o.proto_runs)
                    })
            })
            .sum::<usize>()
}

/// What the bytes of a tree start with (and the version of their format).
const MAGIC: &[u8] = b"qtTallies1\n";

/// The fewest bytes [`Writer`] writes for a number (a varint), a text (its
/// length, then its bytes), a node (its kinds and its flags) and a string
/// attribute (its tag, and two flags or counts): what [`Reader::count`]
/// bounds counts by.
const MIN_NUMBER: usize = 1;
const MIN_TEXT: usize = 1;
const MIN_NODE: usize = 2;
const MIN_ATTRIBUTE: usize = 3;

/// The room made ahead for `n` entries a count announces: at most 4,096,
/// so that what is allocated follows the entries actually read (each
/// takes bytes of its own), not a count, which bytes that are not a tree's
/// can make as large as the bytes left allow.
fn room(n: usize) -> usize {
    n.min(1 << 12)
}

/// The [`KindOrder`] with these bits, if they are one: kinds' codes, four
/// bits each, none twice, and nothing after the first empty one.
fn kind_order(bits: u64) -> Result<KindOrder> {
    let Ok(bits) = u32::try_from(bits) else {
        return panic("A tree of tallies with kinds that are not kinds");
    };
    let mut order = KindOrder::default();
    let mut rest = bits;
    while rest != 0 {
        let code = rest & 0xF;
        let Some(&kind) = code.checked_sub(1).and_then(|c| KINDS.get(c as usize)) else {
            return panic("A tree of tallies with kinds that are not kinds");
        };
        order.add(kind);
        rest >>= 4;
    }
    // A kind twice was added once: the bits differ.
    if order.0 != bits {
        return panic("A tree of tallies with kinds that are not kinds");
    }
    Ok(order)
}

/// Writes the parts of a tree's bytes.
struct Writer(Vec<u8>);

impl Writer {
    /// LEB128.
    fn number(&mut self, mut n: u64) {
        while n >= 0x80 {
            self.0.push((n as u8) | 0x80);
            n >>= 7;
        }
        self.0.push(n as u8);
    }

    fn len(&mut self, n: usize) {
        self.number(n as u64);
    }

    fn text(&mut self, s: &str) {
        self.len(s.len());
        self.0.extend_from_slice(s.as_bytes());
    }

    fn texts<'s>(&mut self, texts: impl ExactSizeIterator<Item = &'s String>) {
        self.len(texts.len());
        for text in texts {
            self.text(text);
        }
    }

    fn attributes(&mut self, attributes: Option<&PortableAttributes>) {
        let Some(PortableAttributes(values)) = attributes else {
            self.0.push(0);
            return;
        };
        self.0.push(1);
        self.len(values.len());
        for value in values {
            match value {
                PortableAttribute::StringTypes(st) => {
                    self.0.push(0);
                    match &st.cases {
                        None => self.0.push(0),
                        Some(cases) => {
                            self.0.push(1);
                            self.len(cases.len());
                            for (case, &count) in cases {
                                self.text(case);
                                self.number(count);
                            }
                        }
                    }
                    self.len(st.transformations.len());
                    for kind in &st.transformations {
                        let code = TRANSFORMED_STRING_TYPE_KINDS
                            .iter()
                            .position(|k| k == kind)
                            .map_or(u8::MAX, |i| i as u8);
                        self.0.push(code);
                    }
                }
                PortableAttribute::Uri((protocols, extensions)) => {
                    self.0.push(1);
                    self.texts(protocols.iter());
                    self.texts(extensions.iter());
                }
            }
        }
    }
}

/// Reads what [`Writer`] wrote.
struct Reader<'b>(&'b [u8]);

impl<'b> Reader<'b> {
    fn byte(&mut self) -> Result<u8> {
        let Some((&b, rest)) = self.0.split_first() else {
            return panic("The bytes of a tree of tallies end early");
        };
        self.0 = rest;
        Ok(b)
    }

    fn flag(&mut self) -> Result<bool> {
        match self.byte()? {
            0 => Ok(false),
            1 => Ok(true),
            _ => panic("A tree of tallies with a flag that is not one"),
        }
    }

    fn number(&mut self) -> Result<u64> {
        let mut n = 0u64;
        for shift in (0..64).step_by(7) {
            let b = self.byte()?;
            n |= u64::from(b & 0x7F) << shift;
            if b & 0x80 == 0 {
                return Ok(n);
            }
        }
        panic("A tree of tallies with a number too large")
    }

    fn number32(&mut self) -> Result<u32> {
        match u32::try_from(self.number()?) {
            Ok(n) => Ok(n),
            Err(_) => panic("A tree of tallies with a number too large"),
        }
    }

    /// A count of what follows, each of which takes `each` bytes at least
    /// ([`Writer`] writes no shorter): at most what the bytes left can
    /// hold, so that nothing is made room for that the bytes do not have.
    fn count(&mut self, each: usize) -> Result<usize> {
        match usize::try_from(self.number()?) {
            Ok(n) if n.saturating_mul(each) <= self.0.len() => Ok(n),
            _ => panic("The bytes of a tree of tallies end early"),
        }
    }

    fn text(&mut self) -> Result<&'b str> {
        let n = self.count(1)?;
        let (text, rest) = self.0.split_at(n);
        self.0 = rest;
        match std::str::from_utf8(text) {
            Ok(text) => Ok(text),
            Err(_) => panic("A tree of tallies with a text that is not UTF-8"),
        }
    }

    fn texts(&mut self) -> Result<IndexSet<String>> {
        let n = self.count(MIN_TEXT)?;
        let mut texts = IndexSet::default();
        for _ in 0..n {
            texts.insert(self.text()?.to_owned());
        }
        Ok(texts)
    }

    fn attributes(&mut self) -> Result<Option<PortableAttributes>> {
        if !self.flag()? {
            return Ok(None);
        }
        let n = self.count(MIN_ATTRIBUTE)?;
        let mut values = Vec::with_capacity(room(n));
        for _ in 0..n {
            values.push(match self.byte()? {
                0 => {
                    let cases = if self.flag()? {
                        let n = self.count(MIN_TEXT + MIN_NUMBER)?;
                        let mut cases = IndexMap::default();
                        for _ in 0..n {
                            let case = self.text()?.to_owned();
                            cases.insert(case, self.number()?);
                        }
                        Some(cases)
                    } else {
                        None
                    };
                    let n = self.count(1)?;
                    let mut transformations = IndexSet::default();
                    for _ in 0..n {
                        match TRANSFORMED_STRING_TYPE_KINDS.get(usize::from(self.byte()?)) {
                            Some(&kind) => transformations.insert(kind),
                            None => return panic("A tree of tallies with a kind it does not know"),
                        };
                    }
                    PortableAttribute::StringTypes(StringTypes::new(cases, transformations)?)
                }
                1 => PortableAttribute::Uri((self.texts()?, self.texts()?)),
                _ => return panic("A tree of tallies with an attribute it does not know"),
            });
        }
        Ok(Some(PortableAttributes(values)))
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
                    o.keys = index_map_with_capacity(keys.len());
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

    const SAMPLES: [&str; 7] = [
        r##"{"a":[1,"x",1.5,"2020-01-01T00:00:00Z",null,true],"$ref":"#/a","u":"http://h/x.png","__proto__":"__proto__"}"##,
        r#"{"__proto__":[{"b":"0123"}],"e":{},"f":[[]],"g":"7","a":[{"b":"__proto__"}],"__proto__":{"p":1}}"#,
        r#"[{"b":{"e":true,"__proto__":[2]}},"http://h/x.PNG",{"a":[]},"6ba7b810-9dad-11d1-80b4-00c04fd430c8"]"#,
        r#"{"z":{"y":1},"a":[{"q":1.5}],"b":{"c":"s","__proto__":"t"},"d":"https://h/y.jpg","x":"x","x":2}"#,
        r#""long string, long string, long string, long string, long string, too""#,
        r##"{"$ref":"#/z","$ref":"2020-01-01","a":{"$ref":"https://h/r"},"c":"false","t":"12:00:00Z"}"##,
        // URIs with ports, user info, queries and fragments, some parsed
        // (not plain), at places that had others.
        r#"{"u":"http://user:pw@h.example:8080/a/b.png?x=1#f","v":["ftp://anon@files.example:21/pub/x.tar.gz","https://h:443/","http://[::1]:80/i.JPG"],"d":"https://u@h/y.jpg?z"}"#,
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

    /// A tree as bytes, read back, is the same tree: imported, it is the
    /// tree read, in tallies that know other texts already (and the
    /// absorbing samples' trees, whose places drop their cases).
    #[test]
    fn trees_as_bytes_are_the_trees_read() {
        for handle_refs in [false, true] {
            let config = config(handle_refs);
            let all = format!("[{}]", ABSORBING.join(","));
            for sample in SAMPLES.iter().copied().chain([all.as_str()]) {
                let mut read = RunningTallies::new();
                let tree = parse_stream_into(
                    &mut TallyBuilder::new(&mut read, &config),
                    sample.as_bytes(),
                    Framing::Value,
                )
                .unwrap();
                let expected = read.dump(tree);
                let bytes = portable(&config, sample).to_bytes();
                let back = PortableTree::from_bytes(&bytes).unwrap();
                assert_eq!(back.to_bytes(), bytes);
                let mut into = RunningTallies::new();
                parse_stream_into(
                    &mut TallyBuilder::new(&mut into, &config),
                    br#"{"zz":["q","x","c","__proto__"],"x":1}"#,
                    Framing::Value,
                )
                .unwrap();
                let root = into.tallies.import(&mut into.strings, back).unwrap();
                assert_eq!(into.dump(root), expected, "{sample}");
            }
        }
    }

    /// Bytes that are not a tree's, cut or changed anywhere, give an error
    /// or some tree, which imports and merges without a panic.
    #[test]
    fn broken_bytes_are_an_error_or_a_tree() {
        let config = config(true);
        let bytes = portable(&config, &format!("[{}]", SAMPLES.join(","))).to_bytes();
        let mut rng = crate::input::json_split::tests::Rng(99);
        let (mut errors, mut trees) = (0, 0);
        for round in 0..20_000 {
            let mut broken = bytes.clone();
            match round % 3 {
                0 => broken.truncate(rng.below(bytes.len())),
                1 => {
                    let at = rng.below(bytes.len());
                    broken[at] = rng.next() as u8;
                }
                _ => {
                    for _ in 0..1 + rng.below(4) {
                        let at = rng.below(broken.len());
                        broken[at] ^= 1 << rng.below(8);
                    }
                }
            }
            match PortableTree::from_bytes(&broken) {
                Err(_) => errors += 1,
                Ok(tree) => {
                    trees += 1;
                    let mut into = RunningTallies::new();
                    let first = into
                        .tallies
                        .import(&mut into.strings, portable(&config, SAMPLES[0]));
                    if let Ok(root) = into.tallies.import(&mut into.strings, tree) {
                        let _ = into.tallies.merge(first.unwrap(), root);
                    }
                }
            }
        }
        assert!(
            errors > 1_000 && trees > 1_000,
            "{errors} errors, {trees} trees"
        );
    }

    /// A length or count that says far more follows than the bytes hold,
    /// at any place (a text's length, the texts', the nodes', a place's
    /// cases, keys, `__proto__` runs, attributes), is an error before
    /// anything is made room for: a count of 2^31 or 2^63 nodes, cases or
    /// keys would otherwise allocate gigabytes, or fail to.
    #[test]
    fn counts_past_the_bytes_are_errors() {
        let config = config(true);
        let samples: Vec<&str> = SAMPLES.iter().chain(&ABSORBING).copied().collect();
        let bytes = portable(&config, &format!("[{}]", samples.join(","))).to_bytes();
        // 2^31, 2^63, and the bytes' own length a thousand times over.
        let huge: [&[u8]; 3] = [
            &[0x80, 0x80, 0x80, 0x80, 0x08],
            &[0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00],
            &[0xC0, 0x84, 0x3D],
        ];
        let mut errors = 0;
        for at in MAGIC.len()..bytes.len() {
            for number in huge {
                // The number in place of the byte at `at` (a varint's
                // first byte, or any other).
                let mut broken = bytes[..at].to_vec();
                broken.extend_from_slice(number);
                broken.extend_from_slice(&bytes[at + 1..]);
                if PortableTree::from_bytes(&broken).is_err() {
                    errors += 1;
                }
            }
        }
        let places = bytes.len() - MAGIC.len();
        assert!(errors > places * 2, "{errors} errors of {}", 3 * places);
        // A count is at most what the bytes left hold.
        assert_eq!(Reader(&[0x05, 1, 2, 3, 4, 5]).count(1).unwrap(), 5);
        assert!(Reader(&[0x06, 1, 2, 3, 4, 5]).count(1).is_err());
        assert!(Reader(&[0x02, 1, 2, 3, 4, 5]).count(3).is_err());
        let largest = [0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x01];
        assert!(Reader(&largest).count(1).is_err());
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
