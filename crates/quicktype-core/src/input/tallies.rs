//! Running tallies of JSON samples: what type inference reads from all the
//! values at one place of the samples, counted while the samples are read.
//! See `docs/STREAMING-INFERENCE.md`, which argues section by section why
//! inference from tallies equals quicktype's inference.
//!
//! Not a port of one TypeScript file. quicktype keeps every sample in a
//! `CompressedJSON`, and `Inference.ts` then gathers, for each place in the
//! samples, the list of all its values (a top-level's samples, all values
//! of a property across objects, all elements of all arrays at a place) and
//! adds them to a `UnionAccumulator`. A place's [`Node`] keeps exactly what
//! the accumulator and `inferClassType` read from such a list:
//!
//! - the order in which the non-string kinds were first seen
//!   ([`KindOrder`]);
//! - for strings ([`StringTally`]): each interned string (a candidate enum
//!   case) with its count, and the attributes the other strings add,
//!   combined as the accumulator combines them, both as they are with enum
//!   inference and as they are without;
//! - for objects ([`ObjectTally`]): their number, each key's number of
//!   occurrences and the node of its values, keys in first-seen order, and
//!   `__proto__`'s quirks (it is listed again at each occurrence, and only
//!   its last value counts);
//! - for arrays: the node of all their elements.
//!
//! A place is identified by its path from the top-level (keys and array
//! elements), so a tally grows with the number of distinct paths, keys and
//! string cases, not with the size of the samples.
//! [`tally_inference`](super::tally_inference) infers types from it.
//!
//! [`TallyBuilder`] is the [`JsonSink`] that reads each sample into a tree
//! of nodes of its own from a reader's events (the stream-json tokenizer's,
//! or those of a `JSON.parse` sample's parsed value), classifying strings
//! exactly as `CompressedJSON.commitString` does; a sample that fails is
//! freed whole. [`Tallies::merge`] appends one tree to another, as if the
//! second tree's samples had followed the first's; it changes nothing
//! unless it succeeds.

#[cfg(test)]
use std::cell::Cell;
use std::fmt;

use indexmap::IndexMap;
use quicktype_js_compat::utf16;

use super::compressed_json::{CompressedJson, JsonSink, Strings};
use crate::attributes::string_types::{
    StringTypes, StringTypesTypeAttributeKind, infer_transformed_string_type_kind_for_string,
};
use crate::attributes::type_attributes::{
    AttributeKind, CombinationKind, TypeAttributes, combine_type_attributes2,
};
use crate::attributes::uri_attributes::UriTypeAttributeKind;
use crate::messages::Result;
use crate::support::fast_hash::BuildHasher;
use crate::support::support::{defined, panic};
use crate::ty::transformed_string_type::{TypeKind, transformed_string_type_attributes_producer};

/// A node's index in [`Tallies`].
pub(crate) type NodeId = u32;

/// The non-string kinds in the order they were first seen at a place (TS:
/// the keys of the accumulator's `_nonStringTypeAttributes`, which inference
/// always adds with empty attributes). Up to six kinds, four bits each.
#[derive(Clone, Copy, Default, PartialEq, Eq)]
pub(crate) struct KindOrder(u32);

/// The kinds a [`KindOrder`] holds; a kind's code is its position plus one.
const KINDS: [TypeKind; 6] = [
    TypeKind::Null,
    TypeKind::Bool,
    TypeKind::Integer,
    TypeKind::Double,
    TypeKind::Object,
    TypeKind::Array,
];

impl KindOrder {
    fn code(kind: TypeKind) -> u32 {
        match kind {
            TypeKind::Null => 1,
            TypeKind::Bool => 2,
            TypeKind::Integer => 3,
            TypeKind::Double => 4,
            TypeKind::Object => 5,
            // `TypeKind::Array`, the only other kind added.
            _ => 6,
        }
    }

    /// Adds `kind` (one of [`KINDS`]) unless it was seen already.
    pub(crate) fn add(&mut self, kind: TypeKind) {
        let code = Self::code(kind);
        let mut bits = self.0;
        let mut shift = 0;
        while bits != 0 {
            if bits & 0xF == code {
                return;
            }
            bits >>= 4;
            shift += 4;
        }
        self.0 |= code << shift;
    }

    /// The kinds, in the order they were first seen.
    pub(crate) fn iter(self) -> impl Iterator<Item = TypeKind> {
        let mut bits = self.0;
        std::iter::from_fn(move || {
            let code = bits & 0xF;
            bits >>= 4;
            (code != 0).then(|| KINDS[code as usize - 1])
        })
    }

    pub(crate) fn is_empty(self) -> bool {
        self.0 == 0
    }
}

impl fmt::Debug for KindOrder {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.debug_list().entries(self.iter()).finish()
    }
}

/// The strings at a place.
#[derive(Debug, Default)]
pub(crate) struct StringTally {
    /// The interned strings (`Tag.InternedString`, each one
    /// `addStringCase(s, 1)` with enum inference), by their index in
    /// [`Tallies`]' strings, with their counts, in first-seen order.
    pub(crate) cases: IndexMap<u32, u64, BuildHasher>,
    /// What the other strings add to the accumulator's `string` attributes
    /// (`addStringType("string", ...)`), combined in order as
    /// `combineTypeAttributes("union", ...)` combines them; `None` if they
    /// add nothing.
    pub(crate) with_enums: Option<TypeAttributes>,
    /// The same without enum inference, where every interned string adds
    /// an unrestricted string instead of a case.
    pub(crate) without_enums: Option<TypeAttributes>,
    /// Whether some string here is not interned (the `$ref` check).
    pub(crate) not_interned: bool,
}

