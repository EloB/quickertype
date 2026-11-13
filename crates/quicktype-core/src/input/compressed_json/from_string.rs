//! `CompressedJSONFromString.parseSync(input)`: `JSON.parse(input)`, then
//! `process` the value in `Object.getOwnPropertyNames` order, without
//! building the value, into any [`JsonSink`]: a [`CompressedJson`] or the
//! running tallies ([`parse_string_into`](super::parse_string_into)).
//!
//! The text is read in two passes:
//!
//! 1. **Record.** The text is validated against V8's JSON grammar and
//!    recorded as a *tape*: one node per value and per key, in source
//!    order. A string node points into the text (or, if it has escapes,
//!    into a buffer of decoded strings), a number node is already
//!    classified (`parsedNumberIsDouble`), a key node holds the key's id
//!    in the reader's own key table (not the string table), and an object
//!    or array node knows where its content ends. Nothing is committed in
//!    this pass, so a sample that is not JSON, or that is declined,
//!    leaves the compressed form as it was.
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
//!    A key is interned in the string table as `commitValue` interns it,
//!    after its value (so the string table is TypeScript's, string for
//!    string), and only for the members `JSON.parse` keeps: one
//!    `"__proto__"` for an object with two. TypeScript's `process`
//!    recurses once per value and overflows Node's stack past
//!    [`PROCESS_MAX_DEPTH`] nested values; this pass fails there with the
//!    same `RangeError`, having committed what `process` commits before
//!    (see "Very deeply nested JSON" in `docs/PARITY.md`).
//!
//! On a syntax error, the message is that of
//! [`quicktype_js_compat::json::parse`], the port of V8's parser
//! ([`parse_string_value_into`](super::parse_string_value_into)). Should
//! that parser accept a text this reader rejects, the value it returns is
//! processed instead: the grammar is V8's either way. That value cannot be
//! checked against [`StringSampleLimits`], so with any limits such a
//! sample is declined instead ([`Decline::Unchecked`]), as is a text too
//! long for the tape.
//!
//! Duplicate keys are found without a set per object: every key of the
//! key table has a *stamp*, the serial number of the last object that had
//! it, and objects are numbered as they open. A key whose stamp is the
//! object's own serial is a duplicate; one with a smaller stamp is new to
//! the object (an object that started earlier and is still open cannot
//! add keys while this one is open); one with a larger stamp was used by a
//! nested object in between. Only then are the object's earlier keys
//! compared: one by one while it has at most [`SCAN_MEMBERS`] (records
//! whose nested objects share key names with them, which is common), and
//! past that with a set of its keys, made once from its members so far
//! and kept up to date from then on, so that a wide object whose keys
//! keep reappearing in its values (`{"k0": {"k1": 0}, "k1": {"k2": 0},
//! …}`) is still read in linear time. `"__proto__"`, which TypeScript
//! interns anew every time, is not in the key table ([`PROTO`]) and is
//! tracked per object.
//!
//! After a sample, the tape and the key table are kept for the next one
//! only while they are small ([`KEEP_NODES`], [`KEEP_KEYS`]); a large
//! sample's are freed.

use std::hash::BuildHasher as _;

use hashbrown::HashTable;
use quicktype_js_compat::json::is_array_index;

use super::{
    CompressedJson, JsonSink, NO_INDEX, PROCESS_MAX_DEPTH, ParseError, Strings, Value,
    parse_string_value_into, syntax_error, vec_size,
};
use crate::messages::{QuickTypeError, Result};
use crate::support::fast_hash::{BuildHasher, HashMap, HashSet};
use crate::support::recursion::stack_overflow;

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

