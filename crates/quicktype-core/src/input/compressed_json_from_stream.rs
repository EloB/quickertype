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
//! would with the whole input at hand. This port reads the sample chunk by
//! chunk too ([`CompressedJson::parse_stream_reader`]), so a large file is
//! never held whole: it keeps only a window of decoded text, which grows
//! while a token is still incomplete (every look-ahead first reads more),
//! so chunk boundaries cannot change the result. The sample is UTF-8
//! decoded like Node's `setEncoding("utf8")`
//! ([`quicktype_js_compat::utf8::Decoder`]: invalid sequences become
//! U+FFFD, also when a sequence is split between chunks); a byte order mark
//! is not stripped and is a syntax error, as in the CLI.

use std::io::Read;

use quicktype_js_compat::utf8;

use super::compressed_json::{CompressedJson, ParseError, Value};
use crate::input::io::node_io::IoError;
use crate::messages::{JsErrorName, JsException, QuickTypeError, Result};

/// How many bytes are read at a time: Node's file stream chunk size.
const CHUNK_SIZE: usize = 64 * 1024;

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
        self.parse_stream_reader(&mut &*sample)
    }

    /// [`parse_stream`](Self::parse_stream) on a byte stream, read chunk
    /// by chunk: only a window of the sample is in memory at a time. A
    /// failed read ends the sample with [`ParseError::Read`]; when the
    /// error wraps an [`IoError`], that is the exception reported (its
    /// name and message), otherwise an `Error` with the error's text.
    pub fn parse_stream_reader(&mut self, reader: &mut dyn Read) -> Result<Value, ParseError> {
        self.parse_stream_chunked(reader, CHUNK_SIZE)
    }

    fn parse_stream_chunked(
        &mut self,
        reader: &mut dyn Read,
        chunk_size: usize,
    ) -> Result<Value, ParseError> {
        let (result, read_error) = {
            let mut tokenizer = Tokenizer::new(reader, chunk_size, self);
            let result = tokenizer.run();
            (result, tokenizer.read_error.take())
        };
        // A failed read looks like the end of the input to the parser; the
        // read error is what is reported.
        let result = match read_error {
            Some(e) => Err(e),
            None => result,
        };
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

/// A string token: a range of the window (no escapes), or decoded text.
enum Token {
    Range(usize, usize),
    Owned(String),
}

/// stream-json's tokenizer, emitting straight into the builder.
///
/// `text` is the decoded input from the start of the current token on (the
/// part before it is dropped between tokens); `index` is the position in
/// it. Every look-ahead goes through [`byte`](Self::byte) or
/// [`skip`](Self::skip), which read more input first if the window ends
/// before the byte asked for.
struct Tokenizer<'a> {
    reader: &'a mut dyn Read,
    decoder: utf8::Decoder,
    buffer: Vec<u8>,
    at_end: bool,
    /// The error that ended the input early, if a read failed.
    read_error: Option<ParseError>,
    text: String,
    index: usize,
    cjson: &'a mut CompressedJson,
}

/// stream-json's `Error` with `message`.
fn syntax(message: &str) -> ParseError {
    ParseError::Js(JsException::new(JsErrorName::Error, message))
}

/// A failed read of the sample.
fn read_error(e: &std::io::Error) -> ParseError {
    let error = match e
        .get_ref()
        .and_then(|inner| inner.downcast_ref::<IoError>())
    {
        Some(io) => QuickTypeError::js_exception(io.name(), io.message()),
        None => QuickTypeError::js_exception(JsErrorName::Error, e.to_string()),
    };
    ParseError::Read(error)
}

/// `TERM` and the whitespace the parser skips: space, tab, LF and CR only.
fn is_whitespace(b: u8) -> bool {
    matches!(b, b' ' | b'\t' | b'\n' | b'\r')
}

/// A JavaScript `\w` character, for the `\b` after a literal.
fn is_word(b: u8) -> bool {
    b.is_ascii_alphanumeric() || b == b'_'
}

/// A string character that needs no escape handling.
fn is_plain(b: u8) -> bool {
    b >= 0x20 && b != b'"' && b != b'\\'
}

impl<'a> Tokenizer<'a> {
    fn new(reader: &'a mut dyn Read, chunk_size: usize, cjson: &'a mut CompressedJson) -> Self {
        Tokenizer {
            reader,
            decoder: utf8::Decoder::new(),
            buffer: vec![0; chunk_size.max(1)],
            at_end: false,
            read_error: None,
            text: String::new(),
            index: 0,
            cjson,
        }
    }

    /// Reads and decodes input until the window grows or the input ends.
    /// Returns whether it grew. A failed read ends the input and is kept
    /// in `read_error`.
    #[cold]
    fn fill(&mut self) -> bool {
        while !self.at_end {
            let before = self.text.len();
            match self.reader.read(&mut self.buffer) {
                Ok(0) => {
                    self.at_end = true;
                    self.decoder.finish(&mut self.text);
                }
                Ok(n) => self.decoder.push(&self.buffer[..n], &mut self.text),
                Err(e) if e.kind() == std::io::ErrorKind::Interrupted => {}
                Err(e) => {
                    self.at_end = true;
                    self.read_error = Some(read_error(&e));
                    return false;
                }
            }
            if self.text.len() > before {
                return true;
            }
        }
        false
    }

