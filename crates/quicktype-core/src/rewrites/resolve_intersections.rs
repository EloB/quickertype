//! Port of `packages/quicktype-core/src/rewrites/ResolveIntersections.ts`.
//!
//! Replaces intersections (JSON Schema `allOf`) by the types they describe:
//! primitive kinds are intersected (an integer and a double intersect to an
//! integer), objects get the union of the properties with intersected
//! property types, arrays intersected item types. Intersections of members
//! that are still non-canonical unions wait for
//! [`flatten_unions`](super::flatten_unions); new intersections made for
//! property and item types need another pass.
//!
//! A reproduced quirk: of the arrays being intersected, the first one only
//! starts the item set, so its items are dropped (`allOf` of `integer[]` and
//! `string[]` is `string[]`).

use std::cell::Cell;
use std::rc::Rc;

use indexmap::{IndexMap, IndexSet};

use crate::attributes::type_attributes::{
    CombinationKind, TypeAttributes, combine_type_attributes, combine_type_attributes2,
    make_type_attributes_inferred,
};
use crate::graph_rewriting::make_replacer;
use crate::messages::Result;
use crate::support::support::{defined, must_not_happen, panic};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_builder::TypeBuilder;
use crate::ty::type_builder_utils::StringTypeMapping;
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::TypeRef;
use crate::ty::type_utils::{
    make_groups_to_flatten, set_operation_members_recursively, union_is_canonical,
};
use crate::union_builder::{UnionBuilder, UnionTypeProvider};

/// `canResolve(t)`: an intersection can be resolved once its members are
/// not non-canonical unions.
fn can_resolve(graph: &TypeGraph, t: TypeRef) -> Result<bool> {
    let (members, _) = set_operation_members_recursively(graph, &[t], None)?;
    if members.len() <= 1 {
        return Ok(true);
    }
    for &m in &members {
        if graph.kind(m)? == TypeKind::Union && !union_is_canonical(graph, m)? {
            return Ok(false);
        }
    }
    Ok(true)
}

/// `GenericClassProperty<Set<Type>>`: the types a property has to be (all
/// of them), and whether it is optional.
#[derive(Clone, Debug)]
pub struct IntersectionProperty {
    /// `typeData`.
    pub types: IndexSet<TypeRef>,
    /// `isOptional`.
    pub is_optional: bool,
}

/// `PropertyMap`.
pub type PropertyMap = IndexMap<String, IntersectionProperty>;

/// The object data of an [`IntersectionAccumulator`]: the properties and
/// the types additional properties have to be (`None`: no additional
/// properties allowed). `None` as a whole means the type can't be an object.
pub type IntersectionObjectData = Option<(PropertyMap, Option<IndexSet<TypeRef>>)>;

/// `_arrayItemTypes`.
#[derive(Clone, Debug)]
pub enum IntersectionArrayItems {
    /// `undefined`: no types seen yet.
    Unseen,
    /// A set: all types seen can be arrays; their items (except the first
    /// array's, a quirk).
    Items(IndexSet<TypeRef>),
    /// `false`: some type can't be an array.
    NotArray,
}

/// `IntersectionAccumulator`: intersects the members of an intersection.
pub struct IntersectionAccumulator {
    primitive_types: Option<IndexSet<TypeKind>>,
    primitive_attributes: IndexMap<TypeKind, TypeAttributes>,
    array_item_types: IntersectionArrayItems,
    array_attributes: TypeAttributes,
    object_data: IntersectionObjectData,
    object_attributes: TypeAttributes,
    lost_type_attributes: Cell<bool>,
}

impl Default for IntersectionAccumulator {
    fn default() -> Self {
        IntersectionAccumulator::new()
    }
}