/// The `stringTypes` of `attributes`, if any.
fn string_types_in(attributes: &Option<TypeAttributes>) -> Option<&StringTypes> {
    attributes
        .as_ref()
        .and_then(|a| StringTypesTypeAttributeKind.try_get_in_attributes(a))
}

/// Combines `attributes` into `combined`: one more element of the list that
/// `combineTypeAttributes("union", list)` combines. Empty attributes add
/// nothing to that combination.
fn combine_into(combined: &mut Option<TypeAttributes>, attributes: TypeAttributes) -> Result<()> {
    if attributes.is_empty() {
        return Ok(());
    }
    *combined = Some(match combined.take() {
        None => attributes,
        Some(c) => combine_type_attributes2(CombinationKind::Union, &c, &attributes)?,
    });
    Ok(())
}

/// Adds `StringTypes.unrestricted`. Combining it into string types that are
/// unrestricted already changes nothing, so that is skipped.
fn add_unrestricted(combined: &mut Option<TypeAttributes>) -> Result<()> {
    if string_types_in(combined).is_some_and(|st| !st.is_restricted()) {
        return Ok(());
    }
    combine_into(
        combined,
        StringTypesTypeAttributeKind.make_attributes(StringTypes::unrestricted()),
    )
}

/// Adds `new StringTypes(new Map(), new Set([kind]))`, unless the combined
/// string types already allow `kind` (or are unrestricted), where it would
/// change nothing.
fn add_transformation(combined: &mut Option<TypeAttributes>, kind: TypeKind) -> Result<()> {
    if string_types_in(combined)
        .is_some_and(|st| !st.is_restricted() || st.transformations.contains(&kind))
    {
        return Ok(());
    }
    combine_into(
        combined,
        StringTypesTypeAttributeKind.make_attributes(StringTypes {
            cases: Some(IndexMap::new()),
            transformations: [kind].into_iter().collect(),
        }),
    )
}

/// Adds a `uri`'s attributes (`uriInferenceAttributesProducer(s)`), unless
/// the combined URI attributes already hold its protocol and extension.
fn add_produced(combined: &mut Option<TypeAttributes>, attributes: &TypeAttributes) -> Result<()> {
    let known = |a: &TypeAttributes| {
        let (Some(new), Some(old)) = (
            UriTypeAttributeKind.try_get_in_attributes(a),
            combined
                .as_ref()
                .and_then(|c| UriTypeAttributeKind.try_get_in_attributes(c)),
        ) else {
            return false;
        };
        a.iter().count() == 1
            && new.0.iter().all(|p| old.0.contains(p))
            && new.1.iter().all(|e| old.1.contains(e))
    };
    if known(attributes) {
        return Ok(());
    }
    combine_into(combined, attributes.clone())
}

/// The attribute combinations of two string tallies, one after the other
/// (with and without enum inference): see [`StringTally::combined_with`].
type Combined = (Option<TypeAttributes>, Option<TypeAttributes>);

/// `a` with `b` combined into it, as [`combine_into`] does, if that takes
/// a combination; `None` if `b` adds nothing or `a` is empty, where the
/// result is `a` or `b` as they are.
fn combined(
    a: &Option<TypeAttributes>,
    b: &Option<TypeAttributes>,
) -> Result<Option<TypeAttributes>> {
    match (a, b) {
        (Some(a), Some(b)) if !b.is_empty() => Ok(Some(combine_type_attributes2(
            CombinationKind::Union,
            a,
            b,
        )?)),
        _ => Ok(None),
    }
}

/// Sets `target` to `target` combined with `other`, given what [`combined`]
/// computed for them.
fn take_combined(
    target: &mut Option<TypeAttributes>,
    other: Option<TypeAttributes>,
    combined: Option<TypeAttributes>,
) {
    match combined {
        Some(c) => *target = Some(c),
        None if target.is_none() => *target = other.filter(|a| !a.is_empty()),
        None => {}
    }
}

impl StringTally {
    /// The fallible part of appending `other`'s strings after these: the
    /// combined attributes, computed without changing anything.
    fn combined_with(&self, other: &StringTally) -> Result<Combined> {
        Ok((
            combined(&self.with_enums, &other.with_enums)?,
            combined(&self.without_enums, &other.without_enums)?,
        ))
    }

    /// Appends `other`'s strings after these, with the attributes
    /// [`combined_with`](Self::combined_with) computed for them.
    fn append(&mut self, other: StringTally, (with_enums, without_enums): Combined) {
        for (id, count) in other.cases {
            *self.cases.entry(id).or_insert(0) += count;
        }
        take_combined(&mut self.with_enums, other.with_enums, with_enums);
        take_combined(&mut self.without_enums, other.without_enums, without_enums);
        self.not_interned |= other.not_interned;
    }
}

/// One key of the objects at a place.
#[derive(Clone, Copy, Debug)]
pub(crate) struct KeyTally {
    /// How often the key occurs (TS `propertyValues[key].length`; a key
    /// that repeats within one object counts each time).
    pub(crate) count: u64,
    /// The node of its values.
    pub(crate) node: NodeId,
}