    /// The byte `offset` bytes after the current one; `None` past the end
    /// of the input.
    #[inline]
    fn byte(&mut self, offset: usize) -> Option<u8> {
        let i = self.index + offset;
        match self.text.as_bytes().get(i) {
            Some(&b) => Some(b),
            None => self.byte_after_fill(i),
        }
    }

    #[cold]
    fn byte_after_fill(&mut self, i: usize) -> Option<u8> {
        while i >= self.text.len() {
            if !self.fill() {
                return None;
            }
        }
        Some(self.text.as_bytes()[i])
    }

    #[inline]
    fn peek(&mut self) -> Option<u8> {
        self.byte(0)
    }

    /// Advances past the bytes for which `p` holds.
    #[inline]
    fn skip(&mut self, p: impl Fn(u8) -> bool) {
        loop {
            let rest = &self.text.as_bytes()[self.index..];
            let n = rest.iter().position(|&b| !p(b)).unwrap_or(rest.len());
            self.index += n;
            if self.index < self.text.len() || !self.fill() {
                return;
            }
        }
    }

    /// Drops the text before the current position, between tokens, once
    /// there is enough of it to be worth moving the rest.
    fn discard_consumed(&mut self) {
        if self.index >= self.buffer.len() && self.text.is_char_boundary(self.index) {
            self.text.drain(..self.index);
            self.index = 0;
        }
    }

    fn skip_whitespace(&mut self) {
        self.skip(is_whitespace);
    }

    /// `expected[parent]`: the state after a complete value.
    fn after_value(stack: &[Parent]) -> Expect {
        match stack.last() {
            Some(Parent::Object) => Expect::ObjectStop,
            Some(Parent::Array) => Expect::ArrayStop,
            None => Expect::Done,
        }
    }

