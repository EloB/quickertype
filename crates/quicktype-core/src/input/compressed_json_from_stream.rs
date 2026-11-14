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

use std::borrow::Cow;
use std::io::Read;

use quicktype_js_compat::utf8;

use super::compressed_json::{CompressedJson, JsonSink, ParseError, Value};
use super::json_scan::plain_run;
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
        parse_stream_into(self, sample)
    }

    /// [`parse_stream`](Self::parse_stream) on a byte stream, read chunk
    /// by chunk: only a window of the sample is in memory at a time. A
    /// failed read ends the sample with [`ParseError::Read`]; when the
    /// error wraps an [`IoError`], that is the exception reported (its
    /// name and message), otherwise an `Error` with the error's text.
    pub fn parse_stream_reader(&mut self, reader: &mut dyn Read) -> Result<Value, ParseError> {
        parse_stream_reader_into(self, reader)
    }

    #[cfg(test)]
    fn parse_stream_chunked(
        &mut self,
        reader: &mut dyn Read,
        chunk_size: usize,
    ) -> Result<Value, ParseError> {
        parse_stream_chunked_into(self, reader, chunk_size)
    }
}

/// [`CompressedJson::parse_stream`] into any [`JsonSink`].
pub(crate) fn parse_stream_into<S: JsonSink>(
    sink: &mut S,
    sample: &[u8],
) -> Result<S::Root, ParseError> {
    // In memory: decode once (borrowing valid UTF-8) and tokenize it
    // as one window.
    match utf8::decode(sample) {
        Cow::Borrowed(text) => tokenize(sink, Tokenizer::in_memory(text)),
        Cow::Owned(text) => tokenize(sink, Tokenizer::in_memory(text)),
    }
}

/// [`CompressedJson::parse_stream_reader`] into any [`JsonSink`].
pub(crate) fn parse_stream_reader_into<S: JsonSink>(
    sink: &mut S,
    reader: &mut dyn Read,
) -> Result<S::Root, ParseError> {
    parse_stream_chunked_into(sink, reader, CHUNK_SIZE)
}

/// [`parse_stream_reader_into`] with chunks of at most `chunk_size` bytes.
pub(crate) fn parse_stream_chunked_into<S: JsonSink>(
    sink: &mut S,
    reader: &mut dyn Read,
    chunk_size: usize,
) -> Result<S::Root, ParseError> {
    tokenize(sink, Tokenizer::streaming(reader, chunk_size))
}

fn tokenize<S: JsonSink, W: Window>(
    sink: &mut S,
    mut tokenizer: Tokenizer<'_, W>,
) -> Result<S::Root, ParseError> {
    let result = tokenizer.run(sink);
    let read_error = tokenizer.read_error.take();
    // A failed read looks like the end of the input to the parser; the
    // read error is what is reported.
    let result = match read_error {
        Some(e) => Err(e),
        None => result,
    };
    if result.is_err() {
        sink.reset_partial_sample();
    }
    result
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
/// `text` is the window of decoded input: the whole sample when it is in
/// memory, otherwise the input from (at most a chunk before) the current
/// token on. `index` is the position in it. Every look-ahead goes through
/// [`byte`](Self::byte) or [`skip`](Self::skip), which read more input
/// first if the window ends before the byte asked for. The text before the
/// current token is dropped between tokens and while skipping whitespace;
/// a single token is held whole, however long (a 1 GB string needs 1 GB).
struct Tokenizer<'r, W> {
    /// The rest of the input; `None` when it is all in `text`.
    reader: Option<&'r mut dyn Read>,
    decoder: utf8::Decoder,
    /// The read buffer: it starts small and doubles up to the chunk size,
    /// so that small samples do not pay for a full chunk.
    buffer: Vec<u8>,
    /// The most bytes read at a time, and how far into the window `index`
    /// must be for the text before it to be dropped
    /// ([`discard_consumed`](Self::discard_consumed)). `usize::MAX` for a
    /// sample in memory, which reads nothing and keeps its text.
    chunk_size: usize,
    at_end: bool,
    /// The error that ended the input early, if a read failed.
    read_error: Option<ParseError>,
    text: W,
    index: usize,
}

