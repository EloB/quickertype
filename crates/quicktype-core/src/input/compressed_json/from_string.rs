//! `CompressedJSONFromString.parseSync(input)`: `JSON.parse(input)`, then
//! `process` the value in `Object.getOwnPropertyNames` order, without
//! building the value.
//!
//! The text is read in two passes:
//!
//! 1. **Record.** The text is validated against V8's JSON grammar and
//!    recorded as a *tape*: one node per value and per key, in source
//!    order. A string node points into the text (or, if it has escapes,
//!    into a buffer of decoded strings), a number node is already
//!    classified (`parsedNumberIsDouble`), a key node holds the key
//!    interned, and an object or array node knows where its content ends.
//!    Nothing is committed in this pass, so a syntax error leaves the
//!    compressed form as it was (only keys have been interned, which no
//!    value refers to).
//! 2. **Commit.** The tape is replayed into the builder, as `process` walks
//!    the value `JSON.parse` returns: an object's members in JavaScript
//!    own-property order, which is source order unless the object has a
//!    duplicate key or an array-index key out of ascending order before
//!    the other keys. Such *reordered* objects are recognized in the first
//!    pass; for them the second pass orders the members as
//!    [`insert_js_property`](quicktype_js_compat::json::insert_js_property)
//!    would (array-index keys first, ascending; then the others where they
//!    first appeared; a repeated key takes its last value), and the values
//!    a later duplicate replaced are never committed, as in TypeScript.
//!
//! On a syntax error, the message is that of
//! [`quicktype_js_compat::json::parse`], the port of V8's parser. Should
//! that parser accept a text this reader rejects, the value it returns is
//! processed instead: the grammar is V8's either way.
//!
//! Duplicate keys are found without a set per object: every interned
//! string has a *stamp*, the serial number of the last object that had it
//! as a key, and objects are numbered as they open. A key whose stamp is
//! the object's own serial is a duplicate; one with a smaller stamp is new
//! to the object (an object that started earlier and is still open cannot
//! add keys while this one is open); one with a larger stamp was used by a
//! nested object in between, and only then are the object's earlier keys
//! compared. `"__proto__"`, which is interned anew every time, is tracked
//! per object.

use quicktype_js_compat::json::{self as js_json, is_array_index};

use super::{CompressedJson, ParseError, Value};
use crate::messages::{JsErrorName, JsException, QuickTypeError, Result};
use crate::support::fast_hash::HashMap;

/// Limits on what [`CompressedJson::read_string_sample`] reads; a sample
/// beyond them is not read at all ([`ReadStringError::Declined`]).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct StringSampleLimits {
    /// The deepest nesting of objects and arrays read (a top-level `[]` is
    /// at depth 1); `None` for no limit.
    pub max_depth: Option<usize>,
    /// Whether `\u` escapes that leave a UTF-16 surrogate unpaired are read
    /// (as U+FFFD, which a Rust string has in place of the lone surrogate a
    /// JavaScript string would hold).
    pub lone_surrogates: bool,
}

impl Default for StringSampleLimits {
    /// No limits: what [`CompressedJson::parse_string`] reads.
    fn default() -> Self {
        StringSampleLimits {
            max_depth: None,
            lone_surrogates: true,
        }
    }
}

/// Why [`CompressedJson::read_string_sample`] did not return a value.
#[derive(Clone, Debug, PartialEq)]
pub enum ReadStringError {
    /// The sample could not be read, as with
    /// [`parse_string`](CompressedJson::parse_string). For a syntax error,
    /// nothing was committed.
    Parse(ParseError),
    /// The sample is beyond the [`StringSampleLimits`]; nothing was
    /// committed.
    Declined(Decline),
}

/// Which of the [`StringSampleLimits`] a sample exceeds.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Decline {
    /// Nested deeper than `max_depth`.
    TooDeep,
    /// A `\u` escape leaves a surrogate unpaired.
    LoneSurrogate,
}

