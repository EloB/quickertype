//! Port of `packages/quicktype-core/src/UnionBuilder.ts`.
//!
//! Building unions: a [`UnionAccumulator`] collects the members of a union
//! (by kind, with their attributes), and a [`UnionBuilder`] turns that into
//! a type: a single type if only one kind remains, otherwise a union with
//! one member per kind, in kind order. How arrays and objects are combined
//! is up to the union builder (unification, intersection or inference).

use indexmap::{IndexMap, IndexSet};

use crate::attributes::string_types::{StringTypes, StringTypesTypeAttributeKind};
use crate::attributes::type_attributes::{
    AttributeKind, CombinationKind, TypeAttributes, combine_type_attributes,
    combine_type_attributes2, increase_type_attributes_distance, make_type_attributes_inferred,
};
use crate::messages::Result;
use crate::support::support::{assert, defined, panic};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_builder::TypeBuilder;
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::TypeRef;

/// `UnionTypeProvider`: what a union builder needs to know about the
/// members of the union it builds.
pub trait UnionTypeProvider {
    /// The data arrays are combined from.
    type ArrayData;
    /// The data objects are combined from.
    type ObjectData;

    /// `arrayData`.
    fn array_data(&self) -> &Self::ArrayData;
    /// `objectData`.
    fn object_data(&self) -> &Self::ObjectData;
    /// `enumCases`: errors where TypeScript's getter panics (intersections
    /// can't have enums).
    fn enum_cases(&self) -> Result<&IndexSet<String>>;
    /// `getMemberKinds()`: the member kinds and their attributes, in order.
    fn get_member_kinds(&self) -> Result<IndexMap<TypeKind, TypeAttributes>>;
    /// `lostTypeAttributes`.
    fn lost_type_attributes(&self) -> bool;
}

/// `TypeAttributeMapBuilder`: attributes per kind, in insertion order.
type TypeAttributeMapBuilder = IndexMap<TypeKind, Vec<TypeAttributes>>;

/// `addAttributesToBuilder`: the first attributes of a kind are always
/// recorded (even if empty), later ones only if non-empty.
fn add_attributes_to_builder(
    builder: &mut TypeAttributeMapBuilder,
    kind: TypeKind,
    new_attributes: TypeAttributes,
) {
    match builder.get_mut(&kind) {
        None => {
            builder.insert(kind, vec![new_attributes]);
        }
        Some(arr) => {
            if !new_attributes.is_empty() {
                arr.push(new_attributes);
            }
        }
    }
}

/// `buildTypeAttributeMap`.
fn build_type_attribute_map(
    builder: &TypeAttributeMapBuilder,
) -> Result<IndexMap<TypeKind, TypeAttributes>> {
    let mut result = IndexMap::with_capacity(builder.len());
    for (&kind, arr) in builder {
        let refs: Vec<&TypeAttributes> = arr.iter().collect();
        result.insert(
            kind,
            combine_type_attributes(CombinationKind::Union, &refs)?,
        );
    }
    Ok(result)
}

/// `setAttributes`: combines into an existing kind (keeping its slot) or
/// appends.
fn set_attributes(
    attribute_map: &mut IndexMap<TypeKind, TypeAttributes>,
    kind: TypeKind,
    new_attributes: &TypeAttributes,
) -> Result<()> {
    let combined = match attribute_map.get(&kind) {
        None => new_attributes.clone(),
        Some(existing) => {
            combine_type_attributes2(CombinationKind::Union, existing, new_attributes)?
        }
    };
    attribute_map.insert(kind, combined);
    Ok(())
}

/// `moveAttributes`: removes `from_kind` and combines its attributes into
/// `to_kind`.
fn move_attributes(
    map: &mut IndexMap<TypeKind, TypeAttributes>,
    from_kind: TypeKind,
    to_kind: TypeKind,
) -> Result<()> {
    let from_attributes = defined(map.shift_remove(&from_kind))?;
    set_attributes(map, to_kind, &from_attributes)
}

