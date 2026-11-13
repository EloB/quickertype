//! Port of `packages/quicktype-core/src/rewrites/FlattenStrings.ts`.
//!
//! In a union that has a plain (unrestricted) `string` member, the other
//! string-like members (enums, transformed strings) are redundant: they are
//! merged into the `string`.

use indexmap::IndexSet;

use crate::attributes::type_attributes::{
    CombinationKind, TypeAttributes, combine_type_attributes2,
};
use crate::graph_rewriting::make_replacer;
use crate::messages::Result;
use crate::support::support::{assert, assert_default, defined};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_builder::TypeBuilder;
use crate::ty::type_builder_utils::StringTypeMapping;
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::TypeRef;
use crate::ty::type_utils::{
    combine_type_attributes_of_types, find_member, string_type_members, string_types_for_type,
};

/// `unionNeedsReplacing(u)`: the string-like members, if there are several
/// and one of them is `string`.
fn union_needs_replacing(graph: &TypeGraph, u: TypeRef) -> Result<Option<IndexSet<TypeRef>>> {
    let string_members = string_type_members(graph, u)?;
    if string_members.len() <= 1 {
        return Ok(None);
    }
    let Some(string_type) = find_member(graph, u, TypeKind::String)? else {
        return Ok(None);
    };
    assert(
        !string_types_for_type(graph, string_type)?.is_restricted(),
        "We must only flatten strings if we have no restriced strings",
    )?;
    Ok(Some(string_members))
}

/// `replaceUnion(group, builder, forwardingRef)`: replaces all string types
/// in the union with the basic string type.
fn replace_union(
    u: TypeRef,
    builder: &mut TypeBuilder<'_>,
    forwarding_ref: TypeRef,
) -> Result<TypeRef> {
    let graph = builder.original_graph()?;
    let string_members = defined(union_needs_replacing(graph, u)?)?;
    let string_attributes = combine_type_attributes_of_types(
        graph,
        CombinationKind::Union,
        string_members.iter().copied(),
    )?;
    let mut types: IndexSet<TypeRef> = IndexSet::new();
    for &t in graph.type_at(u)?.members()? {
        if string_members.contains(&t) {
            continue;
        }
        types.insert(builder.reconstitute_type(t, TypeAttributes::new(), None)?);
    }

    let union_attributes = graph.attributes(u)?;
    if types.is_empty() {
        return builder.get_string_type(
            combine_type_attributes2(CombinationKind::Union, &string_attributes, union_attributes)?,
            None,
            Some(forwarding_ref),
        );
    }

    types.insert(builder.get_string_type(string_attributes, None, None)?);
    builder.get_union_type(union_attributes.clone(), types, Some(forwarding_ref))
}

/// `flattenStrings(graph, stringTypeMapping, debugPrintReconstitution)`.
///
/// Returns `None` (TypeScript: the same graph) if no union needs it.
pub fn flatten_strings(
    graph: &TypeGraph,
    string_type_mapping: &StringTypeMapping,
    debug_print_reconstitution: bool,
) -> Result<Option<TypeGraph>> {
    let mut unions_to_replace: Vec<Vec<TypeRef>> = Vec::new();
    for u in graph.all_named_types_separated()?.unions {
        if union_needs_replacing(graph, u)?.is_some() {
            unions_to_replace.push(vec![u]);
        }
    }

    let replacer = make_replacer(|group, builder, forwarding_ref| {
        assert_default(group.len() == 1)?;
        let u = *defined(group.first())?;
        replace_union(u, builder, forwarding_ref)
    });
    graph.rewrite(
        "flatten strings",
        string_type_mapping,
        false,
        unions_to_replace,
        debug_print_reconstitution,
        replacer,
        false,
    )
}