/// What the reader keeps between samples: the key stamps (see the module
/// documentation) and buffers worth reusing.
#[derive(Debug, Default)]
pub(super) struct StringReaderState {
    /// By string index: the serial of the last object with that key.
    stamps: Vec<u32>,
    /// The serial of the last object opened.
    serial: u32,
    /// The tape of the last sample, emptied, if it was small.
    spare_nodes: Vec<Node>,
    /// By position in an object: the string index of the last key read
    /// there. Objects of one shape (an array of records) have the same key
    /// at the same position, which is then found without hashing it.
    key_cache: Vec<u32>,
}

/// How many positions [`StringReaderState::key_cache`] remembers keys at.
const KEY_CACHE: usize = 64;

/// Tapes up to this many nodes are kept for the next sample.
const SPARE_NODES: usize = 1 << 16;

impl StringReaderState {
    /// Numbers objects from 1 again if a sample of `len` bytes (at most
    /// `len / 2` objects) could run out of serials.
    fn reserve_serials(&mut self, len: usize) {
        if u64::from(self.serial) + len as u64 / 2 + 1 >= u64::from(u32::MAX) {
            self.stamps.fill(0);
            self.serial = 0;
        }
    }

    fn next_serial(&mut self) -> u32 {
        self.serial += 1;
        self.serial
    }

    /// Stamps `key` with `serial` and returns its previous stamp.
    fn stamp(&mut self, key: u32, serial: u32) -> u32 {
        let index = key as usize;
        if index >= self.stamps.len() {
            self.stamps.resize(index + 1, 0);
        }
        std::mem::replace(&mut self.stamps[index], serial)
    }
}

/// What a tape node is.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
enum Kind {
    Null,
    False,
    True,
    /// A number inferred as `integer`.
    Integer,
    /// A number inferred as `double`.
    Double,
    /// A string without escapes: `a..a + b` in the text.
    Text,
    /// A string with escapes, decoded: `a..a + b` in the decoded buffer.
    Decoded,
    /// An object key, interned as string `a`.
    Key,
    /// An object; its content (keys and values) ends before node `a`; `b`
    /// is 1 if it is reordered.
    Object,
    /// An array; its elements end before node `a`.
    Array,
}

#[derive(Clone, Copy, Debug)]
struct Node {
    kind: Kind,
    a: u32,
    b: u32,
}

/// Why the first pass stopped.
enum Stop {
    Syntax,
    Declined(Decline),
}

/// An object whose members are being recorded.
struct OpenObject {
    /// Its [`Kind::Object`] node.
    node: usize,
    serial: u32,
    has_proto: bool,
    /// The last array-index key, if all keys so far are ascending array
    /// indexes.
    last_index: Option<u32>,
    /// Whether a key that is not an array index has been seen.
    has_name: bool,
    reordered: bool,
    /// How many members it has so far.
    members: usize,
}

enum Open {
    Array(usize),
    Object(OpenObject),
}

/// Whether reading a string stops at this byte: `"`, `\` or a control
/// character (which `JSON.parse` rejects).
const STRING_STOP: [bool; 256] = {
    let mut table = [false; 256];
    let mut b = 0;
    while b < 0x20 {
        table[b] = true;
        b += 1;
    }
    table[b'"' as usize] = true;
    table[b'\\' as usize] = true;
    table
};

/// `internString(key)` for the key at member position `position`: the key
/// read last at that position, if it is the same text, else interned (and
/// remembered there).
fn intern_key(cjson: &mut CompressedJson, position: usize, key: &str) -> u32 {
    // "__proto__" is interned anew every time.
    if key == "__proto__" {
        return cjson.strings.intern(key);
    }
    let cached = cjson.string_reader.key_cache.get(position).copied();
    if let Some(index) = cached
        && cjson.strings.get(index as usize) == Some(key)
    {
        return index;
    }
    let index = cjson.strings.intern(key);
    let cache = &mut cjson.string_reader.key_cache;
    if position < KEY_CACHE {
        if position >= cache.len() {
            cache.resize(position + 1, u32::MAX);
        }
        cache[position] = index;
    }
    index
}

