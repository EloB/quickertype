//! Port of `packages/quicktype-core/src/attributes/URIAttributes.ts`.
//!
//! The protocols and file extensions seen in `uri` strings, from JSON
//! inference ([`uri_inference_attributes_producer`], on the urijs port in
//! `quicktype_js_compat::uri`) and from JSON Schema
//! ([`uri_schema_attributes_producer`]). `addToSchema` follows with the JSON
//! Schema output.

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

// ---------------------------------------------------------------------------
// JSON Schema output: `addToSchema`

/// `URITypeAttributeKind.addToSchema`: for `string` and `uri` types, the
/// protocols and extensions, each sorted in UTF-16 order, if there are any.
pub fn add_uri_attributes_to_schema(
    schema: &mut crate::attributes::type_attributes::SchemaObject,
    kind: crate::ty::transformed_string_type::TypeKind,
    attrs: &UriAttributes,
) {
    use crate::ty::transformed_string_type::TypeKind;
    use quicktype_js_compat::json::JsonValue;

    if kind != TypeKind::String && kind != TypeKind::Uri {
        return;
    }

    let sorted = |set: &IndexSet<String>| {
        let mut items: Vec<String> = set.iter().cloned().collect();
        quicktype_js_compat::sort::sort_strings(&mut items);
        Some(JsonValue::Array(
            items.into_iter().map(JsonValue::String).collect(),
        ))
    };
    let (protocols, extensions) = attrs;
    if !protocols.is_empty() {
        crate::attributes::type_attributes::set_schema_property(
            schema,
            PROTOCOLS_SCHEMA_PROPERTY,
            sorted(protocols),
        );
    }

    if !extensions.is_empty() {
        crate::attributes::type_attributes::set_schema_property(
            schema,
            EXTENSIONS_SCHEMA_PROPERTY,
            sorted(extensions),
        );
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::attributes::type_attributes::AttributeKind;

    #[test]
    fn extensions() {
        assert_eq!(path_extension("/a/b.jpg"), Some(".jpg"));
        assert_eq!(path_extension("/a/b.tar.gz"), Some(".gz"));
        assert_eq!(path_extension(".jpg"), None);
        assert_eq!(path_extension("/a.b/c"), None);
        assert_eq!(path_extension("/"), None);
    }

    fn producer(s: &str) -> Option<(Vec<String>, Vec<String>)> {
        let attributes = uri_inference_attributes_producer(s);
        UriTypeAttributeKind
            .try_get_in_attributes(&attributes)
            .map(|(p, e)| (p.iter().cloned().collect(), e.iter().cloned().collect()))
    }

    #[test]
    fn inference_producer() {
        let some = |p: &str, e: &[&str]| {
            Some((
                vec![p.to_owned()],
                e.iter().map(|&e| e.to_owned()).collect(),
            ))
        };
        assert_eq!(producer("http://a/b.JSON"), some("http", &[".json"]));
        assert_eq!(
            producer("https://a/x.tar.gz?q=1#f"),
            some("https", &[".gz"])
        );
        assert_eq!(producer("ftp://a/.htaccess"), some("ftp", &[".htaccess"]));
        assert_eq!(producer("http://a"), some("http", &[]));
        assert_eq!(producer("http://a:99999/x"), None);
        assert_eq!(producer("http://a:0/x"), None);
        assert_eq!(producer("http://a:8080/x.png"), some("http", &[".png"]));
        assert_eq!(producer("http://a:0x50/x"), some("http", &[]));
        assert_eq!(producer("http://u%zz@a/x"), None);
        assert_eq!(producer("http://u%C3%A9@a/x"), some("http", &[]));
        assert_eq!(producer("http://u%C3@a/x"), None);
        assert_eq!(producer("http:///\\a/b.c"), some("http", &[".c"]));
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