/// The objects at a place.
#[derive(Debug, Default)]
pub(crate) struct ObjectTally {
    /// The number of objects (TS `objects.length`).
    pub(crate) count: u64,
    /// The keys other than `__proto__`, by their index in [`Tallies`]'
    /// strings, in first-seen order (TS `propertyNames`).
    pub(crate) keys: IndexMap<u32, KeyTally, BuildHasher>,
    /// The occurrences of `__proto__`: TypeScript collects the values in a
    /// plain object, where `"__proto__"` is never an own property, so each
    /// occurrence is listed in `propertyNames` again. Each entry is the
    /// number of keys listed before a run of occurrences, and the run's
    /// length.
    pub(crate) proto_runs: Vec<(u32, u64)>,
    /// The node of `__proto__`'s last value, the only one TypeScript keeps.
    pub(crate) proto: Option<NodeId>,
}

/// Records `count` occurrences of `__proto__` after the first `keys` keys
/// in `runs` (see [`ObjectTally::proto_runs`]).
pub(crate) fn add_proto_occurrences(runs: &mut Vec<(u32, u64)>, keys: usize, count: u64) {
    let position = keys as u32;
    match runs.last_mut() {
        Some((p, n)) if *p == position => *n += count,
        _ => runs.push((position, count)),
    }
}

/// The property names in `propertyNames` order, of `keys` keys and the
/// `__proto__` occurrences `runs`: `Some(i)` for the `i`th key, `None` for
/// `count` occurrences of `__proto__`.
pub(crate) fn property_names(
    runs: &[(u32, u64)],
    keys: usize,
) -> impl Iterator<Item = (Option<usize>, u64)> + '_ {
    let mut runs = runs.iter().peekable();
    let mut key = 0;
    std::iter::from_fn(move || {
        if let Some(&&(position, count)) = runs.peek()
            && position as usize <= key
        {
            runs.next();
            return Some((None, count));
        }
        if key < keys {
            key += 1;
            return Some((Some(key - 1), 1));
        }
        None
    })
}

impl ObjectTally {
    /// Records an occurrence of `__proto__`.
    fn add_proto_occurrences(&mut self, count: u64) {
        add_proto_occurrences(&mut self.proto_runs, self.keys.len(), count);
    }

    /// The property names in `propertyNames` order: `Some(i)` for the
    /// `i`th key, `None` for `count` occurrences of `__proto__`.
    pub(crate) fn property_names(&self) -> impl Iterator<Item = (Option<usize>, u64)> + '_ {
        property_names(&self.proto_runs, self.keys.len())
    }

    /// Appends `other`'s objects after these. The values of a key both
    /// have are joined by a merge step of their own; `other`'s last
    /// `__proto__` value replaces this one's, which goes to `replaced`.
    fn append(&mut self, other: ObjectTally, replaced: &mut Vec<NodeId>) {
        self.count += other.count;
        let mut runs = other.proto_runs.into_iter().peekable();
        for (i, (id, tally)) in other.keys.into_iter().enumerate() {
            while let Some(&(position, count)) = runs.peek()
                && position as usize <= i
            {
                self.add_proto_occurrences(count);
                runs.next();
            }
            match self.keys.get_mut(&id) {
                Some(existing) => existing.count += tally.count,
                None => {
                    self.keys.insert(id, tally);
                }
            }
        }
        for (_, count) in runs {
            self.add_proto_occurrences(count);
        }
        if let Some(proto) = other.proto
            && let Some(old) = self.proto.replace(proto)
        {
            replaced.push(old);
        }
    }
}

/// All values at one place.
#[derive(Debug, Default)]
pub(crate) struct Node {
    /// The non-string kinds, in first-seen order.
    pub(crate) kinds: KindOrder,
    /// The node of all elements of all arrays here.
    pub(crate) items: Option<NodeId>,
    /// The strings here.
    pub(crate) strings: Option<Box<StringTally>>,
    /// The objects here.
    pub(crate) object: Option<Box<ObjectTally>>,
}

/// The nodes of all tallies of a JSON input, and the text of their keys
/// and string cases.
pub(crate) struct Tallies {
    nodes: Vec<Node>,
    /// Nodes no tree uses any more, for reuse.
    free: Vec<NodeId>,
    strings: Strings,
    /// Makes the next [`merge`](Self::merge) fail after planning this many
    /// steps (for tests).
    #[cfg(test)]
    pub(crate) fail_merge_at: Cell<Option<usize>>,
}

/// One pair of places [`Tallies::merge`] joins: the values at `from` are
/// appended to those at `into`.
struct MergeStep {
    into: NodeId,
    from: NodeId,
    /// If both places have strings, their combined attributes.
    strings: Option<Combined>,
}

impl fmt::Debug for Tallies {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.debug_struct("Tallies")
            .field("nodes", &(self.nodes.len() - self.free.len()))
            .field("strings", &self.strings.len())
            .finish_non_exhaustive()
    }
}

/// Allocates an empty node.
fn alloc(nodes: &mut Vec<Node>, free: &mut Vec<NodeId>) -> Result<NodeId> {
    if let Some(id) = free.pop() {
        return Ok(id);
    }
    let Ok(id) = NodeId::try_from(nodes.len()) else {
        return panic("Too many places in the JSON samples");
    };
    nodes.push(Node::default());
    Ok(id)
}

impl Tallies {
    pub(crate) fn new() -> Self {
        Tallies {
            nodes: Vec::new(),
            free: Vec::new(),
            strings: Strings::new(),
            #[cfg(test)]
            fail_merge_at: Cell::new(None),
        }
    }