/// Whether a byte of `word` is `"`, `\\` or a control character.
fn has_string_stop(word: u64) -> bool {
    const ONES: u64 = u64::from_ne_bytes([1; 8]);
    const HIGH: u64 = ONES << 7;
    // A byte below `n` (for `n` at most 0x80), and a zero byte.
    let below = |v: u64, n: u8| v.wrapping_sub(ONES * u64::from(n)) & !v & HIGH;
    let zero = |v: u64| below(v, 1);
    (zero(word ^ (ONES * u64::from(b'"')))
        | zero(word ^ (ONES * u64::from(b'\\')))
        | below(word, 0x20))
        != 0
}

/// Where the run of string characters from `pos` ends: the first byte
/// that is `"`, `\\` or a control character, or the end; eight bytes at a
/// time.
fn plain_run(bytes: &[u8], mut pos: usize) -> usize {
    while let Some(chunk) = bytes.get(pos..pos + 8) {
        let Ok(chunk) = <[u8; 8]>::try_from(chunk) else {
            break;
        };
        if has_string_stop(u64::from_le_bytes(chunk)) {
            break;
        }
        pos += 8;
    }
    while bytes.get(pos).is_some_and(|&b| !STRING_STOP[b as usize]) {
        pos += 1;
    }
    pos
}

/// The first pass over one sample.
struct Recorder<'t> {
    text: &'t str,
    bytes: &'t [u8],
    pos: usize,
    nodes: Vec<Node>,
    /// The decoded strings with escapes, back to back.
    decoded: String,
    /// The current key, if it has escapes.
    key: String,
    limits: StringSampleLimits,
    /// Whether every integer of at most 15 digits fits the integer range,
    /// so that their literals need not be compared to it.
    small_integers_fit: bool,
}

/// Whether `s` is an ASCII integer literal (an optional `-`, digits).
fn is_plain_integer(s: &str) -> bool {
    let digits = s.strip_prefix('-').unwrap_or(s);
    !digits.is_empty() && digits.bytes().all(|b| b.is_ascii_digit())
}

/// A key that is an array index, as a number.
fn array_index(key: &str) -> Option<u32> {
    if is_array_index(key) {
        key.parse().ok()
    } else {
        None
    }
}

impl<'t> Recorder<'t> {
    fn new(cjson: &mut CompressedJson, text: &'t str, limits: StringSampleLimits) -> Self {
        let small_integers_fit = match &cjson.supported_integer_range {
            None => true,
            Some(range) => {
                is_plain_integer(range.min())
                    && is_plain_integer(range.max())
                    && cjson.integer_string_fits("-999999999999999")
                    && cjson.integer_string_fits("999999999999999")
            }
        };
        Recorder {
            text,
            bytes: text.as_bytes(),
            pos: 0,
            nodes: std::mem::take(&mut cjson.string_reader.spare_nodes),
            decoded: String::new(),
            key: String::new(),
            limits,
            small_integers_fit,
        }
    }

    fn push(&mut self, kind: Kind, a: u32, b: u32) -> usize {
        self.nodes.push(Node { kind, a, b });
        self.nodes.len() - 1
    }

    /// Skips JSON whitespace and returns the next byte.
    fn next_token(&mut self) -> Option<u8> {
        while let Some(&b) = self.bytes.get(self.pos) {
            if !matches!(b, b' ' | b'\t' | b'\n' | b'\r') {
                return Some(b);
            }
            self.pos += 1;
        }
        None
    }

