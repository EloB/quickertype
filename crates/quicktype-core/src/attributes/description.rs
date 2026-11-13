//! Port of `packages/quicktype-core/src/attributes/Description.ts`.
//!
//! Descriptions of types and of class properties. The schema attribute
//! producer (`descriptionAttributeProducer`) and `addToSchema` are ported
//! with the JSON Schema input and output.

use indexmap::{IndexMap, IndexSet};

use quicktype_js_compat::utf16;

/// `descriptionTypeAttributeKind`: a type's descriptions.
#[derive(Clone, Copy, Debug, Default)]
pub struct DescriptionTypeAttributeKind;

/// `propertyDescriptionsTypeAttributeKind`: descriptions of a class's
/// properties, by property name.
#[derive(Clone, Copy, Debug, Default)]
pub struct PropertyDescriptionsTypeAttributeKind;

/// `DescriptionTypeAttributeKind.combine`: the union of all descriptions.
pub(crate) fn combine_descriptions(attrs: &[&IndexSet<String>]) -> IndexSet<String> {
    attrs.iter().flat_map(|s| s.iter().cloned()).collect()
}

/// `PropertyDescriptionsTypeAttributeKind.combine`: per property, the union
/// of the descriptions.
pub(crate) fn combine_property_descriptions(
    attrs: &[&IndexMap<String, IndexSet<String>>],
) -> IndexMap<String, IndexSet<String>> {
    let mut result: IndexMap<String, IndexSet<String>> = IndexMap::new();
    for attr in attrs {
        for (name, descriptions) in attr.iter() {
            result
                .entry(name.clone())
                .or_default()
                .extend(descriptions.iter().cloned());
        }
    }
    result
}

/// `DescriptionTypeAttributeKind.stringify`: the first description, cut to
/// five UTF-16 code units plus `...` if longer than eight, and `, ...` if
/// there are more.
pub(crate) fn stringify_description(descriptions: &IndexSet<String>) -> Option<String> {
    let first = descriptions.first()?;
    let mut result = if utf16::len(first) > 5 + 3 {
        // `result.slice(0, 5)`; a cut surrogate pair is dropped (see "Known
        // gaps" in docs/PARITY.md).
        format!("{}...", utf16::slice(first, 0, Some(5)))
    } else {
        first.clone()
    };
    if descriptions.len() > 1 {
        result.push_str(", ...");
    }
    Some(result)
}

/// `PropertyDescriptionsTypeAttributeKind.stringify`.
pub(crate) fn stringify_property_descriptions(
    property_descriptions: &IndexMap<String, IndexSet<String>>,
) -> Option<String> {
    if property_descriptions.is_empty() {
        return None;
    }
    Some(format!("prop descs: {}", property_descriptions.len()))
}

/// `addDescriptionToSchema`'s value: the descriptions joined by newlines.
pub fn description_for_schema<'a>(description: impl IntoIterator<Item = &'a String>) -> String {
    description
        .into_iter()
        .map(String::as_str)
        .collect::<Vec<_>>()
        .join("\n")
}

// ---------------------------------------------------------------------------
// JSON Schema input: `descriptionAttributeProducer`

/// `isPropertiesKey(el)`.
fn is_properties_key(el: &crate::input::path_element::PathElement) -> bool {
    el.key_or_index() == Some("properties")
}

