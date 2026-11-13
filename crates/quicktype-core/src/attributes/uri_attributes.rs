//! Port of `packages/quicktype-core/src/attributes/URIAttributes.ts`.
//!
//! The protocols and file extensions seen in `uri` strings. The inference
//! producer (`uriInferenceAttributesProducer`, which needs the `urijs` port)
//! and the schema producer and `addToSchema` are ported with the JSON input,
//! the JSON Schema input and the JSON Schema output.

use indexmap::IndexSet;

/// `URIAttributes`: `[protocols, extensions]`.
pub type UriAttributes = (IndexSet<String>, IndexSet<String>);

/// `uriTypeAttributeKind`: `uriAttributes`, part of the identity.
#[derive(Clone, Copy, Debug, Default)]
pub struct UriTypeAttributeKind;

/// `qt-uri-protocols`.
pub const PROTOCOLS_SCHEMA_PROPERTY: &str = "qt-uri-protocols";
/// `qt-uri-extensions`.
pub const EXTENSIONS_SCHEMA_PROPERTY: &str = "qt-uri-extensions";

/// `URITypeAttributeKind.combine`: the union of protocols and of extensions.
pub(crate) fn combine(attrs: &[&UriAttributes]) -> UriAttributes {
    let protocols = attrs.iter().flat_map(|a| a.0.iter().cloned()).collect();
    let extensions = attrs.iter().flat_map(|a| a.1.iter().cloned()).collect();
    (protocols, extensions)
}

/// `pathExtension(path)`: the extension matched by `/^.+(\.[^./\\]+)$/`.
pub fn path_extension(path: &str) -> Option<&str> {
    let dot = path.rfind('.')?;
    let extension = &path[dot..];
    let before = &path[..dot];
    if before.is_empty() || extension.len() < 2 {
        return None;
    }
    if extension[1..].contains(['.', '/', '\\']) {
        return None;
    }
    // `.+` does not match line terminators.
    if before.contains(['\n', '\r', '\u{2028}', '\u{2029}']) {
        return None;
    }
    Some(extension)
}

// ---------------------------------------------------------------------------
// JSON input: `uriInferenceAttributesProducer`; JSON Schema input:
// `uriSchemaAttributesProducer`

/// `uriInferenceAttributesProducer(s)`: the protocol and the (lowercased)
/// path extension of a string inferred as a `uri`; no attributes if urijs
/// cannot parse it (an invalid port).
pub fn uri_inference_attributes_producer(
    s: &str,
) -> crate::attributes::type_attributes::TypeAttributes {
    use crate::attributes::type_attributes::{AttributeKind, TypeAttributes};
    let Ok(uri) = quicktype_js_compat::uri::Uri::parse(s) else {
        return TypeAttributes::new();
    };
    let extensions: IndexSet<String> = path_extension(uri.path())
        .map(str::to_lowercase)
        .into_iter()
        .collect();
    UriTypeAttributeKind.make_attributes((
        [uri.protocol().to_lowercase()].into_iter().collect(),
        extensions,
    ))
}

/// `uriSchemaAttributesProducer(schema, ref, types)`: `qt-uri-protocols`
/// and `qt-uri-extensions` of a string schema.
pub fn uri_schema_attributes_producer(
    schema: &crate::input::json_schema_store::JsonSchema,
    _ref: &crate::input::json_schema_input::Ref,
    types: &IndexSet<crate::input::json_schema_input::JsonSchemaType>,
    _cases: Option<&[crate::input::json_schema_store::JsonSchema]>,
) -> crate::messages::Result<Option<crate::input::json_schema_input::JsonSchemaAttributes>> {
    use crate::attributes::type_attributes::AttributeKind;
    use crate::input::json_schema_input::{JsonSchemaAttributes, JsonSchemaType};
    use crate::input::json_schema_store::{JsonSchema, check_array};

    if schema.type_of() != "object" || !types.contains(&JsonSchemaType::String) {
        return Ok(None);
    }
    let strings = |property: &str| -> crate::messages::Result<IndexSet<String>> {
        Ok(match schema.get(property) {
            None => IndexSet::new(),
            Some(values) => check_array(values, |v| matches!(v, JsonSchema::String(_)))?
                .iter()
                .filter_map(|v| v.as_str().map(str::to_owned))
                .collect(),
        })
    };
    let protocols = strings(PROTOCOLS_SCHEMA_PROPERTY)?;
    let extensions = strings(EXTENSIONS_SCHEMA_PROPERTY)?;
    if protocols.is_empty() && extensions.is_empty() {
        return Ok(None);
    }
    Ok(Some(JsonSchemaAttributes {
        for_string: Some(UriTypeAttributeKind.make_attributes((protocols, extensions))),
        ..JsonSchemaAttributes::default()
    }))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn extensions() {
        assert_eq!(path_extension("/a/b.jpg"), Some(".jpg"));
        assert_eq!(path_extension("/a/b.tar.gz"), Some(".gz"));
        assert_eq!(path_extension(".jpg"), None);
        assert_eq!(path_extension("/a.b/c"), None);
        assert_eq!(path_extension("/"), None);
    }

    #[test]
    fn combine_unites() {
        let a: UriAttributes = (["http".into()].into_iter().collect(), IndexSet::new());
        let b: UriAttributes = (
            ["https".into(), "http".into()].into_iter().collect(),
            [".png".into()].into_iter().collect(),
        );
        let c = combine(&[&a, &b]);
        assert_eq!(c.0.iter().collect::<Vec<_>>(), vec!["http", "https"]);
        assert_eq!(c.1.len(), 1);
    }
}