    /// Ends the container whose node is `node` here.
    fn close(&mut self, node: usize, reordered: bool) {
        let end = self.nodes.len() as u32;
        let n = &mut self.nodes[node];
        n.a = end;
        n.b = u32::from(reordered);
    }

    /// Opens a container one level deeper than `depth` containers.
    fn deeper(&self, depth: usize) -> Result<(), Stop> {
        match self.limits.max_depth {
            Some(max) if depth + 1 > max => Err(Stop::Declined(Decline::TooDeep)),
            _ => Ok(()),
        }
    }

    /// Records the sample.
    fn record(&mut self, cjson: &mut CompressedJson) -> Result<(), Stop> {
        let mut stack: Vec<Open> = Vec::new();
        'value: loop {
            match self.next_token() {
                Some(b'{') => {
                    self.deeper(stack.len())?;
                    self.pos += 1;
                    let node = self.push(Kind::Object, 0, 0);
                    if self.next_token() == Some(b'}') {
                        self.pos += 1;
                        self.close(node, false);
                    } else {
                        let mut object = OpenObject {
                            node,
                            serial: cjson.string_reader.next_serial(),
                            has_proto: false,
                            last_index: None,
                            has_name: false,
                            reordered: false,
                            members: 0,
                        };
                        self.member_key(cjson, &mut object)?;
                        stack.push(Open::Object(object));
                        continue 'value;
                    }
                }
                Some(b'[') => {
                    self.deeper(stack.len())?;
                    self.pos += 1;
                    let node = self.push(Kind::Array, 0, 0);
                    if self.next_token() == Some(b']') {
                        self.pos += 1;
                        self.close(node, false);
                    } else {
                        stack.push(Open::Array(node));
                        continue 'value;
                    }
                }
                Some(b'"') => {
                    self.pos += 1;
                    let start = self.decoded.len();
                    match self.string(false)? {
                        Some((a, b)) => self.push(Kind::Text, a, b),
                        None => {
                            let len = self.decoded.len() - start;
                            self.push(Kind::Decoded, start as u32, len as u32)
                        }
                    };
                }
                Some(b'-' | b'0'..=b'9') => {
                    let kind = self.number(cjson)?;
                    self.push(kind, 0, 0);
                }
                Some(b't') => self.literal(b"true", Kind::True)?,
                Some(b'f') => self.literal(b"false", Kind::False)?,
                Some(b'n') => self.literal(b"null", Kind::Null)?,
                _ => return Err(Stop::Syntax),
            }

            // After a value.
            loop {
                match stack.last_mut() {
                    None => {
                        return match self.next_token() {
                            None => Ok(()),
                            Some(_) => Err(Stop::Syntax),
                        };
                    }
                    Some(Open::Array(node)) => {
                        let node = *node;
                        match self.next_token() {
                            Some(b',') => {
                                self.pos += 1;
                                continue 'value;
                            }
                            Some(b']') => {
                                self.pos += 1;
                                stack.pop();
                                self.close(node, false);
                            }
                            _ => return Err(Stop::Syntax),
                        }
                    }
                    Some(Open::Object(object)) => match self.next_token() {
                        Some(b',') => {
                            self.pos += 1;
                            self.member_key(cjson, object)?;
                            continue 'value;
                        }
                        Some(b'}') => {
                            self.pos += 1;
                            let (node, reordered) = (object.node, object.reordered);
                            stack.pop();
                            self.close(node, reordered);
                        }
                        _ => return Err(Stop::Syntax),
                    },
                }
            }
        }
    }

    /// A member's key and the `:` after it; whitespace before the key has
    /// not been skipped yet.
    fn member_key(
        &mut self,
        cjson: &mut CompressedJson,
        object: &mut OpenObject,
    ) -> Result<(), Stop> {
        if self.next_token() != Some(b'"') {
            return Err(Stop::Syntax);
        }
        self.pos += 1;
        self.key.clear();
        let index = match self.string(true)? {
            Some((a, b)) => {
                let key = &self.text[a as usize..(a + b) as usize];
                self.check_key(cjson, object, key)
            }
            None => {
                let key = std::mem::take(&mut self.key);
                let index = self.check_key(cjson, object, &key);
                self.key = key;
                index
            }
        };
        self.push(Kind::Key, index, 0);
        if self.next_token() != Some(b':') {
            return Err(Stop::Syntax);
        }
        self.pos += 1;
        Ok(())
    }

    /// Interns `key` and notes whether it makes `object` reordered.
    fn check_key(&self, cjson: &mut CompressedJson, object: &mut OpenObject, key: &str) -> u32 {
        let index = intern_key(cjson, object.members, key);
        object.members += 1;
        if object.reordered {
            return index;
        }
        if key == "__proto__" {
            object.reordered = object.has_proto;
            object.has_proto = true;
        } else {
            let stamp = cjson.string_reader.stamp(index, object.serial);
            object.reordered = stamp == object.serial
                || (stamp > object.serial && self.has_key(object.node, index));
        }
        if !object.reordered {
            match key.as_bytes().first() {
                Some(b'0'..=b'9') => match array_index(key) {
                    Some(n) => {
                        object.reordered =
                            object.has_name || object.last_index.is_some_and(|last| n <= last);
                        object.last_index = Some(n);
                    }
                    None => object.has_name = true,
                },
                _ => object.has_name = true,
            }
        }
        index
    }

    /// Whether the object at `node`, still being recorded, has the key
    /// `index` already.
    fn has_key(&self, node: usize, index: u32) -> bool {
        let mut i = node + 1;
        while i < self.nodes.len() {
            if self.nodes[i].a == index {
                return true;
            }
            // Past the key and its value.
            i = match self.nodes.get(i + 1) {
                Some(Node {
                    kind: Kind::Object | Kind::Array,
                    a,
                    ..
                }) => *a as usize,
                _ => i + 2,
            };
        }
        false
    }

    /// `ScanJsonString()`: the cursor is just past the opening quote. A
    /// string without escapes is returned as its range in the text; one
    /// with escapes is decoded into the key buffer (`key`) or the decoded
    /// buffer, and `None` is returned.
    fn string(&mut self, key: bool) -> Result<Option<(u32, u32)>, Stop> {
        let start = self.pos;
        self.pos = plain_run(self.bytes, self.pos);
        {
            let Some(&b) = self.bytes.get(self.pos) else {
                return Err(Stop::Syntax);
            };
            match b {
                b'"' => {
                    let range = (start as u32, (self.pos - start) as u32);
                    self.pos += 1;
                    Ok(Some(range))
                }
                b'\\' => {
                    let mut out = if key {
                        std::mem::take(&mut self.key)
                    } else {
                        std::mem::take(&mut self.decoded)
                    };
                    out.push_str(&self.text[start..self.pos]);
                    let result = self.escaped(&mut out);
                    if key {
                        self.key = out;
                    } else {
                        self.decoded = out;
                    }
                    result.map(|()| None)
                }
                _ => Err(Stop::Syntax),
            }
        }
    }

    /// The rest of a string with escapes, decoded into `out`; the cursor is
    /// on a backslash.
    fn escaped(&mut self, out: &mut String) -> Result<(), Stop> {
        let mut pending_high: Option<u16> = None;
        loop {
            let Some(&b) = self.bytes.get(self.pos) else {
                return Err(Stop::Syntax);
            };
            match b {
                b'"' => {
                    self.pos += 1;
                    return self.flush_high(out, &mut pending_high);
                }
                b'\\' => {
                    self.pos += 1;
                    let decoded = match self.bytes.get(self.pos) {
                        Some(b'"') => '"',
                        Some(b'\\') => '\\',
                        Some(b'/') => '/',
                        Some(b'b') => '\u{8}',
                        Some(b'f') => '\u{c}',
                        Some(b'n') => '\n',
                        Some(b'r') => '\r',
                        Some(b't') => '\t',
                        Some(b'u') => {
                            let unit = self.unicode_escape()?;
                            self.code_unit(out, &mut pending_high, unit)?;
                            continue;
                        }
                        _ => return Err(Stop::Syntax),
                    };
                    self.pos += 1;
                    self.flush_high(out, &mut pending_high)?;
                    out.push(decoded);
                }
                _ if b < 0x20 => return Err(Stop::Syntax),
                _ => {
                    let run = self.pos;
                    self.pos = plain_run(self.bytes, self.pos);
                    self.flush_high(out, &mut pending_high)?;
                    out.push_str(&self.text[run..self.pos]);
                }
            }
        }
    }

    /// The code unit of a `\uXXXX` escape; the cursor is on the `u` and
    /// ends past the last digit.
    fn unicode_escape(&mut self) -> Result<u16, Stop> {
        let digits = self
            .bytes
            .get(self.pos + 1..self.pos + 5)
            .ok_or(Stop::Syntax)?;
        let mut unit: u16 = 0;
        for &d in digits {
            let digit = char::from(d).to_digit(16).ok_or(Stop::Syntax)?;
            unit = unit * 16 + digit as u16;
        }
        self.pos += 5;
        Ok(unit)
    }

    /// Appends a code unit from a `\u` escape, pairing surrogates.
    fn code_unit(
        &self,
        out: &mut String,
        pending_high: &mut Option<u16>,
        unit: u16,
    ) -> Result<(), Stop> {
        match unit {
            0xD800..=0xDBFF => {
                self.flush_high(out, pending_high)?;
                *pending_high = Some(unit);
            }
            0xDC00..=0xDFFF => match pending_high.take() {
                Some(high) => {
                    let code_point =
                        0x10000 + ((u32::from(high) - 0xD800) << 10) + (u32::from(unit) - 0xDC00);
                    out.push(char::from_u32(code_point).unwrap_or('\u{FFFD}'));
                }
                None => self.lone_surrogate(out)?,
            },
            _ => {
                self.flush_high(out, pending_high)?;
                out.push(char::from_u32(u32::from(unit)).unwrap_or('\u{FFFD}'));
            }
        }
        Ok(())
    }

    /// A high surrogate not followed by a low one is a lone surrogate.
    fn flush_high(&self, out: &mut String, pending_high: &mut Option<u16>) -> Result<(), Stop> {
        if pending_high.take().is_some() {
            self.lone_surrogate(out)?;
        }
        Ok(())
    }

    fn lone_surrogate(&self, out: &mut String) -> Result<(), Stop> {
        if !self.limits.lone_surrogates {
            return Err(Stop::Declined(Decline::LoneSurrogate));
        }
        out.push('\u{FFFD}');
        Ok(())
    }

    /// `ScanLiteral`: the cursor is on the literal's first byte.
    fn literal(&mut self, literal: &[u8], kind: Kind) -> Result<(), Stop> {
        if self.bytes.get(self.pos..self.pos + literal.len()) != Some(literal) {
            return Err(Stop::Syntax);
        }
        self.pos += literal.len();
        self.push(kind, 0, 0);
        Ok(())
    }

    /// `ParseJsonNumber()` and `parsedNumberIsDouble` of the result: the
    /// cursor is on `-` or a digit.
    fn number(&mut self, cjson: &CompressedJson) -> Result<Kind, Stop> {
        let (text, bytes) = (self.text, self.bytes);
        let digit = |pos: usize| bytes.get(pos).is_some_and(u8::is_ascii_digit);
        let start = self.pos;
        let mut pos = start;
        if bytes[pos] == b'-' {
            pos += 1;
        }
        let digits_start = pos;
        match bytes.get(pos) {
            Some(b'0') => pos += 1,
            Some(b'1'..=b'9') => {
                while digit(pos) {
                    pos += 1;
                }
            }
            _ => return Err(Stop::Syntax),
        }
        let digits = pos - digits_start;
        let mut plain = true;
        if bytes.get(pos) == Some(&b'.') {
            pos += 1;
            if !digit(pos) {
                return Err(Stop::Syntax);
            }
            while digit(pos) {
                pos += 1;
            }
            plain = false;
        }
        if matches!(bytes.get(pos), Some(b'e' | b'E')) {
            pos += 1;
            if matches!(bytes.get(pos), Some(b'+' | b'-')) {
                pos += 1;
            }
            if !digit(pos) {
                return Err(Stop::Syntax);
            }
            while digit(pos) {
                pos += 1;
            }
            plain = false;
        }
        self.pos = pos;
        let literal = &text[start..pos];
        let is_double = if plain && digits <= 15 {
            // An integer below 1e15 is exact as a double, and its literal
            // (JSON has no leading zeros; `-0` compares as zero) is what
            // `toFixed(0)` gives.
            !(self.small_integers_fit || cjson.integer_string_fits(literal))
        } else {
            // Correctly rounded like V8's `StringToDouble`; `1e400` is ∞.
            let n: f64 = literal.parse().map_err(|_| Stop::Syntax)?;
            cjson.parsed_number_is_double(n)
        };
        Ok(if is_double {
            Kind::Double
        } else {
            Kind::Integer
        })
    }
}

