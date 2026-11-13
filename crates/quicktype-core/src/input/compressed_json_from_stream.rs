//! Port of `src/CompressedJSONFromStream.ts` (the quicktype CLI) and of the
//! parser of stream-json 3.5.0 (`node_modules/stream-json/src/core/parser.js`)
//! that it is driven by.
//!
//! This is how the CLI reads JSON samples
//! ([`CompressedJson::parse_stream`](crate::input::compressed_json::CompressedJson::parse_stream)),
//! and it differs from `JSON.parse`
//! ([`CompressedJson::parse_string`](crate::input::compressed_json::CompressedJson::parse_string)):
//!
//! - a number is a `double` iff its literal contains `.`, `e` or `E`, or it
//!   is a whole number outside the target's integer range (compared as a
//!   decimal string, so `9223372036854775807` is an int64);
//! - object keys keep their source order and duplicate keys are all kept;
//! - errors are stream-json's (`Parser cannot parse input: expected ','`),
//!   which carry no position.
//!
//! It lives in quicktype-core rather than in the CLI because the Rust API
//! offers both reading semantics.
//!
//! stream-json parses chunk by chunk and waits for more input where a token
//! could continue; at the end of the input every wait resolves the way it
//! would with the whole input at hand, so this port reads the whole sample
//! in one pass with end-of-input semantics. The sample is UTF-8 decoded
//! like Node's `setEncoding("utf8")` (invalid sequences become U+FFFD); a
//! byte order mark is not stripped and is a syntax error, as in the CLI.

use std::borrow::Cow;

use super::compressed_json::{CompressedJson, ParseError, Value};
use crate::messages::{JsErrorName, JsException, Result};

impl CompressedJson {
    /// `CompressedJSONFromStream.parse(readStream)`: reads a sample with the
    /// CLI's stream-json semantics. The sample is the raw bytes of a file,
    /// URL body or standard input (TS: a `Readable`); each token goes to
    /// the builder (TS `methodMap`).
    ///
    /// ```
    /// use quicktype_core::date_time::DefaultDateTimeRecognizer;
    /// use quicktype_core::input::compressed_json::{CompressedJson, ParseError, Value};
    /// use quicktype_core::messages::{JsErrorName, JsException};
    ///
    /// let mut cjson = CompressedJson::with_int64_range(Box::new(DefaultDateTimeRecognizer), false);
    /// assert_eq!(cjson.parse_stream(b"1.0"), Ok(Value::Double));
    /// assert_eq!(
    ///     cjson.parse_stream(b"[1 2]"),
    ///     Err(ParseError::Js(JsException::new(
    ///         JsErrorName::Error,
    ///         "Parser cannot parse input: expected ','"
    ///     )))
    /// );
    /// ```
    pub fn parse_stream(&mut self, sample: &[u8]) -> Result<Value, ParseError> {
        let text = quicktype_js_compat::utf8::decode(sample);
        let result = Tokenizer::new(&text, self).run();
        if result.is_err() {
            self.reset_partial_sample();
        }
        result
    }
}

/// The parser's `expect` states. The number states are folded into
/// [`Tokenizer::number`].
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
enum Expect {
    /// `value1`: a value or, right after `[`, the `]` of an empty array.
    Value1,
    /// `value`: a value.
    Value,
    /// `key1`: a key or, right after `{`, the `}` of an empty object.
    Key1,
    /// `key`: a key.
    Key,
    /// `colon`.
    Colon,
    /// `arrayStop`: `,` or `]`.
    ArrayStop,
    /// `objectStop`: `,` or `}`.
    ObjectStop,
    /// `done`: only whitespace may follow the root value.
    Done,
}

/// The enclosing container (`parent` and the parser's `stack`).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
enum Parent {
    Object,
    Array,
}

/// stream-json's tokenizer, emitting straight into the builder.
struct Tokenizer<'a> {
    bytes: &'a [u8],
    text: &'a str,
    index: usize,
    cjson: &'a mut CompressedJson,
}

/// stream-json's `Error` with `message`.
fn syntax(message: &str) -> ParseError {
    ParseError::Js(JsException::new(JsErrorName::Error, message))
}

