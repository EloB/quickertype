//! Port of `packages/quicktype-core/src/attributes/URIAttributes.ts`.
//!
//! The protocols and file extensions seen in `uri` strings, from JSON
//! inference ([`uri_inference_attributes_producer`], on the urijs port in
//! `quicktype_js_compat::uri`) and from JSON Schema
//! ([`uri_schema_attributes_producer`]). `addToSchema` follows with the JSON
//! Schema output.

use std::borrow::Cow;

use indexmap::IndexSet;
use quicktype_js_compat::json::JsonValue;
use quicktype_js_compat::sort::sort_strings;

use crate::attributes::type_attributes::{SchemaObject, set_schema_property};
use crate::ty::transformed_string_type::TypeKind;

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

/// What [`uri_inference_attributes_producer`] makes of a `uri` string:
/// its protocol and its path extension, both lowercased (borrowed from
/// the string where that changes nothing).
#[derive(Clone, Debug, PartialEq, Eq)]
pub(crate) struct UriParts<'a> {
    pub(crate) protocol: Cow<'a, str>,
    pub(crate) extension: Option<Cow<'a, str>>,
}

impl UriParts<'_> {
    /// The attributes `uriInferenceAttributesProducer` makes of these.
    pub(crate) fn attributes(&self) -> crate::attributes::type_attributes::TypeAttributes {
        use crate::attributes::type_attributes::AttributeKind;
        UriTypeAttributeKind.make_attributes((
            [self.protocol.clone().into_owned()].into_iter().collect(),
            self.extension
                .iter()
                .map(|e| e.clone().into_owned())
                .collect(),
        ))
    }
}

/// `s.toLowerCase()`, borrowed if that is `s`.
fn lowercase(s: &str) -> Cow<'_, str> {
    if s.bytes().any(|b| b.is_ascii_uppercase() || !b.is_ascii()) {
        Cow::Owned(s.to_lowercase())
    } else {
        Cow::Borrowed(s)
    }
}

/// What a byte is to [`plain_uri`] in a URI's path: most are
/// [`ORDINARY`].
const ORDINARY: u8 = 0;
/// `#` or `?`: the path ends.
const PATH_END: u8 = 1;
/// A backslash, tab or line break, which urijs' parser turns into a slash
/// or removes.
const UNPLAIN: u8 = 2;
const DOT: u8 = 3;
const SLASH: u8 = 4;
/// Part of a character that is not ASCII.
const NOT_ASCII: u8 = 5;

static PATH_BYTES: [u8; 256] = {
    let mut table = [ORDINARY; 256];
    table[b'#' as usize] = PATH_END;
    table[b'?' as usize] = PATH_END;
    table[b'\\' as usize] = UNPLAIN;
    table[b'\t' as usize] = UNPLAIN;
    table[b'\n' as usize] = UNPLAIN;
    table[b'\r' as usize] = UNPLAIN;
    table[b'.' as usize] = DOT;
    table[b'/' as usize] = SLASH;
    let mut b = 0x80;
    while b < 0x100 {
        table[b] = NOT_ASCII;
        b += 1;
    }
    table
};

/// The protocol, path and path extension `new URI(s)` and `pathExtension`
/// find in `s`, without building the URI, for the URIs whose parse is
/// plain: `http://`, `https://` or `ftp://` (as the `uri` kind's pattern
/// spells them), then a host without user info, port or brackets, a path,
/// a query and a fragment. Anything else is `None`, for urijs' parser: a
/// slash right after the protocol (which its rewrite of the protocol
/// drops), a backslash, tab or line break before the query (which it
/// turns into a slash or removes), or a `@`, `:` or `[` in the host (user
/// info, a port that may be invalid, an IPv6 address).
///
/// For the others, `URI.parse` cuts the fragment at the first `#` and the
/// query at the first `?` before it, leaves `https://` as it is in its
/// protocol rewrite, takes the protocol up to the first `:` and the
/// authority after `//`, finds no user info (no `@` before the first
/// slash), and takes the host up to the first slash (no `:` in it, so no
/// port, whatever colons the path has) and the path from there, `/` if
/// there is none: which is what this does, in one pass that also finds the
/// path's last dot. The extension (`/^.+(\.[^./\\]+)$/`) is from that dot
/// on, if it is not the path's first character, has a character after it
/// and no slash, and no line terminator comes before it: none can in an
/// ASCII path here, and a path that is not ASCII is left to
/// [`path_extension`].
fn plain_uri(s: &str) -> Option<(&'static str, &str, Option<&str>)> {
    let (protocol, rest) = if let Some(rest) = s.strip_prefix("https://") {
        ("https", rest)
    } else if let Some(rest) = s.strip_prefix("http://") {
        ("http", rest)
    } else {
        ("ftp", s.strip_prefix("ftp://")?)
    };
    let bytes = rest.as_bytes();
    // The host.
    let mut i = 0;
    loop {
        match bytes.get(i) {
            None | Some(b'#' | b'?') => return Some((protocol, "/", None)),
            Some(b'/') if i == 0 => return None,
            Some(b'/') => break,
            Some(b'@' | b':' | b'[' | b'\\' | b'\t' | b'\n' | b'\r') => return None,
            Some(_) => i += 1,
        }
    }
    // The path, from its first slash.
    let start = i;
    let mut dot = start;
    let mut ascii = true;
    i += 1;
    while let Some(&b) = bytes.get(i) {
        match PATH_BYTES[b as usize] {
            ORDINARY => {}
            PATH_END => break,
            UNPLAIN => return None,
            DOT => dot = i,
            SLASH => dot = start,
            _ => ascii = false,
        }
        i += 1;
    }
    let path = &rest[start..i];
    let extension = if !ascii {
        path_extension(path)
    } else if dot != start && i - dot >= 2 {
        Some(&rest[dot..i])
    } else {
        None
    };
    Some((protocol, path, extension))
}