impl IntersectionAccumulator {
    /// A new accumulator: no primitive types yet, every object allowed.
    pub fn new() -> Self {
        IntersectionAccumulator {
            primitive_types: None,
            primitive_attributes: IndexMap::new(),
            array_item_types: IntersectionArrayItems::Unseen,
            array_attributes: TypeAttributes::new(),
            object_data: Some((IndexMap::new(), Some(IndexSet::new()))),
            object_attributes: TypeAttributes::new(),
            lost_type_attributes: Cell::new(false),
        }
    }

    fn update_primitive_types(&mut self, graph: &TypeGraph, members: &[TypeRef]) -> Result<()> {
        let mut types: IndexSet<TypeRef> = IndexSet::new();
        for &t in members {
            if graph.kind(t)?.is_primitive_type_kind() {
                types.insert(t);
            }
        }
        // `attributesForTypes`: the last type of a kind wins.
        let mut attributes: IndexMap<TypeKind, TypeAttributes> = IndexMap::new();
        for &t in &types {
            attributes.insert(graph.kind(t)?, graph.attributes(t)?.clone());
        }
        for (kind, b) in attributes {
            let merged = match self.primitive_attributes.get(&kind) {
                None => b,
                Some(a) => combine_type_attributes2(CombinationKind::Intersect, a, &b)?,
            };
            self.primitive_attributes.insert(kind, merged);
        }

        let mut kinds: IndexSet<TypeKind> = IndexSet::new();
        for &t in &types {
            kinds.insert(graph.kind(t)?);
        }
        let Some(primitive_types) = &self.primitive_types else {
            self.primitive_types = Some(kinds);
            return Ok(());
        };

        let have_number = primitive_types.iter().any(|k| k.is_number_type_kind())
            && kinds.iter().any(|k| k.is_number_type_kind());
        let mut intersected: IndexSet<TypeKind> = primitive_types
            .iter()
            .filter(|k| kinds.contains(*k))
            .copied()
            .collect();
        if have_number && !intersected.iter().any(|k| k.is_number_type_kind()) {
            // One set has integer, the other has double. The intersection
            // of that is integer.
            intersected.insert(TypeKind::Integer);
        }
        self.primitive_types = Some(intersected);
        Ok(())
    }

    fn update_array_item_types(&mut self, graph: &TypeGraph, members: &[TypeRef]) -> Result<()> {
        let mut maybe_array = None;
        for &t in members {
            if graph.type_at(t)?.is_array() {
                maybe_array = Some(t);
                break;
            }
        }
        let Some(array) = maybe_array else {
            self.array_item_types = IntersectionArrayItems::NotArray;
            return Ok(());
        };

        self.array_attributes = combine_type_attributes2(
            CombinationKind::Intersect,
            &self.array_attributes,
            graph.attributes(array)?,
        )?;

        match &mut self.array_item_types {
            IntersectionArrayItems::Unseen => {
                // The first array's items are dropped (TypeScript quirk).
                self.array_item_types = IntersectionArrayItems::Items(IndexSet::new());
            }
            IntersectionArrayItems::Items(items) => {
                items.insert(graph.type_at(array)?.items()?);
            }
            IntersectionArrayItems::NotArray => {}
        }
        Ok(())
    }

