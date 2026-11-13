//! Port of `packages/quicktype-core/src/UnifyClasses.ts`.
//!
//! Unification: building one type from a set of types of the graph being
//! rewritten. Classes are merged property by property (a property missing in
//! some class becomes optional), arrays by unifying their items, and
//! everything else through a union.
//!
//! The recursion (unifying property types) goes through a callback, because
//! `FlattenUnions` plugs in its own; [`union_builder_for_unification`]
//! provides the standard one.

use std::rc::Rc;

use indexmap::{IndexMap, IndexSet};

use crate::attributes::type_attributes::{
    CombinationKind, TypeAttributes, combine_type_attributes2,
};
use crate::messages::Result;
use crate::support::support::{assert, panic};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::ty::ClassProperty;
use crate::ty::type_builder::TypeBuilder;
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::TypeRef;
use crate::ty::type_utils::assert_is_object;
use crate::union_builder::{TypeRefUnionAccumulator, UnionBuilder};

/// The callback a [`UnifyUnionBuilder`] uses to unify a list of types (of
/// the original graph) into one new type. It receives the union builder
/// itself so it can recurse with it.
pub type UnifyTypesCallback<'g> =
    Rc<dyn Fn(&UnifyUnionBuilder<'g>, &mut TypeBuilder<'g>, &[TypeRef]) -> Result<TypeRef> + 'g>;

/// `getCliqueProperties(clique, builder, makePropertyType)`: the union of the
/// properties of a set of objects. The additional properties are unified
/// first, then each property in name order.
fn get_clique_properties<'g>(
    graph: &TypeGraph,
    clique: &[TypeRef],
    builder: &mut TypeBuilder<'g>,
    mut make_property_type: impl FnMut(&mut TypeBuilder<'g>, &IndexSet<TypeRef>) -> Result<TypeRef>,
) -> Result<(IndexMap<String, ClassProperty>, Option<TypeRef>, bool)> {
    let lost_type_attributes = false;
    let mut property_names: IndexSet<String> = IndexSet::new();
    for &o in clique {
        property_names.extend(graph.type_at(o).properties()?.keys().cloned());
    }

    let mut properties: Vec<(String, IndexSet<TypeRef>, bool)> = property_names
        .into_iter()
        .map(|name| (name, IndexSet::new(), false))
        .collect();
    let mut additional_properties: Option<IndexSet<TypeRef>> = None;
    for &o in clique {
        let object = graph.type_at(o);
        let additional = object.additional_properties()?;
        if let Some(additional) = additional {
            additional_properties
                .get_or_insert_with(IndexSet::new)
                .insert(additional);
        }

        for (name, types, is_optional) in &mut properties {
            match object.properties()?.get(name) {
                None => {
                    *is_optional = true;
                    if let Some(additional) = additional
                        && graph.kind(additional) != TypeKind::Any
                    {
                        types.insert(additional);
                    }
                }
                Some(property) => {
                    if property.is_optional {
                        *is_optional = true;
                    }
                    types.insert(property.type_ref);
                }
            }
        }
    }

    let unified_additional_properties = match &additional_properties {
        None => None,
        Some(types) => Some(make_property_type(builder, types)?),
    };

    let mut unified_properties = IndexMap::with_capacity(properties.len());
    for (name, types, is_optional) in properties {
        let t = make_property_type(builder, &types)?;
        unified_properties.insert(name, builder.make_class_property(t, is_optional));
    }

    Ok((
        unified_properties,
        unified_additional_properties,
        lost_type_attributes,
    ))
}

struct PropertyCounts {
    has_properties: bool,
    has_additional_properties: bool,
    has_non_any_additional_properties: bool,
}

/// `countProperties(clique)`.
fn count_properties(graph: &TypeGraph, clique: &[TypeRef]) -> Result<PropertyCounts> {
    let mut counts = PropertyCounts {
        has_properties: false,
        has_additional_properties: false,
        has_non_any_additional_properties: false,
    };
    for &o in clique {
        let object = graph.type_at(o);
        if !object.properties()?.is_empty() {
            counts.has_properties = true;
        }
        if let Some(additional) = object.additional_properties()? {
            counts.has_additional_properties = true;
            if graph.kind(additional) != TypeKind::Any {
                counts.has_non_any_additional_properties = true;
            }
        }
    }
    Ok(counts)
}

/// `UnifyUnionBuilder`: the union builder for unification.
pub struct UnifyUnionBuilder<'g> {
    make_object_types: bool,
    make_classes_fixed: bool,
    unify_types: UnifyTypesCallback<'g>,
}

impl<'g> UnifyUnionBuilder<'g> {
    /// `new UnifyUnionBuilder(typeBuilder, makeObjectTypes,
    /// makeClassesFixed, unifyTypes)`.
    ///
    /// * `make_object_types`: unify objects into `object` types (with
    ///   additional properties) rather than classes or maps.
    /// * `make_classes_fixed`: unified classes are fixed.
    pub fn new(
        make_object_types: bool,
        make_classes_fixed: bool,
        unify_types: UnifyTypesCallback<'g>,
    ) -> Self {
        UnifyUnionBuilder {
            make_object_types,
            make_classes_fixed,
            unify_types,
        }
    }

    fn unify(&self, builder: &mut TypeBuilder<'g>, types: &[TypeRef]) -> Result<TypeRef> {
        let callback = Rc::clone(&self.unify_types);
        callback(self, builder, types)
    }
}