    /// The node `id`.
    pub(crate) fn node(&self, id: NodeId) -> Result<&Node> {
        defined(self.nodes.get(id as usize))
    }

    /// The text of the key or string case `id`.
    pub(crate) fn text(&self, id: u32) -> Result<&str> {
        defined(self.strings.get(id as usize))
    }

    /// The number of nodes in use (for tests).
    #[cfg(test)]
    pub(crate) fn live_nodes(&self) -> usize {
        self.nodes.len() - self.free.len()
    }

    /// The tree at `node` with keys and cases as text, independent of node
    /// numbers (for tests).
    #[cfg(test)]
    pub(crate) fn dump(&self, node: NodeId) -> String {
        let n = self.node(node).unwrap();
        let mut out = format!("{:?}", n.kinds);
        if let Some(s) = &n.strings {
            let cases: Vec<(&str, u64)> = s
                .cases
                .iter()
                .map(|(&id, &c)| (self.text(id).unwrap(), c))
                .collect();
            out += &format!(
                " strings{cases:?} {:?} {:?} {}",
                s.with_enums, s.without_enums, s.not_interned
            );
        }
        if let Some(o) = &n.object {
            out += &format!(" objects {} {:?} {{", o.count, o.proto_runs);
            for (&id, k) in &o.keys {
                out += &format!(
                    "{:?}×{}: {}, ",
                    self.text(id).unwrap(),
                    k.count,
                    self.dump(k.node)
                );
            }
            if let Some(p) = o.proto {
                out += &format!("__proto__: {}", self.dump(p));
            }
            out += "}";
        }
        if let Some(items) = n.items {
            out += &format!(" items [{}]", self.dump(items));
        }
        out
    }

    /// A new, empty tree; returns its root.
    pub(crate) fn new_tree(&mut self) -> Result<NodeId> {
        alloc(&mut self.nodes, &mut self.free)
    }

    /// Frees the tree at `root`.
    pub(crate) fn free_tree(&mut self, root: NodeId) {
        let mut stack = vec![root];
        while let Some(id) = stack.pop() {
            let Some(node) = self.nodes.get_mut(id as usize) else {
                continue;
            };
            let node = std::mem::take(node);
            stack.extend(node.items);
            if let Some(object) = node.object {
                stack.extend(object.keys.values().map(|k| k.node));
                stack.extend(object.proto);
            }
            self.free.push(id);
        }
    }

    /// Appends the samples of the tree `from` to those of the tree `into`,
    /// as if they had been read after them. `from` is used up: its nodes
    /// move to `into` or are freed.
    ///
    /// All or nothing: everything that can fail (looking nodes up,
    /// combining string attributes) is done before `into` changes, so
    /// after an error `into` is as it was, and `from` is freed.
    pub(crate) fn merge(&mut self, into: NodeId, from: NodeId) -> Result<()> {
        match self.plan_merge(into, from) {
            Ok(steps) => {
                self.commit_merge(steps);
                Ok(())
            }
            Err(e) => {
                self.free_tree(from);
                Err(e)
            }
        }
    }

    /// The pairs of places a merge joins (those where both trees have
    /// values), and the string attributes they combine to; changes nothing.
    fn plan_merge(&self, into: NodeId, from: NodeId) -> Result<Vec<MergeStep>> {
        #[cfg(test)]
        let fail_at = self.fail_merge_at.take();
        let mut steps = Vec::new();
        let mut pending = vec![(into, from)];
        while let Some((a, b)) = pending.pop() {
            #[cfg(test)]
            if fail_at == Some(steps.len()) {
                return panic("Injected merge failure");
            }
            let (x, y) = (self.node(a)?, self.node(b)?);
            if let (Some(i), Some(j)) = (x.items, y.items) {
                pending.push((i, j));
            }
            if let (Some(xo), Some(yo)) = (&x.object, &y.object) {
                for (id, key) in &yo.keys {
                    if let Some(existing) = xo.keys.get(id) {
                        pending.push((existing.node, key.node));
                    }
                }
            }
            let strings = match (&x.strings, &y.strings) {
                (Some(xs), Some(ys)) => Some(xs.combined_with(ys)?),
                _ => None,
            };
            steps.push(MergeStep {
                into: a,
                from: b,
                strings,
            });
        }
        Ok(steps)
    }

    /// Carries out the steps [`plan_merge`](Self::plan_merge) planned. The
    /// trees are as they were when it planned them (it took `&self`, and
    /// each node is in at most one step), so every node exists and every
    /// pair of strings has its combination: nothing here can fail.
    fn commit_merge(&mut self, steps: Vec<MergeStep>) {
        let mut replaced = Vec::new();
        for step in steps {
            let y = std::mem::take(&mut self.nodes[step.from as usize]);
            self.free.push(step.from);
            let x = &mut self.nodes[step.into as usize];
            for kind in y.kinds.iter() {
                x.kinds.add(kind);
            }
            // Items both have are a step of their own.
            if x.items.is_none() {
                x.items = y.items;
            }
            match (&mut x.strings, y.strings) {
                (Some(xs), Some(ys)) => xs.append(*ys, step.strings.unwrap_or_default()),
                (None, ys) => x.strings = ys,
                (Some(_), None) => {}
            }
            match (&mut x.object, y.object) {
                (Some(xo), Some(yo)) => xo.append(*yo, &mut replaced),
                (None, yo) => x.object = yo,
                (Some(_), None) => {}
            }
        }
        for old in replaced {
            self.free_tree(old);
        }
    }
}

