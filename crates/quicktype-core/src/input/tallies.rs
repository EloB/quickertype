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
use std::mem::size_of;
use std::rc::Rc;

use indexmap::IndexMap;
use quicktype_js_compat::utf16;

use super::compressed_json::{
    CompressedJson, JsonSink, StringReaderState, Strings, TableCounts, Value, vec_size,
};
use crate::attributes::string_types::{
    StringTypes, StringTypesTypeAttributeKind, infer_transformed_string_type_kind_for_string,
    may_have_attributes,
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
    /// What `with_enums` and `without_enums` are known to absorb, as bits
    /// (see [`add_unrestricted_once`]), which the values' combinations
    /// set; a merge keeps those of both tallies.
    absorbed: [u32; 2],
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

/// The bit of `StringTally::absorbed` for unrestricted string types, which
/// absorb every other string type.
const ABSORBS_UNRESTRICTED: u32 = 1 << 31;

/// The bit of `StringTally::absorbed` for transformation `kind`; none
/// (never recorded) for a kind past the bits.
fn absorbs_transformation(kind: TypeKind) -> u32 {
    match 1u32.checked_shl(kind as u32) {
        Some(bit) if bit != ABSORBS_UNRESTRICTED => bit,
        _ => 0,
    }
}

/// [`add_unrestricted`], skipped once `absorbed` says the string types are
/// unrestricted. Combining only ever adds (the union of string types is
/// unrestricted if either is, and unites the transformations), so once
/// the combined string types absorb an addition they always do, and the
/// bit records that instead of looking at them for every value.
#[inline(always)]
fn add_unrestricted_once(combined: &mut Option<TypeAttributes>, absorbed: &mut u32) -> Result<()> {
    if *absorbed & ABSORBS_UNRESTRICTED != 0 {
        return Ok(());
    }
    add_unrestricted(combined)?;
    *absorbed |= ABSORBS_UNRESTRICTED;
    Ok(())
}

/// [`add_transformation`], skipped once `absorbed` says the string types
/// allow `kind` or are unrestricted (see [`add_unrestricted_once`]).
#[inline(always)]
fn add_transformation_once(
    combined: &mut Option<TypeAttributes>,
    absorbed: &mut u32,
    kind: TypeKind,
) -> Result<()> {
    let bit = absorbs_transformation(kind);
    if *absorbed & (ABSORBS_UNRESTRICTED | bit) != 0 {
        return Ok(());
    }
    add_transformation(combined, kind)?;
    *absorbed |= bit;
    Ok(())
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

/// Whether combining `b` into `a` gives `a` again, so that the combination
/// can be skipped, as reading skips it (see [`add_unrestricted`],
/// [`add_transformation`] and [`add_produced`]): `b` holds nothing but string
/// types and URI attributes, and `a`'s absorb them. `combineTypeAttributes`
/// combines kind by kind, keeping `a`'s order; string types that are
/// unrestricted stay as they are, restricted ones without cases add no
/// transformation `a` lacks, and URI attributes add no protocol or
/// extension `a` lacks.
fn absorbs(a: &TypeAttributes, b: &TypeAttributes) -> bool {
    let string_types = StringTypesTypeAttributeKind.try_get_in_attributes(b);
    let uri = UriTypeAttributeKind.try_get_in_attributes(b);
    if b.iter().count() != usize::from(string_types.is_some()) + usize::from(uri.is_some()) {
        return false;
    }
    let string_types_absorbed = string_types.is_none_or(|b| {
        StringTypesTypeAttributeKind
            .try_get_in_attributes(a)
            .is_some_and(|a| {
                !a.is_restricted()
                    || (b.cases.as_ref().is_some_and(IndexMap::is_empty)
                        && b.transformations
                            .iter()
                            .all(|t| a.transformations.contains(t)))
            })
    });
    let uri_absorbed = uri.is_none_or(|(protocols, extensions)| {
        UriTypeAttributeKind
            .try_get_in_attributes(a)
            .is_some_and(|(p, e)| {
                protocols.iter().all(|x| p.contains(x)) && extensions.iter().all(|x| e.contains(x))
            })
    });
    string_types_absorbed && uri_absorbed
}

/// `a` with `b` combined into it, as [`combine_into`] does, if that takes
/// a combination; `None` if `b` adds nothing or `a` is empty, where the
/// result is `a` or `b` as they are.
fn combined(
    a: &Option<TypeAttributes>,
    b: &Option<TypeAttributes>,
) -> Result<Option<TypeAttributes>> {
    match (a, b) {
        (Some(a), Some(b)) if !b.is_empty() && !absorbs(a, b) => Ok(Some(
            combine_type_attributes2(CombinationKind::Union, a, b)?,
        )),
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
    /// Whether the string types are unrestricted both with and without
    /// enum inference: then a string here changes nothing inference reads
    /// but for a URI's attributes (see [`Tallies::add_case`]). Once true,
    /// always true, as [`add_unrestricted_once`] argues, and a merge keeps
    /// it.
    #[inline(always)]
    fn absorbs_strings(&self) -> bool {
        self.absorbed[0] & self.absorbed[1] & ABSORBS_UNRESTRICTED != 0
    }

    /// What an interned string (`Tag.InternedString`) adds besides its
    /// case: an unrestricted string, without enum inference.
    #[inline(always)]
    fn add_interned(&mut self) -> Result<()> {
        add_unrestricted_once(&mut self.without_enums, &mut self.absorbed[1])
    }

    /// A string too long to intern (`Tag.UninternedString`).
    #[inline(always)]
    fn add_uninterned(&mut self) -> Result<()> {
        self.not_interned = true;
        add_unrestricted_once(&mut self.with_enums, &mut self.absorbed[0])?;
        add_unrestricted_once(&mut self.without_enums, &mut self.absorbed[1])
    }

    /// A string of a transformed kind without attribute producer
    /// (`Tag.StringFormat`).
    #[inline(always)]
    fn add_string_format(&mut self, kind: TypeKind) -> Result<()> {
        self.not_interned = true;
        add_transformation_once(&mut self.with_enums, &mut self.absorbed[0], kind)?;
        add_transformation_once(&mut self.without_enums, &mut self.absorbed[1], kind)
    }

    /// A string of a transformed kind with an attribute producer (`uri`,
    /// `Tag.TransformedString`): the producer's attributes, then the kind.
    fn add_transformed_string(
        &mut self,
        kind: TypeKind,
        attributes: &TypeAttributes,
    ) -> Result<()> {
        self.not_interned = true;
        add_produced(&mut self.with_enums, attributes)?;
        add_transformation_once(&mut self.with_enums, &mut self.absorbed[0], kind)?;
        add_produced(&mut self.without_enums, attributes)?;
        add_transformation_once(&mut self.without_enums, &mut self.absorbed[1], kind)
    }

    /// The fallible part of appending `other`'s strings after these: the
    /// combined attributes, computed without changing anything.
    fn combined_with(&self, other: &StringTally) -> Result<Combined> {
        Ok((
            combined(&self.with_enums, &other.with_enums)?,
            combined(&self.without_enums, &other.without_enums)?,
        ))
    }

    /// Appends `other`'s strings after these, with the attributes
    /// [`combined_with`](Self::combined_with) computed for them, and
    /// empties `other`.
    fn append(&mut self, other: &mut StringTally, (with_enums, without_enums): Combined) {
        for (id, count) in other.cases.drain(..) {
            *self.cases.entry(id).or_insert(0) += count;
        }
        take_combined(&mut self.with_enums, other.with_enums.take(), with_enums);
        take_combined(
            &mut self.without_enums,
            other.without_enums.take(),
            without_enums,
        );
        self.not_interned |= other.not_interned;
        // What either combination absorbs, their union does.
        for (absorbed, other) in self.absorbed.iter_mut().zip(other.absorbed) {
            *absorbed |= other;
        }
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

    /// Appends `other`'s objects after these, and empties `other`. The
    /// values of a key both have are joined by a merge step of their own;
    /// `other`'s last `__proto__` value replaces this one's, which goes to
    /// `replaced`.
    fn append(&mut self, other: &mut ObjectTally, replaced: &mut Vec<NodeId>) {
        self.count += other.count;
        let mut runs = other.proto_runs.drain(..).peekable();
        for (i, (id, tally)) in other.keys.drain(..).enumerate() {
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
        if let Some(proto) = other.proto.take()
            && let Some(old) = self.proto.replace(proto)
        {
            replaced.push(old);
        }
    }
}

/// How many emptied string and object tallies [`Tallies`] keeps for the
/// places of the next samples (of each kind), and the most cases or keys
/// one may have room for: at most a few hundred kilobytes.
const SPARE_TALLIES: usize = 256;
const SPARE_CAPACITY: usize = 64;

/// Keeps `tally` for reuse, emptied, unless there are enough or it is
/// large.
fn keep_spare<T: Default>(
    spares: &mut Vec<Box<T>>,
    mut tally: Box<T>,
    empty: impl FnOnce(&mut T) -> usize,
) {
    let capacity = empty(&mut tally);
    if spares.len() < SPARE_TALLIES && capacity <= SPARE_CAPACITY {
        spares.push(tally);
    }
}

/// Empties a string tally (keeping the room for its cases); returns that room.
fn empty_strings(tally: &mut StringTally) -> usize {
    let mut cases = std::mem::take(&mut tally.cases);
    cases.clear();
    *tally = StringTally {
        cases,
        ..StringTally::default()
    };
    tally.cases.capacity()
}

/// Empties an object tally (keeping the room for its keys); returns that room.
fn empty_object(tally: &mut ObjectTally) -> usize {
    let mut keys = std::mem::take(&mut tally.keys);
    keys.clear();
    let mut proto_runs = std::mem::take(&mut tally.proto_runs);
    proto_runs.clear();
    *tally = ObjectTally {
        keys,
        proto_runs,
        ..ObjectTally::default()
    };
    tally.keys.capacity()
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

/// The nodes of all tallies of a JSON input. Keys and string cases are
/// string ids, whose text is in a string table beside them: the
/// [`RunningTallies`]' own, or the compressed form's for the tallies of a
/// compressed form ([`tally_compressed`]).
pub(crate) struct Tallies {
    nodes: Vec<Node>,
    /// Nodes no tree uses any more, for reuse.
    free: Vec<NodeId>,
    /// Emptied string and object tallies, for reuse: each sample is read
    /// into a tree of its own, which merging empties. Boxed as the nodes
    /// hold them, so that reusing one moves a pointer.
    #[allow(clippy::vec_box)]
    spare_strings: Vec<Box<StringTally>>,
    #[allow(clippy::vec_box)]
    spare_objects: Vec<Box<ObjectTally>>,
    /// Where string cases were counted last ([`CaseSlot`]); empty until
    /// the first case, then [`CASE_SLOTS`] long.
    case_slots: Vec<CaseSlot>,
    /// Makes the next [`merge`](Self::merge) fail after planning this many
    /// steps (for tests).
    #[cfg(test)]
    pub(crate) fail_merge_at: Cell<Option<usize>>,
}

/// The running tallies of a JSON input's samples (see [`TallyBuilder`]),
/// and the text of their keys and string cases.
pub(crate) struct RunningTallies {
    pub(crate) tallies: Tallies,
    /// The text of the keys and string cases, by the ids the tallies know
    /// them by.
    pub(crate) strings: Strings,
    /// What the `JSON.parse` reader keeps between samples.
    string_reader: StringReaderState,
}

impl RunningTallies {
    pub(crate) fn new() -> Self {
        RunningTallies {
            tallies: Tallies::new(),
            strings: Strings::new(),
            string_reader: StringReaderState::default(),
        }
    }

    /// The tree at `node` with keys and cases as text (for tests).
    #[cfg(test)]
    pub(crate) fn dump(&self, node: NodeId) -> String {
        self.tallies.dump(&self.strings, node)
    }
}

impl fmt::Debug for RunningTallies {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.debug_struct("RunningTallies")
            .field("tallies", &self.tallies)
            .field("strings", &self.strings.len())
            .finish_non_exhaustive()
    }
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
            .finish_non_exhaustive()
    }
}

/// About how many bytes `map`'s buffers take: its entries (each with its
/// hash) and its index table (an index and a control byte per bucket).
fn map_size<K, V, S>(map: &IndexMap<K, V, S>) -> usize {
    map.capacity() * (size_of::<(u64, K, V)>() + size_of::<usize>() + 1)
}

fn string_tally_size(tally: &StringTally) -> usize {
    size_of::<StringTally>() + map_size(&tally.cases)
}

fn object_tally_size(tally: &ObjectTally) -> usize {
    size_of::<ObjectTally>() + map_size(&tally.keys) + vec_size(&tally.proto_runs)
}

/// The tallies of a compressed form's top-levels ([`tally_compressed`]).
pub(crate) struct FormTallies {
    pub(crate) tallies: Tallies,
    /// Each top-level's tree, in order.
    pub(crate) roots: Vec<NodeId>,
}

/// What the walk made of a compressed form's samples, kept with the form
/// ([`CompressedJson::kept_tallies`]) for the next inference over the same
/// samples (`JsonInput::set_keep_tallies`): their tallies, or that the walk
/// declined them. A form only ever grows, and what is in it never changes,
/// so the walk makes the same of the same samples. Adding a sample drops
/// this, since the next inference will most likely be over more samples.
pub(crate) struct KeptTallies {
    /// Each top-level's samples, as they were walked: the input's own
    /// lists, shared, not copies.
    samples: Vec<Rc<Vec<Value>>>,
    /// Their tallies; `None` if the walk declined them.
    tallied: Option<Rc<FormTallies>>,
    /// About how many bytes this holds.
    bytes: usize,
}

impl KeptTallies {
    /// What the walk made of the samples `top_levels` (`None` for a
    /// decline), to keep.
    pub(crate) fn new(
        tallied: Option<FormTallies>,
        top_levels: impl IntoIterator<Item = Rc<Vec<Value>>>,
    ) -> Self {
        let tallied = tallied.map(|mut tallied| {
            tallied.tallies.trim();
            Rc::new(tallied)
        });
        let samples: Vec<Rc<Vec<Value>>> = top_levels.into_iter().collect();
        // The lists count here: they outlive the input they are shared
        // with, as long as these are kept.
        let bytes = size_of::<Self>()
            + tallied.as_ref().map_or(0, |t| {
                size_of::<FormTallies>() + t.tallies.heap_size() + vec_size(&t.roots)
            })
            + vec_size(&samples)
            + samples
                .iter()
                .map(|s| size_of::<Vec<Value>>() + vec_size(s))
                .sum::<usize>();
        KeptTallies {
            samples,
            tallied,
            bytes,
        }
    }

    /// The tallies; `None` if the walk declined the samples.
    pub(crate) fn tallied(&self) -> Option<&Rc<FormTallies>> {
        self.tallied.as_ref()
    }

    /// Whether this is what the walk made of `top_levels`' samples.
    pub(crate) fn of<'c>(&self, top_levels: impl IntoIterator<Item = &'c [Value]>) -> bool {
        let mut count = 0;
        for (i, samples) in top_levels.into_iter().enumerate() {
            // The same list (the input that made these) or an equal one.
            let same = self
                .samples
                .get(i)
                .is_some_and(|s| std::ptr::eq(s.as_slice(), samples) || s.as_slice() == samples);
            if !same {
                return false;
            }
            count += 1;
        }
        count == self.samples.len()
    }

    /// About how many bytes these tallies hold.
    pub(crate) fn heap_size(&self) -> usize {
        self.bytes
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
            spare_strings: Vec::new(),
            spare_objects: Vec::new(),
            case_slots: Vec::new(),
            #[cfg(test)]
            fail_merge_at: Cell::new(None),
        }
    }

    /// The node `id`.
    pub(crate) fn node(&self, id: NodeId) -> Result<&Node> {
        defined(self.nodes.get(id as usize))
    }

    /// The number of nodes in use (for tests).
    #[cfg(test)]
    pub(crate) fn live_nodes(&self) -> usize {
        self.nodes.len() - self.free.len()
    }

    /// The tree at `node` with keys and cases as their text in `strings`,
    /// independent of node numbers (for tests).
    #[cfg(test)]
    pub(crate) fn dump(&self, strings: &Strings, node: NodeId) -> String {
        let text = |id: u32| strings.get(id as usize).unwrap();
        let n = self.node(node).unwrap();
        let mut out = format!("{:?}", n.kinds);
        if let Some(s) = &n.strings {
            let cases: Vec<(&str, u64)> = s.cases.iter().map(|(&id, &c)| (text(id), c)).collect();
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
                    text(id),
                    k.count,
                    self.dump(strings, k.node)
                );
            }
            if let Some(p) = o.proto {
                out += &format!("__proto__: {}", self.dump(strings, p));
            }
            out += "}";
        }
        if let Some(items) = n.items {
            out += &format!(" items [{}]", self.dump(strings, items));
        }
        out
    }

    /// About how many bytes the tallies hold: their buffers and what
    /// their nodes own (not what the allocator adds, nor the few attribute
    /// sets of each place's strings).
    pub(crate) fn heap_size(&self) -> usize {
        let nodes: usize = self
            .nodes
            .iter()
            .map(|n| {
                n.strings.as_deref().map_or(0, string_tally_size)
                    + n.object.as_deref().map_or(0, object_tally_size)
            })
            .sum();
        let spares: usize = self
            .spare_strings
            .iter()
            .map(|s| string_tally_size(s))
            .chain(self.spare_objects.iter().map(|o| object_tally_size(o)))
            .sum();
        vec_size(&self.nodes)
            + vec_size(&self.free)
            + vec_size(&self.spare_strings)
            + vec_size(&self.spare_objects)
            + vec_size(&self.case_slots)
            + nodes
            + spares
    }

    /// Drops what only adding to the tallies needs (the spare tallies, the
    /// case slots, the free list) and the room the buffers grew for (of the
    /// nodes, and of each place's cases and keys: up to half of what they
    /// hold), for tallies that are kept as they are. (The nodes freed for
    /// a `__proto__` stay, empty: compacting would renumber every node,
    /// and only a repeated `__proto__` key frees one.)
    fn trim(&mut self) {
        self.spare_strings = Vec::new();
        self.spare_objects = Vec::new();
        self.case_slots = Vec::new();
        self.free = Vec::new();
        self.nodes.shrink_to_fit();
        for node in &mut self.nodes {
            if let Some(strings) = &mut node.strings {
                strings.cases.shrink_to_fit();
            }
            if let Some(object) = &mut node.object {
                object.keys.shrink_to_fit();
                object.proto_runs.shrink_to_fit();
            }
        }
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
                keep_spare(&mut self.spare_objects, object, empty_object);
            }
            if let Some(strings) = node.strings {
                keep_spare(&mut self.spare_strings, strings, empty_strings);
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
                (Some(xs), Some(mut ys)) => {
                    xs.append(&mut ys, step.strings.unwrap_or_default());
                    keep_spare(&mut self.spare_strings, ys, empty_strings);
                }
                (None, ys) => x.strings = ys,
                (Some(_), None) => {}
            }
            match (&mut x.object, y.object) {
                (Some(xo), Some(mut yo)) => {
                    xo.append(&mut yo, &mut replaced);
                    keep_spare(&mut self.spare_objects, yo, empty_object);
                }
                (None, yo) => x.object = yo,
                (Some(_), None) => {}
            }
        }
        for old in replaced {
            self.free_tree(old);
        }
    }
}