/// Walks the tape of a recorded sample.
struct Tape<'t> {
    text: &'t str,
    nodes: &'t [Node],
    decoded: &'t str,
}

/// A container being committed.
enum Frame {
    /// An array, or an object in source order: the next node and the end.
    InOrder {
        next: usize,
        end: usize,
        object: bool,
    },
    /// A reordered object: its members (key, value node) in JavaScript
    /// order, and the next one.
    Reordered {
        members: Vec<(u32, usize)>,
        next: usize,
    },
}

impl Tape<'_> {
    /// The node after the value at `at`.
    fn after(&self, at: usize) -> usize {
        match self.nodes[at] {
            Node {
                kind: Kind::Object | Kind::Array,
                a,
                ..
            } => a as usize,
            _ => at + 1,
        }
    }

    /// The members of the reordered object at `node` in own-property order:
    /// array-index keys ascending, then the other keys where they first
    /// appeared, each with its last value (`CreateDataProperty` for each
    /// member in source order).
    fn js_order(&self, cjson: &CompressedJson, node: usize) -> Result<Vec<(u32, usize)>> {
        let end = self.nodes[node].a as usize;
        let mut members: Vec<(Option<u32>, u32, usize)> = Vec::new();
        let mut positions: HashMap<&str, usize> = HashMap::default();
        let mut i = node + 1;
        while i < end {
            let key = self.nodes[i].a;
            let value = i + 1;
            i = self.after(value);
            let text = cjson.string_at(key)?;
            match positions.get(text) {
                Some(&position) => members[position].2 = value,
                None => {
                    positions.insert(text, members.len());
                    members.push((array_index(text), key, value));
                }
            }
        }
        // Stable: the other keys keep their order.
        members.sort_by_key(|&(index, _, _)| match index {
            Some(n) => (0, n),
            None => (1, 0),
        });
        Ok(members
            .into_iter()
            .map(|(_, key, value)| (key, value))
            .collect())
    }

    /// Commits the sample, as `process(json)` and `finish()` do.
    fn commit(&self, cjson: &mut CompressedJson) -> Result<Value> {
        let mut frames: Vec<Frame> = Vec::new();
        let mut at = 0;
        loop {
            let node = self.nodes[at];
            match node.kind {
                Kind::Null => cjson.commit_null()?,
                Kind::False => cjson.commit_boolean(false)?,
                Kind::True => cjson.commit_boolean(true)?,
                Kind::Integer => cjson.commit_number(false)?,
                Kind::Double => cjson.commit_number(true)?,
                Kind::Text => {
                    cjson.commit_string(&self.text[node.a as usize..(node.a + node.b) as usize])?
                }
                Kind::Decoded => cjson
                    .commit_string(&self.decoded[node.a as usize..(node.a + node.b) as usize])?,
                Kind::Object => {
                    cjson.push_object_context();
                    frames.push(if node.b != 0 {
                        Frame::Reordered {
                            members: self.js_order(cjson, at)?,
                            next: 0,
                        }
                    } else {
                        Frame::InOrder {
                            next: at + 1,
                            end: node.a as usize,
                            object: true,
                        }
                    });
                }
                Kind::Array => {
                    cjson.push_array_context();
                    frames.push(Frame::InOrder {
                        next: at + 1,
                        end: node.a as usize,
                        object: false,
                    });
                }
                Kind::Key => return Err(QuickTypeError::internal("A key where a value should be")),
            }

            // The next value to commit.
            loop {
                let Some(frame) = frames.last_mut() else {
                    return cjson.finish();
                };
                match frame {
                    Frame::InOrder { next, end, object } => {
                        if *next == *end {
                            let object = *object;
                            frames.pop();
                            if object {
                                cjson.finish_object()?;
                            } else {
                                cjson.finish_array()?;
                            }
                            continue;
                        }
                        if *object {
                            cjson.set_property_key_index(self.nodes[*next].a)?;
                            *next += 1;
                        }
                        at = *next;
                        *next = self.after(at);
                        break;
                    }
                    Frame::Reordered { members, next } => {
                        let Some(&(key, value)) = members.get(*next) else {
                            frames.pop();
                            cjson.finish_object()?;
                            continue;
                        };
                        *next += 1;
                        cjson.set_property_key_index(key)?;
                        at = value;
                        break;
                    }
                }
            }
        }
    }
}