/// `UnionAccumulator<TArray, TObject>`: collects union members.
#[derive(Clone, Debug)]
pub struct UnionAccumulator<TArray, TObject> {
    non_string_type_attributes: TypeAttributeMapBuilder,
    string_type_attributes: TypeAttributeMapBuilder,
    string_cases: IndexMap<String, u64>,
    /// `arrayData`: one entry per array added.
    pub array_data: Vec<TArray>,
    /// `objectData`: one entry per object added.
    pub object_data: Vec<TObject>,
    enum_cases: IndexSet<String>,
    lost_type_attributes: bool,
    conflate_numbers: bool,
}

impl<TArray, TObject> UnionAccumulator<TArray, TObject> {
    /// `new UnionAccumulator(conflateNumbers)`: with `conflate_numbers`,
    /// `integer` and `double` members become one `double`.
    pub fn new(conflate_numbers: bool) -> Self {
        UnionAccumulator {
            non_string_type_attributes: IndexMap::new(),
            string_type_attributes: IndexMap::new(),
            string_cases: IndexMap::new(),
            array_data: Vec::new(),
            object_data: Vec::new(),
            enum_cases: IndexSet::new(),
            lost_type_attributes: false,
            conflate_numbers,
        }
    }

    fn have(&self, kind: TypeKind) -> bool {
        self.non_string_type_attributes.contains_key(&kind)
            || self.string_type_attributes.contains_key(&kind)
    }

    /// `addNone(attributes)`: a `none` member adds nothing; its attributes
    /// are lost.
    pub fn add_none(&mut self, _attributes: TypeAttributes) {
        self.lost_type_attributes = true;
    }

    /// `addAny(attributes)`: the union becomes `any`.
    pub fn add_any(&mut self, attributes: TypeAttributes) {
        add_attributes_to_builder(
            &mut self.non_string_type_attributes,
            TypeKind::Any,
            attributes,
        );
        self.lost_type_attributes = true;
    }

    /// `addPrimitive(kind, attributes)`.
    pub fn add_primitive(&mut self, kind: TypeKind, attributes: TypeAttributes) -> Result<()> {
        assert(kind != TypeKind::Any, "any must be added with addAny")?;
        add_attributes_to_builder(&mut self.non_string_type_attributes, kind, attributes);
        Ok(())
    }

    /// `addFullStringType(attributes, stringTypes)`.
    pub fn add_full_string_type(
        &mut self,
        attributes: TypeAttributes,
        string_types: Option<StringTypes>,
    ) -> Result<()> {
        let mut string_types_attributes: Option<TypeAttributes> = None;
        let string_types = match string_types {
            None => StringTypesTypeAttributeKind
                .try_get_in_attributes(&attributes)
                .cloned(),
            Some(st) => {
                string_types_attributes =
                    Some(StringTypesTypeAttributeKind.make_attributes(st.clone()));
                Some(st)
            }
        };
        let string_types = match string_types {
            Some(st) => st,
            None => {
                let st = StringTypes::unrestricted();
                string_types_attributes =
                    Some(StringTypesTypeAttributeKind.make_attributes(st.clone()));
                st
            }
        };

        if string_types.is_restricted() {
            assert(
                !self
                    .non_string_type_attributes
                    .contains_key(&TypeKind::Enum),
                "We can't add both an enum as well as a restricted string type to a union builder",
            )?;
        }

        add_attributes_to_builder(
            &mut self.string_type_attributes,
            TypeKind::String,
            attributes,
        );
        if let Some(sta) = string_types_attributes {
            add_attributes_to_builder(&mut self.string_type_attributes, TypeKind::String, sta);
        }
        Ok(())
    }