/// A key as [`Tallies::add_key`] counts it: the id of its text in the
/// tallies' string table, which may have to be found first.
pub(crate) trait KeyId {
    /// Whether the key is the string `id`.
    fn is(&self, id: u32) -> bool;
    /// Its string id.
    fn id(self) -> u32;
}

/// A key known by its string id (the walk's, an index of the compressed
/// form's string table).
impl KeyId for u32 {
    fn is(&self, id: u32) -> bool {
        *self == id
    }

    fn id(self) -> u32 {
        self
    }
}

/// A key known by its text (a reader's), found in the string table (and
/// added to it) only when it is not the key expected.
struct KeyText<'a> {
    strings: &'a mut Strings,
    text: &'a str,
}

impl KeyId for KeyText<'_> {
    fn is(&self, id: u32) -> bool {
        self.strings.get(id as usize) == Some(self.text)
    }

    fn id(self) -> u32 {
        self.strings.intern_text(self.text)
    }
}

/// How many places [`Tallies`] remembers where a string case was counted
/// (see [`CaseSlot`]): 12 KiB, made with the first case.
const CASE_SLOTS: usize = 1 << 10;

/// Where a string case was counted last, at a slot of [`Tallies`] chosen
/// by its string id and node: its position among the node's cases. A case
/// that recurs at a place (an enum's) is then counted without hashing it.
/// The slot may be another case's, or stale (its node freed and reused,
/// its tally merged); a position is used only if the node's case there is
/// the string, which is then its position, whatever put it there.
#[derive(Clone, Copy, Default)]
struct CaseSlot {
    id: u32,
    node: NodeId,
    position: u32,
}

