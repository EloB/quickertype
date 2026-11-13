//! `JSON.parse`, as V8 (Node 24, V8 13.6) implements it.
//!
//! Port of V8's `src/json/json-parser.cc` without the reviver:
//!
//! - **Values.** Objects are [`JsonValue::Object`] maps in JavaScript
//!   own-property order: array-index keys (`"0"` … `"4294967294"`) first in
//!   ascending order, then every other key in source order. A duplicate key
//!   keeps the slot of its first occurrence and takes the value of its last
//!   ([`insert_js_property`]); `"__proto__"` is an ordinary key. Numbers are
//!   `f64`, correctly rounded, overflowing to ±∞ (`1e400`).
//! - **Errors.** The `SyntaxError` message is V8's, character for character:
//!   which of V8's twenty templates fires, the position (in UTF-16 code
//!   units), the `(line L column C)` suffix and the source excerpt of the
//!   `Unexpected token` messages.
//!
//! JavaScript strings can hold unpaired UTF-16 surrogates (`"\ud800"`); a
//! Rust `String` cannot, so a `\u` escape that leaves a surrogate unpaired
//! decodes to U+FFFD, as does an error message that would quote half of a
//! surrogate pair (Node prints U+FFFD for them as well). See
//! `docs/PARITY.md`, "Lone surrogates".

use std::fmt;

use super::{IndexMap, JsonValue, insert_js_property};

/// The `SyntaxError` `JSON.parse` throws; [`message`](Self::message) is V8's
/// text, e.g. `Unexpected end of JSON input`.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct JsonParseError {
    message: String,
}

impl JsonParseError {
    /// The error's `message`.
    pub fn message(&self) -> &str {
        &self.message
    }
}

impl fmt::Display for JsonParseError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.write_str(&self.message)
    }
}

impl std::error::Error for JsonParseError {}

/// `JSON.parse(text)`.
///
/// ```
/// use quicktype_js_compat::json::{self, JsonValue};
///
/// let value = json::parse(r#"{"b": 1, "2": [true, null], "b": "x"}"#).unwrap();
/// // Array-index keys come first; the duplicate "b" keeps its slot.
/// assert_eq!(json::stringify(&value, None), r#"{"2":[true,null],"b":"x"}"#);
///
/// let error = json::parse("[1, 2").unwrap_err();
/// assert_eq!(
///     error.message(),
///     "Expected ',' or ']' after array element in JSON at position 5 (line 1 column 6)"
/// );
/// ```
pub fn parse(text: &str) -> Result<JsonValue, JsonParseError> {
    Parser {
        text,
        bytes: text.as_bytes(),
        pos: 0,
    }
    .parse_json()
}

/// V8's `JsonToken`: what a character can start.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
enum Token {
    Number,
    String,
    LBrace,
    RBrace,
    LBrack,
    RBrack,
    TrueLiteral,
    FalseLiteral,
    NullLiteral,
    Whitespace,
    Colon,
    Comma,
    Illegal,
    Eos,
}

/// `one_char_json_tokens`: the token a character starts. Every non-ASCII
/// character (and so every UTF-8 lead or continuation byte) is `Illegal`.
fn token_for_byte(b: u8) -> Token {
    match b {
        b'"' => Token::String,
        b'-' | b'0'..=b'9' => Token::Number,
        b't' => Token::TrueLiteral,
        b'f' => Token::FalseLiteral,
        b'n' => Token::NullLiteral,
        b' ' | b'\t' | b'\r' | b'\n' => Token::Whitespace,
        b':' => Token::Colon,
        b',' => Token::Comma,
        b'[' => Token::LBrack,
        b']' => Token::RBrack,
        b'{' => Token::LBrace,
        b'}' => Token::RBrace,
        _ => Token::Illegal,
    }
}

/// `IsNumberPart(character_json_scan_flags[c])`.
fn is_number_part(b: u8) -> bool {
    matches!(b, b'.' | b'e' | b'E' | b'-' | b'+' | b'0'..=b'9')
}

/// The error templates of `MessageTemplate` that carry a position (and so
/// the `(line L column C)` suffix).
#[derive(Clone, Copy, Debug)]
enum Positional {
    UnexpectedTokenNumber,
    UnexpectedTokenString,
    UnterminatedString,
    ExpectedPropNameOrRBrace,
    ExpectedCommaOrRBrack,
    ExpectedCommaOrRBrace,
    UnexpectedNonWhiteSpaceCharacter,
    BadEscapedCharacter,
    BadControlCharacter,
    BadUnicodeEscape,
    NoNumberAfterMinusSign,
    ExponentPartMissingNumber,
    UnterminatedFractionalNumber,
    ExpectedColonAfterPropertyName,
    ExpectedDoubleQuotedPropertyName,
}