    /// `addStringType(kind, attributes, stringTypes)`.
    pub fn add_string_type(
        &mut self,
        kind: TypeKind,
        attributes: TypeAttributes,
        string_types: Option<StringTypes>,
    ) -> Result<()> {
        if kind == TypeKind::String {
            return self.add_full_string_type(attributes, string_types);
        }
        add_attributes_to_builder(&mut self.string_type_attributes, kind, attributes);
        if let Some(st) = string_types {
            add_attributes_to_builder(
                &mut self.string_type_attributes,
                kind,
                StringTypesTypeAttributeKind.make_attributes(st),
            );
        }
        Ok(())
    }

    /// `addArray(t, attributes)`.
    pub fn add_array(&mut self, t: TArray, attributes: TypeAttributes) {
        self.array_data.push(t);
        add_attributes_to_builder(
            &mut self.non_string_type_attributes,
            TypeKind::Array,
            attributes,
        );
    }

    /// `addObject(t, attributes)`.
    pub fn add_object(&mut self, t: TObject, attributes: TypeAttributes) {
        self.object_data.push(t);
        add_attributes_to_builder(
            &mut self.non_string_type_attributes,
            TypeKind::Object,
            attributes,
        );
    }

    /// `addEnum(cases, attributes)`: folds into `string` if there is one.
    pub fn add_enum(&mut self, cases: &IndexSet<String>, attributes: TypeAttributes) {
        if self.string_type_attributes.contains_key(&TypeKind::String) {
            add_attributes_to_builder(
                &mut self.string_type_attributes,
                TypeKind::String,
                attributes,
            );
            return;
        }
        add_attributes_to_builder(
            &mut self.non_string_type_attributes,
            TypeKind::Enum,
            attributes,
        );
        self.enum_cases.extend(cases.iter().cloned());
    }

    /// `addStringCases(cases, attributes)`: counts each distinct case once.
    pub fn add_string_cases(&mut self, cases: &[String], attributes: TypeAttributes) {
        add_attributes_to_builder(
            &mut self.string_type_attributes,
            TypeKind::String,
            attributes,
        );
        let distinct: IndexSet<&String> = cases.iter().collect();
        for s in distinct {
            *self.string_cases.entry(s.clone()).or_insert(0) += 1;
        }
    }

    /// `addStringCase(s, count, attributes)`.
    pub fn add_string_case(&mut self, s: &str, count: u64, attributes: TypeAttributes) {
        add_attributes_to_builder(
            &mut self.string_type_attributes,
            TypeKind::String,
            attributes,
        );
        *self.string_cases.entry(s.to_owned()).or_insert(0) += count;
    }

    /// `enumCases`.
    pub fn enum_cases(&self) -> &IndexSet<String> {
        &self.enum_cases
    }

    /// `lostTypeAttributes`.
    pub fn lost_type_attributes(&self) -> bool {
        self.lost_type_attributes
    }

    /// `getMemberKinds()`: non-string kinds first, then string kinds, each in
    /// insertion order. No members means `none`; an `any` member absorbs
    /// everything; with number conflation `integer` merges into `double`.
    pub fn get_member_kinds(&self) -> Result<IndexMap<TypeKind, TypeAttributes>> {
        assert(
            !(self.have(TypeKind::Enum) && self.have(TypeKind::String)),
            "We can't have both strings and enums in the same union",
        )?;

        let mut string_type_attributes = build_type_attribute_map(&self.string_type_attributes)?;
        if !self.string_cases.is_empty() {
            let cases = StringTypes {
                cases: Some(self.string_cases.clone()),
                transformations: IndexSet::new(),
            };
            set_attributes(
                &mut string_type_attributes,
                TypeKind::String,
                &StringTypesTypeAttributeKind.make_attributes(cases),
            )?;
        }

        // mapMerge: non-string kinds first, string kinds appended.
        let mut merged = build_type_attribute_map(&self.non_string_type_attributes)?;
        for (kind, attributes) in string_type_attributes {
            merged.insert(kind, attributes);
        }

        if merged.is_empty() {
            return Ok([(TypeKind::None, TypeAttributes::new())]
                .into_iter()
                .collect());
        }

        if self.non_string_type_attributes.contains_key(&TypeKind::Any) {
            assert(
                self.lost_type_attributes,
                "This had to be set when we added 'any'",
            )?;
            let all: Vec<&TypeAttributes> = merged.values().collect();
            let all_attributes = combine_type_attributes(CombinationKind::Union, &all)?;
            return Ok([(TypeKind::Any, all_attributes)].into_iter().collect());
        }

        if self.conflate_numbers && self.have(TypeKind::Integer) && self.have(TypeKind::Double) {
            move_attributes(&mut merged, TypeKind::Integer, TypeKind::Double)?;
        }

        if self.have(TypeKind::Map) {
            move_attributes(&mut merged, TypeKind::Map, TypeKind::Class)?;
        }

        Ok(merged)
    }
}