/// The slot of string `id` at `node`.
fn case_slot(id: u32, node: NodeId) -> usize {
    (id ^ node.wrapping_mul(0x9E37_79B9)) as usize & (CASE_SLOTS - 1)
}

/// What each value adds at the node of its place: the handlers both the
/// [`TallyBuilder`] (for each event of a reader) and the walk over a
/// compressed form ([`tally_compressed`], for each value the event made)
/// call, so that they tally the same values alike. Keys and string cases
/// are string ids.
impl Tallies {
    #[inline(always)]
    fn node_mut(&mut self, id: NodeId) -> Result<&mut Node> {
        defined(self.nodes.get_mut(id as usize))
    }

    /// The strings at `node`, a new tally if there are none yet.
    #[inline(always)]
    fn strings_mut(&mut self, node: NodeId) -> Result<&mut StringTally> {
        let Tallies {
            nodes,
            spare_strings,
            ..
        } = self;
        let n = defined(nodes.get_mut(node as usize))?;
        Ok(n.strings
            .get_or_insert_with(|| spare_strings.pop().unwrap_or_default()))
    }

    /// A `null`, a boolean or a number, of non-string `kind`.
    #[inline(always)]
    pub(crate) fn add_kind(&mut self, node: NodeId, kind: TypeKind) -> Result<()> {
        self.node_mut(node)?.kinds.add(kind);
        Ok(())
    }

    /// Whether the strings at `node` absorb every further string but a
    /// URI ([`StringTally::absorbs_strings`]): the reader need not
    /// classify or intern a string here that cannot be one.
    #[inline(always)]
    pub(crate) fn absorbs_strings(&self, node: NodeId) -> Result<bool> {
        Ok(self
            .node(node)?
            .strings
            .as_deref()
            .is_some_and(StringTally::absorbs_strings))
    }

    /// An interned string (`Tag.InternedString`): the case `id`.
    ///
    /// Not counted where the strings are unrestricted with and without
    /// enum inference ([`StringTally::absorbs_strings`]): no inference
    /// reads such a place's cases. With enum inference, the cases are
    /// replayed as `addStringCase`, and `getMemberKinds` unites them with
    /// the combined string types, which are unrestricted and so absorb
    /// them (`StringTypes.union` returns the unrestricted types as they
    /// are; the `string` kind is there either way). Without it, cases are
    /// not replayed at all. A `$ref` resolves its cases only where every
    /// string is interned, and unrestricted string types with enum
    /// inference come from a string that is not (`add_uninterned` set
    /// `not_interned` with the bit). Nothing makes the place restricted
    /// again: more values only add to its string types, and a merge, the
    /// place's into another or another's into it, unites them with
    /// another place's, which is unrestricted if either is. So a case
    /// left out here is not needed later, by a merge, by tallies kept
    /// with a compressed form for later runs, or by inference with other
    /// flags.
    #[inline(always)]
    pub(crate) fn add_case(&mut self, node: NodeId, id: u32) -> Result<()> {
        let Tallies {
            nodes,
            spare_strings,
            case_slots,
            ..
        } = self;
        let n = defined(nodes.get_mut(node as usize))?;
        let strings = n
            .strings
            .get_or_insert_with(|| spare_strings.pop().unwrap_or_default());
        if strings.absorbs_strings() {
            return Ok(());
        }
        if case_slots.is_empty() {
            *case_slots = vec![CaseSlot::default(); CASE_SLOTS];
        }
        let slot = &mut case_slots[case_slot(id, node)];
        match strings.cases.get_index_mut(slot.position as usize) {
            Some((&case, count)) if slot.id == id && slot.node == node && case == id => {
                *count += 1;
            }
            _ => {
                let entry = strings.cases.entry(id);
                *slot = CaseSlot {
                    id,
                    node,
                    position: entry.index() as u32,
                };
                *entry.or_insert(0) += 1;
            }
        }
        strings.add_interned()
    }

    /// A string too long to intern (`Tag.UninternedString`).
    #[inline(always)]
    pub(crate) fn add_uninterned(&mut self, node: NodeId) -> Result<()> {
        self.strings_mut(node)?.add_uninterned()
    }