    fn update_object_properties(&mut self, graph: &TypeGraph, members: &[TypeRef]) -> Result<()> {
        let mut maybe_object = None;
        for &t in members {
            if graph.type_at(t)?.is_object_type() {
                maybe_object = Some(t);
                break;
            }
        }
        let Some(object) = maybe_object else {
            self.object_data = None;
            return Ok(());
        };

        self.object_attributes = combine_type_attributes2(
            CombinationKind::Intersect,
            &self.object_attributes,
            graph.attributes(object)?,
        )?;
        let object_type = graph.type_at(object)?;
        let object_properties = object_type.properties()?;
        let object_additional_properties = object_type.additional_properties()?;

        let Some((properties, additional_property_types)) = &mut self.object_data else {
            return Ok(());
        };

        let mut all_property_names: IndexSet<String> = properties.keys().cloned().collect();
        all_property_names.extend(object_properties.keys().cloned());
        for name in all_property_names {
            let new_property = object_properties.get(&name);
            match (properties.get_mut(&name), new_property) {
                // A property declared by any member is known on the merged
                // object; a member that doesn't allow additional properties
                // must not discard properties declared by others.
                (Some(existing), Some(new_property)) => {
                    existing.types.insert(new_property.type_ref);
                    existing.is_optional = existing.is_optional && new_property.is_optional;
                }
                (Some(existing), None) => {
                    if let Some(additional) = object_additional_properties {
                        existing.types.insert(additional);
                    }
                }
                (None, Some(new_property)) => {
                    let mut types = match additional_property_types {
                        None => IndexSet::new(),
                        Some(additional) => additional.clone(),
                    };
                    types.insert(new_property.type_ref);
                    properties.insert(
                        name,
                        IntersectionProperty {
                            types,
                            is_optional: new_property.is_optional,
                        },
                    );
                }
                (None, None) => return must_not_happen(),
            }
        }

        match (
            additional_property_types.as_mut(),
            object_additional_properties,
        ) {
            (Some(types), Some(additional)) => {
                types.insert(additional);
            }
            (None, None) => {}
            _ => {
                *additional_property_types = None;
                self.lost_type_attributes.set(true);
            }
        }
        Ok(())
    }

    fn add_union_set(&mut self, graph: &TypeGraph, members: &[TypeRef]) -> Result<()> {
        self.update_primitive_types(graph, members)?;
        self.update_array_item_types(graph, members)?;
        self.update_object_properties(graph, members)
    }

    /// `addType(t)`: intersects `t` (of the graph being rewritten) into the
    /// accumulator, and returns its attributes, made inferred.
    pub fn add_type(&mut self, graph: &TypeGraph, t: TypeRef) -> Result<TypeAttributes> {
        let ty = graph.type_at(t)?;
        let mut attributes = graph.attributes(t)?.clone();
        match ty.kind() {
            TypeKind::None => return panic("There shouldn't be a none type"),
            TypeKind::Any => {
                return panic(
                    "The any type should have been filtered out in setOperationMembersRecursively",
                );
            }
            TypeKind::Class => return panic("We should never see class types in intersections"),
            TypeKind::Map => return panic("We should never see map types in intersections"),
            TypeKind::Enum => return panic("We should never see enum types in intersections"),
            TypeKind::Union => {
                let members: Vec<TypeRef> = ty.members()?.iter().copied().collect();
                let mut all: Vec<&TypeAttributes> = vec![&attributes];
                for &m in &members {
                    all.push(graph.attributes(m)?);
                }
                let combined = combine_type_attributes(CombinationKind::Intersect, &all)?;
                attributes = combined;
                self.add_union_set(graph, &members)?;
            }
            TypeKind::Intersection => return panic("Unknown type intersection"),
            _ => self.add_union_set(graph, &[t])?,
        }
        make_type_attributes_inferred(&attributes)
    }
}

impl UnionTypeProvider for IntersectionAccumulator {
    type ArrayData = IntersectionArrayItems;
    type ObjectData = IntersectionObjectData;

    fn array_data(&self) -> &IntersectionArrayItems {
        &self.array_item_types
    }

    fn object_data(&self) -> &IntersectionObjectData {
        &self.object_data
    }

    fn enum_cases(&self) -> Result<&IndexSet<String>> {
        panic("We don't support enums in intersections")
    }