impl<TArray, TObject> UnionTypeProvider for UnionAccumulator<TArray, TObject> {
    type ArrayData = Vec<TArray>;
    type ObjectData = Vec<TObject>;

    fn array_data(&self) -> &Vec<TArray> {
        &self.array_data
    }

    fn object_data(&self) -> &Vec<TObject> {
        &self.object_data
    }

    fn enum_cases(&self) -> Result<&IndexSet<String>> {
        Ok(&self.enum_cases)
    }

    fn get_member_kinds(&self) -> Result<IndexMap<TypeKind, TypeAttributes>> {
        UnionAccumulator::get_member_kinds(self)
    }

    fn lost_type_attributes(&self) -> bool {
        self.lost_type_attributes
    }
}

/// A union or the faux root union of [`attributes_for_types`].
#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
enum UnionOrFaux {
    Faux,
    Union(TypeRef),
}

/// `attributesForTypes(types)`: flattens nested unions into their leaf
/// types. Each leaf gets its own attributes plus those of every ancestor
/// union that has only that one leaf; the union attributes are combined from
/// the visited unions (inferred unless the union is equivalent to the single
/// root type).
fn attributes_for_types(
    graph: &TypeGraph,
    types: &IndexSet<TypeRef>,
) -> Result<(IndexMap<TypeRef, TypeAttributes>, TypeAttributes)> {
    #[derive(Default)]
    struct Traversal {
        /// The unions that are ancestors of each leaf type.
        unions_for_type: IndexMap<TypeRef, IndexSet<UnionOrFaux>>,
        /// The reverse: the leaf types below each union.
        types_for_union: IndexMap<UnionOrFaux, IndexSet<TypeRef>>,
        /// All unions seen, stopping at non-unions.
        unions: IndexSet<TypeRef>,
        /// The unions equivalent to the single root type (if there is one).
        unions_equivalent_to_root: IndexSet<TypeRef>,
    }

    impl Traversal {
        fn traverse(
            &mut self,
            graph: &TypeGraph,
            t: TypeRef,
            path: &mut Vec<UnionOrFaux>,
            is_equivalent_to_root: bool,
        ) -> Result<()> {
            if graph.kind(t)? == TypeKind::Union {
                self.unions.insert(t);
                if is_equivalent_to_root {
                    self.unions_equivalent_to_root.insert(t);
                }
                let members = graph.type_at(t)?.members()?;
                let is_equivalent_to_root = is_equivalent_to_root && members.len() == 1;
                path.push(UnionOrFaux::Union(t));
                for &m in members {
                    self.traverse(graph, m, path, is_equivalent_to_root)?;
                }
                path.pop();
            } else {
                self.unions_for_type
                    .entry(t)
                    .or_default()
                    .extend(path.iter().copied());
                for &u in path.iter() {
                    self.types_for_union.entry(u).or_default().insert(t);
                }
            }
            Ok(())
        }
    }

    let mut traversal = Traversal::default();
    let mut root_path = vec![UnionOrFaux::Faux];
    for &t in types {
        traversal.traverse(graph, t, &mut root_path, types.len() == 1)?;
    }
    let Traversal {
        unions_for_type,
        types_for_union,
        unions,
        unions_equivalent_to_root,
    } = traversal;

    let empty = TypeAttributes::new();
    let union_attributes_of = |u: UnionOrFaux| -> Result<&TypeAttributes> {
        match u {
            UnionOrFaux::Faux => Ok(&empty),
            UnionOrFaux::Union(u) => graph.attributes(u),
        }
    };

    let mut result_attributes: IndexMap<TypeRef, TypeAttributes> = IndexMap::new();
    for (&t, union_for_type) in &unions_for_type {
        let single_ancestors: Vec<UnionOrFaux> = union_for_type
            .iter()
            .copied()
            .filter(|u| types_for_union.get(u).is_some_and(|s| s.len() == 1))
            .collect();
        assert(
            single_ancestors
                .iter()
                .all(|u| types_for_union.get(u).is_some_and(|s| s.contains(&t))),
            "We messed up bookkeeping",
        )?;
        let mut all: Vec<&TypeAttributes> = vec![graph.attributes(t)?];
        for &u in &single_ancestors {
            all.push(union_attributes_of(u)?);
        }
        result_attributes.insert(t, combine_type_attributes(CombinationKind::Union, &all)?);
    }

    let mut union_attributes: Vec<TypeAttributes> = Vec::with_capacity(unions.len());
    for &u in &unions {
        let leaves = types_for_union.get(&UnionOrFaux::Union(u));
        if leaves.is_some_and(|s| s.len() == 1) {
            union_attributes.push(TypeAttributes::new());
            continue;
        }
        let attributes = graph.attributes(u)?;
        if unions_equivalent_to_root.contains(&u) {
            union_attributes.push(attributes.clone());
        } else {
            union_attributes.push(make_type_attributes_inferred(attributes)?);
        }
    }
    let refs: Vec<&TypeAttributes> = union_attributes.iter().collect();
    Ok((
        result_attributes,
        combine_type_attributes(CombinationKind::Union, &refs)?,
    ))
}