impl Positional {
    fn text(self) -> &'static str {
        match self {
            Positional::UnexpectedTokenNumber => "Unexpected number",
            Positional::UnexpectedTokenString => "Unexpected string",
            Positional::UnterminatedString => "Unterminated string",
            Positional::ExpectedPropNameOrRBrace => "Expected property name or '}'",
            Positional::ExpectedCommaOrRBrack => "Expected ',' or ']' after array element",
            Positional::ExpectedCommaOrRBrace => "Expected ',' or '}' after property value",
            Positional::UnexpectedNonWhiteSpaceCharacter => {
                "Unexpected non-whitespace character after JSON"
            }
            Positional::BadEscapedCharacter => "Bad escaped character",
            Positional::BadControlCharacter => "Bad control character in string literal",
            Positional::BadUnicodeEscape => "Bad Unicode escape",
            Positional::NoNumberAfterMinusSign => "No number after minus sign",
            Positional::ExponentPartMissingNumber => "Exponent part is missing a number",
            Positional::UnterminatedFractionalNumber => "Unterminated fractional number",
            Positional::ExpectedColonAfterPropertyName => "Expected ':' after property name",
            Positional::ExpectedDoubleQuotedPropertyName => "Expected double-quoted property name",
        }
    }

    /// Whether the template reads `… in JSON at position` (all but one).
    fn in_json(self) -> bool {
        !matches!(self, Positional::UnexpectedNonWhiteSpaceCharacter)
    }
}

/// V8's `kMaxContextCharacters`.
const MAX_CONTEXT_CHARACTERS: usize = 10;
/// V8's `kMinOriginalSourceLengthForContext`.
const MIN_ORIGINAL_SOURCE_LENGTH_FOR_CONTEXT: usize = MAX_CONTEXT_CHARACTERS * 2 + 1;

/// An object or array whose members are still being parsed (V8's
/// continuation stack).
enum Frame {
    Array(Vec<JsonValue>),
    Object(IndexMap<String, JsonValue>, String),
}

struct Parser<'a> {
    text: &'a str,
    bytes: &'a [u8],
    /// The cursor, a byte offset that is always on a character boundary.
    pos: usize,
}