    fn get_member_kinds(&self) -> Result<IndexMap<TypeKind, TypeAttributes>> {
        let mut kinds: IndexMap<TypeKind, TypeAttributes> = IndexMap::new();
        for &k in defined(self.primitive_types.as_ref())? {
            kinds.insert(k, defined(self.primitive_attributes.get(&k))?.clone());
        }
        // If double was eliminated, add its attributes to integer.
        if let Some(double_attributes) = self.primitive_attributes.get(&TypeKind::Double)
            && !kinds.contains_key(&TypeKind::Double)
            && let Some(integer_attributes) = kinds.get(&TypeKind::Integer)
        {
            let combined = combine_type_attributes2(
                CombinationKind::Intersect,
                integer_attributes,
                double_attributes,
            )?;
            kinds.insert(TypeKind::Integer, combined);
        }

        if let IntersectionArrayItems::Items(_) = self.array_item_types {
            kinds.insert(TypeKind::Array, self.array_attributes.clone());
        } else if !self.array_attributes.is_empty() {
            self.lost_type_attributes.set(true);
        }

        if self.object_data.is_some() {
            kinds.insert(TypeKind::Object, self.object_attributes.clone());
        } else if !self.object_attributes.is_empty() {
            self.lost_type_attributes.set(true);
        }

        Ok(kinds)
    }

    fn lost_type_attributes(&self) -> bool {
        self.lost_type_attributes.get()
    }
}

/// `IntersectionUnionBuilder`: builds the resolved type; property, item
/// and additional property types become new intersections.
#[derive(Default)]
pub struct IntersectionUnionBuilder {
    created_new_intersections: Cell<bool>,
}

impl IntersectionUnionBuilder {
    /// `makeIntersection(members, attributes)`: the single reconstituted
    /// member, or a new intersection of the reconstituted members.
    fn make_intersection(
        &self,
        builder: &mut TypeBuilder<'_>,
        members: &IndexSet<TypeRef>,
        attributes: TypeAttributes,
    ) -> Result<TypeRef> {
        let mut reconstituted_members: IndexSet<TypeRef> = IndexSet::new();
        for &t in members {
            reconstituted_members.insert(builder.reconstitute_type_ref(
                t,
                TypeAttributes::new(),
                None,
            )?);
        }

        let first = *defined(reconstituted_members.first())?;
        if reconstituted_members.len() == 1 {
            builder.add_attributes(first, &attributes)?;
            return Ok(first);
        }

        self.created_new_intersections.set(true);
        builder.get_unique_intersection_type(attributes, Some(reconstituted_members), None)
    }

    /// `createdNewIntersections`.
    pub fn created_new_intersections(&self) -> bool {
        self.created_new_intersections.get()
    }
}

impl<'g> UnionBuilder<'g> for IntersectionUnionBuilder {
    type ArrayData = IntersectionArrayItems;
    type ObjectData = IntersectionObjectData;

    fn make_object(
        &self,
        builder: &mut TypeBuilder<'g>,
        maybe_data: &IntersectionObjectData,
        type_attributes: TypeAttributes,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        let Some((property_types, maybe_additional_properties)) = maybe_data else {
            return panic(
                "Either properties or additional properties must be given to make an object type",
            );
        };

        let mut properties = IndexMap::with_capacity(property_types.len());
        for (name, cp) in property_types {
            let t = self.make_intersection(builder, &cp.types, TypeAttributes::new())?;
            properties.insert(name.clone(), builder.make_class_property(t, cp.is_optional));
        }
        let additional_properties = match maybe_additional_properties {
            None => None,
            Some(types) => Some(self.make_intersection(builder, types, TypeAttributes::new())?),
        };
        builder.get_unique_object_type(
            type_attributes,
            Some(properties),
            additional_properties,
            forwarding_ref,
        )
    }

    fn make_array(
        &self,
        builder: &mut TypeBuilder<'g>,
        arrays: &IntersectionArrayItems,
        type_attributes: TypeAttributes,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        let IntersectionArrayItems::Items(arrays) = arrays else {
            return panic("This should not be called if the type can't be an array");
        };
        // FIXME (TypeScript): attributes
        let items_type = self.make_intersection(builder, arrays, TypeAttributes::new())?;
        builder.get_array_type(type_attributes, items_type, forwarding_ref)
    }
}