impl<'g> UnionBuilder<'g> for UnifyUnionBuilder<'g> {
    type ArrayData = Vec<TypeRef>;
    type ObjectData = Vec<TypeRef>;

    fn make_object(
        &self,
        builder: &mut TypeBuilder<'g>,
        object_refs: &Vec<TypeRef>,
        type_attributes: TypeAttributes,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        if let Some(r) = builder.lookup_type_refs(object_refs, forwarding_ref, true)? {
            assert(
                forwarding_ref.is_none() || Some(r) == forwarding_ref,
                "The forwarding ref must be consumed",
            )?;
            builder.add_attributes(r, &type_attributes)?;
            return Ok(r);
        }

        if object_refs.len() == 1 {
            return builder.reconstitute_type_ref(object_refs[0], type_attributes, forwarding_ref);
        }

        let graph = builder.original_graph()?;
        for &r in object_refs {
            assert_is_object(graph, r)?;
        }
        let counts = count_properties(graph, object_refs)?;

        if !self.make_object_types
            && (counts.has_non_any_additional_properties
                || (!counts.has_properties && counts.has_additional_properties))
        {
            let mut property_types: IndexSet<TypeRef> = IndexSet::new();
            for &o in object_refs {
                property_types.extend(
                    graph
                        .type_at(o)
                        .properties()?
                        .values()
                        .map(|cp| cp.type_ref),
                );
            }
            for &o in object_refs {
                if let Some(additional) = graph.type_at(o).additional_properties()? {
                    property_types.insert(additional);
                }
            }
            let types: Vec<TypeRef> = property_types.into_iter().collect();
            let values = self.unify(builder, &types)?;
            builder.get_map_type(type_attributes, values, forwarding_ref)
        } else {
            let (properties, additional_properties, lost_type_attributes) =
                get_clique_properties(graph, object_refs, builder, |b, types| {
                    assert(!types.is_empty(), "Property has no type")?;
                    let types: Vec<TypeRef> = types.iter().copied().collect();
                    self.unify(b, &types)
                })?;
            if lost_type_attributes {
                builder.set_lost_type_attributes();
            }

            if self.make_object_types {
                builder.get_unique_object_type(
                    type_attributes,
                    Some(properties),
                    additional_properties,
                    forwarding_ref,
                )
            } else {
                assert(
                    additional_properties.is_none(),
                    "We have additional properties but want to make a class",
                )?;
                builder.get_unique_class_type(
                    type_attributes,
                    self.make_classes_fixed,
                    Some(properties),
                    forwarding_ref,
                )
            }
        }
    }

    fn make_array(
        &self,
        builder: &mut TypeBuilder<'g>,
        arrays: &Vec<TypeRef>,
        type_attributes: TypeAttributes,
        forwarding_ref: Option<TypeRef>,
    ) -> Result<TypeRef> {
        let items = self.unify(builder, arrays)?;
        builder.get_array_type(type_attributes, items, forwarding_ref)
    }
}

/// `unionBuilderForUnification(typeBuilder, makeObjectTypes,
/// makeClassesFixed, conflateNumbers)`: a union builder that unifies
/// property and item types with [`unify_types`].
pub fn union_builder_for_unification<'g>(
    make_object_types: bool,
    make_classes_fixed: bool,
    conflate_numbers: bool,
) -> UnifyUnionBuilder<'g> {
    UnifyUnionBuilder::new(
        make_object_types,
        make_classes_fixed,
        Rc::new(move |union_builder, builder, trefs| {
            let types: IndexSet<TypeRef> = trefs.iter().copied().collect();
            unify_types(
                &types,
                &TypeAttributes::new(),
                builder,
                union_builder,
                conflate_numbers,
                None,
            )
        }),
    )
}

/// `unifyTypes(types, typeAttributes, typeBuilder, unionBuilder,
/// conflateNumbers, forwardingRef)`: one new type for `types` (of the
/// original graph). `type_attributes` must not be reconstituted yet.
pub fn unify_types<'g>(
    types: &IndexSet<TypeRef>,
    type_attributes: &TypeAttributes,
    type_builder: &mut TypeBuilder<'g>,
    union_builder: &UnifyUnionBuilder<'g>,
    conflate_numbers: bool,
    maybe_forwarding_ref: Option<TypeRef>,
) -> Result<TypeRef> {
    let type_attributes = type_builder.reconstitute_type_attributes(type_attributes)?;
    let graph = type_builder.original_graph()?;
    match types.first() {
        None => return panic("Cannot unify empty set of types"),
        Some(&first) if types.len() == 1 && graph.kind(first) != TypeKind::Union => {
            return type_builder.reconstitute_type_ref(
                first,
                type_attributes,
                maybe_forwarding_ref,
            );
        }
        Some(_) => {}
    }

    let type_refs: Vec<TypeRef> = types.iter().copied().collect();
    if let Some(r) = type_builder.lookup_type_refs(&type_refs, maybe_forwarding_ref, true)? {
        type_builder.add_attributes(r, &type_attributes)?;
        return Ok(r);
    }

    let mut accumulator = TypeRefUnionAccumulator::new(conflate_numbers);
    let union_attributes = accumulator.add_types(graph, types)?;
    let nested_attributes = type_builder.reconstitute_type_attributes(&union_attributes)?;
    let type_attributes =
        combine_type_attributes2(CombinationKind::Union, &type_attributes, &nested_attributes)?;

    type_builder.with_forwarding_ref(maybe_forwarding_ref, |b, forwarding_ref| {
        b.register_union(&type_refs, forwarding_ref)?;
        union_builder.build_union(
            b,
            &accumulator,
            false,
            type_attributes,
            Some(forwarding_ref),
        )
    })
}
