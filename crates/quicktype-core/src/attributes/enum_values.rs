//! Port of `packages/quicktype-core/src/attributes/EnumValues.ts`.
//!
//! User-specified values for enum cases (`qt-enum-values`). The schema
//! attribute producer is ported with the JSON Schema input.

use indexmap::IndexMap;

use crate::attributes::accessor_names::lookup_key;
use crate::attributes::type_attributes::AttributeKind;
use crate::messages::Result;
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::TypeRef;

/// `enumValuesTypeAttributeKind`: `enumValues`. Cannot be combined.
#[derive(Clone, Copy, Debug, Default)]
pub struct EnumValuesTypeAttributeKind;

/// `enumCaseValues(e, language)`: the value of each enum case.
pub fn enum_case_values(
    graph: &TypeGraph,
    e: TypeRef,
    language: &str,
) -> Result<IndexMap<String, Option<(String, bool)>>> {
    let enum_values = EnumValuesTypeAttributeKind.try_get_in_attributes(graph.attributes(e)?);
    let cases = graph.type_at(e)?.cases()?;
    Ok(cases
        .iter()
        .map(|c| {
            (
                c.clone(),
                enum_values.and_then(|v| lookup_key(v, c, language)),
            )
        })
        .collect())
}
