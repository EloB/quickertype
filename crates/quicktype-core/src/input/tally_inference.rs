//! Port of `packages/quicktype-core/src/input/Inference.ts` over running
//! tallies (see [`tallies`](super::tallies) and
//! `docs/STREAMING-INFERENCE.md`).
//!
//! The decisions and the `TypeBuilder` calls are those of
//! [`inference`](super::inference), in the same order; only the value lists
//! are different. Where TypeScript adds a list of values to a
//! `UnionAccumulator`, this adds the tallies of the places those values
//! came from, each in one go: every non-string kind once in the order it
//! was first seen, every string case once with its count, and the string
//! attributes once, already combined. The accumulator then holds what it
//! would hold after the values (the same member kinds, case counts and
//! combined attributes), and its object and array "data" are the places of
//! the objects and arrays. A list that concatenates several places' values
//! (the samples of a top-level, the values of a key across the objects of
//! several places, the elements of the arrays of several places, all the
//! values of a map) is the list of those places, added in order.

use std::cell::RefCell;

use indexmap::{IndexMap, IndexSet};

use super::inference::resolve_ref;
use super::tallies::{NodeId, ObjectTally, Tallies, add_proto_occurrences, property_names};
use crate::attributes::type_attributes::TypeAttributes;
use crate::messages::Result;
use crate::support::fast_hash::BuildHasher;
use crate::support::recursion::guard;
use crate::support::support::{defined, panic};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::ty::ClassProperty;
use crate::ty::type_builder::TypeBuilder;
use crate::ty::type_ref::TypeRef;
use crate::union_builder::{UnionAccumulator, UnionBuilder};

/// TS `Accumulator`, with the place of the arrays and objects as their
/// data: their elements and properties are combined from the places' tallies.
type Accumulator = UnionAccumulator<NodeId, NodeId>;

/// A `$ref` placeholder intersection and the references it stands for.
type RefIntersection = (TypeRef, Vec<String>);

/// `propertyNames` and `propertyValues` of the objects at a list of
/// places, as `inferClassType` collects them: the keys in first-seen order,
/// each with its number of values and the places of its values, the
/// occurrences of `__proto__` among them, and its last value.
enum Properties<'t> {
    /// The objects of one place, the usual case: its tally is the
    /// collection already.
    One(&'t ObjectTally),
    /// The objects of several places, collected.
    Many(Collected),
}

/// The keys of the objects at several places (see [`Properties`]).
struct Collected {
    /// `objects.length`.
    count: u64,
    /// Each key (by its text's index) in first-seen order: its number of
    /// values, and the range of `places` that holds its places.
    keys: IndexMap<u32, (u64, u32, u32), BuildHasher>,
    /// The places of the keys' values, key by key, each key's in order.
    places: Vec<NodeId>,
    /// `__proto__`'s occurrences, as in [`ObjectTally::proto_runs`].
    proto_runs: Vec<(u32, u64)>,
    /// The place of `__proto__`'s last value.
    proto: Option<NodeId>,
}

impl Properties<'_> {
    /// `objects.length`.
    fn object_count(&self) -> u64 {
        match self {
            Properties::One(object) => object.count,
            Properties::Many(c) => c.count,
        }
    }

    /// The number of distinct keys other than `__proto__`.
    fn key_count(&self) -> usize {
        match self {
            Properties::One(object) => object.keys.len(),
            Properties::Many(c) => c.keys.len(),
        }
    }

    fn proto_runs(&self) -> &[(u32, u64)] {
        match self {
            Properties::One(object) => &object.proto_runs,
            Properties::Many(c) => &c.proto_runs,
        }
    }

    /// The place of `__proto__`'s last value.
    fn proto(&self) -> Option<NodeId> {
        match self {
            Properties::One(object) => object.proto,
            Properties::Many(c) => c.proto,
        }
    }

    /// `propertyNames`: `Some(i)` for the `i`th key, `None` for `count`
    /// occurrences of `__proto__`.
    fn names(&self) -> impl Iterator<Item = (Option<usize>, u64)> + '_ {
        property_names(self.proto_runs(), self.key_count())
    }

    /// `propertyNames.length`.
    fn names_len(&self) -> u64 {
        self.key_count() as u64 + self.proto_runs().iter().map(|&(_, n)| n).sum::<u64>()
    }

    /// The `index`th key: its text's index, its number of values
    /// (`propertyValues[key].length`) and the places of its values.
    fn key(&self, index: usize) -> Result<(u32, u64, &[NodeId])> {
        match self {
            Properties::One(object) => {
                let (&id, key) = defined(object.keys.get_index(index))?;
                Ok((id, key.count, std::slice::from_ref(&key.node)))
            }
            Properties::Many(c) => {
                let (&id, &(count, start, end)) = defined(c.keys.get_index(index))?;
                Ok((
                    id,
                    count,
                    defined(c.places.get(start as usize..end as usize))?,
                ))
            }
        }
    }
}