impl StringSampleLimits {
    /// Whether these are no limits at all ([`Default`]).
    fn is_none(self) -> bool {
        self == StringSampleLimits::default()
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

/// Which of the [`StringSampleLimits`] a sample exceeds, or why it could
/// not be checked against them.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Decline {
    /// Nested deeper than `max_depth`.
    TooDeep,
    /// A `\u` escape leaves a surrogate unpaired.
    LoneSurrogate,
    /// The one-pass reader cannot read the sample (it is too long for the
    /// reader's tape, or the reader rejects a text that the port of V8's
    /// parser accepts), and the value read whole cannot be checked against
    /// limits other than the default ones.
    Unchecked,
}

/// The object keys the reader has read, by key id: the first pass finds
/// duplicates with them, and the second interns each in the string table
/// the first time a value under it is committed.
#[derive(Default)]
struct Keys {
    /// The texts, back to back.
    text: String,
    /// By key id: where its text is in `text`.
    spans: Vec<(u32, u32)>,
    /// Key ids, hashed by text.
    index: HashTable<u32>,
    hasher: BuildHasher,
    /// By key id: its index in the string table, or [`NO_INDEX`] until a
    /// value under it is committed.
    interned: Vec<u32>,
    /// By key id: the serial of the last object with that key.
    stamps: Vec<u32>,
    /// By position in an object: the id of the last key read there.
    /// Objects of one shape (an array of records) have the same key at the
    /// same position, which is then found without hashing it.
    cache: Vec<u32>,
}

/// The key id of `"__proto__"`, which is not in [`Keys`]: TypeScript
/// interns it anew every time (its string index is a plain object).
const PROTO: u32 = u32::MAX;

/// How many positions [`Keys::cache`] remembers keys at.
const KEY_CACHE: usize = 64;

/// Up to how many members an object's earlier keys are compared one by
/// one for a key a nested object used (see the module documentation);
/// past that, with a set.
const SCAN_MEMBERS: usize = 16;

/// Tapes of up to this many nodes (48 KiB) are kept for the next sample.
const KEEP_NODES: usize = 1 << 12;

/// The key table is kept for the next sample while it has at most this
/// many keys, of at most [`KEEP_KEY_BYTES`] of text.
const KEEP_KEYS: usize = 1 << 12;
const KEEP_KEY_BYTES: usize = 1 << 16;

impl Keys {
    fn get(&self, id: u32) -> &str {
        if id == PROTO {
            return "__proto__";
        }
        let (start, len) = self.spans[id as usize];
        &self.text[start as usize..(start + len) as usize]
    }

    /// The id of `key`, read at member position `position`: the key read
    /// last at that position, if it is the same text, else looked up (and
    /// added).
    fn read(&mut self, position: usize, key: &str) -> u32 {
        if key == "__proto__" {
            return PROTO;
        }
        if let Some(&id) = self.cache.get(position)
            && id != PROTO
            && (id as usize) < self.spans.len()
            && self.get(id) == key
        {
            return id;
        }
        let hash = self.hasher.hash_one(key);
        let found = {
            let Keys {
                text, spans, index, ..
            } = &*self;
            index
                .find(hash, |&id| {
                    let (start, len) = spans[id as usize];
                    &text[start as usize..(start + len) as usize] == key
                })
                .copied()
        };
        let id = match found {
            Some(id) => id,
            None => self.add(key, hash),
        };
        if position < KEY_CACHE {
            if position >= self.cache.len() {
                self.cache.resize(position + 1, PROTO);
            }
            self.cache[position] = id;
        }
        id
    }

    fn add(&mut self, key: &str, hash: u64) -> u32 {
        let id = self.spans.len() as u32;
        self.spans.push((self.text.len() as u32, key.len() as u32));
        self.text.push_str(key);
        self.interned.push(NO_INDEX);
        self.stamps.push(0);
        let Keys {
            text,
            spans,
            index,
            hasher,
            ..
        } = self;
        index.insert_unique(hash, id, |&id| {
            let (start, len) = spans[id as usize];
            hasher.hash_one(&text[start as usize..(start + len) as usize])
        });
        id
    }
}

/// What the reader keeps between samples: the key table, the serial of
/// the last object (see the module documentation), and the last tape.
/// Every [`JsonSink`] holds one.
#[derive(Default)]
pub(crate) struct StringReaderState {
    keys: Keys,
    /// The serial of the last object opened.
    serial: u32,
    /// The tape of the last sample, emptied, if it was small.
    spare_nodes: Vec<Node>,
}

impl StringReaderState {
    /// Numbers objects from 1 again if a sample of `len` bytes (at most
    /// `len / 2` objects) could run out of serials.
    fn reserve_serials(&mut self, len: usize) {
        if u64::from(self.serial) + len as u64 / 2 + 1 >= u64::from(u32::MAX) {
            self.keys.stamps.fill(0);
            self.serial = 0;
        }
    }

