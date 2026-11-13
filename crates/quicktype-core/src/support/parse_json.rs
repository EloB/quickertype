//! Port of `packages/quicktype-core/src/support/ParseJSON.ts`.
//!
//! [`parse_json`] is how quicktype reads JSON Schema documents, Postman
//! collections, GraphQL schemas and URL grammars: strip one byte-order mark,
//! try `JSON.parse`, and if that throws, `YAML.parse` (yaml 2.9, see
//! [`quicktype_js_compat::yaml`]). Only the YAML error can surface, because
//! a `JSON.parse` failure always falls through to YAML.

use quicktype_js_compat::json::{IndexMap, JsonValue, insert_js_property};
use quicktype_js_compat::yaml;

use crate::messages::{ErrorKind, Result, message_error};

/// `parseJSON(text, description, address = "<unknown>")`: the value, or
/// `MiscJSONParseError` with the YAML parser's error as
/// `Unknown exception YAMLParseError: …`.
pub fn parse_json(text: &str, description: &str, address: Option<&str>) -> Result<JsonValue> {
    let text = text.strip_prefix('\u{feff}').unwrap_or(text);
    // TODO(json-parse): use quicktype_js_compat::json::parse
    if let Some(value) = json_parse(text) {
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

/// The deepest nesting [`json_parse`] accepts, like [`yaml::MAX_DEPTH`]
/// (quicktype's recursive schema walks would exhaust the JavaScript stack
/// somewhere beyond it).
const MAX_DEPTH: usize = yaml::MAX_DEPTH;

/// A minimal `JSON.parse`: the value, or `None` if the text is not JSON.
///
/// Objects get JavaScript property order (array-index keys first) and the
/// last of duplicate keys wins in the first one's position; numbers are
/// correctly rounded doubles (overflowing to infinity). The error message is
/// not needed: `parseJSON` falls back to YAML on any error. A lone surrogate
/// escape becomes U+FFFD (see "Known gaps" in `docs/PARITY.md`).
fn json_parse(text: &str) -> Option<JsonValue> {
    let mut parser = JsonParser {
        bytes: text.as_bytes(),
        text,
        pos: 0,
    };
    parser.skip_whitespace();
    let value = parser.value(0)?;
    parser.skip_whitespace();
    (parser.pos == parser.bytes.len()).then_some(value)
}

struct JsonParser<'t> {
    bytes: &'t [u8],
    text: &'t str,
    pos: usize,
}

impl JsonParser<'_> {
    fn peek(&self) -> Option<u8> {
        self.bytes.get(self.pos).copied()
    }

    fn skip_whitespace(&mut self) {
        while matches!(self.peek(), Some(b' ' | b'\t' | b'\n' | b'\r')) {
            self.pos += 1;
        }
    }

    fn eat(&mut self, b: u8) -> Option<()> {
        (self.peek() == Some(b)).then(|| self.pos += 1)
    }

    fn literal(&mut self, word: &str, value: JsonValue) -> Option<JsonValue> {
        if self.bytes[self.pos..].starts_with(word.as_bytes()) {
            self.pos += word.len();
            Some(value)
        } else {
            None
        }
    }

    fn value(&mut self, depth: usize) -> Option<JsonValue> {
        if depth > MAX_DEPTH {
            return None;
        }
        match self.peek()? {
            b'{' => self.object(depth),
            b'[' => self.array(depth),
            b'"' => self.string().map(JsonValue::String),
            b't' => self.literal("true", JsonValue::Bool(true)),
            b'f' => self.literal("false", JsonValue::Bool(false)),
            b'n' => self.literal("null", JsonValue::Null),
            b'-' | b'0'..=b'9' => self.number(),
            _ => None,
        }
    }

    fn object(&mut self, depth: usize) -> Option<JsonValue> {
        self.eat(b'{')?;
        let mut map = IndexMap::new();
        self.skip_whitespace();
        if self.eat(b'}').is_some() {
            return Some(JsonValue::Object(map));
        }
        loop {
            self.skip_whitespace();
            if self.peek()? != b'"' {
                return None;
            }
            let key = self.string()?;
            self.skip_whitespace();
            self.eat(b':')?;
            self.skip_whitespace();
            let value = self.value(depth + 1)?;
            insert_js_property(&mut map, key, value);
            self.skip_whitespace();
            match self.peek()? {
                b',' => self.pos += 1,
                b'}' => {
                    self.pos += 1;
                    return Some(JsonValue::Object(map));
                }
                _ => return None,
            }
        }
    }

    fn array(&mut self, depth: usize) -> Option<JsonValue> {
        self.eat(b'[')?;
        let mut items = Vec::new();
        self.skip_whitespace();
        if self.eat(b']').is_some() {
            return Some(JsonValue::Array(items));
        }
        loop {
            self.skip_whitespace();
            items.push(self.value(depth + 1)?);
            self.skip_whitespace();
            match self.peek()? {
                b',' => self.pos += 1,
                b']' => {
                    self.pos += 1;
                    return Some(JsonValue::Array(items));
                }
                _ => return None,
            }
        }
    }

    /// `-?(0|[1-9][0-9]*)(\.[0-9]+)?([eE][+-]?[0-9]+)?`
    fn number(&mut self) -> Option<JsonValue> {
        let start = self.pos;
        let _ = self.eat(b'-');
        match self.peek()? {
            b'0' => self.pos += 1,
            b'1'..=b'9' => self.digits(),
            _ => return None,
        }
        if self.eat(b'.').is_some() {
            if !self.peek()?.is_ascii_digit() {
                return None;
            }
            self.digits();
        }
        if matches!(self.peek(), Some(b'e' | b'E')) {
            self.pos += 1;
            if matches!(self.peek(), Some(b'+' | b'-')) {
                self.pos += 1;
            }
            if !self.peek()?.is_ascii_digit() {
                return None;
            }
            self.digits();
        }
        self.text[start..self.pos]
            .parse()
            .ok()
            .map(JsonValue::Number)
    }

    fn digits(&mut self) {
        while self.peek().is_some_and(|b| b.is_ascii_digit()) {
            self.pos += 1;
        }
    }

    fn hex4(&mut self) -> Option<u16> {
        let digits = self.text.get(self.pos..self.pos + 4)?;
        if !digits.bytes().all(|b| b.is_ascii_hexdigit()) {
            return None;
        }
        self.pos += 4;
        u16::from_str_radix(digits, 16).ok()
    }

    fn string(&mut self) -> Option<String> {
        self.eat(b'"')?;
        let mut out = String::new();
        // UTF-16 units of `\u` escapes not yet combined into a character.
        let mut units: Vec<u16> = Vec::new();
        let flush = |units: &mut Vec<u16>, out: &mut String| {
            out.extend(char::decode_utf16(units.drain(..)).map(|r| r.unwrap_or('\u{FFFD}')));
        };
        loop {
            let start = self.pos;
            while let Some(b) = self.peek() {
                if b == b'"' || b == b'\\' || b < 0x20 {
                    break;
                }
                self.pos += 1;
            }
            if self.pos > start {
                flush(&mut units, &mut out);
                out.push_str(&self.text[start..self.pos]);
            }
            match self.peek()? {
                b'"' => {
                    self.pos += 1;
                    flush(&mut units, &mut out);
                    return Some(out);
                }
                b'\\' => {
                    self.pos += 1;
                    let escaped = self.peek()?;
                    self.pos += 1;
                    let c = match escaped {
                        b'"' => '"',
                        b'\\' => '\\',
                        b'/' => '/',
                        b'b' => '\u{8}',
                        b'f' => '\u{C}',
                        b'n' => '\n',
                        b'r' => '\r',
                        b't' => '\t',
                        b'u' => {
                            units.push(self.hex4()?);
                            continue;
                        }
                        _ => return None,
                    };
                    flush(&mut units, &mut out);
                    out.push(c);
                }
                // A control character.
                _ => return None,
            }
        }
    }
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