    /// A string of a transformed kind without attribute producer
    /// (`Tag.StringFormat`).
    #[inline(always)]
    pub(crate) fn add_string_format(&mut self, node: NodeId, kind: TypeKind) -> Result<()> {
        self.strings_mut(node)?.add_string_format(kind)
    }

    /// A string of a transformed kind with an attribute producer (`uri`,
    /// `Tag.TransformedString`), which made `attributes` of it.
    pub(crate) fn add_transformed_string(
        &mut self,
        node: NodeId,
        kind: TypeKind,
        attributes: &TypeAttributes,
    ) -> Result<()> {
        self.strings_mut(node)?
            .add_transformed_string(kind, attributes)
    }

    /// An object, where it starts (`pushObjectContext`); its keys and
    /// values follow.
    #[inline(always)]
    pub(crate) fn add_object(&mut self, node: NodeId) -> Result<()> {
        let Tallies {
            nodes,
            spare_objects,
            ..
        } = self;
        let n = defined(nodes.get_mut(node as usize))?;
        n.kinds.add(TypeKind::Object);
        n.object
            .get_or_insert_with(|| spare_objects.pop().unwrap_or_default())
            .count += 1;
        Ok(())
    }

    /// An array, where it starts (`pushArrayContext`): returns the node of
    /// its elements, which follow.
    #[inline(always)]
    pub(crate) fn add_array(&mut self, node: NodeId) -> Result<NodeId> {
        let items = match self.node(node)?.items {
            Some(items) => items,
            None => {
                let items = self.new_tree()?;
                self.node_mut(node)?.items = Some(items);
                items
            }
        };
        self.node_mut(node)?.kinds.add(TypeKind::Array);
        Ok(items)
    }

    /// The key `__proto__` of the object at `node` (`setPropertyKey`):
    /// listed again at each occurrence, and only its last value counts, so
    /// this returns a new node for its value and frees the previous one.
    pub(crate) fn add_proto_key(&mut self, node: NodeId) -> Result<NodeId> {
        let fresh = self.new_tree()?;
        let object = defined(self.node_mut(node)?.object.as_mut())?;
        object.add_proto_occurrences(1);
        if let Some(old) = object.proto.replace(fresh) {
            self.free_tree(old);
        }
        Ok(fresh)
    }

    /// A key other than `__proto__` of the object at `node`
    /// (`setPropertyKey`), where the key at index `expected` of the place's
    /// keys is expected: objects at one place usually list their keys in
    /// the same order, and a key found there is counted without a lookup.
    /// Returns the node of the key's value and the index of the key
    /// expected next.
    #[inline(always)]
    pub(crate) fn add_key(
        &mut self,
        node: NodeId,
        key: impl KeyId,
        expected: usize,
    ) -> Result<(NodeId, usize)> {
        let Tallies { nodes, free, .. } = self;
        let object = defined(defined(nodes.get_mut(node as usize))?.object.as_mut())?;
        if let Some((&found, tally)) = object.keys.get_index_mut(expected)
            && key.is(found)
        {
            tally.count += 1;
            return Ok((tally.node, expected + 1));
        }
        let id = key.id();
        let index = match object.keys.get_index_of(&id) {
            Some(index) => index,
            None => {
                let fresh = alloc(nodes, free)?;
                let object = defined(defined(nodes.get_mut(node as usize))?.object.as_mut())?;
                object.keys.insert(
                    id,
                    KeyTally {
                        count: 0,
                        node: fresh,
                    },
                );
                object.keys.len() - 1
            }
        };
        let object = defined(defined(nodes.get_mut(node as usize))?.object.as_mut())?;
        let (_, tally) = defined(object.keys.get_index_mut(index))?;
        tally.count += 1;
        Ok((tally.node, index + 1))
    }
}

#[cfg(test)]
thread_local! {
    /// How many walks [`tally_compressed`] started on this thread (for
    /// tests).
    pub(crate) static WALKS: Cell<usize> = const { Cell::new(0) };
}

/// Tallies the values of a compressed form (each top-level's samples, in
/// order) as reading their samples would have tallied them: the running
/// tallies of samples that were read into a [`CompressedJson`] instead
/// (the WebAssembly engine keeps its inputs in that form, which quicktype's
/// API can ask for at any time), made in one walk over it when their types
/// are inferred. Returns the tallies, whose keys and cases are the
/// compressed form's strings ([`CompressedJson::strings`]), and each
/// top-level's tree; `Ok(None)` if the values are not as a reader makes
/// them (see [`CompressedTally`]), where only inference from the values
/// themselves is exact. An error is one tallying raises (as reading the
/// samples would have), not a decline: it is the run's. See
/// `docs/STREAMING-INFERENCE.md`, "Tallies of a compressed form".
pub(crate) fn tally_compressed<'c>(
    cjson: &CompressedJson,
    top_levels: impl IntoIterator<Item = &'c [Value]>,
) -> Result<Option<(Tallies, Vec<NodeId>)>> {
    #[cfg(test)]
    WALKS.with(|walks| walks.set(walks.get() + 1));
    // A string is known by its index, but for `"__proto__"`, which is
    // interned anew each time and so is known by its text.
    if !cjson.unique_strings() {
        return Ok(None);
    }
    let mut tallies = Tallies::new();
    let mut walk = CompressedTally::new(cjson);
    let mut roots = Vec::new();
    for samples in top_levels {
        match walk.tally(&mut tallies, samples)? {
            Some(root) => roots.push(root),
            None => return Ok(None),
        }
    }
    Ok(Some((tallies, roots)))
}

/// The walk of [`tally_compressed`]: for each value, what the
/// [`TallyBuilder`] does for the reader's event that made it, with the
/// same handlers ([`Tallies::add_kind`] and the others).
///
/// The values a reader made form a tree from each sample's root: every
/// object and array is the value of exactly one key, element or root. A
/// compressed form from elsewhere (the tables of a JavaScript
/// `CompressedJSON`) could hold one that is reached twice, or a cycle; the
/// walk then declines. So it does for the other values no reader makes: an
/// object key that is not an interned string, a transformed string whose
/// text has no kind or no attribute producer (`Inference.ts` fails on it),
/// and a string table that holds a text twice. Nothing else declines: an
/// error tallying a value (a lookup that fails, too many places) is raised.
struct CompressedTally<'c> {
    cjson: &'c CompressedJson,
    /// The number of strings, objects and arrays of the form.
    counts: TableCounts,
    /// Whether the form has a `"__proto__"` text; most have none, and then
    /// no string is looked at to tell.
    protos: bool,
    /// When it has: by string index, whether the string was looked at, and
    /// whether it is `"__proto__"` (a bit each, made with the first look),
    /// so that each string's text is compared once.
    proto_seen: Vec<u64>,
    proto_strings: Vec<u64>,
    /// The index of the first `"__proto__"` looked at, which stands for
    /// every one ([`NO_INDEX`] before).
    proto: u32,
    /// Bit sets of the objects and arrays reached so far, by index, as
    /// long as the largest index reached needs.
    objects_seen: Vec<u64>,
    arrays_seen: Vec<u64>,
    /// The kind and attributes of transformed strings recognized so far,
    /// at the slot of their string index ([`TRANSFORMED_SLOTS`] of them,
    /// made with the first): the same text recurs under the same index,
    /// and is recognized once while its slot keeps it.
    transformed: Vec<Option<(u32, TypeKind, TypeAttributes)>>,
    /// The containers being walked, innermost last.
    stack: Vec<WalkFrame<'c>>,
}

/// No string index (yet).
const NO_INDEX: u32 = u32::MAX;

/// How many transformed strings (URIs) the walk keeps the kind and
/// attributes of, by string index: a bounded number, since an input of
/// distinct URIs would gain nothing from keeping them all (each a few
/// hundred bytes), and one whose URIs recur has few of them.
const TRANSFORMED_SLOTS: usize = 256;

/// An object or array whose values [`CompressedTally`] is walking.
enum WalkFrame<'c> {
    Object {
        entries: &'c [(Value, Value)],
        /// The next entry.
        next: usize,
        /// The node of the object.
        node: NodeId,
        /// The index of the key expected next (see [`Tallies::add_key`]).
        next_key: usize,
    },
    Array {
        items: &'c [Value],
        /// The next element.
        next: usize,
        /// The node of the elements.
        node: NodeId,
    },
}