/// `TERM` and the whitespace the parser skips: space, tab, LF and CR only.
fn is_whitespace(b: u8) -> bool {
    matches!(b, b' ' | b'\t' | b'\n' | b'\r')
}

/// A JavaScript `\w` character, for the `\b` after a literal.
fn is_word(b: u8) -> bool {
    b.is_ascii_alphanumeric() || b == b'_'
}

impl<'a> Tokenizer<'a> {
    fn new(text: &'a str, cjson: &'a mut CompressedJson) -> Self {
        Tokenizer {
            bytes: text.as_bytes(),
            text,
            index: 0,
            cjson,
        }
    }

    fn peek(&self) -> Option<u8> {
        self.bytes.get(self.index).copied()
    }

    fn skip_whitespace(&mut self) {
        while self.peek().is_some_and(is_whitespace) {
            self.index += 1;
        }
    }

    /// `expected[parent]`: the state after a complete value.
    fn after_value(stack: &[Parent]) -> Expect {
        match stack.last() {
            Some(Parent::Object) => Expect::ObjectStop,
            Some(Parent::Array) => Expect::ArrayStop,
            None => Expect::Done,
        }
    }

    fn run(mut self) -> Result<Value, ParseError> {
        let mut expect = Expect::Value;
        let mut stack: Vec<Parent> = Vec::new();
        loop {
            match expect {
                Expect::Value | Expect::Value1 => {
                    self.skip_whitespace();
                    let Some(b) = self.peek() else {
                        return Err(syntax("Parser has expected a value"));
                    };
                    match b {
                        b'"' => {
                            self.index += 1;
                            let s = self.string()?;
                            self.cjson.commit_string(&s)?;
                            expect = Self::after_value(&stack);
                        }
                        b'{' => {
                            self.index += 1;
                            self.cjson.push_object_context();
                            stack.push(Parent::Object);
                            expect = Expect::Key1;
                        }
                        b'[' => {
                            self.index += 1;
                            self.cjson.push_array_context();
                            stack.push(Parent::Array);
                            expect = Expect::Value1;
                        }
                        b']' => {
                            if expect != Expect::Value1 {
                                return Err(syntax(
                                    "Parser cannot parse input: unexpected token ']'",
                                ));
                            }
                            self.index += 1;
                            self.cjson.finish_array()?;
                            stack.pop();
                            expect = Self::after_value(&stack);
                        }
                        b'-' | b'0'..=b'9' => {
                            self.number()?;
                            expect = Self::after_value(&stack);
                        }
                        b't' | b'f' | b'n' => {
                            self.literal()?;
                            expect = Self::after_value(&stack);
                        }
                        _ => return Err(syntax("Parser cannot parse input: expected a value")),
                    }
                }
                Expect::Key | Expect::Key1 => {
                    self.skip_whitespace();
                    match self.peek() {
                        Some(b'"') => {
                            self.index += 1;
                            let key = self.string()?;
                            self.cjson.set_property_key(&key)?;
                            expect = Expect::Colon;
                        }
                        Some(b'}') => {
                            if expect != Expect::Key1 {
                                return Err(syntax(
                                    "Parser cannot parse input: unexpected token '}'",
                                ));
                            }
                            self.index += 1;
                            self.cjson.finish_object()?;
                            stack.pop();
                            expect = Self::after_value(&stack);
                        }
                        _ => {
                            return Err(syntax(
                                "Parser cannot parse input: expected an object key",
                            ));
                        }
                    }
                }
                Expect::Colon => {
                    self.skip_whitespace();
                    if self.peek() != Some(b':') {
                        return Err(syntax("Parser cannot parse input: expected ':'"));
                    }
                    self.index += 1;
                    expect = Expect::Value;
                }
                Expect::ArrayStop | Expect::ObjectStop => {
                    self.skip_whitespace();
                    let in_array = expect == Expect::ArrayStop;
                    match self.peek() {
                        Some(b',') => {
                            self.index += 1;
                            expect = if in_array { Expect::Value } else { Expect::Key };
                        }
                        Some(b']') if in_array => {
                            self.index += 1;
                            self.cjson.finish_array()?;
                            stack.pop();
                            expect = Self::after_value(&stack);
                        }
                        Some(b'}') if !in_array => {
                            self.index += 1;
                            self.cjson.finish_object()?;
                            stack.pop();
                            expect = Self::after_value(&stack);
                        }
                        Some(b']' | b'}') => {
                            return Err(syntax(if in_array {
                                "Parser cannot parse input: expected ']'"
                            } else {
                                "Parser cannot parse input: expected '}'"
                            }));
                        }
                        _ => return Err(syntax("Parser cannot parse input: expected ','")),
                    }
                }
                Expect::Done => {
                    self.skip_whitespace();
                    if self.peek().is_some() {
                        return Err(syntax("Parser cannot parse input: unexpected characters"));
                    }
                    // The `end` event.
                    return Ok(self.cjson.finish()?);
                }
            }
        }
    }