/// `TypeInference` over tallies.
pub(crate) struct TallyInference<'t> {
    tallies: &'t Tallies,
    handle_refs: bool,
    infer_maps: bool,
    infer_enums: bool,
    /// `_refIntersections`.
    ref_intersections: RefCell<Option<Vec<RefIntersection>>>,
}

impl<'t> TallyInference<'t> {
    /// `new TypeInference(cjson, typeBuilder, inferMaps, inferEnums)`.
    pub(crate) fn new(
        tallies: &'t Tallies,
        handle_refs: bool,
        infer_maps: bool,
        infer_enums: bool,
    ) -> Self {
        TallyInference {
            tallies,
            handle_refs,
            infer_maps,
            infer_enums,
            ref_intersections: RefCell::new(None),
        }
    }

    /// `addValuesToAccumulator(valueArray, accumulator)` for the values of
    /// the place `node`.
    fn add_values_to_accumulator(&self, node: NodeId, accumulator: &mut Accumulator) -> Result<()> {
        let empty = TypeAttributes::new;
        let n = self.tallies.node(node)?;
        for kind in n.kinds.iter() {
            match kind {
                TypeKind::Object => accumulator.add_object(node, empty()),
                TypeKind::Array => accumulator.add_array(defined(n.items)?, empty()),
                kind => accumulator.add_primitive(kind, empty())?,
            }
        }
        if let Some(strings) = &n.strings {
            if self.infer_enums {
                for (&id, &count) in &strings.cases {
                    accumulator.add_string_case(self.tallies.text(id)?, count, empty());
                }
                if let Some(attributes) = &strings.with_enums {
                    accumulator.add_string_type(TypeKind::String, attributes.clone(), None)?;
                }
            } else if let Some(attributes) = &strings.without_enums {
                accumulator.add_string_type(TypeKind::String, attributes.clone(), None)?;
            }
        }
        Ok(())
    }

    /// `inferType(typeAttributes, valueArray, fixed, forwardingRef)` for
    /// the values of the places `nodes`, in order.
    ///
    /// Recurses once per nesting level of the input, called where
    /// [`TypeInference::infer_type`](super::inference::TypeInference::infer_type)
    /// is, and guarded the same way: past
    /// [`MAX_DEPTH`](crate::support::recursion::MAX_DEPTH) levels it fails
    /// with TypeScript's `RangeError` at the same depth.
    fn infer_type(
        &self,
        builder: &mut TypeBuilder<'_>,
        type_attributes: TypeAttributes,
        nodes: &[NodeId],
        fixed: bool,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        guard(|| {
            let mut accumulator = Accumulator::new(true);
            for &node in nodes {
                self.add_values_to_accumulator(node, &mut accumulator)?;
            }
            self.make_type_from_accumulator(
                builder,
                &accumulator,
                type_attributes,
                fixed,
                forwarding_ref,
            )
        })
    }