/// Marks container `index` (of `count`) in `bits`, which grow to hold it;
/// whether it was not marked yet. An index past `count` is a value that is
/// not there, as looking it up finds.
#[inline(always)]
fn first_visit(bits: &mut Vec<u64>, index: u32, count: usize) -> Result<bool> {
    if index as usize >= count {
        return defined(None);
    }
    let (word, bit) = ((index / 64) as usize, 1u64 << (index % 64));
    if word >= bits.len() {
        bits.resize(word + 1, 0);
    }
    let first = bits[word] & bit == 0;
    bits[word] |= bit;
    Ok(first)
}

impl<'c> CompressedTally<'c> {
    fn new(cjson: &'c CompressedJson) -> Self {
        CompressedTally {
            cjson,
            counts: cjson.table_counts(),
            protos: cjson.has_proto_strings(),
            proto_seen: Vec::new(),
            proto_strings: Vec::new(),
            proto: NO_INDEX,
            objects_seen: Vec::new(),
            arrays_seen: Vec::new(),
            transformed: Vec::new(),
            stack: Vec::new(),
        }
    }

    /// Whether string `index` is `"__proto__"`. An index past the string
    /// table is a value that is not there, as looking it up finds.
    #[inline(always)]
    fn is_proto(&mut self, index: u32) -> Result<bool> {
        if index as usize >= self.counts.strings {
            return defined(None);
        }
        if !self.protos {
            return Ok(false);
        }
        if self.proto_seen.is_empty() {
            self.proto_seen = vec![0; self.counts.strings.div_ceil(64)];
            self.proto_strings = vec![0; self.counts.strings.div_ceil(64)];
        }
        let (word, bit) = ((index / 64) as usize, 1u64 << (index % 64));
        if self.proto_seen[word] & bit == 0 {
            self.proto_seen[word] |= bit;
            if defined(self.cjson.string(index))? == "__proto__" {
                self.proto_strings[word] |= bit;
                if self.proto == NO_INDEX {
                    self.proto = index;
                }
            }
        }
        Ok(self.proto_strings[word] & bit != 0)
    }

    /// The kind and attributes `commitString` classified the transformed
    /// string `index` by, recognized from its text as `Inference.ts`
    /// recognizes them (once while its slot keeps them); `None` if it has
    /// no kind or no attribute producer.
    fn transformed(&mut self, index: u32) -> Result<Option<(TypeKind, &TypeAttributes)>> {
        if self.transformed.is_empty() {
            self.transformed.resize_with(TRANSFORMED_SLOTS, || None);
        }
        let slot = &mut self.transformed[index as usize % TRANSFORMED_SLOTS];
        if !matches!(slot, Some((known, ..)) if *known == index) {
            let text = defined(self.cjson.string(index))?;
            let Some(kind) = infer_transformed_string_type_kind_for_string(
                text,
                self.cjson.date_time_recognizer(),
            ) else {
                return Ok(None);
            };
            let Some(producer) = transformed_string_type_attributes_producer(kind) else {
                return Ok(None);
            };
            *slot = Some((index, kind, producer(text)));
        }
        Ok(slot
            .as_ref()
            .map(|(_, kind, attributes)| (*kind, attributes)))
    }

    /// Tallies `samples` into a new tree of `tallies`, and returns it;
    /// `Ok(None)` if a value is not one a reader makes (see the type).
    fn tally(&mut self, tallies: &mut Tallies, samples: &[Value]) -> Result<Option<NodeId>> {
        let root = tallies.new_tree()?;
        for &sample in samples {
            if !self.walk(tallies, root, sample)? {
                return Ok(None);
            }
        }
        Ok(Some(root))
    }

    /// Tallies `value` and everything in it at `node`; whether it is a
    /// tree as a reader makes it (`Ok(false)` declines it).
    fn walk(&mut self, tallies: &mut Tallies, node: NodeId, value: Value) -> Result<bool> {
        if !self.visit(tallies, node, value)? {
            return Ok(false);
        }
        while let Some(frame) = self.stack.last_mut() {
            let (node, value) = match frame {
                WalkFrame::Array { items, next, node } => match items.get(*next) {
                    Some(&item) => {
                        *next += 1;
                        (*node, item)
                    }
                    None => {
                        self.stack.pop();
                        continue;
                    }
                },
                WalkFrame::Object {
                    entries,
                    next,
                    node,
                    next_key,
                } => match entries.get(*next) {
                    Some(&(key, value)) => {
                        *next += 1;
                        let (object, expected) = (*node, *next_key);
                        let Value::InternedString(key) = key else {
                            return Ok(false);
                        };
                        let (child, following) = self.key(tallies, object, key, expected)?;
                        if let Some(WalkFrame::Object { next_key, .. }) = self.stack.last_mut() {
                            *next_key = following;
                        }
                        (child, value)
                    }
                    None => {
                        self.stack.pop();
                        continue;
                    }
                },
            };
            if !self.visit(tallies, node, value)? {
                return Ok(false);
            }
        }
        Ok(true)
    }

    /// Counts key `key` (a string index) in the object at `node`, where the
    /// key at index `expected` is expected, as the [`TallyBuilder`] counts
    /// its text. Returns the node of its value and the index of the key
    /// expected next.
    fn key(
        &mut self,
        tallies: &mut Tallies,
        node: NodeId,
        key: u32,
        expected: usize,
    ) -> Result<(NodeId, usize)> {
        if self.is_proto(key)? {
            Ok((tallies.add_proto_key(node)?, expected))
        } else {
            tallies.add_key(node, key, expected)
        }
    }