    /// A string or key body; the index is past the opening quote. Decodes
    /// escapes; `\uXXXX` escapes are UTF-16 code units, and one that stays
    /// unpaired becomes U+FFFD. A string without escapes is borrowed from
    /// the input.
    ///
    /// stream-json's `string` state matches
    /// `[^\x00-\x1f\"\\]{1,256}|\\[bfnrt\"\\\/]|\\u[\da-fA-F]{4}|\"`: input
    /// that matches none of these is `escaped characters` if any input is
    /// left, and `expected a string value` at the end of the input.
    fn string(&mut self) -> Result<Cow<'a, str>, ParseError> {
        let start = self.index;
        // The common case: no escapes up to the closing quote.
        while self
            .peek()
            .is_some_and(|b| b >= 0x20 && b != b'"' && b != b'\\')
        {
            self.index += 1;
        }
        if self.peek() == Some(b'"') {
            let text: &'a str = self.text;
            let s = &text[start..self.index];
            self.index += 1;
            return Ok(Cow::Borrowed(s));
        }
        let mut units: Option<Vec<u16>> = None;
        let mut out = String::from(&self.text[start..self.index]);
        loop {
            let Some(b) = self.peek() else {
                return Err(syntax("Parser has expected a string value"));
            };
            match b {
                b'"' => {
                    self.index += 1;
                    return Ok(Cow::Owned(match units {
                        Some(units) => String::from_utf16_lossy(&units),
                        None => out,
                    }));
                }
                b'\\' => {
                    let decoded: u16 = match self.bytes.get(self.index + 1) {
                        Some(b'b') => 0x08,
                        Some(b'f') => 0x0C,
                        Some(b'n') => u16::from(b'\n'),
                        Some(b'r') => u16::from(b'\r'),
                        Some(b't') => u16::from(b'\t'),
                        Some(&c @ (b'"' | b'\\' | b'/')) => u16::from(c),
                        Some(b'u') => {
                            let hex = self
                                .bytes
                                .get(self.index + 2..self.index + 6)
                                .filter(|h| h.iter().all(u8::is_ascii_hexdigit))
                                .and_then(|h| std::str::from_utf8(h).ok())
                                .and_then(|h| u16::from_str_radix(h, 16).ok());
                            let Some(unit) = hex else {
                                return Err(syntax(
                                    "Parser cannot parse input: escaped characters",
                                ));
                            };
                            self.index += 4;
                            unit
                        }
                        _ => return Err(syntax("Parser cannot parse input: escaped characters")),
                    };
                    self.index += 2;
                    let units = units.get_or_insert_with(|| out.encode_utf16().collect());
                    units.push(decoded);
                }
                0..0x20 => return Err(syntax("Parser cannot parse input: escaped characters")),
                _ => {
                    let start = self.index;
                    while self
                        .peek()
                        .is_some_and(|b| b >= 0x20 && b != b'"' && b != b'\\')
                    {
                        self.index += 1;
                    }
                    let run = &self.text[start..self.index];
                    match &mut units {
                        Some(units) => units.extend(run.encode_utf16()),
                        None => out.push_str(run),
                    }
                }
            }
        }
    }

    /// `true`, `false` or `null`: `true\b|false\b|null\b` must match.
    fn literal(&mut self) -> Result<(), ParseError> {
        let rest = &self.bytes[self.index..];
        let (word, value): (&[u8], Option<bool>) = match rest[0] {
            b't' => (b"true", Some(true)),
            b'f' => (b"false", Some(false)),
            _ => (b"null", None),
        };
        let matches = rest.starts_with(word) && !rest.get(word.len()).copied().is_some_and(is_word);
        if !matches {
            return Err(syntax("Parser cannot parse input: expected a value"));
        }
        self.index += word.len();
        match value {
            Some(b) => self.cjson.commit_boolean(b)?,
            None => self.cjson.commit_null()?,
        }
        Ok(())
    }

    /// A number: the `numberStart` … `numberExpDigit` states, then
    /// `handleStartNumber` / `handleNumberChunk` / `handleEndNumber`. The
    /// number is a double iff a chunk contains `.`, `e` or `E`, or the
    /// integer literal does not fit the target's integer range.
    fn number(&mut self) -> Result<(), ParseError> {
        let start = self.index;
        let digit = |t: &Self| t.peek().is_some_and(|b| b.is_ascii_digit());
        if self.peek() == Some(b'-') {
            self.index += 1;
            // numberStart
            if !digit(self) {
                return Err(syntax(
                    "Parser cannot parse input: expected a starting digit",
                ));
            }
        }
        // A leading 0 goes straight to numberFraction; otherwise numberDigit.
        if self.peek() == Some(b'0') {
            self.index += 1;
        } else {
            while digit(self) {
                self.index += 1;
            }
        }
        // numberFraction
        let mut is_double = false;
        if self.peek() == Some(b'.') {
            is_double = true;
            self.index += 1;
            // numberFracStart
            if !digit(self) {
                return Err(syntax(
                    "Parser cannot parse input: expected a fractional part of a number",
                ));
            }
            while digit(self) {
                self.index += 1;
            }
        }
        // numberExponent (after a fraction) or numberFraction's [eE].
        if matches!(self.peek(), Some(b'e' | b'E')) {
            is_double = true;
            self.index += 1;
            // numberExpSign
            match self.peek() {
                Some(b'-' | b'+') => self.index += 1,
                Some(_) => {}
                None => {
                    return Err(syntax("Parser has expected an exponent value of a number"));
                }
            }
            // numberExpStart
            if !digit(self) {
                return Err(syntax(
                    "Parser cannot parse input: expected an exponent part of a number",
                ));
            }
            while digit(self) {
                self.index += 1;
            }
        }
        let is_double = is_double
            || !self
                .cjson
                .integer_string_fits(&self.text[start..self.index]);
        self.cjson.commit_number(is_double)?;
        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::date_time::DefaultDateTimeRecognizer;
    use crate::support::integer_range::{INT64_RANGE, IntegerRange};

    fn reader(range: Option<IntegerRange>) -> CompressedJson {
        CompressedJson::new(Box::new(DefaultDateTimeRecognizer), false, range)
    }

    fn read(text: &str) -> Result<Value, ParseError> {
        reader(Some(INT64_RANGE.clone())).parse_stream(text.as_bytes())
    }

    fn error(text: &str) -> String {
        read(text).unwrap_err().message().to_owned()
    }

    #[test]
    fn number_classification_by_literal() {
        assert_eq!(read("1.0"), Ok(Value::Double));
        assert_eq!(read("1e2"), Ok(Value::Double));
        assert_eq!(read("-0.0"), Ok(Value::Double));
        assert_eq!(read("-0"), Ok(Value::Integer));
        assert_eq!(read("9007199254740993"), Ok(Value::Integer));
        assert_eq!(read("9223372036854775807"), Ok(Value::Integer));
        assert_eq!(read("9223372036854775808"), Ok(Value::Double));
        assert_eq!(read("-9223372036854775809"), Ok(Value::Double));
        assert_eq!(read("1E400"), Ok(Value::Double));
        let mut unbounded = reader(None);
        assert_eq!(
            unbounded.parse_stream(b"123456789012345678901234567890"),
            Ok(Value::Integer)
        );
    }

    #[test]
    fn duplicate_keys_and_source_order() {
        let mut r = reader(Some(INT64_RANGE.clone()));
        let v = r
            .parse_stream(br#"{"b":1.0,"2":1,"a":2,"b":"dup"}"#)
            .unwrap();
        let cjson = &r;
        let keys: Vec<&str> = cjson
            .get_object_for_value(v)
            .unwrap()
            .iter()
            .map(|(k, _)| cjson.get_string_for_value(*k).unwrap())
            .collect();
        assert_eq!(keys, ["b", "2", "a", "b"]);
    }

    // The error table of research 02, section 1.2.
    #[test]
    fn stream_json_error_messages() {
        let cases = [
            ("", "Parser has expected a value"),
            ("[", "Parser has expected a value"),
            ("{\"a\":", "Parser has expected a value"),
            ("\u{feff}{}", "Parser cannot parse input: expected a value"),
            ("NaN", "Parser cannot parse input: expected a value"),
            ("tru}", "Parser cannot parse input: expected a value"),
            ("'x'", "Parser cannot parse input: expected a value"),
            (
                "{\"a\":1} {\"b\":2}",
                "Parser cannot parse input: unexpected characters",
            ),
            (
                "{\"a\":1,}",
                "Parser cannot parse input: unexpected token '}'",
            ),
            ("[1,]", "Parser cannot parse input: unexpected token ']'"),
            ("[1,2", "Parser cannot parse input: expected ','"),
            ("{\"a\":01}", "Parser cannot parse input: expected ','"),
            ("[1 2]", "Parser cannot parse input: expected ','"),
            ("[1}", "Parser cannot parse input: expected ']'"),
            ("{\"a\":1]", "Parser cannot parse input: expected '}'"),
            ("{1:2}", "Parser cannot parse input: expected an object key"),
            ("{", "Parser cannot parse input: expected an object key"),
            ("{\"a\" 1}", "Parser cannot parse input: expected ':'"),
            (
                "\"a\u{1}\"",
                "Parser cannot parse input: escaped characters",
            ),
            ("\"\\x\"", "Parser cannot parse input: escaped characters"),
            ("\"abc", "Parser has expected a string value"),
            ("-x", "Parser cannot parse input: expected a starting digit"),
            (
                "1.x",
                "Parser cannot parse input: expected a fractional part of a number",
            ),
            (
                "1e+x",
                "Parser cannot parse input: expected an exponent part of a number",
            ),
            ("1e", "Parser has expected an exponent value of a number"),
        ];
        for (input, message) in cases {
            assert_eq!(error(input), message, "{input:?}");
        }
    }

    /// Deep samples are read without recursion, on success and when the
    /// error comes after the root value or inside it.
    #[test]
    fn deep_nesting() {
        let n = 1_000_000;
        let deep = format!("{}{}", "[".repeat(n), "]".repeat(n));
        let mut r = reader(None);
        assert!(matches!(
            r.parse_stream(deep.as_bytes()),
            Ok(Value::Array(_))
        ));
        assert_eq!(
            r.parse_stream(format!("{deep} x").as_bytes())
                .unwrap_err()
                .message(),
            "Parser cannot parse input: unexpected characters"
        );
        assert_eq!(
            r.parse_stream(format!("{}x", r#"{"a":["#.repeat(n / 2)).as_bytes())
                .unwrap_err()
                .message(),
            "Parser cannot parse input: expected a value"
        );
        assert_eq!(r.parse_stream(b"1"), Ok(Value::Integer));
    }

    #[test]
    fn escapes_and_surrogates() {
        let mut r = reader(Some(INT64_RANGE.clone()));
        let v = r
            .parse_stream(br#"["\ud83d\ude00x", "\u00e9\n", "\ud800"]"#)
            .unwrap();
        let cjson = &r;
        let items = cjson.get_array_for_value(v).unwrap();
        let text = |v| cjson.get_string_for_value(v).unwrap();
        assert_eq!(text(items[0]), "😀x");
        assert_eq!(text(items[1]), "é\n");
        assert_eq!(text(items[2]), "\u{FFFD}");
    }
}