impl Parser<'_> {
    fn current(&self) -> Option<u8> {
        self.bytes.get(self.pos).copied()
    }

    /// `SkipWhitespace()` followed by `peek()`.
    fn skip_whitespace(&mut self) -> Token {
        while let Some(&b) = self.bytes.get(self.pos) {
            let token = token_for_byte(b);
            if token != Token::Whitespace {
                return token;
            }
            self.pos += 1;
        }
        Token::Eos
    }

    /// `Check(token)`: skips whitespace, then consumes `token` if it is next.
    fn check(&mut self, token: Token) -> bool {
        if self.skip_whitespace() == token {
            self.pos += 1;
            true
        } else {
            false
        }
    }

    /// `Expect(token, message)` right after a whitespace skip.
    fn expect(&mut self, token: Token, message: Positional) -> Result<(), JsonParseError> {
        if self.peek() == token {
            self.pos += 1;
            Ok(())
        } else {
            Err(self.positional(message))
        }
    }

    /// `ExpectNext(token, message)`.
    fn expect_next(&mut self, token: Token, message: Positional) -> Result<(), JsonParseError> {
        self.skip_whitespace();
        self.expect(token, message)
    }

    fn peek(&self) -> Token {
        self.current().map_or(Token::Eos, token_for_byte)
    }

    /// `ParseJson()` without a reviver.
    fn parse_json(mut self) -> Result<JsonValue, JsonParseError> {
        let value = self.parse_json_value()?;
        if !self.check(Token::Eos) {
            return Err(self.positional(Positional::UnexpectedNonWhiteSpaceCharacter));
        }
        Ok(value)
    }

    /// `ParseJsonValue()`, iteratively (V8's continuation stack), so deep
    /// nesting cannot overflow the Rust stack.
    fn parse_json_value(&mut self) -> Result<JsonValue, JsonParseError> {
        let mut stack: Vec<Frame> = Vec::new();
        'value: loop {
            let mut value = match self.skip_whitespace() {
                Token::Number => JsonValue::Number(self.parse_json_number()?),
                Token::String => {
                    self.pos += 1;
                    JsonValue::String(self.scan_json_string()?)
                }
                Token::TrueLiteral => {
                    self.scan_literal("true")?;
                    JsonValue::Bool(true)
                }
                Token::FalseLiteral => {
                    self.scan_literal("false")?;
                    JsonValue::Bool(false)
                }
                Token::NullLiteral => {
                    self.scan_literal("null")?;
                    JsonValue::Null
                }
                Token::LBrace => {
                    self.pos += 1;
                    if self.check(Token::RBrace) {
                        JsonValue::Object(IndexMap::new())
                    } else {
                        let key = self.scan_property_key(Positional::ExpectedPropNameOrRBrace)?;
                        stack.push(Frame::Object(IndexMap::new(), key));
                        continue 'value;
                    }
                }
                Token::LBrack => {
                    self.pos += 1;
                    if self.check(Token::RBrack) {
                        JsonValue::Array(Vec::new())
                    } else {
                        stack.push(Frame::Array(Vec::new()));
                        continue 'value;
                    }
                }
                Token::Colon
                | Token::Comma
                | Token::Illegal
                | Token::RBrace
                | Token::RBrack
                | Token::Eos
                | Token::Whitespace => return Err(self.unexpected_character()),
            };

            loop {
                match stack.last_mut() {
                    None => return Ok(value),
                    Some(Frame::Array(items)) => {
                        items.push(value);
                        if self.check(Token::Comma) {
                            continue 'value;
                        }
                        self.expect(Token::RBrack, Positional::ExpectedCommaOrRBrack)?;
                        let Some(Frame::Array(items)) = stack.pop() else {
                            unreachable!("the top frame is an array")
                        };
                        value = JsonValue::Array(items);
                    }
                    Some(Frame::Object(map, key)) => {
                        insert_js_property(map, std::mem::take(key), value);
                        if self.check(Token::Comma) {
                            *key = self
                                .scan_property_key(Positional::ExpectedDoubleQuotedPropertyName)?;
                            continue 'value;
                        }
                        self.expect(Token::RBrace, Positional::ExpectedCommaOrRBrace)?;
                        let Some(Frame::Object(map, _)) = stack.pop() else {
                            unreachable!("the top frame is an object")
                        };
                        value = JsonValue::Object(map);
                    }
                }
            }
        }
    }

    /// `ExpectNext(STRING, message)`, `ScanJsonPropertyKey()` and
    /// `ExpectNext(COLON, kJsonParseExpectedColonAfterPropertyName)`.
    fn scan_property_key(&mut self, message: Positional) -> Result<String, JsonParseError> {
        self.expect_next(Token::String, message)?;
        let key = self.scan_json_string()?;
        self.expect_next(Token::Colon, Positional::ExpectedColonAfterPropertyName)?;
        Ok(key)
    }

    /// `ScanLiteral(s)`: the cursor is on the literal's first character.
    fn scan_literal(&mut self, literal: &str) -> Result<(), JsonParseError> {
        for &expected in &literal.as_bytes()[1..] {
            self.pos += 1;
            match self.current() {
                None => return Err(self.unexpected_token(Token::Eos)),
                Some(b) if b == expected => {}
                Some(_) => return Err(self.unexpected_character()),
            }
        }
        self.pos += 1;
        Ok(())
    }

    /// `ParseJsonNumber()`: the cursor is on `-` or a digit.
    fn parse_json_number(&mut self) -> Result<f64, JsonParseError> {
        let start = self.pos;
        let mut negative = false;
        if self.current() == Some(b'-') {
            negative = true;
            self.pos += 1;
        }

        if self.current() == Some(b'0') {
            // A leading zero may only be followed by a fraction or exponent.
            self.pos += 1;
            match self.current() {
                Some(b) if is_number_part(b) => {
                    if b.is_ascii_digit() {
                        return Err(self.unexpected_token(Token::Number));
                    }
                }
                _ if !negative => return Ok(0.0),
                _ => {}
            }
        } else {
            // V8 reads up to nine digits as a small integer first.
            let smi_start = self.pos;
            let stop = (self.pos + 9).min(self.bytes.len());
            while self.pos < stop && self.bytes[self.pos].is_ascii_digit() {
                self.pos += 1;
            }
            if self.pos == smi_start {
                return Err(self.positional(Positional::NoNumberAfterMinusSign));
            }
            if !self.current().is_some_and(is_number_part) {
                return Ok(self.number_value(start));
            }
            self.advance_to_non_decimal();
        }

        if self.current() == Some(b'.') {
            self.pos += 1;
            if !self.current().is_some_and(|b| b.is_ascii_digit()) {
                return Err(self.positional(Positional::UnterminatedFractionalNumber));
            }
            self.advance_to_non_decimal();
        }

        if matches!(self.current(), Some(b'e' | b'E')) {
            self.pos += 1;
            if matches!(self.current(), Some(b'-' | b'+')) {
                self.pos += 1;
            }
            if !self.current().is_some_and(|b| b.is_ascii_digit()) {
                return Err(self.positional(Positional::ExponentPartMissingNumber));
            }
            self.advance_to_non_decimal();
        }

        Ok(self.number_value(start))
    }

    fn advance_to_non_decimal(&mut self) {
        while self.current().is_some_and(|b| b.is_ascii_digit()) {
            self.pos += 1;
        }
    }

    /// `StringToDouble` of the lexeme: Rust's parser is correctly rounded,
    /// like V8's, and overflows to infinity.
    fn number_value(&self, start: usize) -> f64 {
        self.text[start..self.pos].parse().unwrap_or(f64::NAN)
    }

    /// `ScanJsonString()`: the cursor is just past the opening quote.
    fn scan_json_string(&mut self) -> Result<String, JsonParseError> {
        let mut out = String::new();
        let mut pending_high: Option<u16> = None;
        loop {
            let Some(b) = self.current() else {
                return Err(self.positional(Positional::UnterminatedString));
            };
            match b {
                b'"' => {
                    self.pos += 1;
                    flush_high_surrogate(&mut out, &mut pending_high);
                    return Ok(out);
                }
                b'\\' => {
                    self.pos += 1;
                    // V8 reads the escaped character as a code unit: the
                    // end of input and anything above U+00FF are reported
                    // as an unexpected token, the rest of the illegal
                    // escapes as a bad escaped character.
                    let Some(escape) = self.current() else {
                        return Err(self.unexpected_token(Token::Eos));
                    };
                    if self.text[self.pos..]
                        .chars()
                        .next()
                        .is_some_and(|c| u32::from(c) > 0xFF)
                    {
                        return Err(self.unexpected_token(Token::Illegal));
                    }
                    let decoded = match escape {
                        b'"' => '"',
                        b'\\' => '\\',
                        b'/' => '/',
                        b'b' => '\u{8}',
                        b'f' => '\u{c}',
                        b'n' => '\n',
                        b'r' => '\r',
                        b't' => '\t',
                        b'u' => {
                            let unit = self.scan_unicode_character()?;
                            push_code_unit(&mut out, &mut pending_high, unit);
                            self.pos += 1;
                            continue;
                        }
                        _ => return Err(self.positional(Positional::BadEscapedCharacter)),
                    };
                    flush_high_surrogate(&mut out, &mut pending_high);
                    out.push(decoded);
                    self.pos += 1;
                }
                0..0x20 => return Err(self.positional(Positional::BadControlCharacter)),
                _ => {
                    let run_start = self.pos;
                    while self
                        .current()
                        .is_some_and(|b| b >= 0x20 && b != b'"' && b != b'\\')
                    {
                        self.pos += 1;
                    }
                    flush_high_surrogate(&mut out, &mut pending_high);
                    out.push_str(&self.text[run_start..self.pos]);
                }
            }
        }
    }

    /// `ScanUnicodeCharacter()`: the cursor is on the `u` of `\u` and ends
    /// on the last hex digit.
    fn scan_unicode_character(&mut self) -> Result<u16, JsonParseError> {
        let mut value: u16 = 0;
        for _ in 0..4 {
            self.pos += 1;
            let Some(digit) = self.current().and_then(|b| char::from(b).to_digit(16)) else {
                return Err(self.positional(Positional::BadUnicodeEscape));
            };
            value = value * 16 + digit as u16;
        }
        Ok(value)
    }

    /// `ReportUnexpectedCharacter(CurrentCharacter())`.
    fn unexpected_character(&self) -> JsonParseError {
        self.unexpected_token(self.peek())
    }

    /// `ReportUnexpectedToken(token)` without an explicit message:
    /// `LookUpErrorMessageForJsonToken`.
    fn unexpected_token(&self, token: Token) -> JsonParseError {
        match token {
            Token::Eos => JsonParseError {
                message: "Unexpected end of JSON input".to_owned(),
            },
            Token::Number => self.positional(Positional::UnexpectedTokenNumber),
            Token::String => self.positional(Positional::UnexpectedTokenString),
            _ => {
                let message = if is_special_string(self.text) {
                    format!("\"{}\" is not valid JSON", self.text)
                } else {
                    self.unexpected_token_with_context()
                };
                JsonParseError { message }
            }
        }
    }

    /// The `Unexpected token '…', "…" is not valid JSON` family: a source
    /// shorter than 21 code units is quoted whole, a longer one up to ten
    /// code units on either side of the error.
    fn unexpected_token_with_context(&self) -> String {
        let units: Vec<u16> = self.text.encode_utf16().collect();
        let pos = self.utf16_position();
        let token = String::from_utf16_lossy(&units[pos..=pos]);
        let length = units.len();
        if length < MIN_ORIGINAL_SOURCE_LENGTH_FOR_CONTEXT {
            return format!(
                "Unexpected token '{token}', \"{}\" is not valid JSON",
                self.text
            );
        }
        let excerpt = |start: usize, end: usize| String::from_utf16_lossy(&units[start..end]);
        if pos < MAX_CONTEXT_CHARACTERS {
            let end = (pos + MAX_CONTEXT_CHARACTERS).min(length);
            format!(
                "Unexpected token '{token}', \"{}\"... is not valid JSON",
                excerpt(0, end)
            )
        } else if pos < length - MAX_CONTEXT_CHARACTERS {
            format!(
                "Unexpected token '{token}', ...\"{}\"... is not valid JSON",
                excerpt(pos - MAX_CONTEXT_CHARACTERS, pos + MAX_CONTEXT_CHARACTERS)
            )
        } else {
            format!(
                "Unexpected token '{token}', ...\"{}\" is not valid JSON",
                excerpt(pos - MAX_CONTEXT_CHARACTERS, length)
            )
        }
    }

    /// A positional message: `… in JSON at position P (line L column C)`.
    fn positional(&self, message: Positional) -> JsonParseError {
        let (line, column) = self.line_and_column();
        let in_json = if message.in_json() { " in JSON" } else { "" };
        JsonParseError {
            message: format!(
                "{}{in_json} at position {} (line {line} column {column})",
                message.text(),
                self.utf16_position()
            ),
        }
    }

    /// The cursor as a UTF-16 offset.
    fn utf16_position(&self) -> usize {
        self.text[..self.pos].encode_utf16().count()
    }

    /// `CalculateFileLocation`: `\r\n`, `\r` and `\n` each end a line; the
    /// column counts UTF-16 code units from 1.
    fn line_and_column(&self) -> (usize, usize) {
        let end = self.pos;
        let mut line = 1;
        let mut last_line_break = 0;
        let mut i = 0;
        while i < end {
            if self.bytes[i] == b'\r' && i + 1 < end && self.bytes[i + 1] == b'\n' {
                i += 1;
            }
            if matches!(self.bytes[i], b'\r' | b'\n') {
                line += 1;
                last_line_break = i + 1;
            }
            i += 1;
        }
        let column = 1 + self.text[last_line_break..end].encode_utf16().count();
        (line, column)
    }
}