/// The object or array being read (TS `Context`).
#[derive(Clone, Copy, Debug)]
enum Frame {
    Object {
        /// The node of this object.
        node: NodeId,
        /// The node the current key's value goes to (TS `currentKey`).
        value: Option<NodeId>,
        /// Whether the current key is `"$ref"` (TS `isExpectingRef`).
        expecting_ref: bool,
        /// The index of the key expected next: objects at one place
        /// usually list their keys in the same order, and a key found
        /// there needs no lookup.
        next_key: usize,
    },
    Array {
        /// The node of the elements.
        items: NodeId,
    },
}

/// Reads samples into tallies, one value at a time: the [`JsonSink`] of
/// the readers. Each sample goes to a tree of its own, which
/// [`finish`](JsonSink::finish) returns; a sample that fails is freed
/// ([`reset_partial_sample`](JsonSink::reset_partial_sample), or when the
/// builder is dropped), so it leaves nothing behind but the text of its
/// keys and strings in the shared string table, which nothing refers to.
/// Appending a sample to others is [`Tallies::merge`]'s job.
pub(crate) struct TallyBuilder<'a> {
    tallies: &'a mut Tallies,
    /// The reading configuration: date/time recognizer, `$ref` handling,
    /// integer range.
    config: &'a CompressedJson,
    /// The tree of the sample being read, from its first value until
    /// `finish` returns it.
    root: Option<NodeId>,
    frames: Vec<Frame>,
}

impl<'a> TallyBuilder<'a> {
    /// A builder that reads samples as `config` reads them.
    pub(crate) fn new(tallies: &'a mut Tallies, config: &'a CompressedJson) -> Self {
        TallyBuilder {
            tallies,
            config,
            root: None,
            frames: Vec::new(),
        }
    }

    /// The node the next value goes to (TS `commitValue`'s destination);
    /// the sample's root value starts its tree.
    fn destination(&mut self) -> Result<NodeId> {
        match self.frames.last() {
            None => {
                if self.root.is_some() {
                    return panic(
                        "Committing value but nowhere to commit to - root value still there.",
                    );
                }
                let root = self.tallies.new_tree()?;
                self.root = Some(root);
                Ok(root)
            }
            Some(Frame::Object {
                value: Some(node), ..
            }) => Ok(*node),
            Some(Frame::Object { value: None, .. }) => {
                panic("Must have key and can't have string when committing")
            }
            Some(Frame::Array { items }) => Ok(*items),
        }
    }

    fn node_mut(&mut self, id: NodeId) -> Result<&mut Node> {
        defined(self.tallies.nodes.get_mut(id as usize))
    }

    /// The current key's value is complete (TS: `currentKey = undefined`).
    fn value_done(&mut self) {
        if let Some(Frame::Object { value, .. }) = self.frames.last_mut() {
            *value = None;
        }
    }

    /// A value of a non-string `kind`.
    fn add_kind(&mut self, kind: TypeKind) -> Result<()> {
        let node = self.destination()?;
        self.node_mut(node)?.kinds.add(kind);
        self.value_done();
        Ok(())
    }

    fn strings_mut(&mut self, node: NodeId) -> Result<&mut StringTally> {
        Ok(self.node_mut(node)?.strings.get_or_insert_default())
    }

    /// An interned string (`Tag.InternedString`).
    fn add_case(&mut self, s: &str) -> Result<()> {
        let node = self.destination()?;
        let id = self.tallies.strings.intern_text(s);
        let strings = self.strings_mut(node)?;
        *strings.cases.entry(id).or_insert(0) += 1;
        add_unrestricted(&mut strings.without_enums)?;
        self.value_done();
        Ok(())
    }

    /// A string too long to intern (`Tag.UninternedString`).
    fn add_uninterned(&mut self) -> Result<()> {
        let node = self.destination()?;
        let strings = self.strings_mut(node)?;
        strings.not_interned = true;
        add_unrestricted(&mut strings.with_enums)?;
        add_unrestricted(&mut strings.without_enums)?;
        self.value_done();
        Ok(())
    }

    /// A string of a transformed kind without attribute producer
    /// (`Tag.StringFormat`).
    fn add_string_format(&mut self, kind: TypeKind) -> Result<()> {
        let node = self.destination()?;
        let strings = self.strings_mut(node)?;
        strings.not_interned = true;
        add_transformation(&mut strings.with_enums, kind)?;
        add_transformation(&mut strings.without_enums, kind)?;
        self.value_done();
        Ok(())
    }

    /// A string of a transformed kind with an attribute producer (`uri`,
    /// `Tag.TransformedString`): the producer's attributes, then the kind.
    fn add_transformed_string(
        &mut self,
        kind: TypeKind,
        attributes: &TypeAttributes,
    ) -> Result<()> {
        let node = self.destination()?;
        let strings = self.strings_mut(node)?;
        strings.not_interned = true;
        add_produced(&mut strings.with_enums, attributes)?;
        add_transformation(&mut strings.with_enums, kind)?;
        add_produced(&mut strings.without_enums, attributes)?;
        add_transformation(&mut strings.without_enums, kind)?;
        self.value_done();
        Ok(())
    }
}