/// `TypeRefUnionAccumulator`: a union accumulator over existing types; array
/// data are item types, object data are the objects themselves.
pub type TypeRefUnionAccumulator = UnionAccumulator<TypeRef, TypeRef>;

impl UnionAccumulator<TypeRef, TypeRef> {
    /// `addType(t, attributes)`.
    fn add_type(
        &mut self,
        graph: &TypeGraph,
        t: TypeRef,
        attributes: TypeAttributes,
    ) -> Result<()> {
        let ty = graph.type_at(t)?;
        match ty.kind() {
            TypeKind::None => self.add_none(attributes),
            TypeKind::Any => self.add_any(attributes),
            TypeKind::Null | TypeKind::Bool | TypeKind::Integer | TypeKind::Double => {
                self.add_primitive(ty.kind(), attributes)?
            }
            TypeKind::String => self.add_string_type(TypeKind::String, attributes, None)?,
            TypeKind::Array => self.add_array(ty.items()?, attributes),
            TypeKind::Class | TypeKind::Map | TypeKind::Object => self.add_object(t, attributes),
            // FIXME (TypeScript): counts are not carried, which is wrong with
            // enum inference; JSON Schema input uses this without it.
            TypeKind::Enum => self.add_enum(ty.cases()?, attributes),
            TypeKind::Union => {
                return panic(
                    "The unions should have been eliminated in attributesForTypesInUnion",
                );
            }
            TypeKind::Intersection => return panic("Unknown type intersection"),
            kind => self.add_string_type(kind, attributes, None)?,
        }
        Ok(())
    }

    /// `addTypes(types)`: adds the leaf types of `types` (of `graph`),
    /// flattening unions, and returns the attributes for the union.
    pub fn add_types(
        &mut self,
        graph: &TypeGraph,
        types: &IndexSet<TypeRef>,
    ) -> Result<TypeAttributes> {
        let (attributes_map, union_attributes) = attributes_for_types(graph, types)?;
        for (t, attributes) in attributes_map {
            self.add_type(graph, t, attributes)?;
        }
        Ok(union_attributes)
    }
}