/// `IsSpecialString()`: the whole source is what `JSON.parse` receives for
/// `undefined`, `NaN`, `Infinity` or a plain object.
fn is_special_string(text: &str) -> bool {
    matches!(text, "[object Object]" | "undefined" | "Infinity" | "NaN")
}

/// Appends one UTF-16 code unit from a `\u` escape, pairing surrogates;
/// an unpaired surrogate becomes U+FFFD.
fn push_code_unit(out: &mut String, pending_high: &mut Option<u16>, unit: u16) {
    match unit {
        0xD800..=0xDBFF => {
            flush_high_surrogate(out, pending_high);
            *pending_high = Some(unit);
        }
        0xDC00..=0xDFFF => match pending_high.take() {
            Some(high) => {
                let code_point =
                    0x10000 + ((u32::from(high) - 0xD800) << 10) + (u32::from(unit) - 0xDC00);
                out.push(char::from_u32(code_point).unwrap_or('\u{FFFD}'));
            }
            None => out.push('\u{FFFD}'),
        },
        _ => {
            flush_high_surrogate(out, pending_high);
            out.push(char::from_u32(u32::from(unit)).unwrap_or('\u{FFFD}'));
        }
    }
}

fn flush_high_surrogate(out: &mut String, pending_high: &mut Option<u16>) {
    if pending_high.take().is_some() {
        out.push('\u{FFFD}');
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::json::{JsonValue, stringify};

    fn ok(text: &str) -> String {
        stringify(&parse(text).unwrap(), None)
    }

    fn err(text: &str) -> String {
        parse(text).unwrap_err().message().to_owned()
    }

    #[test]
    fn values_and_key_order() {
        assert_eq!(
            ok(" [1, -0, 1.5e3, \"a\\u00e9\\ud83d\\ude00\"] "),
            "[1,0,1500,\"aé😀\"]"
        );
        assert_eq!(
            ok(r#"{"b":1,"2":2,"a":3,"1":4,"01":5,"4294967295":6,"b":7}"#),
            r#"{"1":4,"2":2,"b":7,"a":3,"01":5,"4294967295":6}"#
        );
        assert_eq!(ok(r#"{"__proto__":1}"#), r#"{"__proto__":1}"#);
        assert_eq!(ok("1e400"), "null");
        assert_eq!(ok("\"\\ud800x\""), "\"\u{FFFD}x\"");
    }

    // Port of the strict-JSON case of test/unit/parse-json.test.ts (its BOM
    // and YAML cases are `parseJSON`'s, not `JSON.parse`'s).
    #[test]
    fn parses_strict_json() {
        let JsonValue::Object(map) = parse(r#"{"name":"quicktype","count":2}"#).unwrap() else {
            panic!("an object")
        };
        assert_eq!(map["name"], JsonValue::String("quicktype".to_owned()));
        assert_eq!(map["count"], JsonValue::Number(2.0));
        assert_eq!(map.len(), 2);
    }

    #[test]
    fn error_messages() {
        assert_eq!(err(""), "Unexpected end of JSON input");
        assert_eq!(err("[1,"), "Unexpected end of JSON input");
        assert_eq!(err("tru"), "Unexpected end of JSON input");
        assert_eq!(err("x"), "Unexpected token 'x', \"x\" is not valid JSON");
        assert_eq!(err("NaN"), "\"NaN\" is not valid JSON");
        assert_eq!(
            err("[1,]"),
            "Unexpected token ']', \"[1,]\" is not valid JSON"
        );
        assert_eq!(
            err("{\"a\":1,}"),
            "Expected double-quoted property name in JSON at position 7 (line 1 column 8)"
        );
        assert_eq!(
            err("{"),
            "Expected property name or '}' in JSON at position 1 (line 1 column 2)"
        );
        assert_eq!(
            err("{\"a\" 1}"),
            "Expected ':' after property name in JSON at position 5 (line 1 column 6)"
        );
        assert_eq!(
            err("01"),
            "Unexpected number in JSON at position 1 (line 1 column 2)"
        );
        assert_eq!(
            err("1 2"),
            "Unexpected non-whitespace character after JSON at position 2 (line 1 column 3)"
        );
        assert_eq!(
            err("\"abc"),
            "Unterminated string in JSON at position 4 (line 1 column 5)"
        );
        assert_eq!(
            err("[\r\n1,\n\"\\x\"]"),
            "Bad escaped character in JSON at position 8 (line 3 column 3)"
        );
        assert_eq!(
            err("[1\r\n\r2]"),
            "Expected ',' or ']' after array element in JSON at position 5 (line 3 column 1)"
        );
        assert_eq!(err("\"ab\\"), "Unexpected end of JSON input");
        assert_eq!(
            err("\"\\€\""),
            "Unexpected token '€', \"\"\\€\"\" is not valid JSON"
        );
        assert_eq!(
            err("[1, 2, 3, 4, 5, 6, 7, x]"),
            "Unexpected token 'x', ...\" 5, 6, 7, x]\" is not valid JSON"
        );
        assert_eq!(
            err("[1, 2, 3, 4, 5, 6, 7, 8, 😀]"),
            "Unexpected token '\u{FFFD}', ...\" 6, 7, 8, 😀]\" is not valid JSON"
        );
    }
}
