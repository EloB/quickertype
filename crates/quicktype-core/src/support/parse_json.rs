//! Port of `packages/quicktype-core/src/support/ParseJSON.ts`.
//!
//! [`parse_json`] is how quicktype reads JSON Schema documents, Postman
//! collections, GraphQL schemas and URL grammars: strip one byte-order mark,
//! try `JSON.parse`, and if that throws, `YAML.parse` (yaml 2.9, see
//! [`quicktype_js_compat::yaml`]). Only the YAML error can surface, because
//! a `JSON.parse` failure (`quicktype_js_compat::json::parse`) always falls
//! through to YAML.

use quicktype_js_compat::json::{self, JsonValue};
use quicktype_js_compat::yaml;

use crate::messages::{ErrorKind, Result, message_error};

/// `parseJSON(text, description, address = "<unknown>")`: the value, or
/// `MiscJSONParseError` with the YAML parser's error as
/// `Unknown exception YAMLParseError: …`.
///
/// Values can nest arbitrarily deep, as with `JSON.parse`; walk them
/// iteratively or with a depth limit.
pub fn parse_json(text: &str, description: &str, address: Option<&str>) -> Result<JsonValue> {
    let text = text.strip_prefix('\u{feff}').unwrap_or(text);
    if let Ok(value) = json::parse(text) {
        return Ok(value);
    }
    yaml::parse(text).or_else(|e| {
        // `yaml`'s errors are not `SyntaxError`s.
        message_error(
            ErrorKind::MiscJSONParseError,
            vec![
                ("description", description.into()),
                ("address", address.unwrap_or("<unknown>").into()),
                ("message", format!("Unknown exception {e}").into()),
            ],
        )
    })
}

#[cfg(test)]
mod tests {
    //! Includes a port of `test/unit/parse-json.test.ts`.

    use super::*;
    use quicktype_js_compat::json::stringify;

    fn parsed(text: &str) -> String {
        match parse_json(text, "test", None) {
            Ok(v) => stringify(&v, None),
            Err(e) => format!("error: {e}"),
        }
    }

    #[test]
    fn parses_strict_json() {
        assert_eq!(
            parsed(r#"{"name":"quicktype","count":2}"#),
            r#"{"name":"quicktype","count":2}"#
        );
    }

    #[test]
    fn falls_back_to_yaml() {
        assert_eq!(
            parsed("name: quicktype\ncount: 2\n"),
            r#"{"name":"quicktype","count":2}"#
        );
    }

    #[test]
    fn accepts_a_byte_order_mark_before_strict_json() {
        assert_eq!(
            parsed("\u{feff}{\"name\":\"quicktype\"}"),
            r#"{"name":"quicktype"}"#
        );
    }

    #[test]
    fn json_parse_semantics() {
        assert_eq!(
            parsed(r#"{"b":1,"2":2,"a":3,"1":4,"b":5}"#),
            r#"{"1":4,"2":2,"b":5,"a":3}"#
        );
        assert_eq!(parsed(r#"["😀é\n", 1e400, -0]"#), "[\"😀é\\n\",null,0]");
        // Duplicate keys are fine in JSON but an error in YAML.
        assert_eq!(parsed(r#"{"a":1,"a":2}"#), r#"{"a":2}"#);
        assert_eq!(parsed(r#"{"a":1,}"#), r#"{"a":1}"#);
        assert_eq!(parsed(""), "null");
        assert!(parsed("a: 1\na: 2\n").starts_with(
            "error: Syntax error in test JSON <unknown>: Unknown exception YAMLParseError: Map keys must be unique"
        ));
    }
}