    fn run(&mut self) -> Result<Value, ParseError> {
        let mut expect = Expect::Value;
        let mut stack: Vec<Parent> = Vec::new();
        loop {
            self.discard_consumed();
            match expect {
                Expect::Value | Expect::Value1 => {
                    self.skip_whitespace();
                    let Some(b) = self.peek() else {
                        return Err(syntax("Parser has expected a value"));
                    };
                    match b {
                        b'"' => {
                            self.index += 1;
                            match self.string()? {
                                Token::Range(start, end) => {
                                    self.cjson.commit_string(&self.text[start..end])?;
                                }
                                Token::Owned(s) => self.cjson.commit_string(&s)?,
                            }
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
                            match self.string()? {
                                Token::Range(start, end) => {
                                    self.cjson.set_property_key(&self.text[start..end])?;
                                }
                                Token::Owned(key) => self.cjson.set_property_key(&key)?,
                            }
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
    /// unpaired becomes U+FFFD. A string without escapes is a range of the
    /// window.
    ///
    /// stream-json's `string` state matches
    /// `[^\x00-\x1f\"\\]{1,256}|\\[bfnrt\"\\\/]|\\u[\da-fA-F]{4}|\"`: input
    /// that matches none of these is `escaped characters` if any input is
    /// left, and `expected a string value` at the end of the input.
    fn string(&mut self) -> Result<Token, ParseError> {
        let start = self.index;
        // The common case: no escapes up to the closing quote.
        self.skip(is_plain);
        if self.peek() == Some(b'"') {
            let end = self.index;
            self.index += 1;
            return Ok(Token::Range(start, end));
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
                    return Ok(Token::Owned(match units {
                        Some(units) => String::from_utf16_lossy(&units),
                        None => out,
                    }));
                }
                b'\\' => {
                    let decoded: u16 = match self.byte(1) {
                        Some(b'b') => 0x08,
                        Some(b'f') => 0x0C,
                        Some(b'n') => u16::from(b'\n'),
                        Some(b'r') => u16::from(b'\r'),
                        Some(b't') => u16::from(b'\t'),
                        Some(c @ (b'"' | b'\\' | b'/')) => u16::from(c),
                        Some(b'u') => {
                            // Four hex digits, all in the window.
                            let complete = self.byte(5).is_some();
                            let hex = self
                                .text
                                .as_bytes()
                                .get(self.index + 2..self.index + 6)
                                .filter(|h| complete && h.iter().all(u8::is_ascii_hexdigit))
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
                    self.skip(is_plain);
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
        let (word, value): (&[u8], Option<bool>) = match self.peek() {
            Some(b't') => (b"true", Some(true)),
            Some(b'f') => (b"false", Some(false)),
            _ => (b"null", None),
        };
        // The word and the character after it, as far as the input goes.
        self.byte(word.len());
        let rest = &self.text.as_bytes()[self.index..];
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

    fn digit(&mut self) -> bool {
        self.peek().is_some_and(|b| b.is_ascii_digit())
    }

    /// A number: the `numberStart` … `numberExpDigit` states, then
    /// `handleStartNumber` / `handleNumberChunk` / `handleEndNumber`. The
    /// number is a double iff a chunk contains `.`, `e` or `E`, or the
    /// integer literal does not fit the target's integer range.
    fn number(&mut self) -> Result<(), ParseError> {
        let start = self.index;
        if self.peek() == Some(b'-') {
            self.index += 1;
            // numberStart
            if !self.digit() {
                return Err(syntax(
                    "Parser cannot parse input: expected a starting digit",
                ));
            }
        }
        // A leading 0 goes straight to numberFraction; otherwise numberDigit.
        if self.peek() == Some(b'0') {
            self.index += 1;
        } else {
            self.skip(|b| b.is_ascii_digit());
        }
        // numberFraction
        let mut is_double = false;
        if self.peek() == Some(b'.') {
            is_double = true;
            self.index += 1;
            // numberFracStart
            if !self.digit() {
                return Err(syntax(
                    "Parser cannot parse input: expected a fractional part of a number",
                ));
            }
            self.skip(|b| b.is_ascii_digit());
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
            if !self.digit() {
                return Err(syntax(
                    "Parser cannot parse input: expected an exponent part of a number",
                ));
            }
            self.skip(|b| b.is_ascii_digit());
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

    /// Reads `bytes` in chunks of `size`: the root value and the tables, or
    /// the error.
    fn read_chunked(
        bytes: &[u8],
        size: usize,
    ) -> Result<(Value, crate::input::compressed_json::CompressedJsonTables), ParseError> {
        let mut r = reader(Some(INT64_RANGE.clone()));
        let value = r.parse_stream_chunked(&mut &*bytes, size)?;
        Ok((value, r.to_tables(&[value]).0))
    }

    /// Chunk boundaries never change the result: every sample input, and
    /// every prefix of a document with escapes, multi-byte and invalid
    /// UTF-8, numbers and literals, read in chunks of 1 to 16 bytes, gives
    /// what reading it in one chunk gives (values, tables and errors).
    #[test]
    fn chunk_boundaries_do_not_change_the_result() {
        let mut documents: Vec<Vec<u8>> = Vec::new();
        let samples = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
            .join("../../tests/inputs/json/samples");
        for entry in std::fs::read_dir(samples).unwrap() {
            documents.push(std::fs::read(entry.unwrap().path()).unwrap());
        }
        let mut tricky: Vec<u8> =
            br#"{"a":"x\u00e9\ud83d\ude00y","b":[true,false,null,1.5e-3,-0,"#.to_vec();
        tricky.extend_from_slice(br#"12345678901234567890],"c":"\n\"\/","#);
        tricky.extend_from_slice(b"\"\xC3\xA9\xE2\x82\xAC\xF0\x9F\x98\x80\":");
        tricky.extend_from_slice(b"\"bad \xE2\x82 \xFF \xF0\x9F x\",\"long\":\"");
        tricky.extend_from_slice("\u{20AC}".repeat(40).as_bytes());
        tricky.extend_from_slice(br#"","t":truex}"#);
        let prefixes: Vec<Vec<u8>> = (0..=tricky.len()).map(|n| tricky[..n].to_vec()).collect();
        documents.extend(prefixes);
        for extra in [
            &b"\xEF\xBB\xBF{}"[..],
            b"",
            b"   ",
            b"[1, 2] x",
            br#"{"a":nul}"#,
            b"[\"\xE2\x82\"]",
            b"[\"\xE2\x82",
            b"[1e",
            b"[-",
            br#""\u12"#,
        ] {
            documents.push(extra.to_vec());
        }
        for doc in &documents {
            let whole = read_chunked(doc, doc.len().max(1));
            for size in [1, 2, 3, 4, 5, 7, 16] {
                assert_eq!(
                    read_chunked(doc, size),
                    whole,
                    "chunks of {size}: {:?}",
                    String::from_utf8_lossy(&doc[..doc.len().min(80)])
                );
            }
        }
    }

    /// A failed read is reported as the exception the reader's error wraps.
    #[test]
    fn read_errors_end_the_sample() {
        struct Failing(usize);
        impl Read for Failing {
            fn read(&mut self, buf: &mut [u8]) -> std::io::Result<usize> {
                if self.0 == 0 {
                    return Err(std::io::Error::other(IoError::new(
                        crate::input::io::node_io::IoErrorKind::Other,
                        JsErrorName::Error,
                        "EIO: i/o error, read",
                    )));
                }
                self.0 -= 1;
                buf[0] = b'[';
                Ok(1)
            }
        }
        let mut r = reader(None);
        let error = r.parse_stream_reader(&mut Failing(3)).unwrap_err();
        assert_eq!(
            error,
            ParseError::Read(QuickTypeError::js_exception(
                JsErrorName::Error,
                "EIO: i/o error, read"
            ))
        );
        // The instance can read the next sample.
        assert_eq!(r.parse_stream(b"[]"), Ok(Value::Array(0)));
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
