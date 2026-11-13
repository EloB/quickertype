//! Port of `packages/quicktype-core/src/language/CSharp/utils.ts`.
//!
//! So far only [`need_transformer_for_type`], which the C# target language's
//! `needsTransformerForType` hook needs; the renderer helpers follow with
//! the C# renderer.

use crate::attributes::constraints::{min_max_length_for_type, min_max_value_for_type};
use crate::messages::Result;
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::TypeRef;
use crate::ty::type_utils::nullable_from_union;

/// What `needTransformerForType` decides for a type.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum TransformerNeed {
    /// `"automatic"`.
    Automatic,
    /// `"manual"`.
    Manual,
    /// `"nullable"`.
    Nullable,
    /// `"none"`.
    None,
}

/// `needTransformerForType(t)`: whether (and how) the C# converters must
/// transform values of type `t`.
pub fn need_transformer_for_type(graph: &TypeGraph, t: TypeRef) -> Result<TransformerNeed> {
    let ty = graph.type_at(t)?;
    if ty.is_union() {
        let Some(nullable) = nullable_from_union(graph, t)? else {
            return Ok(TransformerNeed::Automatic);
        };
        if need_transformer_for_type(graph, nullable)? == TransformerNeed::Manual {
            return Ok(TransformerNeed::Nullable);
        }
        return Ok(TransformerNeed::None);
    }

    if ty.is_array() {
        let items_need = need_transformer_for_type(graph, ty.items()?)?;
        if matches!(
            items_need,
            TransformerNeed::Manual | TransformerNeed::Nullable
        ) {
            return Ok(TransformerNeed::Automatic);
        }
        return Ok(TransformerNeed::None);
    }

    if ty.is_enum() {
        return Ok(TransformerNeed::Automatic);
    }
    Ok(match ty.kind() {
        TypeKind::Double | TypeKind::Integer => {
            if min_max_value_for_type(graph, t)?.is_some() {
                TransformerNeed::Manual
            } else {
                TransformerNeed::None
            }
        }
        TypeKind::IntegerString | TypeKind::BoolString => TransformerNeed::Manual,
        TypeKind::String => {
            if min_max_length_for_type(graph, t)?.is_some() {
                TransformerNeed::Manual
            } else {
                TransformerNeed::None
            }
        }
        _ => TransformerNeed::None,
    })
}