    fn next_serial(&mut self) -> u32 {
        self.serial += 1;
        self.serial
    }

    /// Stamps `key` with `serial` and returns its previous stamp.
    fn stamp(&mut self, key: u32, serial: u32) -> u32 {
        std::mem::replace(&mut self.keys.stamps[key as usize], serial)
    }

    /// The text of key `id`.
    pub(crate) fn key_text(&self, id: u32) -> &str {
        self.keys.get(id)
    }

    /// `makeString(key)` for key `id`: its index in `strings`, interned the
    /// first time (`"__proto__"` every time).
    pub(super) fn intern_key(&mut self, id: u32, strings: &mut Strings) -> u32 {
        if id == PROTO {
            return strings.intern("__proto__");
        }
        let Keys {
            text,
            spans,
            interned,
            ..
        } = &mut self.keys;
        let index = &mut interned[id as usize];
        if *index == NO_INDEX {
            let (start, len) = spans[id as usize];
            *index = strings.intern(&text[start as usize..(start + len) as usize]);
        }
        *index
    }

    /// The bytes of its buffers ([`CompressedJson::heap_size`]).
    pub(super) fn heap_size(&self) -> usize {
        let keys = &self.keys;
        keys.text.capacity()
            + vec_size(&keys.spans)
            + keys.index.allocation_size()
            + vec_size(&keys.interned)
            + vec_size(&keys.stamps)
            + vec_size(&keys.cache)
            + vec_size(&self.spare_nodes)
    }