/// `descriptionAttributeProducer(schema, ref, types)`: the schema's
/// `description` for the type, unless it is a property whose single
/// (non-null) type is not an object and that has no `enum`, and for an
/// object the `description`s of its properties.
pub fn description_attribute_producer(
    schema: &crate::input::json_schema_store::JsonSchema,
    r: &crate::input::json_schema_input::Ref,
    types: &IndexSet<crate::input::json_schema_input::JsonSchemaType>,
    _cases: Option<&[crate::input::json_schema_store::JsonSchema]>,
) -> crate::messages::Result<Option<crate::input::json_schema_input::JsonSchemaAttributes>> {
    use crate::attributes::type_attributes::{AttributeKind, TypeAttributes};
    use crate::input::json_schema_input::{JsonSchemaAttributes, JsonSchemaType, js_exception};
    use crate::input::json_schema_store::JsonSchema;

    if schema.type_of() != "object" {
        return Ok(None);
    }
    let mut description = TypeAttributes::new();
    let mut property_description = TypeAttributes::new();

    let path = r.path();
    let path_length = path.len();
    let non_null_types = types.iter().filter(|t| **t != JsonSchemaType::Null).count();
    if types.contains(&JsonSchemaType::Object)
        || non_null_types > 1
        || schema.get("enum").is_some()
        || path_length < 2
        || !is_properties_key(&path[path_length - 2])
    {
        if let Some(JsonSchema::String(d)) = schema.get("description") {
            description =
                DescriptionTypeAttributeKind.make_attributes([d.clone()].into_iter().collect());
        }
    }

    if types.contains(&JsonSchemaType::Object)
        && let Some(properties) = schema.get("properties").filter(|p| p.type_of() == "object")
    {
        // `mapFromObject(schema.properties)`: own property names, which for
        // an array are its indexes (and `length`, whose number value has no
        // description).
        let entries: Vec<(String, &JsonSchema)> = match properties {
            JsonSchema::Object(map) => map.iter().map(|(k, v)| (k.clone(), v)).collect(),
            JsonSchema::Array(items) => items
                .iter()
                .enumerate()
                .map(|(i, v)| (i.to_string(), v))
                .collect(),
            _ => return Err(js_exception("Cannot convert undefined or null to object")),
        };
        let mut property_descriptions: IndexMap<String, IndexSet<String>> = IndexMap::new();
        for (name, prop_schema) in entries {
            if let JsonSchema::Object(prop) = prop_schema
                && let Some(JsonSchema::String(d)) = prop.get("description")
            {
                property_descriptions.insert(name, [d.clone()].into_iter().collect());
            }
        }
        if !property_descriptions.is_empty() {
            property_description =
                PropertyDescriptionsTypeAttributeKind.make_attributes(property_descriptions);
        }
    }

    Ok(Some(JsonSchemaAttributes {
        for_type: Some(description),
        for_object: Some(property_description),
        ..JsonSchemaAttributes::default()
    }))
}

#[cfg(test)]
mod tests {
    use super::*;

    fn set(items: &[&str]) -> IndexSet<String> {
        items.iter().map(|s| (*s).to_owned()).collect()
    }

    #[test]
    fn stringify() {
        assert_eq!(stringify_description(&set(&["short"])).unwrap(), "short");
        assert_eq!(
            stringify_description(&set(&["12345678"])).unwrap(),
            "12345678"
        );
        assert_eq!(
            stringify_description(&set(&["123456789"])).unwrap(),
            "12345..."
        );
        assert_eq!(stringify_description(&set(&["a", "b"])).unwrap(), "a, ...");
        assert_eq!(stringify_description(&IndexSet::new()), None);
    }

    #[test]
    fn combine_property_descriptions_unions_per_property() {
        let a: IndexMap<String, IndexSet<String>> =
            [("x".to_owned(), set(&["1"])), ("y".to_owned(), set(&["2"]))]
                .into_iter()
                .collect();
        let b: IndexMap<String, IndexSet<String>> =
            [("y".to_owned(), set(&["3"])), ("z".to_owned(), set(&["4"]))]
                .into_iter()
                .collect();
        let c = combine_property_descriptions(&[&a, &b]);
        assert_eq!(c.keys().collect::<Vec<_>>(), vec!["x", "y", "z"]);
        assert_eq!(c["y"], set(&["2", "3"]));
        assert_eq!(
            stringify_property_descriptions(&c).unwrap(),
            "prop descs: 3"
        );
    }
}