    /// `inferTopLevelType(typeAttributes, valueArray, fixed)` for the
    /// samples of the tree `root`.
    pub(crate) fn infer_top_level_type(
        &self,
        builder: &mut TypeBuilder<'_>,
        type_attributes: TypeAttributes,
        root: NodeId,
        fixed: bool,
    ) -> Result<TypeRef> {
        if self.ref_intersections.borrow().is_some() {
            return panic("Didn't reset ref intersections - nested invocations?");
        }
        if self.handle_refs {
            *self.ref_intersections.borrow_mut() = Some(Vec::new());
        }

        let top_level = self.infer_type(builder, type_attributes, &[root], fixed, None)?;
        if self.handle_refs {
            let intersections = defined(self.ref_intersections.borrow_mut().take())?;
            for (tref, refs) in intersections {
                let resolved = refs
                    .iter()
                    .map(|r| resolve_ref(builder, r, top_level))
                    .collect::<Result<IndexSet<TypeRef>>>()?;
                builder.set_set_operation_members(tref, resolved)?;
            }
        }
        Ok(top_level)
    }

    /// `makeTypeFromAccumulator(accumulator, typeAttributes, fixed,
    /// forwardingRef)`.
    fn make_type_from_accumulator(
        &self,
        builder: &mut TypeBuilder<'_>,
        accumulator: &Accumulator,
        type_attributes: TypeAttributes,
        fixed: bool,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        let union_builder = TallyUnionBuilder {
            inference: self,
            fixed,
        };
        union_builder.build_union(builder, accumulator, false, type_attributes, forwarding_ref)
    }