/// The tokenizer's text: a sample in memory (`&str`, or the `String` it
/// decoded to), or a stream's window (a `String` that grows and shrinks).
/// Generic rather than a `Cow`, so that reading a byte costs no branch.
trait Window: AsRef<str> {
    /// The text to grow or shrink; `None` for text that is borrowed.
    fn as_string(&mut self) -> Option<&mut String>;
}

impl Window for &str {
    fn as_string(&mut self) -> Option<&mut String> {
        None
    }
}

impl Window for String {
    fn as_string(&mut self) -> Option<&mut String> {
        Some(self)
    }
}

/// The first read buffer's size.
const FIRST_READ: usize = 8 * 1024;

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

impl<'r, W: Window> Tokenizer<'r, W> {
    /// A tokenizer over a whole sample in memory.
    fn in_memory(text: W) -> Self {
        Tokenizer {
            reader: None,
            decoder: utf8::Decoder::new(),
            buffer: Vec::new(),
            chunk_size: usize::MAX,
            at_end: true,
            read_error: None,
            text,
            index: 0,
        }
    }

    fn text(&self) -> &str {
        self.text.as_ref()
    }
}

impl<'r> Tokenizer<'r, String> {
    /// A tokenizer that reads `reader` in chunks of up to `chunk_size`.
    fn streaming(reader: &'r mut dyn Read, chunk_size: usize) -> Self {
        let chunk_size = chunk_size.max(1);
        Tokenizer {
            reader: Some(reader),
            decoder: utf8::Decoder::new(),
            buffer: vec![0; chunk_size.min(FIRST_READ)],
            chunk_size,
            at_end: false,
            read_error: None,
            text: String::new(),
            index: 0,
        }
    }
}