/// `uriInferenceAttributesProducer(s)`'s protocol and path extension of
/// `s` (see [`UriParts`]); `None` if urijs cannot parse it (an invalid
/// port), where it makes no attributes. A plain URI ([`plain_uri`]) is
/// read without urijs' parser, which allocates every part.
pub(crate) fn uri_inference_parts(s: &str) -> Option<UriParts<'_>> {
    if let Some((protocol, _, extension)) = plain_uri(s) {
        return Some(UriParts {
            protocol: Cow::Borrowed(protocol),
            extension: extension.map(lowercase),
        });
    }
    let uri = quicktype_js_compat::uri::Uri::parse(s).ok()?;
    Some(UriParts {
        protocol: Cow::Owned(uri.protocol().to_lowercase()),
        extension: path_extension(uri.path()).map(|e| Cow::Owned(e.to_lowercase())),
    })
}

/// `uriInferenceAttributesProducer(s)`: the protocol and the (lowercased)
/// path extension of a string inferred as a `uri` ([`uri_inference_parts`]);
/// no attributes if urijs cannot parse it (an invalid port).
pub fn uri_inference_attributes_producer(
    s: &str,
) -> crate::attributes::type_attributes::TypeAttributes {
    match uri_inference_parts(s) {
        Some(parts) => parts.attributes(),
        None => crate::attributes::type_attributes::TypeAttributes::new(),
    }
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
    schema: &mut SchemaObject,
    kind: TypeKind,
    attrs: &UriAttributes,
) {
    if kind != TypeKind::String && kind != TypeKind::Uri {
        return;
    }

    let sorted = |set: &IndexSet<String>| {
        let mut items: Vec<String> = set.iter().cloned().collect();
        sort_strings(&mut items);
        Some(JsonValue::Array(
            items.into_iter().map(JsonValue::String).collect(),
        ))
    };
    let (protocols, extensions) = attrs;
    if !protocols.is_empty() {
        set_schema_property(schema, PROTOCOLS_SCHEMA_PROPERTY, sorted(protocols));
    }

    if !extensions.is_empty() {
        set_schema_property(schema, EXTENSIONS_SCHEMA_PROPERTY, sorted(extensions));
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

    /// What urijs' parser makes of `s`, as `uri_inference_parts` did
    /// before it read plain URIs itself.
    fn parsed_parts(s: &str) -> Option<(String, Option<String>)> {
        let uri = quicktype_js_compat::uri::Uri::parse(s).ok()?;
        Some((
            uri.protocol().to_lowercase(),
            path_extension(uri.path()).map(str::to_lowercase),
        ))
    }

    fn owned(parts: Option<UriParts<'_>>) -> Option<(String, Option<String>)> {
        parts.map(|p| (p.protocol.into_owned(), p.extension.map(Cow::into_owned)))
    }

    /// Plain URIs are read as urijs' parser reads them, and the others are
    /// left to it: random strings of the characters that matter to it.
    #[test]
    fn plain_uris_read_as_parsed() {
        let prefixes = [
            "http://",
            "https://",
            "ftp://",
            "HTTP://",
            "http:/",
            "http:",
            "ftp:///",
            "https:\\\\",
        ];
        let alphabet = [
            "a", "B", ".", ".", "/", "/", "\\", "@", ":", "[", "]", "?", "#", "\t", "\n", "\r",
            "%", "1", "é", "É", "\u{2028}", "-", "J", "pG", ".tar", "%zz", "%C3%A9", " ", "{",
            "a.", "/.",
        ];
        let mut seed: u64 = 0x2545_f491_4f6c_dd1d;
        let mut next = |n: usize| {
            seed ^= seed << 13;
            seed ^= seed >> 7;
            seed ^= seed << 17;
            (seed % n as u64) as usize
        };
        let mut plain = 0;
        for _ in 0..200_000 {
            let mut s = prefixes[next(prefixes.len())].to_owned();
            for _ in 0..next(16) {
                s.push_str(alphabet[next(alphabet.len())]);
            }
            if let Some((_, path, extension)) = plain_uri(&s) {
                plain += 1;
                assert_eq!(extension, path_extension(path), "{s:?}");
            }
            assert_eq!(owned(uri_inference_parts(&s)), parsed_parts(&s), "{s:?}");
        }
        assert!(plain > 20_000, "{plain}");
        for s in [
            "https://cards.example/large/front/0/0/a.jpg?1783943221",
            "https://example.com",
            "https://example.com?q",
            "https://#f",
            "http://a/b.JSON",
            "http://a/b/c:d@e.png",
            "ftp://a/.htaccess",
            "http://a/\u{2028}x.png",
            "http://a/x.PNG#frag\\",
            "http://a/x.É",
        ] {
            assert!(plain_uri(s).is_some(), "{s:?}");
            assert_eq!(owned(uri_inference_parts(s)), parsed_parts(s), "{s:?}");
        }
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