    /// The properties of the objects at the places `objects`, in order.
    fn properties(&self, objects: &[NodeId]) -> Result<Properties<'t>> {
        let object = |place: NodeId| -> Result<&'t ObjectTally> {
            defined(self.tallies.node(place)?.object.as_deref())
        };
        if let [place] = *objects {
            return Ok(Properties::One(object(place)?));
        }
        // First the keys in first-seen order, their counts and their
        // numbers of places, then the places, into one list.
        let mut c = Collected {
            count: 0,
            keys: IndexMap::default(),
            places: Vec::new(),
            proto_runs: Vec::new(),
            proto: None,
        };
        for &place in objects {
            let object = object(place)?;
            c.count += object.count;
            for (key, run) in object.property_names() {
                match key {
                    None => add_proto_occurrences(&mut c.proto_runs, c.keys.len(), run),
                    Some(i) => {
                        let (&id, tally) = defined(object.keys.get_index(i))?;
                        let (count, _, places) = c.keys.entry(id).or_default();
                        *count += tally.count;
                        *places += 1;
                    }
                }
            }
            if object.proto.is_some() {
                c.proto = object.proto;
            }
        }
        let mut start = 0;
        for (_, start_of_key, end) in c.keys.values_mut() {
            let places = *end;
            *start_of_key = start;
            // `end` is where the next place goes until all are there.
            *end = start;
            start += places;
        }
        c.places = vec![0; start as usize];
        for &place in objects {
            for (id, tally) in &object(place)?.keys {
                let (_, _, next) = defined(c.keys.get_mut(id))?;
                *defined(c.places.get_mut(*next as usize))? = tally.node;
                *next += 1;
            }
        }
        Ok(Properties::Many(c))
    }

    /// Whether every value at `node` is an interned string.
    fn only_interned_strings(&self, node: NodeId) -> Result<bool> {
        let n = self.tallies.node(node)?;
        Ok(n.kinds.is_empty() && n.strings.as_ref().is_some_and(|s| !s.not_interned))
    }

    /// `inferClassType(typeAttributes, objects, fixed, forwardingRef)` for
    /// the objects of the places `objects`, in order.
    fn infer_class_type(
        &self,
        builder: &mut TypeBuilder<'_>,
        type_attributes: TypeAttributes,
        objects: &[NodeId],
        fixed: bool,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        let properties = self.properties(objects)?;
        let names_len = properties.names_len();

        if self.handle_refs && names_len == 1 && properties.key_count() == 1 {
            let (id, _, places) = properties.key(0)?;
            if self.tallies.text(id)? == "$ref" {
                let mut all_interned = true;
                for &place in places {
                    all_interned &= self.only_interned_strings(place)?;
                }
                if all_interned {
                    // The references in first-seen order: resolving the
                    // rest of TypeScript's list (repeats) adds nothing.
                    let mut all_refs: IndexSet<&str> = IndexSet::new();
                    for &place in places {
                        let strings = defined(self.tallies.node(place)?.strings.as_deref())?;
                        for &case in strings.cases.keys() {
                            all_refs.insert(self.tallies.text(case)?);
                        }
                    }
                    let all_refs = all_refs.into_iter().map(str::to_owned).collect();
                    // FIXME in TypeScript: add an is-ref attribute.
                    let tref = builder.get_unique_intersection_type(type_attributes, None, None)?;
                    match self.ref_intersections.borrow_mut().as_mut() {
                        Some(intersections) => intersections.push((tref, all_refs)),
                        None => return panic("Defined value expected, but got undefined"),
                    }
                    return Ok(tref);
                }
            }
        }

        if self.infer_maps && names_len > 500 {
            let mut accumulator = Accumulator::new(true);
            for (key, run) in properties.names() {
                match key {
                    Some(index) => {
                        for &place in properties.key(index)?.2 {
                            self.add_values_to_accumulator(place, &mut accumulator)?;
                        }
                    }
                    None => {
                        let place = defined(properties.proto())?;
                        for _ in 0..run {
                            self.add_values_to_accumulator(place, &mut accumulator)?;
                        }
                    }
                }
            }
            let values = self.make_type_from_accumulator(
                builder,
                &accumulator,
                TypeAttributes::new(),
                fixed,
                None,
            )?;
            return builder.get_map_type(type_attributes, values, forwarding_ref);
        }

        let object_count = properties.object_count();
        let mut class_properties: IndexMap<String, ClassProperty> = IndexMap::new();
        for (key, run) in properties.names() {
            match key {
                Some(index) => {
                    let (id, count, places) = properties.key(index)?;
                    let t = self.infer_type(builder, TypeAttributes::new(), places, false, None)?;
                    let is_optional = count < object_count;
                    class_properties.insert(
                        self.tallies.text(id)?.to_owned(),
                        builder.make_class_property(t, is_optional),
                    );
                }
                None => {
                    // `propertyValues["__proto__"]` holds the last value only.
                    let places = [defined(properties.proto())?];
                    for _ in 0..run {
                        let t =
                            self.infer_type(builder, TypeAttributes::new(), &places, false, None)?;
                        let is_optional = 1 < object_count;
                        class_properties.insert(
                            "__proto__".to_owned(),
                            builder.make_class_property(t, is_optional),
                        );
                    }
                }
            }
        }

        if fixed {
            return builder.get_unique_class_type(
                type_attributes,
                true,
                Some(class_properties),
                forwarding_ref,
            );
        }
        builder.get_class_type(type_attributes, class_properties, forwarding_ref)
    }
}

/// `InferenceUnionBuilder` over tallies: objects are inferred as classes
/// from the places they are at, arrays get the union of the elements at
/// their places.
struct TallyUnionBuilder<'i, 't> {
    inference: &'i TallyInference<'t>,
    fixed: bool,
}

impl<'g> UnionBuilder<'g> for TallyUnionBuilder<'_, '_> {
    type ArrayData = Vec<NodeId>;
    type ObjectData = Vec<NodeId>;

    fn make_object(
        &self,
        builder: &mut TypeBuilder<'g>,
        objects: &Self::ObjectData,
        type_attributes: TypeAttributes,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        self.inference.infer_class_type(
            builder,
            type_attributes,
            objects,
            self.fixed,
            forwarding_ref,
        )
    }

    fn make_array(
        &self,
        builder: &mut TypeBuilder<'g>,
        arrays: &Self::ArrayData,
        type_attributes: TypeAttributes,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        // As in TypeScript, the forwarding ref goes to the items.
        let items = self.inference.infer_type(
            builder,
            TypeAttributes::new(),
            arrays,
            self.fixed,
            forwarding_ref,
        )?;
        builder.get_array_type(type_attributes, items, None)
    }
}