impl JsonSink for TallyBuilder<'_> {
    /// The tree of the sample.
    type Root = NodeId;

    fn commit_null(&mut self) -> Result<()> {
        self.add_kind(TypeKind::Null)
    }

    fn commit_boolean(&mut self, _v: bool) -> Result<()> {
        self.add_kind(TypeKind::Bool)
    }

    fn commit_number(&mut self, is_double: bool) -> Result<()> {
        self.add_kind(if is_double {
            TypeKind::Double
        } else {
            TypeKind::Integer
        })
    }

    /// `commitString(s)`: classifies the string as `CompressedJSON` does.
    fn commit_string(&mut self, s: &str) -> Result<()> {
        let expecting_ref = matches!(
            self.frames.last(),
            Some(Frame::Object {
                expecting_ref: true,
                ..
            })
        );
        if self.config.handle_refs() && expecting_ref {
            return self.add_case(s);
        }
        match infer_transformed_string_type_kind_for_string(s, self.config.date_time_recognizer()) {
            Some(kind) => match transformed_string_type_attributes_producer(kind) {
                Some(producer) => self.add_transformed_string(kind, &producer(s)),
                None => self.add_string_format(kind),
            },
            None if utf16::len(s) <= 64 => self.add_case(s),
            None => self.add_uninterned(),
        }
    }

    fn push_object_context(&mut self) -> Result<()> {
        let node = self.destination()?;
        let n = self.node_mut(node)?;
        n.kinds.add(TypeKind::Object);
        n.object.get_or_insert_default().count += 1;
        self.frames.push(Frame::Object {
            node,
            value: None,
            expecting_ref: false,
            next_key: 0,
        });
        Ok(())
    }

    fn set_property_key(&mut self, key: &str) -> Result<()> {
        let Some(&Frame::Object { node, next_key, .. }) = self.frames.last() else {
            return panic("Setting a key outside an object");
        };
        let Tallies {
            nodes,
            free,
            strings,
            ..
        } = &mut *self.tallies;
        let mut replaced = None;
        let (value, next_key) = if key == "__proto__" {
            let fresh = alloc(nodes, free)?;
            let object = defined(defined(nodes.get_mut(node as usize))?.object.as_mut())?;
            object.add_proto_occurrences(1);
            replaced = object.proto.replace(fresh);
            (fresh, next_key)
        } else {
            let object = defined(defined(nodes.get_mut(node as usize))?.object.as_mut())?;
            let expected = object
                .keys
                .get_index(next_key)
                .is_some_and(|(&id, _)| strings.get(id as usize) == Some(key));
            let index = if expected {
                next_key
            } else {
                let id = strings.intern_text(key);
                match object.keys.get_index_of(&id) {
                    Some(index) => index,
                    None => {
                        let fresh = alloc(nodes, free)?;
                        let object =
                            defined(defined(nodes.get_mut(node as usize))?.object.as_mut())?;
                        object.keys.insert(
                            id,
                            KeyTally {
                                count: 0,
                                node: fresh,
                            },
                        );
                        object.keys.len() - 1
                    }
                }
            };
            let object = defined(defined(nodes.get_mut(node as usize))?.object.as_mut())?;
            let (_, tally) = defined(object.keys.get_index_mut(index))?;
            tally.count += 1;
            (tally.node, index + 1)
        };
        if let Some(old) = replaced {
            self.tallies.free_tree(old);
        }
        if let Some(Frame::Object {
            value: v,
            expecting_ref,
            next_key: n,
            ..
        }) = self.frames.last_mut()
        {
            *v = Some(value);
            *expecting_ref = key == "$ref";
            *n = next_key;
        }
        Ok(())
    }

    fn finish_object(&mut self) -> Result<()> {
        match self.frames.pop() {
            Some(Frame::Object { .. }) => {
                self.value_done();
                Ok(())
            }
            _ => panic("Object ended but not started"),
        }
    }

    fn push_array_context(&mut self) -> Result<()> {
        let node = self.destination()?;
        let items = match self.node_mut(node)?.items {
            Some(items) => items,
            None => {
                let items = self.tallies.new_tree()?;
                self.node_mut(node)?.items = Some(items);
                items
            }
        };
        self.node_mut(node)?.kinds.add(TypeKind::Array);
        self.frames.push(Frame::Array { items });
        Ok(())
    }

    fn finish_array(&mut self) -> Result<()> {
        match self.frames.pop() {
            Some(Frame::Array { .. }) => {
                self.value_done();
                Ok(())
            }
            _ => panic("Array ended but not started"),
        }
    }

    fn finish(&mut self) -> Result<NodeId> {
        if !self.frames.is_empty() {
            return panic("Finished with contexts present");
        }
        match self.root.take() {
            Some(root) => Ok(root),
            None => panic("Finished without root document"),
        }
    }

    fn integer_string_fits(&self, integer_string: &str) -> bool {
        self.config.integer_string_fits(integer_string)
    }

    fn parsed_number_is_double(&self, n: f64) -> bool {
        self.config.parsed_number_is_double(n)
    }

    /// Frees the failed sample's tree: the tallies are as they were before
    /// it (but for the text of its keys and strings).
    fn reset_partial_sample(&mut self) {
        self.frames.clear();
        if let Some(root) = self.root.take() {
            self.tallies.free_tree(root);
        }
    }
}