    /// After a sample: keeps its tape and the key table for the next one
    /// only if they are small.
    fn finish_sample(&mut self, mut nodes: Vec<Node>) {
        if nodes.capacity() <= KEEP_NODES {
            nodes.clear();
            self.spare_nodes = nodes;
        }
        if self.keys.spans.len() > KEEP_KEYS || self.keys.text.len() > KEEP_KEY_BYTES {
            self.keys = Keys::default();
            self.serial = 0;
        }
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
    /// An object key: key `a` of the key table, or [`PROTO`].
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
    /// Its keys, once a key with a stamp larger than its serial came up
    /// past [`SCAN_MEMBERS`] members (see the module documentation); every
    /// key after that is added.
    keys: Option<HashSet<u32>>,
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

/// A key that is an array index, as a number.
fn array_index(key: &str) -> Option<u32> {
    if is_array_index(key) {
        key.parse().ok()
    } else {
        None
    }
}

impl<'t> Recorder<'t> {
    fn new<S: JsonSink>(sink: &mut S, text: &'t str, limits: StringSampleLimits) -> Self {
        let small_integers_fit = sink.small_integers_fit();
        Recorder {
            text,
            bytes: text.as_bytes(),
            pos: 0,
            nodes: std::mem::take(&mut sink.string_reader().spare_nodes),
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
    fn record<S: JsonSink>(&mut self, sink: &mut S) -> Result<(), Stop> {
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
                            serial: sink.string_reader().next_serial(),
                            has_proto: false,
                            last_index: None,
                            has_name: false,
                            reordered: false,
                            members: 0,
                            keys: None,
                        };
                        self.member_key(sink, &mut object)?;
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
                    let kind = self.number(sink)?;
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
                            self.member_key(sink, object)?;
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
    fn member_key<S: JsonSink>(
        &mut self,
        sink: &mut S,
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
                self.check_key(sink, object, key)
            }
            None => {
                let key = std::mem::take(&mut self.key);
                let index = self.check_key(sink, object, &key);
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

    /// The id of `key` in the key table; notes whether it makes `object`
    /// reordered.
    fn check_key<S: JsonSink>(&self, sink: &mut S, object: &mut OpenObject, key: &str) -> u32 {
        let reader = sink.string_reader();
        let index = reader.keys.read(object.members, key);
        object.members += 1;
        if object.reordered {
            return index;
        }
        if index == PROTO {
            object.reordered = object.has_proto;
            object.has_proto = true;
        } else {
            let stamp = reader.stamp(index, object.serial);
            object.reordered = match &mut object.keys {
                Some(keys) => !keys.insert(index),
                // Used by a nested object since this one opened.
                None if stamp > object.serial && object.members <= SCAN_MEMBERS => {
                    self.has_key(object.node, index)
                }
                None if stamp > object.serial => {
                    let mut keys = self.member_keys(object.node);
                    let repeated = !keys.insert(index);
                    object.keys = Some(keys);
                    repeated
                }
                None => stamp == object.serial,
            };
        }
        if object.reordered {
            // Duplicates no longer matter.
            object.keys = None;
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

    /// The key nodes of the object at `node`, still being recorded, so
    /// far: what each of its members starts with.
    fn member_keys_at(&self, node: usize) -> impl Iterator<Item = u32> + '_ {
        let mut i = node + 1;
        std::iter::from_fn(move || {
            let key = self.nodes.get(i)?.a;
            #[cfg(test)]
            tests::KEYS_WALKED.with(|n| n.set(n.get() + 1));
            // Past the key and its value.
            i = match self.nodes.get(i + 1) {
                Some(Node {
                    kind: Kind::Object | Kind::Array,
                    a,
                    ..
                }) => *a as usize,
                _ => i + 2,
            };
            Some(key)
        })
    }

    /// Whether the object at `node`, still being recorded, has the key
    /// `index` already.
    fn has_key(&self, node: usize, index: u32) -> bool {
        self.member_keys_at(node).any(|key| key == index)
    }

    /// The keys (but `"__proto__"`) of the object at `node`, still being
    /// recorded, so far.
    fn member_keys(&self, node: usize) -> HashSet<u32> {
        self.member_keys_at(node)
            .filter(|&key| key != PROTO)
            .collect()
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
    fn number<S: JsonSink>(&mut self, sink: &S) -> Result<Kind, Stop> {
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
            !(self.small_integers_fit || sink.integer_string_fits(literal))
        } else {
            // Correctly rounded like V8's `StringToDouble`; `1e400` is ∞.
            let n: f64 = literal.parse().map_err(|_| Stop::Syntax)?;
            sink.parsed_number_is_double(n)
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
    fn js_order<S: JsonSink>(&self, sink: &mut S, node: usize) -> Vec<(u32, usize)> {
        let end = self.nodes[node].a as usize;
        let mut members: Vec<(Option<u32>, u32, usize)> = Vec::new();
        let mut positions: HashMap<u32, usize> = HashMap::default();
        let mut i = node + 1;
        while i < end {
            let key = self.nodes[i].a;
            let value = i + 1;
            i = self.after(value);
            match positions.get(&key) {
                Some(&position) => members[position].2 = value,
                None => {
                    positions.insert(key, members.len());
                    let text = sink.string_reader().key_text(key);
                    members.push((array_index(text), key, value));
                }
            }
        }
        // Stable: the other keys keep their order.
        members.sort_by_key(|&(index, _, _)| match index {
            Some(n) => (0, n),
            None => (1, 0),
        });
        members
            .into_iter()
            .map(|(_, key, value)| (key, value))
            .collect()
    }

    /// Commits the sample, as `process(json)` and `finish()` do: past
    /// [`PROCESS_MAX_DEPTH`] nested values, `process` overflows Node's
    /// stack, and so does this, at the same value, after committing what
    /// `process` commits before it.
    fn commit<S: JsonSink>(&self, sink: &mut S) -> Result<S::Root> {
        let mut frames: Vec<Frame> = Vec::new();
        let mut at = 0;
        loop {
            // The value at `at` is `frames.len() + 1` deep.
            if frames.len() >= PROCESS_MAX_DEPTH {
                return Err(stack_overflow());
            }
            let node = self.nodes[at];
            match node.kind {
                Kind::Null => sink.commit_null()?,
                Kind::False => sink.commit_boolean(false)?,
                Kind::True => sink.commit_boolean(true)?,
                Kind::Integer => sink.commit_number(false)?,
                Kind::Double => sink.commit_number(true)?,
                Kind::Text => {
                    sink.commit_string(&self.text[node.a as usize..(node.a + node.b) as usize])?
                }
                Kind::Decoded => {
                    sink.commit_string(&self.decoded[node.a as usize..(node.a + node.b) as usize])?
                }
                Kind::Object => {
                    sink.push_object_context()?;
                    frames.push(if node.b != 0 {
                        Frame::Reordered {
                            members: self.js_order(sink, at),
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
                    sink.push_array_context()?;
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
                    return sink.finish();
                };
                match frame {
                    Frame::InOrder { next, end, object } => {
                        if *next == *end {
                            let object = *object;
                            frames.pop();
                            if object {
                                sink.finish_object()?;
                            } else {
                                sink.finish_array()?;
                            }
                            continue;
                        }
                        if *object {
                            sink.set_property_key_read(self.nodes[*next].a)?;
                            *next += 1;
                        }
                        at = *next;
                        *next = self.after(at);
                        break;
                    }
                    Frame::Reordered { members, next } => {
                        let Some(&(key, value)) = members.get(*next) else {
                            frames.pop();
                            sink.finish_object()?;
                            continue;
                        };
                        *next += 1;
                        sink.set_property_key_read(key)?;
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
        read_string_sample_into(self, text, limits)
    }
}

/// [`CompressedJson::read_string_sample`] into any [`JsonSink`].
pub(crate) fn read_string_sample_into<S: JsonSink>(
    sink: &mut S,
    text: &str,
    limits: StringSampleLimits,
) -> Result<S::Root, ReadStringError> {
    if u32::try_from(text.len()).is_err() {
        // Too long for the tape's offsets: read the value whole.
        return read_whole(sink, text, limits);
    }
    sink.string_reader().reserve_serials(text.len());
    let mut recorder = Recorder::new(sink, text, limits);
    let recorded = recorder.record(sink);
    let Recorder { nodes, decoded, .. } = recorder;
    let result = match recorded {
        Ok(()) => {
            let tape = Tape {
                text,
                nodes: &nodes,
                decoded: &decoded,
            };
            let committed = tape.commit(sink);
            if committed.is_err() {
                sink.reset_partial_sample();
            }
            committed.map_err(|e| ReadStringError::Parse(ParseError::Quicktype(e)))
        }
        Err(Stop::Declined(decline)) => Err(ReadStringError::Declined(decline)),
        // V8's message, from the port of its parser.
        Err(Stop::Syntax) => read_whole(sink, text, limits),
    };
    sink.string_reader().finish_sample(nodes);
    result
}

/// What the one-pass reader falls back on: `JSON.parse` with the port of
/// V8's parser (for its error message, or for a text too long for the
/// tape), then `process` the value. The value read whole cannot be checked
/// against `limits` (its strings hold U+FFFD where the text has a lone
/// surrogate), so with any limits a sample that parses is declined, and
/// nothing is committed: only without limits is it read.
fn read_whole<S: JsonSink>(
    sink: &mut S,
    text: &str,
    limits: StringSampleLimits,
) -> Result<S::Root, ReadStringError> {
    if limits.is_none() {
        return parse_string_value_into(sink, text).map_err(ReadStringError::Parse);
    }
    match quicktype_js_compat::json::parse(text) {
        Ok(_) => Err(ReadStringError::Declined(Decline::Unchecked)),
        Err(e) => Err(ReadStringError::Parse(syntax_error(&e))),
    }
}

#[cfg(test)]
mod tests;