impl CompressedJson {
    /// [`parse_string`](Self::parse_string) within `limits`.
    pub fn read_string_sample(
        &mut self,
        text: &str,
        limits: StringSampleLimits,
    ) -> Result<Value, ReadStringError> {
        if u32::try_from(text.len()).is_err() {
            // Too long for the tape's offsets: read the value whole.
            return self
                .parse_string_value(text)
                .map_err(ReadStringError::Parse);
        }
        self.string_reader.reserve_serials(text.len());
        let mut recorder = Recorder::new(self, text, limits);
        let recorded = recorder.record(self);
        let Recorder { nodes, decoded, .. } = recorder;
        let result = match recorded {
            Ok(()) => {
                let tape = Tape {
                    text,
                    nodes: &nodes,
                    decoded: &decoded,
                };
                let committed = tape.commit(self);
                if committed.is_err() {
                    self.reset_partial_sample();
                }
                committed.map_err(|e| ReadStringError::Parse(ParseError::Quicktype(e)))
            }
            Err(Stop::Declined(decline)) => Err(ReadStringError::Declined(decline)),
            Err(Stop::Syntax) => {
                // V8's message, from the port of its parser.
                self.parse_string_value(text)
                    .map_err(ReadStringError::Parse)
            }
        };
        if nodes.capacity() <= SPARE_NODES {
            let mut nodes = nodes;
            nodes.clear();
            self.string_reader.spare_nodes = nodes;
        }
        result
    }

    /// `JSON.parse(text)` with the port of V8's parser, then `process` the
    /// value.
    fn parse_string_value(&mut self, text: &str) -> Result<Value, ParseError> {
        let json = js_json::parse(text)
            .map_err(|e| ParseError::Js(JsException::new(JsErrorName::SyntaxError, e.message())))?;
        let result = self.process(&json).and_then(|()| self.finish());
        if result.is_err() {
            self.reset_partial_sample();
        }
        Ok(result?)
    }
}

#[cfg(test)]
mod tests;