impl Drop for TallyBuilder<'_> {
    /// Frees a sample that was started but not finished.
    fn drop(&mut self) {
        self.reset_partial_sample();
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::date_time::DefaultDateTimeRecognizer;
    use crate::input::compressed_json::parse_string_into;
    use crate::input::compressed_json_from_stream::parse_stream_into;

    fn config(handle_refs: bool) -> CompressedJson {
        CompressedJson::with_int64_range(Box::new(DefaultDateTimeRecognizer), handle_refs)
    }

    /// Reads `samples` (at least one), each into a tree of its own, and
    /// merges them in order; returns the tree.
    fn read(tallies: &mut Tallies, config: &CompressedJson, samples: &[&str]) -> NodeId {
        let trees: Vec<NodeId> = samples
            .iter()
            .map(|sample| {
                parse_stream_into(&mut TallyBuilder::new(tallies, config), sample.as_bytes())
                    .expect("valid JSON")
            })
            .collect();
        let (&first, rest) = trees.split_first().expect("a sample");
        for &tree in rest {
            tallies.merge(first, tree).unwrap();
        }
        first
    }

    fn dump(tallies: &Tallies, node: NodeId) -> String {
        tallies.dump(node)
    }

    #[test]
    fn kinds_in_first_seen_order() {
        let mut kinds = KindOrder::default();
        assert!(kinds.is_empty());
        for kind in [
            TypeKind::Integer,
            TypeKind::Null,
            TypeKind::Integer,
            TypeKind::Array,
            TypeKind::Double,
            TypeKind::Null,
            TypeKind::Bool,
            TypeKind::Object,
            TypeKind::Bool,
        ] {
            kinds.add(kind);
        }
        assert_eq!(
            kinds.iter().collect::<Vec<_>>(),
            [
                TypeKind::Integer,
                TypeKind::Null,
                TypeKind::Array,
                TypeKind::Double,
                TypeKind::Bool,
                TypeKind::Object
            ]
        );
    }

    #[test]
    fn proto_is_listed_at_each_occurrence_with_its_last_value() {
        let config = config(false);
        let mut tallies = Tallies::new();
        let root = read(
            &mut tallies,
            &config,
            &[r#"[{"a":1,"__proto__":1,"__proto__":{"x":2},"b":1},{"__proto__":"s","a":2}]"#],
        );
        let items = tallies.node(root).unwrap().items.unwrap();
        let object = tallies.node(items).unwrap().object.as_deref().unwrap();
        assert_eq!(object.count, 2);
        assert_eq!(
            object.property_names().collect::<Vec<_>>(),
            [(Some(0), 1), (None, 2), (Some(1), 1), (None, 1)]
        );
        assert_eq!(object.keys[0].count, 2);
        let proto = tallies.node(object.proto.unwrap()).unwrap();
        assert!(proto.kinds.is_empty());
        assert!(proto.strings.is_some());
    }

    #[test]
    fn replaced_proto_values_are_freed() {
        let config = config(false);
        let mut tallies = Tallies::new();
        let one = r#"{"__proto__":{"a":{"b":[1]}}}"#;
        let root = read(&mut tallies, &config, &[one]);
        let after_one = tallies.live_nodes();
        let more = read(&mut tallies, &config, &[one, one, one]);
        tallies.merge(root, more).unwrap();
        assert_eq!(tallies.live_nodes(), after_one);
        // Also within one sample.
        let mut within = Tallies::new();
        read(
            &mut within,
            &config,
            &[r#"[{"__proto__":{"a":{"b":[1]}},"__proto__":{"a":{"b":[1]}}}]"#],
        );
        let mut once = Tallies::new();
        read(&mut once, &config, &[r#"[{"__proto__":{"a":{"b":[1]}}}]"#]);
        assert_eq!(within.live_nodes(), once.live_nodes());
    }

    const SAMPLES: [&str; 4] = [
        r#"{"a":[1,"x"],"b":{"__proto__":1,"c":null},"d":"2020-01-01"}"#,
        r#"[{"b":{"e":true,"__proto__":[2]}},"http://h/x.PNG",{"a":[]}]"#,
        r#"{"z":{"y":1},"a":[{"q":1.5}],"b":{"c":"s","__proto__":"t"},"d":"https://h/y.jpg"}"#,
        r#""long string, long string, long string, long string, long string, too""#,
    ];

    /// Merging the samples' trees gives the tree of the elements of one
    /// array of them, read in one go, however the samples are grouped.
    #[test]
    fn merging_trees_is_reading_on() {
        let config = config(true);
        let mut one = Tallies::new();
        let root = read(&mut one, &config, &[&format!("[{}]", SAMPLES.join(","))]);
        let items = one.node(root).unwrap().items.unwrap();
        for split in 1..SAMPLES.len() {
            let mut two = Tallies::new();
            let a = read(&mut two, &config, &SAMPLES[..split]);
            let b = read(&mut two, &config, &SAMPLES[split..]);
            two.merge(a, b).unwrap();
            assert_eq!(dump(&two, a), dump(&one, items), "split at {split}");
            // All but the array's node.
            assert_eq!(two.live_nodes(), one.live_nodes() - 1, "split at {split}");
        }
    }

    /// A merge that fails anywhere leaves the tree merged into as it was
    /// and frees the other one.
    #[test]
    fn a_failed_merge_changes_nothing() {
        let config = config(false);
        let first = [
            r#"{"a":[1,{"b":"x"}],"c":{"d":"2020-01-01","g":[[1]]},"__proto__":{"p":1}}"#,
            SAMPLES[0],
        ];
        let second = [
            r#"{"a":[2.5,{"b":"http://h/y.png","e":null}],"c":{"d":"y","f":[true],"g":[["s"]]},"__proto__":[1]}"#,
            SAMPLES[2],
        ];
        let mut expected = Tallies::new();
        let all = read(
            &mut expected,
            &config,
            &[first[0], first[1], second[0], second[1]],
        );
        let steps = {
            let mut tallies = Tallies::new();
            let a = read(&mut tallies, &config, &first);
            let b = read(&mut tallies, &config, &second);
            tallies.plan_merge(a, b).unwrap().len()
        };
        assert!(steps > 10, "{steps} steps");
        for fail_at in 0..steps {
            let mut tallies = Tallies::new();
            let a = read(&mut tallies, &config, &first);
            let before = (dump(&tallies, a), tallies.live_nodes());
            let b = read(&mut tallies, &config, &second);
            tallies.fail_merge_at.set(Some(fail_at));
            assert!(tallies.merge(a, b).is_err(), "failing at step {fail_at}");
            assert_eq!(
                (dump(&tallies, a), tallies.live_nodes()),
                before,
                "failing at step {fail_at}"
            );
            // The tree takes the next merge as if nothing had happened.
            let b = read(&mut tallies, &config, &second);
            tallies.merge(a, b).unwrap();
            assert_eq!(dump(&tallies, a), dump(&expected, all));
            assert_eq!(tallies.live_nodes(), expected.live_nodes());
        }
    }

    /// A sample that fails part way, at any point, is forgotten: the next
    /// sample reads as if it had been the only one.
    #[test]
    fn a_failed_sample_leaves_nothing_behind() {
        let config = config(false);
        let good = r#"{"a":[1,{"b":"x"}],"c":"2020-01-01","__proto__":{"q":[]}}"#;
        let broken = r#"{"a":[2.5,{"b":"y","z":[null,{"w":"http://h/a.png"}]}],"c":"q","__proto__":{"p":1},"d":{"e":[[1]]}}"#;
        let mut expected = Tallies::new();
        let tree = read(&mut expected, &config, &[good]);
        let expected = (dump(&expected, tree), expected.live_nodes());
        for cut in 1..broken.len() {
            let mut tallies = Tallies::new();
            let mut builder = TallyBuilder::new(&mut tallies, &config);
            assert!(parse_stream_into(&mut builder, &broken.as_bytes()[..cut]).is_err());
            let tree = parse_stream_into(&mut builder, good.as_bytes()).unwrap();
            drop(builder);
            assert_eq!(
                (dump(&tallies, tree), tallies.live_nodes()),
                expected,
                "cut at {cut}"
            );
        }
        // A builder dropped in the middle of a sample frees it too.
        let mut tallies = Tallies::new();
        let mut builder = TallyBuilder::new(&mut tallies, &config);
        builder.push_object_context().unwrap();
        builder.set_property_key("a").unwrap();
        builder.push_array_context().unwrap();
        builder.commit_null().unwrap();
        drop(builder);
        assert_eq!(tallies.live_nodes(), 0);
    }

    /// `JSON.parse` samples emit what the stream reader emits for text both
    /// read alike.
    #[test]
    fn text_samples_tally_as_streamed() {
        let samples = [
            r##"{"a":[1,"x",1.5,"2020-01-01T00:00:00Z"],"$ref":"#/a","u":"http://h/x.png"}"##,
            r#"{"__proto__":[{"b":"0123"}],"e":{},"f":[[]],"g":"7"}"#,
        ];
        for handle_refs in [false, true] {
            let config = config(handle_refs);
            let mut streamed = Tallies::new();
            let root = read(&mut streamed, &config, &samples);
            let mut parsed = Tallies::new();
            let trees: Vec<NodeId> = samples
                .iter()
                .map(|sample| {
                    parse_string_into(&mut TallyBuilder::new(&mut parsed, &config), sample).unwrap()
                })
                .collect();
            parsed.merge(trees[0], trees[1]).unwrap();
            assert_eq!(dump(&parsed, trees[0]), dump(&streamed, root));
        }
    }

    #[test]
    fn string_attributes_combine_once_per_change() {
        let config = config(false);
        let mut tallies = Tallies::new();
        let root = read(
            &mut tallies,
            &config,
            &[r#"["2020-01-01","x","http://h/a.PNG","2020-01-02","https://h/b.png","12:00:00Z"]"#],
        );
        let items = tallies.node(root).unwrap().items.unwrap();
        let strings = tallies.node(items).unwrap().strings.as_deref().unwrap();
        let with_enums = strings.with_enums.as_ref().unwrap();
        let st = StringTypesTypeAttributeKind
            .try_get_in_attributes(with_enums)
            .unwrap();
        assert_eq!(
            st.transformations.iter().copied().collect::<Vec<_>>(),
            [TypeKind::Date, TypeKind::Uri, TypeKind::Time]
        );
        let uri = UriTypeAttributeKind
            .try_get_in_attributes(with_enums)
            .unwrap();
        assert_eq!(uri.0.iter().collect::<Vec<_>>(), ["http", "https"]);
        assert_eq!(uri.1.iter().collect::<Vec<_>>(), [".png"]);
        // Without enum inference "x" is an unrestricted string.
        let without = strings.without_enums.as_ref().unwrap();
        assert!(
            !StringTypesTypeAttributeKind
                .try_get_in_attributes(without)
                .unwrap()
                .is_restricted()
        );
        assert_eq!(strings.cases.len(), 1);
    }
}
