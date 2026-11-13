//! Port of `packages/quicktype-core/src/attributes/DefaultValue.ts`.
//!
//! The JSON Schema `default` of a type, part of its identity. The schema
//! attribute producer and `addToSchema` are ported with the JSON Schema input
//! and output.

use crate::attributes::type_attributes::AttributeKind;
use crate::messages::Result;
use crate::support::collection_utils::{HASH_CODE_INIT, JsEquals, JsHash};
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::TypeRef;
use quicktype_js_compat::json;

/// `DefaultValue`: `boolean | number | string | null`.
#[derive(Clone, Debug, PartialEq)]
pub enum DefaultValue {
    /// A boolean.
    Bool(bool),
    /// A number.
    Number(f64),
    /// A string.
    String(String),
    /// `null`.
    Null,
}

impl DefaultValue {
    /// JavaScript `===`.
    fn strict_equals(&self, other: &DefaultValue) -> bool {
        match (self, other) {
            (DefaultValue::Bool(a), DefaultValue::Bool(b)) => a == b,
            (DefaultValue::Number(a), DefaultValue::Number(b)) => a == b,
            (DefaultValue::String(a), DefaultValue::String(b)) => a == b,
            (DefaultValue::Null, DefaultValue::Null) => true,
            _ => false,
        }
    }
}

impl JsHash for DefaultValue {
    fn hash_code(&self) -> i64 {
        match self {
            DefaultValue::Bool(b) => b.hash_code(),
            DefaultValue::Number(n) => n.hash_code(),
            DefaultValue::String(s) => s.hash_code(),
            DefaultValue::Null => HASH_CODE_INIT + 3,
        }
    }
}

impl JsEquals for DefaultValue {
    fn js_equals(&self, other: &Self) -> bool {
        self.strict_equals(other)
    }
}

/// `defaultValueTypeAttributeKind`: `defaultValue`.
#[derive(Clone, Copy, Debug, Default)]
pub struct DefaultValueTypeAttributeKind;

/// `DefaultValueTypeAttributeKind.combine`: the value if all are `===`,
/// otherwise none.
pub(crate) fn combine(values: &[DefaultValue]) -> Option<DefaultValue> {
    let first = values.first()?;
    if values.iter().all(|v| v.strict_equals(first)) {
        Some(first.clone())
    } else {
        None
    }
}

/// `DefaultValueTypeAttributeKind.stringify`: `JSON.stringify(value)`.
pub(crate) fn stringify(value: &DefaultValue) -> String {
    match value {
        DefaultValue::Bool(b) => b.to_string(),
        DefaultValue::Number(n) => json::number(*n),
        DefaultValue::String(s) => json::quote(s),
        DefaultValue::Null => "null".to_owned(),
    }
}

/// `defaultValueForType(t)`.
pub fn default_value_for_type(graph: &TypeGraph, t: TypeRef) -> Result<Option<DefaultValue>> {
    Ok(DefaultValueTypeAttributeKind
        .try_get_in_attributes(graph.attributes(t)?)
        .cloned())
}

// ---------------------------------------------------------------------------
// JSON Schema input: `defaultValueAttributeProducer`

/// `defaultValueAttributeProducer(schema, ref, types)`: a `default` that
/// is `null`, a boolean, a number or a string, for the matching type if the
/// schema includes it.
pub fn default_value_attribute_producer(
    schema: &crate::input::json_schema_store::JsonSchema,
    _ref: &crate::input::json_schema_input::Ref,
    types: &indexmap::IndexSet<crate::input::json_schema_input::JsonSchemaType>,
    _cases: Option<&[crate::input::json_schema_store::JsonSchema]>,
) -> Result<Option<crate::input::json_schema_input::JsonSchemaAttributes>> {
    use crate::input::json_schema_input::{JsonSchemaAttributes, JsonSchemaType as T};
    use crate::input::json_schema_store::JsonSchema;

    let value = match schema.get("default") {
        Some(JsonSchema::Null) => DefaultValue::Null,
        Some(JsonSchema::Bool(b)) => DefaultValue::Bool(*b),
        Some(JsonSchema::Number(n)) => DefaultValue::Number(*n),
        Some(JsonSchema::String(s)) => DefaultValue::String(s.clone()),
        _ => return Ok(None),
    };
    let attributes = Some(DefaultValueTypeAttributeKind.make_attributes(value.clone()));
    let mut result = JsonSchemaAttributes::default();
    match value {
        DefaultValue::Number(_) => {
            if !types.contains(&T::Number) && !types.contains(&T::Integer) {
                return Ok(None);
            }
            result.for_number = attributes;
        }
        DefaultValue::String(_) => {
            if !types.contains(&T::String) {
                return Ok(None);
            }
            result.for_string = attributes;
        }
        DefaultValue::Bool(_) => {
            if !types.contains(&T::Boolean) {
                return Ok(None);
            }
            result.for_boolean = attributes;
        }
        DefaultValue::Null => {
            if !types.contains(&T::Null) {
                return Ok(None);
            }
            result.for_null = attributes;
        }
    }
    Ok(Some(result))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn combine_requires_strict_equality() {
        let one = DefaultValue::Number(1.0);
        assert_eq!(combine(&[one.clone(), one.clone()]), Some(one.clone()));
        assert_eq!(
            combine(&[one.clone(), DefaultValue::String("1".into())]),
            None
        );
        let nan = DefaultValue::Number(f64::NAN);
        assert_eq!(combine(&[nan.clone(), nan]), None);
        assert_eq!(
            combine(&[DefaultValue::Number(0.0), DefaultValue::Number(-0.0)]),
            Some(DefaultValue::Number(0.0))
        );
    }

    #[test]
    fn stringify_like_json() {
        assert_eq!(
            stringify(&DefaultValue::String("a\"b".into())),
            "\"a\\\"b\""
        );
        assert_eq!(stringify(&DefaultValue::Number(1e21)), "1e+21");
        assert_eq!(stringify(&DefaultValue::Null), "null");
        assert_eq!(DefaultValue::Null.hash_code(), 20);
        assert_eq!(DefaultValue::Bool(true).hash_code(), 18);
    }
}