    /// Tallies `value` at `node`, as the [`TallyBuilder`] tallies the
    /// reader's event that made it (whose strings `commitString` classified
    /// as the value records); an object or array is pushed, its values to
    /// come. Whether the value is one a reader makes.
    fn visit(&mut self, tallies: &mut Tallies, node: NodeId, value: Value) -> Result<bool> {
        match value {
            Value::Null => tallies.add_kind(node, TypeKind::Null)?,
            Value::False | Value::True => tallies.add_kind(node, TypeKind::Bool)?,
            Value::Integer => tallies.add_kind(node, TypeKind::Integer)?,
            Value::Double => tallies.add_kind(node, TypeKind::Double)?,
            Value::InternedString(index) => {
                // Every `"__proto__"` is the first one's case.
                let id = if self.is_proto(index)? {
                    self.proto
                } else {
                    index
                };
                tallies.add_case(node, id)?;
            }
            Value::UninternedString => tallies.add_uninterned(node)?,
            Value::StringFormat(kind) => tallies.add_string_format(node, kind)?,
            Value::TransformedString(index) => {
                let Some((kind, attributes)) = self.transformed(index)? else {
                    return Ok(false);
                };
                tallies.add_transformed_string(node, kind, attributes)?;
            }
            Value::Object(index) => {
                if !first_visit(&mut self.objects_seen, index, self.counts.objects)? {
                    return Ok(false);
                }
                tallies.add_object(node)?;
                self.stack.push(WalkFrame::Object {
                    entries: self.cjson.get_object_for_value(value)?,
                    next: 0,
                    node,
                    next_key: 0,
                });
            }
            Value::Array(index) => {
                if !first_visit(&mut self.arrays_seen, index, self.counts.arrays)? {
                    return Ok(false);
                }
                let items = tallies.add_array(node)?;
                self.stack.push(WalkFrame::Array {
                    items: self.cjson.get_array_for_value(value)?,
                    next: 0,
                    node: items,
                });
            }
        }
        Ok(true)
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
        /// The index of the key expected next (see [`Tallies::add_key`]).
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
/// Appending a sample to others is [`Tallies::merge`]'s job. What each
/// event adds is [`Tallies`]' handlers' job ([`Tallies::add_kind`] and the
/// others), which the walk over a compressed form calls too.
pub(crate) struct TallyBuilder<'a> {
    tallies: &'a mut Tallies,
    /// The text of the keys and cases.
    strings: &'a mut Strings,
    string_reader: &'a mut StringReaderState,
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
    pub(crate) fn new(running: &'a mut RunningTallies, config: &'a CompressedJson) -> Self {
        let RunningTallies {
            tallies,
            strings,
            string_reader,
        } = running;
        TallyBuilder {
            tallies,
            strings,
            string_reader,
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

    /// What [`JsonSink::set_property_key`] does: counts `key` in the
    /// current object, and makes its value's node where the next value
    /// goes. Takes only the fields it needs, so that `key` can be borrowed
    /// from another (the reader's key table,
    /// [`JsonSink::set_property_key_read`]).
    fn set_key(
        tallies: &mut Tallies,
        strings: &mut Strings,
        frames: &mut [Frame],
        key: &str,
    ) -> Result<()> {
        let Some(Frame::Object {
            node,
            value,
            expecting_ref,
            next_key,
        }) = frames.last_mut()
        else {
            return panic("Setting a key outside an object");
        };
        let (child, following) = if key == "__proto__" {
            (tallies.add_proto_key(*node)?, *next_key)
        } else {
            tallies.add_key(*node, KeyText { strings, text: key }, *next_key)?
        };
        *value = Some(child);
        *expecting_ref = key == "$ref";
        *next_key = following;
        Ok(())
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
        self.tallies.add_kind(node, kind)?;
        self.value_done();
        Ok(())
    }

    /// An interned string (`Tag.InternedString`) at `node`.
    fn add_case(&mut self, node: NodeId, s: &str) -> Result<()> {
        let id = self.strings.intern_text(s);
        self.tallies.add_case(node, id)
    }

    /// `commitString`'s classification of `s`, a string at `node` that is
    /// not a reference, and what it adds there.
    fn add_string(&mut self, node: NodeId, s: &str) -> Result<()> {
        match infer_transformed_string_type_kind_for_string(s, self.config.date_time_recognizer()) {
            Some(kind) => match transformed_string_type_attributes_producer(kind) {
                Some(producer) => self
                    .tallies
                    .add_transformed_string(node, kind, &producer(s)),
                None => self.tallies.add_string_format(node, kind),
            },
            // At most 64 UTF-16 code units: each takes 1 to 3 UTF-8 bytes,
            // or 4 bytes for a surrogate pair, so a string of at most 64
            // bytes has at most 64 units and one of more than 192 bytes
            // more, and only the others are measured. A case is not
            // counted where the strings absorb it (`Tallies::add_case`), so
            // it need not be interned there.
            None if s.len() <= 64 || (s.len() <= 192 && utf16::len(s) <= 64) => {
                if self.tallies.absorbs_strings(node)? {
                    Ok(())
                } else {
                    self.add_case(node, s)
                }
            }
            None => self.tallies.add_uninterned(node),
        }
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
    /// Where the strings absorb every further string but a URI
    /// ([`Tallies::absorbs_strings`]), one that cannot be a URI
    /// ([`may_have_attributes`]) adds nothing, and is not classified.
    fn commit_string(&mut self, s: &str) -> Result<()> {
        let expecting_ref = matches!(
            self.frames.last(),
            Some(Frame::Object {
                expecting_ref: true,
                ..
            })
        );
        let node = self.destination()?;
        if self.config.handle_refs() && expecting_ref {
            self.add_case(node, s)?;
        } else if may_have_attributes(s) || !self.tallies.absorbs_strings(node)? {
            self.add_string(node, s)?;
        }
        self.value_done();
        Ok(())
    }

    fn push_object_context(&mut self) -> Result<()> {
        let node = self.destination()?;
        self.tallies.add_object(node)?;
        self.frames.push(Frame::Object {
            node,
            value: None,
            expecting_ref: false,
            next_key: 0,
        });
        Ok(())
    }

    fn set_property_key(&mut self, key: &str) -> Result<()> {
        Self::set_key(self.tallies, self.strings, &mut self.frames, key)
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
        let items = self.tallies.add_array(node)?;
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

    fn small_integers_fit(&self) -> bool {
        self.config.small_integers_fit()
    }

    fn string_reader(&mut self) -> &mut StringReaderState {
        self.string_reader
    }

    /// A key of the reader's key table: its id in the string table is
    /// found once per key and remembered by the reader
    /// ([`StringReaderState::key_index`]), and the key expected next is
    /// matched by that id, without comparing texts.
    fn set_property_key_read(&mut self, id: u32) -> Result<()> {
        let TallyBuilder {
            tallies,
            strings,
            string_reader,
            frames,
            ..
        } = self;
        let Some(Frame::Object {
            node,
            value,
            expecting_ref,
            next_key,
        }) = frames.last_mut()
        else {
            return panic("Setting a key outside an object");
        };
        let (child, following) = match string_reader.key_index(id, strings) {
            Some(key) => tallies.add_key(*node, key, *next_key)?,
            None => (tallies.add_proto_key(*node)?, *next_key),
        };
        *value = Some(child);
        *expecting_ref = string_reader.key_text(id) == "$ref";
        *next_key = following;
        Ok(())
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
    fn read(tallies: &mut RunningTallies, config: &CompressedJson, samples: &[&str]) -> NodeId {
        let trees: Vec<NodeId> = samples
            .iter()
            .map(|sample| {
                parse_stream_into(&mut TallyBuilder::new(tallies, config), sample.as_bytes())
                    .expect("valid JSON")
            })
            .collect();
        let (&first, rest) = trees.split_first().expect("a sample");
        for &tree in rest {
            tallies.tallies.merge(first, tree).unwrap();
        }
        first
    }

    fn dump(tallies: &RunningTallies, node: NodeId) -> String {
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
        let mut tallies = RunningTallies::new();
        let root = read(
            &mut tallies,
            &config,
            &[r#"[{"a":1,"__proto__":1,"__proto__":{"x":2},"b":1},{"__proto__":"s","a":2}]"#],
        );
        let items = tallies.tallies.node(root).unwrap().items.unwrap();
        let object = tallies
            .tallies
            .node(items)
            .unwrap()
            .object
            .as_deref()
            .unwrap();
        assert_eq!(object.count, 2);
        assert_eq!(
            object.property_names().collect::<Vec<_>>(),
            [(Some(0), 1), (None, 2), (Some(1), 1), (None, 1)]
        );
        assert_eq!(object.keys[0].count, 2);
        let proto = tallies.tallies.node(object.proto.unwrap()).unwrap();
        assert!(proto.kinds.is_empty());
        assert!(proto.strings.is_some());
    }

    #[test]
    fn replaced_proto_values_are_freed() {
        let config = config(false);
        let mut tallies = RunningTallies::new();
        let one = r#"{"__proto__":{"a":{"b":[1]}}}"#;
        let root = read(&mut tallies, &config, &[one]);
        let after_one = tallies.tallies.live_nodes();
        let more = read(&mut tallies, &config, &[one, one, one]);
        tallies.tallies.merge(root, more).unwrap();
        assert_eq!(tallies.tallies.live_nodes(), after_one);
        // Also within one sample.
        let mut within = RunningTallies::new();
        read(
            &mut within,
            &config,
            &[r#"[{"__proto__":{"a":{"b":[1]}},"__proto__":{"a":{"b":[1]}}}]"#],
        );
        let mut once = RunningTallies::new();
        read(&mut once, &config, &[r#"[{"__proto__":{"a":{"b":[1]}}}]"#]);
        assert_eq!(within.tallies.live_nodes(), once.tallies.live_nodes());
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
        let mut one = RunningTallies::new();
        let root = read(&mut one, &config, &[&format!("[{}]", SAMPLES.join(","))]);
        let items = one.tallies.node(root).unwrap().items.unwrap();
        for split in 1..SAMPLES.len() {
            let mut two = RunningTallies::new();
            let a = read(&mut two, &config, &SAMPLES[..split]);
            let b = read(&mut two, &config, &SAMPLES[split..]);
            two.tallies.merge(a, b).unwrap();
            assert_eq!(dump(&two, a), dump(&one, items), "split at {split}");
            // All but the array's node.
            assert_eq!(
                two.tallies.live_nodes(),
                one.tallies.live_nodes() - 1,
                "split at {split}"
            );
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
        let mut expected = RunningTallies::new();
        let all = read(
            &mut expected,
            &config,
            &[first[0], first[1], second[0], second[1]],
        );
        let steps = {
            let mut tallies = RunningTallies::new();
            let a = read(&mut tallies, &config, &first);
            let b = read(&mut tallies, &config, &second);
            tallies.tallies.plan_merge(a, b).unwrap().len()
        };
        assert!(steps > 10, "{steps} steps");
        for fail_at in 0..steps {
            let mut tallies = RunningTallies::new();
            let a = read(&mut tallies, &config, &first);
            let before = (dump(&tallies, a), tallies.tallies.live_nodes());
            let b = read(&mut tallies, &config, &second);
            tallies.tallies.fail_merge_at.set(Some(fail_at));
            assert!(
                tallies.tallies.merge(a, b).is_err(),
                "failing at step {fail_at}"
            );
            assert_eq!(
                (dump(&tallies, a), tallies.tallies.live_nodes()),
                before,
                "failing at step {fail_at}"
            );
            // The tree takes the next merge as if nothing had happened.
            let b = read(&mut tallies, &config, &second);
            tallies.tallies.merge(a, b).unwrap();
            assert_eq!(dump(&tallies, a), dump(&expected, all));
            assert_eq!(tallies.tallies.live_nodes(), expected.tallies.live_nodes());
        }
    }

    /// A sample that fails part way, at any point, is forgotten: the next
    /// sample reads as if it had been the only one.
    #[test]
    fn a_failed_sample_leaves_nothing_behind() {
        let config = config(false);
        let good = r#"{"a":[1,{"b":"x"}],"c":"2020-01-01","__proto__":{"q":[]}}"#;
        let broken = r#"{"a":[2.5,{"b":"y","z":[null,{"w":"http://h/a.png"}]}],"c":"q","__proto__":{"p":1},"d":{"e":[[1]]}}"#;
        let mut expected = RunningTallies::new();
        let tree = read(&mut expected, &config, &[good]);
        let expected = (dump(&expected, tree), expected.tallies.live_nodes());
        for cut in 1..broken.len() {
            let mut tallies = RunningTallies::new();
            let mut builder = TallyBuilder::new(&mut tallies, &config);
            assert!(parse_stream_into(&mut builder, &broken.as_bytes()[..cut]).is_err());
            let tree = parse_stream_into(&mut builder, good.as_bytes()).unwrap();
            drop(builder);
            assert_eq!(
                (dump(&tallies, tree), tallies.tallies.live_nodes()),
                expected,
                "cut at {cut}"
            );
        }
        // A builder dropped in the middle of a sample frees it too.
        let mut tallies = RunningTallies::new();
        let mut builder = TallyBuilder::new(&mut tallies, &config);
        builder.push_object_context().unwrap();
        builder.set_property_key("a").unwrap();
        builder.push_array_context().unwrap();
        builder.commit_null().unwrap();
        drop(builder);
        assert_eq!(tallies.tallies.live_nodes(), 0);
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
            let mut streamed = RunningTallies::new();
            let root = read(&mut streamed, &config, &samples);
            let mut parsed = RunningTallies::new();
            let trees: Vec<NodeId> = samples
                .iter()
                .map(|sample| {
                    parse_string_into(&mut TallyBuilder::new(&mut parsed, &config), sample).unwrap()
                })
                .collect();
            parsed.tallies.merge(trees[0], trees[1]).unwrap();
            assert_eq!(dump(&parsed, trees[0]), dump(&streamed, root));
        }
    }

    /// Samples with every kind of value, `__proto__` (also as a string, and
    /// repeated, which only the stream reader keeps), `$ref`s, repeated and
    /// reordered keys, nesting and strings of every class.
    const WALKED: [&str; 7] = [
        r##"{"a":[1,"x",1.5,"2020-01-01T00:00:00Z",null,true],"$ref":"#/a","u":"http://h/x.png","__proto__":"__proto__"}"##,
        r#"{"__proto__":[{"b":"0123"}],"e":{},"f":[[]],"g":"7","a":[{"b":"__proto__"}],"__proto__":{"p":1}}"#,
        r#"[{"b":{"e":true,"__proto__":[2]}},"http://h/x.PNG",{"a":[]},"6ba7b810-9dad-11d1-80b4-00c04fd430c8"]"#,
        r#"{"z":{"y":1},"a":[{"q":1.5}],"b":{"c":"s","__proto__":"t"},"d":"https://h/y.jpg","x":"x","x":2}"#,
        r#""long string, long string, long string, long string, long string, too""#,
        r##"{"$ref":"#/z","$ref":"2020-01-01","a":{"$ref":"https://h/r"},"c":"false","t":"12:00:00Z"}"##,
        r#"[[[["deep"]]],{"k":{"k":{"k":"__proto__"}}},-0,1e400,"x","x","y"]"#,
    ];

    /// Tallying the compressed form the readers made of samples gives the
    /// tallies reading them gives (with either reader, references handled
    /// or not), whatever the samples are grouped into.
    #[test]
    fn tallying_a_compressed_form_is_reading() {
        for handle_refs in [false, true] {
            let config = config(handle_refs);
            let mut read_tallies = RunningTallies::new();
            let expected = read(&mut read_tallies, &config, &WALKED);
            let expected = dump(&read_tallies, expected);
            let mut streamed = self::config(handle_refs);
            let mut parsed = self::config(handle_refs);
            let mut stream_roots = Vec::new();
            let mut string_roots = Vec::new();
            for sample in WALKED {
                stream_roots.push(streamed.parse_stream(sample.as_bytes()).unwrap());
                string_roots.push(parsed.parse_string(sample).unwrap());
            }
            // The stream reader keeps what the tallies were read with.
            let (tallies, roots) = tally_compressed(&streamed, [stream_roots.as_slice()])
                .unwrap()
                .unwrap();
            let walked = |tallies: &Tallies, root| tallies.dump(streamed.strings(), root);
            assert_eq!(walked(&tallies, roots[0]), expected, "refs {handle_refs}");
            // Split into top-levels: each its own tree.
            let (first, rest) = stream_roots.split_at(3);
            let (tallies, roots) = tally_compressed(&streamed, [first, rest]).unwrap().unwrap();
            let mut one = RunningTallies::new();
            let a = read(&mut one, &config, &WALKED[..3]);
            let b = read(&mut one, &config, &WALKED[3..]);
            assert_eq!(walked(&tallies, roots[0]), dump(&one, a));
            assert_eq!(walked(&tallies, roots[1]), dump(&one, b));
            // `JSON.parse` semantics: as reading the text samples.
            let mut text_tallies = RunningTallies::new();
            let trees: Vec<NodeId> = WALKED
                .iter()
                .map(|sample| {
                    parse_string_into(&mut TallyBuilder::new(&mut text_tallies, &config), sample)
                        .unwrap()
                })
                .collect();
            for &tree in &trees[1..] {
                text_tallies.tallies.merge(trees[0], tree).unwrap();
            }
            let (tallies, roots) = tally_compressed(&parsed, [string_roots.as_slice()])
                .unwrap()
                .unwrap();
            assert_eq!(
                tallies.dump(parsed.strings(), roots[0]),
                dump(&text_tallies, trees[0]),
                "refs {handle_refs}"
            );
        }
    }

    /// URIs that recur, between others that push them out of the walk's
    /// slots of recognized strings, are tallied as reading tallies them.
    #[test]
    fn recurring_uris_are_tallied_as_read() {
        let uris: Vec<String> = (0..2_000)
            .map(|i| match i % 4 {
                0 => format!(r#""http://h/{i}.png""#),
                1 => r#""https://h/same.jpg""#.to_owned(),
                2 => format!(r#""ftp://h/{}.gif""#, i % 7),
                _ => r#""2020-01-01""#.to_owned(),
            })
            .collect();
        let sample = format!("[{}]", uris.join(","));
        let config = config(false);
        let mut read_tallies = RunningTallies::new();
        let expected = read(&mut read_tallies, &config, &[&sample]);
        let mut cjson = self::config(false);
        let root = cjson.parse_stream(sample.as_bytes()).unwrap();
        let (tallies, roots) = tally_compressed(&cjson, [[root].as_slice()])
            .unwrap()
            .unwrap();
        assert_eq!(
            tallies.dump(cjson.strings(), roots[0]),
            dump(&read_tallies, expected)
        );
    }

    /// Cases are counted right however many there are, many more than the
    /// slots that remember where they were counted, which they share.
    #[test]
    fn many_cases_are_counted() {
        let distinct = 3 * CASE_SLOTS + 7;
        let mut values: Vec<String> = Vec::new();
        for round in 0..3 {
            for i in 0..distinct {
                values.push(format!(r#""c{i}""#));
                // A few that recur all along, between the others.
                values.push(format!(r#""r{}""#, (i + round) % 5));
            }
        }
        let sample = format!("[{}]", values.join(","));
        let config = config(false);
        let mut tallies = RunningTallies::new();
        let tree = read(&mut tallies, &config, &[&sample]);
        let items = tallies.tallies.node(tree).unwrap().items.unwrap();
        let strings = tallies
            .tallies
            .node(items)
            .unwrap()
            .strings
            .as_deref()
            .unwrap();
        assert_eq!(strings.cases.len(), distinct + 5);
        let count = |text: &str| {
            let id = (0..tallies.strings.len())
                .find(|&i| tallies.strings.get(i) == Some(text))
                .unwrap();
            strings.cases[&(id as u32)]
        };
        assert_eq!(count("c0"), 3);
        assert_eq!(count(&format!("c{}", distinct - 1)), 3);
        assert_eq!(
            (0..5).map(|r| count(&format!("r{r}"))).sum::<u64>(),
            3 * distinct as u64
        );
        // The compressed form's walk counts the same.
        let mut cjson = self::config(false);
        let root = cjson.parse_stream(sample.as_bytes()).unwrap();
        let (walked, roots) = tally_compressed(&cjson, [[root].as_slice()])
            .unwrap()
            .unwrap();
        assert_eq!(walked.dump(cjson.strings(), roots[0]), dump(&tallies, tree));
    }

    /// Tables no reader makes: the walk declines them.
    #[test]
    fn tables_no_reader_makes_are_declined() {
        use crate::input::compressed_json::CompressedJsonTables;
        let tables = |strings: &[&str], objects: &[i32], arrays: &[i32]| CompressedJsonTables {
            strings: strings.iter().map(|s| (*s).to_owned()).collect(),
            objects: objects.to_vec(),
            object_offsets: if objects.is_empty() { vec![] } else { vec![0] },
            arrays: arrays.to_vec(),
            array_offsets: if arrays.is_empty() { vec![] } else { vec![0] },
        };
        let (string, integer, object, array, transformed) = (6, 4, 8, 9, 11);
        let cases = [
            // `[o, o]` with `o = {"a": 1}`: an object reached twice.
            (tables(&["a"], &[string, integer], &[object, object]), array),
            // `o = {"a": o}`: a cycle.
            (tables(&["a"], &[string, object], &[]), object),
            // `{"a": 1, "a": 1}` with the key twice in the string table.
            (
                tables(
                    &["a", "a"],
                    &[string, integer, string | 1 << 4, integer],
                    &[],
                ),
                object,
            ),
            // `["x"]` with `"x"` a transformed string: no kind.
            (tables(&["x"], &[], &[transformed]), array),
        ];
        for (tables, root) in cases {
            let cjson =
                CompressedJson::from_tables(Box::new(DefaultDateTimeRecognizer), false, &tables)
                    .unwrap();
            let (objects, arrays) = cjson.counts();
            let root = cjson.decode_value(root, objects, arrays).unwrap();
            assert!(
                tally_compressed(&cjson, [[root].as_slice()])
                    .unwrap()
                    .is_none(),
                "{tables:?}"
            );
        }
        // The same tables without the anomaly are tallied.
        let good = tables(&["a"], &[string, integer], &[object]);
        let cjson =
            CompressedJson::from_tables(Box::new(DefaultDateTimeRecognizer), false, &good).unwrap();
        let (objects, arrays) = cjson.counts();
        let root = cjson.decode_value(array, objects, arrays).unwrap();
        let (tallies, roots) = tally_compressed(&cjson, [[root].as_slice()])
            .unwrap()
            .unwrap();
        assert_eq!(
            tallies.dump(cjson.strings(), roots[0]),
            "[array] items [[object] objects 1 [] {\"a\"×1: [integer], }]"
        );
    }

    /// A value that is not there is an error, as it is for the values'
    /// inference, which looks it up: not a form the walk declines.
    #[test]
    fn values_that_are_not_there_are_errors() {
        let mut cjson = config(false);
        let root = cjson.parse_stream(br#"[{"a":"x"}]"#).unwrap();
        let (objects, arrays) = cjson.counts();
        let strings = cjson.table_counts().strings as u32;
        for missing in [
            Value::Object(objects as u32),
            Value::Array(arrays as u32),
            Value::InternedString(strings),
            Value::TransformedString(strings),
        ] {
            let error = tally_compressed(&cjson, [[root, missing].as_slice()]).unwrap_err();
            assert_eq!(
                error.user_message(),
                "Internal error: Defined value expected, but got undefined",
                "{missing:?}"
            );
        }
    }

    /// The cases at `node`, as text.
    fn cases(tallies: &RunningTallies, node: NodeId) -> Vec<(String, u64)> {
        let strings = tallies.tallies.node(node).unwrap().strings.as_deref();
        strings
            .unwrap()
            .cases
            .iter()
            .map(|(&id, &count)| (tallies.strings.get(id as usize).unwrap().to_owned(), count))
            .collect()
    }

    /// Once a place's strings are unrestricted with and without enum
    /// inference, its strings are neither counted nor interned, but for
    /// URIs, whose attributes still count, and references. A merge of
    /// such a place with one that is not keeps what the other counted,
    /// either way round; the walk over a compressed form tallies alike.
    #[test]
    fn strings_a_place_absorbs_are_not_counted() {
        let long = "x".repeat(70);
        let config = config(false);
        let mut tallies = RunningTallies::new();
        let sample =
            format!(r#"["a","{long}","b","https://h/c.PNG","a","ftp://h/d.zip","2020-01-01","c"]"#);
        let root = read(&mut tallies, &config, &[&sample]);
        let items = tallies.tallies.node(root).unwrap().items.unwrap();
        assert_eq!(cases(&tallies, items), [("a".to_owned(), 1)]);
        assert!(tallies.tallies.absorbs_strings(items).unwrap());
        for text in ["b", "c"] {
            assert!(!(0..tallies.strings.len()).any(|i| tallies.strings.get(i) == Some(text)));
        }
        let strings = tallies.tallies.node(items).unwrap().strings.as_deref();
        let with_enums = strings.unwrap().with_enums.as_ref().unwrap();
        let (protocols, extensions) = UriTypeAttributeKind
            .try_get_in_attributes(with_enums)
            .unwrap();
        assert_eq!(protocols.iter().collect::<Vec<_>>(), ["https", "ftp"]);
        assert_eq!(extensions.iter().collect::<Vec<_>>(), [".png", ".zip"]);
        // The walk over the compressed form of the same sample.
        let mut cjson = self::config(false);
        let value = cjson.parse_stream(sample.as_bytes()).unwrap();
        let (walked, roots) = tally_compressed(&cjson, [[value].as_slice()])
            .unwrap()
            .unwrap();
        assert_eq!(walked.dump(cjson.strings(), roots[0]), dump(&tallies, root));
        // Merged with a place that counts its cases, either way round.
        let counted = r#"["d","e","d"]"#;
        let absorbing = format!(r#"["{long}","e","f"]"#);
        for counted_first in [true, false] {
            let mut tallies = RunningTallies::new();
            let a = read(&mut tallies, &config, &[counted]);
            let b = read(&mut tallies, &config, &[&absorbing]);
            let (into, from) = if counted_first { (a, b) } else { (b, a) };
            tallies.tallies.merge(into, from).unwrap();
            let items = tallies.tallies.node(into).unwrap().items.unwrap();
            assert_eq!(
                cases(&tallies, items),
                [("d".to_owned(), 2), ("e".to_owned(), 1)]
            );
            assert!(tallies.tallies.absorbs_strings(items).unwrap());
        }
        // References are counted wherever they are.
        let config = self::config(true);
        let mut tallies = RunningTallies::new();
        let root = read(
            &mut tallies,
            &config,
            &[&format!(
                r##"[{{"$ref":"#/a"}},{{"$ref":"{long}"}},{{"$ref":"#/b"}}]"##
            )],
        );
        let items = tallies.tallies.node(root).unwrap().items.unwrap();
        let object = tallies
            .tallies
            .node(items)
            .unwrap()
            .object
            .as_deref()
            .unwrap();
        let refs = object.keys[0].node;
        assert_eq!(
            cases(&tallies, refs),
            [
                ("#/a".to_owned(), 1),
                (long.clone(), 1),
                ("#/b".to_owned(), 1)
            ]
        );
    }

    #[test]
    fn string_attributes_combine_once_per_change() {
        let config = config(false);
        let mut tallies = RunningTallies::new();
        let root = read(
            &mut tallies,
            &config,
            &[r#"["2020-01-01","x","http://h/a.PNG","2020-01-02","https://h/b.png","12:00:00Z"]"#],
        );
        let items = tallies.tallies.node(root).unwrap().items.unwrap();
        let strings = tallies
            .tallies
            .node(items)
            .unwrap()
            .strings
            .as_deref()
            .unwrap();
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
