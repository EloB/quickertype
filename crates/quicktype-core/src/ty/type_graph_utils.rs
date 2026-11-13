//! Port of `packages/quicktype-core/src/Type/TypeGraphUtils.ts`.
//!
//! Small whole-graph rewrites. Each returns `None` where TypeScript returns
//! the unchanged graph.

use indexmap::{IndexMap, IndexSet};

use crate::attributes::type_attributes::{AttributeKind, CombinationKind};
use crate::attributes::type_names::{NamesTypeAttributeKind, TypeNames};
use crate::graph_rewriting::make_replacer;
use crate::messages::Result;
use crate::support::support::{assert, assert_default, defined, panic};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::ty::ClassProperty;
use crate::ty::type_builder::TypeBuilder;
use crate::ty::type_builder_utils::StringTypeMapping;
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::TypeRef;
use crate::ty::type_utils::{combine_type_attributes_of_types, is_nullable};

/// `noneToAny(graph, stringTypeMapping, debugPrintReconstitution)`: replaces
/// the (at most one) `none` type by `any`.
pub fn none_to_any(
    graph: &TypeGraph,
    string_type_mapping: &StringTypeMapping,
    debug_print_reconstitution: bool,
) -> Result<Option<TypeGraph>> {
    let none_types: Vec<TypeRef> = graph
        .types()
        .iter()
        .filter(|t| t.kind() == TypeKind::None)
        .map(|t| t.type_ref())
        .collect();
    if none_types.is_empty() {
        return Ok(None);
    }

    assert(none_types.len() == 1, "Cannot have more than one none type")?;
    let replacer = make_replacer(|types, builder, forwarding_ref| {
        let original = builder.original_graph()?;
        let attributes = combine_type_attributes_of_types(
            original,
            CombinationKind::Union,
            types.iter().copied(),
        )?;
        builder.get_primitive_type(TypeKind::Any, attributes, Some(forwarding_ref))
    });
    graph.rewrite(
        "none to any",
        string_type_mapping,
        false,
        vec![none_types],
        debug_print_reconstitution,
        replacer,
        false,
    )
}

/// Rebuilds a class, turning each optional, non-nullable property type `T`
/// into the union `T | null` (named after the property if `T` has no name).
fn rewrite_class(
    c: TypeRef,
    builder: &mut TypeBuilder<'_>,
    forwarding_ref: TypeRef,
) -> Result<TypeRef> {
    let original = builder.original_graph()?;
    let class = original.type_at(c)?;
    let mut properties: IndexMap<String, ClassProperty> = IndexMap::new();
    for (name, p) in class.properties()? {
        let t = p.type_ref;
        let r = if !p.is_optional || is_nullable(original, t)? {
            builder.reconstitute_type(t, Default::default(), None)?
        } else {
            let null_type = builder.get_primitive_type(TypeKind::Null, Default::default(), None)?;
            let mut members: IndexSet<TypeRef> = IndexSet::new();
            if original.kind(t)? == TypeKind::Union {
                for &m in original.type_at(t)?.members()? {
                    members.insert(builder.reconstitute_type(m, Default::default(), None)?);
                }
                members.insert(null_type);
            } else {
                members.insert(builder.reconstitute_type(t, Default::default(), None)?);
                members.insert(null_type);
            }
            let attributes =
                NamesTypeAttributeKind.set_default_in_attributes(original.attributes(t)?, || {
                    TypeNames::make(
                        [name.clone()].into_iter().collect(),
                        Some(IndexSet::new()),
                        true,
                    )
                });
            builder.get_union_type(attributes, members, None)?
        };
        properties.insert(name.clone(), builder.make_class_property(r, p.is_optional));
    }
    let attributes = original.attributes(c)?.clone();
    if class.is_fixed() {
        builder.get_unique_class_type(attributes, true, Some(properties), Some(forwarding_ref))
    } else {
        builder.get_class_type(attributes, properties, Some(forwarding_ref))
    }
}

/// `optionalToNullable(graph, stringTypeMapping, debugPrintReconstitution)`:
/// for languages without optional properties, makes optional properties
/// nullable instead.
pub fn optional_to_nullable(
    graph: &TypeGraph,
    string_type_mapping: &StringTypeMapping,
    debug_print_reconstitution: bool,
) -> Result<Option<TypeGraph>> {
    let mut replacement_groups: Vec<Vec<TypeRef>> = Vec::new();
    for t in graph.all_types_unordered() {
        let ty = graph.type_at(t)?;
        if ty.is_class() && ty.properties()?.values().any(|p| p.is_optional) {
            replacement_groups.push(vec![t]);
        }
    }
    if replacement_groups.is_empty() {
        return Ok(None);
    }

    let replacer = make_replacer(|set_of_class, builder, forwarding_ref| {
        assert_default(set_of_class.len() == 1)?;
        let c = *defined(set_of_class.first())?;
        rewrite_class(c, builder, forwarding_ref)
    });
    graph.rewrite(
        "optional to nullable",
        string_type_mapping,
        false,
        replacement_groups,
        debug_print_reconstitution,
        replacer,
        false,
    )
}

/// `removeIndirectionIntersections(graph, stringTypeMapping,
/// debugPrintRemapping)`: remaps every chain of single-member
/// intersections (forwarding intersections) to its final target.
pub fn remove_indirection_intersections(
    graph: &TypeGraph,
    string_type_mapping: &StringTypeMapping,
    debug_print_remapping: bool,
) -> Result<Option<TypeGraph>> {
    let mut map: IndexMap<TypeRef, TypeRef> = IndexMap::new();

    for t in graph.all_types_unordered() {
        if graph.kind(t)? != TypeKind::Intersection {
            continue;
        }
        let mut seen: IndexSet<TypeRef> = [t].into_iter().collect();
        let mut current = t;
        loop {
            let members = graph.type_at(current)?.members()?;
            if members.len() != 1 {
                break;
            }
            let member = members[0];
            if graph.kind(member)? != TypeKind::Intersection {
                map.insert(t, member);
                break;
            }
            if seen.contains(&member) {
                // FIXME (TypeScript): technically, this is an any type.
                return panic("There's a cycle of intersection types");
            }
            seen.insert(member);
            current = member;
        }
    }

    graph.remap(
        "remove indirection intersections",
        string_type_mapping,
        false,
        map,
        debug_print_remapping,
        false,
    )
}