/// `replace(types, builder, forwardingRef)`: builds the resolved type of a
/// group of intersections with the same members.
fn replace(
    types: &IndexSet<TypeRef>,
    builder: &mut TypeBuilder<'_>,
    forwarding_ref: TypeRef,
    needs_repeat: &Cell<bool>,
) -> Result<TypeRef> {
    let graph = builder.original_graph()?;
    let mut intersections: Vec<TypeRef> = Vec::new();
    for &t in types {
        if graph.kind(t)? == TypeKind::Intersection {
            intersections.push(t);
        }
    }
    let (members, intersection_attributes) =
        set_operation_members_recursively(graph, &intersections, Some(CombinationKind::Intersect))?;
    if members.is_empty() {
        return builder.get_primitive_type(
            TypeKind::Any,
            intersection_attributes,
            Some(forwarding_ref),
        );
    }

    let mut none_type = None;
    for &t in &members {
        if graph.kind(t)? == TypeKind::None {
            none_type = Some(t);
            break;
        }
    }
    if let Some(none_type) = none_type {
        return builder.reconstitute_type(none_type, intersection_attributes, Some(forwarding_ref));
    }

    if members.len() == 1 {
        return builder.reconstitute_type(
            *defined(members.first())?,
            intersection_attributes,
            Some(forwarding_ref),
        );
    }

    let mut accumulator = IntersectionAccumulator::new();
    let mut member_attributes: Vec<TypeAttributes> = Vec::with_capacity(members.len());
    for &t in &members {
        member_attributes.push(accumulator.add_type(graph, t)?);
    }
    let member_attribute_refs: Vec<&TypeAttributes> = member_attributes.iter().collect();
    let extra_attributes = make_type_attributes_inferred(&combine_type_attributes(
        CombinationKind::Intersect,
        &member_attribute_refs,
    )?)?;
    let attributes = combine_type_attributes2(
        CombinationKind::Intersect,
        &intersection_attributes,
        &extra_attributes,
    )?;

    let union_builder = IntersectionUnionBuilder::default();
    let tref = union_builder.build_union(
        builder,
        &accumulator,
        true,
        attributes,
        Some(forwarding_ref),
    )?;
    if union_builder.created_new_intersections() {
        needs_repeat.set(true);
    }
    Ok(tref)
}

/// `resolveIntersections(graph, stringTypeMapping,
/// debugPrintReconstitution)`.
///
/// Returns the new graph (`None` if there was nothing to resolve:
/// TypeScript returns the same graph) and whether resolving is done: false
/// if some intersection had to wait for union flattening or new
/// intersections were made.
pub fn resolve_intersections(
    graph: &TypeGraph,
    string_type_mapping: &StringTypeMapping,
    debug_print_reconstitution: bool,
) -> Result<(Option<TypeGraph>, bool)> {
    let mut all_intersections: Vec<TypeRef> = Vec::new();
    for t in graph.all_types_unordered() {
        if graph.kind(t)? == TypeKind::Intersection {
            all_intersections.push(t);
        }
    }
    let mut resolvable_intersections: Vec<TypeRef> = Vec::new();
    for &t in &all_intersections {
        if can_resolve(graph, t)? {
            resolvable_intersections.push(t);
        }
    }
    let all_resolvable = all_intersections.len() == resolvable_intersections.len();
    let groups = make_groups_to_flatten(graph, resolvable_intersections, None)?;

    let needs_repeat = Rc::new(Cell::new(false));
    let replacer_needs_repeat = Rc::clone(&needs_repeat);
    let replacer = make_replacer(move |types, builder, forwarding_ref| {
        replace(types, builder, forwarding_ref, &replacer_needs_repeat)
    });
    let new_graph = graph.rewrite(
        "resolve intersections",
        string_type_mapping,
        false,
        groups,
        debug_print_reconstitution,
        replacer,
        false,
    )?;

    Ok((new_graph, !needs_repeat.get() && all_resolvable))
}