impl<W: Window> Tokenizer<'_, W> {
    /// Reads and decodes input until the window grows or the input ends.
    /// Returns whether it grew. A failed read ends the input and is kept
    /// in `read_error`.
    #[cold]
    fn fill(&mut self) -> bool {
        let Some(reader) = self.reader.as_mut() else {
            return false;
        };
        while !self.at_end {
            let Some(text) = self.text.as_string() else {
                return false;
            };
            let before = text.len();
            match reader.read(&mut self.buffer) {
                Ok(0) => {
                    self.at_end = true;
                    self.decoder.finish(text);
                }
                Ok(n) => {
                    self.decoder.push(&self.buffer[..n], text);
                    if n == self.buffer.len() && n < self.chunk_size {
                        let size = (n * 2).min(self.chunk_size);
                        self.buffer.resize(size, 0);
                    }
                }
                Err(e) if e.kind() == std::io::ErrorKind::Interrupted => {}
                Err(e) => {
                    self.at_end = true;
                    self.read_error = Some(read_error(&e));
                    return false;
                }
            }
            if self.text.as_ref().len() > before {
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
        match self.text().as_bytes().get(i) {
            Some(&b) => Some(b),
            None => self.byte_after_fill(i),
        }
    }

    #[cold]
    fn byte_after_fill(&mut self, i: usize) -> Option<u8> {
        while i >= self.text().len() {
            if !self.fill() {
                return None;
            }
        }
        Some(self.text().as_bytes()[i])
    }

    #[inline]
    fn peek(&mut self) -> Option<u8> {
        self.byte(0)
    }

    /// Advances to the end of a run: `run_end(window, index)` says where
    /// the run that starts at `index` ends in the window. Where the window
    /// ends first, it reads more and goes on from there.
    #[inline]
    fn skip_run(&mut self, run_end: impl Fn(&[u8], usize) -> usize) {
        loop {
            self.index = run_end(self.text().as_bytes(), self.index);
            if self.index < self.text().len() || !self.fill() {
                return;
            }
        }
    }

    /// Advances past the bytes for which `p` holds.
    #[inline]
    fn skip(&mut self, p: impl Fn(u8) -> bool) {
        self.skip_run(|bytes, start| {
            let rest = &bytes[start..];
            start + rest.iter().position(|&b| !p(b)).unwrap_or(rest.len())
        });
    }

    /// Drops the text before the current position, between tokens, once
    /// there is enough of it to be worth moving the rest (a sample in
    /// memory keeps its text). One comparison per token.
    #[inline]
    fn discard_consumed(&mut self) {
        if self.index >= self.chunk_size {
            self.discard();
        }
    }

    #[cold]
    fn discard(&mut self) {
        if self.text().is_char_boundary(self.index) {
            if let Some(text) = self.text.as_string() {
                text.drain(..self.index);
                self.index = 0;
            }
        }
    }

    /// Skips whitespace, which comes only between tokens: once the window
    /// is all consumed, it is dropped before more is read, so a long run
    /// of whitespace never accumulates.
    fn skip_whitespace(&mut self) {
        loop {
            let rest = &self.text().as_bytes()[self.index..];
            let n = rest
                .iter()
                .position(|&b| !is_whitespace(b))
                .unwrap_or(rest.len());
            self.index += n;
            if self.index < self.text().len() {
                return;
            }
            if self.reader.is_some() {
                if let Some(text) = self.text.as_string() {
                    text.clear();
                    self.index = 0;
                }
            }
            if !self.fill() {
                return;
            }
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

    fn run<S: JsonSink>(&mut self, sink: &mut S) -> Result<S::Root, ParseError> {
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
                                    sink.commit_string(&self.text()[start..end])?;
                                }
                                Token::Owned(s) => sink.commit_string(&s)?,
                            }
                            expect = Self::after_value(&stack);
                        }
                        b'{' => {
                            self.index += 1;
                            sink.push_object_context()?;
                            stack.push(Parent::Object);
                            expect = Expect::Key1;
                        }
                        b'[' => {
                            self.index += 1;
                            sink.push_array_context()?;
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
                            sink.finish_array()?;
                            stack.pop();
                            expect = Self::after_value(&stack);
                        }
                        b'-' | b'0'..=b'9' => {
                            self.number(sink)?;
                            expect = Self::after_value(&stack);
                        }
                        b't' | b'f' | b'n' => {
                            self.literal(sink)?;
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
                                    sink.set_property_key(&self.text()[start..end])?;
                                }
                                Token::Owned(key) => sink.set_property_key(&key)?,
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
                            sink.finish_object()?;
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
                            sink.finish_array()?;
                            stack.pop();
                            expect = Self::after_value(&stack);
                        }
                        Some(b'}') if !in_array => {
                            self.index += 1;
                            sink.finish_object()?;
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
                    return Ok(sink.finish()?);
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
        // The common case: no escapes up to the closing quote. The run of
        // characters that need no escape handling ends at the next `"`,
        // `\` or control character, found eight bytes at a time.
        self.skip_run(plain_run);
        if self.peek() == Some(b'"') {
            let end = self.index;
            self.index += 1;
            return Ok(Token::Range(start, end));
        }
        let mut units: Option<Vec<u16>> = None;
        let mut out = String::from(&self.text()[start..self.index]);
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
                                .text()
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
                    self.skip_run(plain_run);
                    let run = &self.text()[start..self.index];
                    match &mut units {
                        Some(units) => units.extend(run.encode_utf16()),
                        None => out.push_str(run),
                    }
                }
            }
        }
    }

    /// `true`, `false` or `null`: `true\b|false\b|null\b` must match.
    fn literal<S: JsonSink>(&mut self, sink: &mut S) -> Result<(), ParseError> {
        let (word, value): (&[u8], Option<bool>) = match self.peek() {
            Some(b't') => (b"true", Some(true)),
            Some(b'f') => (b"false", Some(false)),
            _ => (b"null", None),
        };
        // The word and the character after it, as far as the input goes.
        self.byte(word.len());
        let rest = &self.text().as_bytes()[self.index..];
        let matches = rest.starts_with(word) && !rest.get(word.len()).copied().is_some_and(is_word);
        if !matches {
            return Err(syntax("Parser cannot parse input: expected a value"));
        }
        self.index += word.len();
        match value {
            Some(b) => sink.commit_boolean(b)?,
            None => sink.commit_null()?,
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
    fn number<S: JsonSink>(&mut self, sink: &mut S) -> Result<(), ParseError> {
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
        let is_double = is_double || !sink.integer_string_fits(&self.text()[start..self.index]);
        sink.commit_number(is_double)?;
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
            // In memory, as parse_stream reads a byte sample.
            let mut r = reader(Some(INT64_RANGE.clone()));
            let whole = r
                .parse_stream(doc)
                .map(|value| (value, r.to_tables(&[value]).0));
            assert_eq!(read_chunked(doc, doc.len().max(1)), whole);
            for size in [1, 2, 3, 4, 5, 7, 16, 8 * 1024] {
                assert_eq!(
                    read_chunked(doc, size),
                    whole,
                    "chunks of {size}: {:?}",
                    String::from_utf8_lossy(&doc[..doc.len().min(80)])
                );
            }
        }
    }

    /// The key a one-key document spells, or the error, read in memory
    /// (`None`) or in chunks of `size`.
    fn only_key(doc: &[u8], size: Option<usize>) -> Result<String, String> {
        let mut r = reader(Some(INT64_RANGE.clone()));
        let value = match size {
            None => r.parse_stream(doc),
            Some(size) => r.parse_stream_chunked(&mut &*doc, size),
        }
        .map_err(|e| e.message().to_owned())?;
        let members = r.get_object_for_value(value).unwrap();
        assert_eq!(members.len(), 1);
        Ok(r.get_string_for_value(members[0].0).unwrap().to_owned())
    }

    /// Strings are scanned eight bytes at a time (`json_scan::plain_run`),
    /// and byte by byte where fewer than eight are left in the window.
    /// Wherever a stop byte, an escape or a multi-byte character falls,
    /// at every offset modulo 8 from the opening quote and at every point
    /// between chunks (of 1 to 17 bytes), the key reads as what it spells,
    /// or fails with the error of the stop it reaches.
    #[test]
    fn string_scan_at_every_offset_and_chunk_boundary() {
        const ESCAPED: &str = "Parser cannot parse input: escaped characters";
        // What follows a run of plain bytes, and what it reads as.
        let pieces: &[(&[u8], Result<&str, &str>)] = &[
            (b"", Ok("")),
            (b"\\n", Ok("\n")),
            (b"\\\"", Ok("\"")),
            (b"\\\\x", Ok("\\x")),
            (b"\\u00e9", Ok("\u{e9}")),
            (b"\\ud83d\\ude00", Ok("\u{1F600}")),
            (
                "\u{e9}\u{20AC}\u{1F600}".as_bytes(),
                Ok("\u{e9}\u{20AC}\u{1F600}"),
            ),
            (b" !#[]^\x7f", Ok(" !#[]^\x7f")),
            (b"\xff\xc3", Ok("\u{FFFD}\u{FFFD}")),
            (b"\"", Err("Parser cannot parse input: expected ':'")),
            (b"\x00", Err(ESCAPED)),
            (b"\t", Err(ESCAPED)),
            (b"\x1f", Err(ESCAPED)),
            (b"\\x", Err(ESCAPED)),
        ];
        for lead in 0..20 {
            for &(piece, read) in pieces {
                for trail in [0, 1, 7, 8, 9] {
                    let mut doc = b"{\"".to_vec();
                    doc.extend(std::iter::repeat_n(b'a', lead));
                    doc.extend_from_slice(piece);
                    doc.extend(std::iter::repeat_n(b'b', trail));
                    doc.extend_from_slice(b"\":0}");
                    let expected = read
                        .map(|text| format!("{}{text}{}", "a".repeat(lead), "b".repeat(trail)))
                        .map_err(str::to_owned);
                    assert_eq!(only_key(&doc, None), expected, "{doc:?}");
                    for size in 1..=17 {
                        assert_eq!(only_key(&doc, Some(size)), expected, "{doc:?} in {size}");
                    }
                }
            }
            // The input ends in the string.
            let mut doc = b"{\"".to_vec();
            doc.extend(std::iter::repeat_n(b'a', lead));
            for size in [None, Some(1), Some(3), Some(8)] {
                assert_eq!(
                    only_key(&doc, size),
                    Err("Parser has expected a string value".to_owned())
                );
            }
        }
    }

    /// Whitespace between tokens is dropped while it is skipped, so the
    /// window stays within a chunk however long the run is.
    #[test]
    fn whitespace_does_not_accumulate() {
        let input = format!("{}1", " \n".repeat(1 << 19));
        let mut bytes = input.as_bytes();
        let mut t = Tokenizer::streaming(&mut bytes, 4096);
        t.skip_whitespace();
        assert_eq!(t.peek(), Some(b'1'));
        assert!(t.text.len() <= 4096, "window of {} bytes", t.text.len());
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
