//! Port of `packages/quicktype-core/src/rewrites/ReplaceObjectType.ts`.
//!
//! Replaces `object` types (objects with both properties and additional
//! properties, as JSON Schema produces them) by what target languages have:
//! a fixed class if there are no additional properties, a map if there are
//! no properties, otherwise a map whose values are the union of the property
//! and additional property types (losing the class semantics).

use indexmap::{IndexMap, IndexSet};

use crate::attributes::type_attributes::TypeAttributes;
use crate::graph_rewriting::make_replacer;
use crate::messages::Result;
use crate::support::support::defined;
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::ty::ClassProperty;
use crate::ty::type_builder::TypeBuilder;
use crate::ty::type_builder_utils::StringTypeMapping;
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::TypeRef;

/// `replace(setOfOneType, builder, forwardingRef)`.
fn replace(o: TypeRef, builder: &mut TypeBuilder<'_>, forwarding_ref: TypeRef) -> Result<TypeRef> {
    let graph = builder.original_graph()?;
    let object = graph.type_at(o)?;
    let attributes = graph.attributes(o)?.clone();
    let properties = object.properties()?;
    let additional_properties = object.additional_properties()?;

    let make_class = |builder: &mut TypeBuilder<'_>,
                      attributes: TypeAttributes|
     -> Result<TypeRef> {
        let mut reconstituted: IndexMap<String, ClassProperty> = IndexMap::new();
        for (name, cp) in properties {
            let t = builder.reconstitute_type_ref(cp.type_ref, TypeAttributes::new(), None)?;
            reconstituted.insert(name.clone(), builder.make_class_property(t, cp.is_optional));
        }
        builder.get_unique_class_type(attributes, true, Some(reconstituted), Some(forwarding_ref))
    };

    let Some(additional_properties) = additional_properties else {
        return make_class(builder, attributes);
    };

    if properties.is_empty() {
        let values =
            builder.reconstitute_type(additional_properties, TypeAttributes::new(), None)?;
        return builder.get_map_type(attributes, values, Some(forwarding_ref));
    }

    if graph.kind(additional_properties)? == TypeKind::Any {
        // FIXME (TypeScript): warn that additional property semantics are
        // lost.
        builder.set_lost_type_attributes();
        return make_class(builder, attributes);
    }

    // FIXME (TypeScript): warn that class semantics are lost.
    let mut property_types: IndexSet<TypeRef> = properties.values().map(|cp| cp.type_ref).collect();
    property_types.insert(additional_properties);
    let property_type_refs: Vec<TypeRef> = property_types.iter().copied().collect();
    let union = match builder.lookup_type_refs(&property_type_refs, None, true)? {
        Some(union) => union,
        None => {
            let mut reconstituted_types: IndexSet<TypeRef> = IndexSet::new();
            for &t in &property_types {
                reconstituted_types.insert(builder.reconstitute_type(
                    t,
                    TypeAttributes::new(),
                    None,
                )?);
            }
            builder.get_unique_union_type(TypeAttributes::new(), Some(reconstituted_types), None)?
        }
    };

    builder.get_map_type(attributes, union, Some(forwarding_ref))
}

/// `replaceObjectType(graph, stringTypeMapping, conflateNumbers,
/// leaveFullObjects, debugPrintReconstitution)`.
///
/// With `leave_full_objects` (the target language's
/// `supportsFullObjectType`), objects with both properties and additional
/// properties are kept. Returns `None` (TypeScript: the same graph) if there
/// is nothing to replace.
pub fn replace_object_type(
    graph: &TypeGraph,
    string_type_mapping: &StringTypeMapping,
    _conflate_numbers: bool,
    leave_full_objects: bool,
    debug_print_reconstitution: bool,
) -> Result<Option<TypeGraph>> {
    let mut groups: Vec<Vec<TypeRef>> = Vec::new();
    for t in graph.all_types_unordered() {
        let ty = graph.type_at(t)?;
        if ty.kind() != TypeKind::Object {
            continue;
        }
        if leave_full_objects
            && !ty.properties()?.is_empty()
            && ty.additional_properties()?.is_some()
        {
            continue;
        }
        groups.push(vec![t]);
    }

    let replacer = make_replacer(|set_of_one_type, builder, forwarding_ref| {
        let o = *defined(set_of_one_type.first())?;
        replace(o, builder, forwarding_ref)
    });
    graph.rewrite(
        "replace object type",
        string_type_mapping,
        false,
        groups,
        debug_print_reconstitution,
        replacer,
        false,
    )
}