/// `UnionBuilder`: builds a union from a [`UnionTypeProvider`]. Implementors
/// decide how arrays and objects are combined.
pub trait UnionBuilder<'g> {
    /// The provider's array data.
    type ArrayData;
    /// The provider's object data.
    type ObjectData;

    /// `makeObject(objects, typeAttributes, forwardingRef)`.
    fn make_object(
        &self,
        builder: &mut TypeBuilder<'g>,
        objects: &Self::ObjectData,
        type_attributes: TypeAttributes,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef>;

    /// `makeArray(arrays, typeAttributes, forwardingRef)`.
    fn make_array(
        &self,
        builder: &mut TypeBuilder<'g>,
        arrays: &Self::ArrayData,
        type_attributes: TypeAttributes,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef>;

    /// `makeTypeOfKind(typeProvider, kind, typeAttributes, forwardingRef)`.
    fn make_type_of_kind<P>(
        &self,
        builder: &mut TypeBuilder<'g>,
        type_provider: &P,
        kind: TypeKind,
        type_attributes: TypeAttributes,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef>
    where
        P: UnionTypeProvider<ArrayData = Self::ArrayData, ObjectData = Self::ObjectData>,
    {
        match kind {
            TypeKind::String => builder.get_string_type(type_attributes, None, forwarding_ref),
            TypeKind::Enum => builder.get_enum_type(
                type_attributes,
                type_provider.enum_cases()?.clone(),
                forwarding_ref,
            ),
            TypeKind::Object => self.make_object(
                builder,
                type_provider.object_data(),
                type_attributes,
                forwarding_ref,
            ),
            TypeKind::Array => self.make_array(
                builder,
                type_provider.array_data(),
                type_attributes,
                forwarding_ref,
            ),
            kind if kind.is_primitive_type_kind() => {
                builder.get_primitive_type(kind, type_attributes, forwarding_ref)
            }
            kind => panic(format!("getMemberKinds() shouldn't return {kind}")),
        }
    }

    /// `buildUnion(typeProvider, unique, typeAttributes, forwardingRef)`.
    fn build_union<P>(
        &self,
        builder: &mut TypeBuilder<'g>,
        type_provider: &P,
        unique: bool,
        type_attributes: TypeAttributes,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef>
    where
        P: UnionTypeProvider<ArrayData = Self::ArrayData, ObjectData = Self::ObjectData>,
    {
        let kinds = type_provider.get_member_kinds()?;

        if type_provider.lost_type_attributes() {
            builder.set_lost_type_attributes();
        }

        if kinds.len() == 1 {
            let (&kind, member_attributes) = defined(kinds.first())?;
            let all_attributes = combine_type_attributes2(
                CombinationKind::Union,
                &type_attributes,
                &increase_type_attributes_distance(member_attributes),
            )?;
            return self.make_type_of_kind(
                builder,
                type_provider,
                kind,
                all_attributes,
                forwarding_ref,
            );
        }

        let union = if unique {
            Some(builder.get_unique_union_type(type_attributes.clone(), None, forwarding_ref)?)
        } else {
            None
        };

        let mut types: Vec<TypeRef> = Vec::with_capacity(kinds.len());
        for (&kind, member_attributes) in &kinds {
            types.push(self.make_type_of_kind(
                builder,
                type_provider,
                kind,
                member_attributes.clone(),
                None,
            )?);
        }

        let types_set: IndexSet<TypeRef> = types.into_iter().collect();
        match union {
            Some(union) => {
                builder.set_set_operation_members(union, types_set)?;
                Ok(union)
            }
            None => builder.get_union_type(type_attributes, types_set, forwarding_ref),
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn string_cases(accumulator: &UnionAccumulator<(), ()>) -> Option<Vec<(String, u64)>> {
        let kinds = accumulator.get_member_kinds().unwrap();
        let attributes = kinds.get(&TypeKind::String).unwrap();
        let st = StringTypesTypeAttributeKind
            .try_get_in_attributes(attributes)
            .unwrap();
        st.cases
            .as_ref()
            .map(|c| c.iter().map(|(k, v)| (k.clone(), *v)).collect())
    }

    // Port of test/unit/union-accumulator.test.ts.
    #[test]
    fn combines_case_counts_without_counting_duplicates_within_one_batch() {
        let mut accumulator = UnionAccumulator::<(), ()>::new(true);
        accumulator.add_string_case("red", 2, TypeAttributes::new());
        accumulator.add_string_cases(&["blue".into(), "blue".into()], TypeAttributes::new());
        assert_eq!(
            string_cases(&accumulator),
            Some(vec![("red".into(), 2), ("blue".into(), 1)])
        );
    }

    // Port of test/unit/union-accumulator.test.ts.
    #[test]
    fn keeps_an_unrestricted_string_unrestricted() {
        let mut accumulator = UnionAccumulator::<(), ()>::new(true);
        accumulator.add_string_case("red", 1, TypeAttributes::new());
        accumulator
            .add_string_type(TypeKind::String, TypeAttributes::new(), None)
            .unwrap();
        assert_eq!(string_cases(&accumulator), None);
    }

    #[test]
    fn member_kinds_order_and_number_conflation() {
        let mut a = UnionAccumulator::<(), ()>::new(true);
        a.add_string_type(TypeKind::Date, TypeAttributes::new(), None)
            .unwrap();
        a.add_primitive(TypeKind::Integer, TypeAttributes::new())
            .unwrap();
        a.add_primitive(TypeKind::Bool, TypeAttributes::new())
            .unwrap();
        a.add_primitive(TypeKind::Double, TypeAttributes::new())
            .unwrap();
        let kinds: Vec<TypeKind> = a.get_member_kinds().unwrap().keys().copied().collect();
        assert_eq!(
            kinds,
            vec![TypeKind::Bool, TypeKind::Double, TypeKind::Date]
        );

        let mut b = UnionAccumulator::<(), ()>::new(false);
        b.add_primitive(TypeKind::Integer, TypeAttributes::new())
            .unwrap();
        b.add_primitive(TypeKind::Double, TypeAttributes::new())
            .unwrap();
        assert_eq!(b.get_member_kinds().unwrap().len(), 2);

        let empty = UnionAccumulator::<(), ()>::new(false);
        assert_eq!(
            empty
                .get_member_kinds()
                .unwrap()
                .keys()
                .copied()
                .collect::<Vec<_>>(),
            vec![TypeKind::None]
        );

        let mut any = UnionAccumulator::<(), ()>::new(false);
        any.add_primitive(TypeKind::Null, TypeAttributes::new())
            .unwrap();
        any.add_any(TypeAttributes::new());
        assert!(any.lost_type_attributes());
        assert_eq!(
            any.get_member_kinds()
                .unwrap()
                .keys()
                .copied()
                .collect::<Vec<_>>(),
            vec![TypeKind::Any]
        );
    }

    #[test]
    fn enums_fold_into_strings() {
        let mut a = UnionAccumulator::<(), ()>::new(false);
        a.add_string_type(TypeKind::String, TypeAttributes::new(), None)
            .unwrap();
        a.add_enum(
            &["x".to_owned()].into_iter().collect(),
            TypeAttributes::new(),
        );
        assert!(a.enum_cases().is_empty());
        let mut b = UnionAccumulator::<(), ()>::new(false);
        b.add_enum(
            &["x".to_owned()].into_iter().collect(),
            TypeAttributes::new(),
        );
        assert!(
            b.add_string_type(
                TypeKind::String,
                TypeAttributes::new(),
                Some(StringTypes::from_case("y", 1))
            )
            .is_err()
        );
    }
}
