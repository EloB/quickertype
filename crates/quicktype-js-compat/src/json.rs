//! `JSON.stringify` and `JSON.parse`, as far as quicktype needs them.
//!
//! - [`parse()`]: `JSON.parse(text)` with V8's semantics and error messages
//!   (see the [`parse`](mod@parse) module).
//! - [`quote`]: `JSON.stringify(string)`. JavaScript escapes `"`, `\`, the
//!   control characters below U+0020 (as `\b \t \n \f \r` or lowercase
//!   `\u00XX`) and lone surrogates; everything else, including U+007F,
//!   U+2028/U+2029 and all non-ASCII text, is written as is. A Rust string has
//!   no lone surrogates, so that case cannot arise.
//! - [`number()`]: `JSON.stringify(number)`: [`crate::number::to_string`], and
//!   `null` for `NaN` and the infinities.
//! - [`stringify()`]: a [`JsonValue`] tree, compact or indented exactly like
//!   V8's `JSON.stringify(value, undefined, space)`.
//!
//! Out of scope: `toJSON` methods, replacer functions and arrays, `undefined`
//! and function values (which `JSON.stringify` skips), `BigInt`, and
//! `JSON.parse`'s reviver.
//! Object keys are written in the order the [`JsonValue::Object`] map holds
//! them; to model a JavaScript object, insert keys with
//! [`insert_js_property`], which reproduces JavaScript's own-property order.

/// The map type of [`JsonValue::Object`], re-exported for building values.
pub use indexmap::IndexMap;

pub use self::parse::{JsonParseError, parse};

use crate::number;

pub mod parse;

/// A JSON value. Objects keep their keys in insertion order.
#[derive(Debug, Clone, PartialEq)]
pub enum JsonValue {
    /// `null`.
    Null,
    /// `true` or `false`.
    Bool(bool),
    /// A number; non-finite values are written as `null`.
    Number(f64),
    /// A string.
    String(String),
    /// An array.
    Array(Vec<JsonValue>),
    /// An object, written in the map's order.
    Object(IndexMap<String, JsonValue>),
}

/// `JSON.stringify(s)` for a string: `s` in double quotes, escaped.
pub fn quote(s: &str) -> String {
    let mut out = String::with_capacity(s.len() + 2);
    write_quoted(&mut out, s);
    out
}

/// Appends [`quote`]`(s)` to `out`.
pub fn write_quoted(out: &mut String, s: &str) {
    const HEX: &[u8; 16] = b"0123456789abcdef";
    out.push('"');
    for c in s.chars() {
        match c {
            '"' => out.push_str("\\\""),
            '\\' => out.push_str("\\\\"),
            '\u{08}' => out.push_str("\\b"),
            '\t' => out.push_str("\\t"),
            '\n' => out.push_str("\\n"),
            '\u{0C}' => out.push_str("\\f"),
            '\r' => out.push_str("\\r"),
            c if c < ' ' => {
                let code = c as usize;
                out.push_str("\\u00");
                out.push(char::from(HEX[code >> 4]));
                out.push(char::from(HEX[code & 0xF]));
            }
            c => out.push(c),
        }
    }
    out.push('"');
}

/// `JSON.stringify(x)` for a number: `null` if `x` is not finite, otherwise
/// [`number::to_string`].
pub fn number(x: f64) -> String {
    if x.is_finite() {
        number::to_string(x)
    } else {
        "null".to_owned()
    }
}

/// The indentation `JSON.stringify` uses for a numeric `space` argument, as
/// V8 computes it: `None` (compact output) unless `space > 0`, otherwise
/// `min(space, 10)` spaces, truncated.
///
/// This follows V8 rather than the specification: for `0 < space < 1` V8
/// still pretty-prints, with line breaks but no indentation.
pub fn gap_from_spaces(space: f64) -> Option<String> {
    // `space > 0` is false for NaN, which V8 also treats as "no gap".
    (space > 0.0).then(|| " ".repeat(space.min(10.0) as usize))
}

/// The indentation `JSON.stringify` uses for a string `space` argument:
/// `None` for `""`, otherwise its first 10 UTF-16 code units (a surrogate
/// pair cut by that limit is dropped).
pub fn gap_from_str(space: &str) -> Option<String> {
    if space.is_empty() {
        return None;
    }
    let mut units = 0;
    let gap = space
        .chars()
        .take_while(|c| {
            units += c.len_utf16();
            units <= 10
        })
        .collect();
    Some(gap)
}

/// `JSON.stringify(value, undefined, space)`, where `gap` is the indentation
/// derived from `space` (see [`gap_from_spaces`] and [`gap_from_str`]):
/// `None` gives the compact form, `Some(gap)` puts every element on its own
/// line, indented by `gap` per level.
pub fn stringify(value: &JsonValue, gap: Option<&str>) -> String {
    let mut out = String::new();
    write_value(&mut out, value, gap, &mut String::new());
    out
}

fn write_value(out: &mut String, value: &JsonValue, gap: Option<&str>, indent: &mut String) {
    match value {
        JsonValue::Null => out.push_str("null"),
        JsonValue::Bool(b) => out.push_str(if *b { "true" } else { "false" }),
        JsonValue::Number(x) if x.is_finite() => number::write_to_string(out, *x),
        JsonValue::Number(_) => out.push_str("null"),
        JsonValue::String(s) => write_quoted(out, s),
        JsonValue::Array(items) => {
            write_container(out, '[', ']', items.iter().map(|v| (None, v)), gap, indent);
        }
        JsonValue::Object(map) => {
            let entries = map.iter().map(|(k, v)| (Some(k.as_str()), v));
            write_container(out, '{', '}', entries, gap, indent);
        }
    }
}

/// `SerializeJSONObject` / `SerializeJSONArray`.
fn write_container<'a>(
    out: &mut String,
    open: char,
    close: char,
    entries: impl ExactSizeIterator<Item = (Option<&'a str>, &'a JsonValue)>,
    gap: Option<&str>,
    indent: &mut String,
) {
    if entries.len() == 0 {
        out.push(open);
        out.push(close);
        return;
    }
    let stepback = indent.len();
    indent.push_str(gap.unwrap_or(""));
    out.push(open);
    for (i, (key, value)) in entries.enumerate() {
        if i > 0 {
            out.push(',');
        }
        if gap.is_some() {
            out.push('\n');
            out.push_str(indent);
        }
        if let Some(key) = key {
            write_quoted(out, key);
            out.push(':');
            if gap.is_some() {
                out.push(' ');
            }
        }
        write_value(out, value, gap, indent);
    }
    indent.truncate(stepback);
    if gap.is_some() {
        out.push('\n');
        out.push_str(indent);
    }
    out.push(close);
}

/// Whether `key` is an array index: the canonical decimal form of an integer
/// in `0..=4294967294` (`"0"`, `"42"`, but not `"01"`, `"-1"`, `"1.5"` or
/// `"4294967295"`). JavaScript objects list these keys first, in ascending
/// numeric order, before all other string keys.
pub fn is_array_index(key: &str) -> bool {
    match key.as_bytes() {
        [b'0'] => true,
        [b'1'..=b'9', rest @ ..] if rest.iter().all(u8::is_ascii_digit) => {
            key.parse::<u64>().is_ok_and(|n| n < u64::from(u32::MAX))
        }
        _ => false,
    }
}

/// Inserts `key` into `map` the way defining a property on a JavaScript
/// object orders it: an existing key keeps its position and takes the new
/// value; a new array-index key (see [`is_array_index`]) goes after the
/// smaller array-index keys and before every other key; any other new key
/// goes last.
///
/// `map` must hold its keys in that order already, i.e. have been built with
/// this function. Finding the position of an array-index key is then a
/// binary search over the leading array-index keys (and appending is O(1)),
/// though inserting before existing keys still shifts them.
///
/// This is `CreateDataProperty`, as `JSON.parse` uses. Plain assignment
/// (`obj[key] = value`) differs only for `"__proto__"`, which then sets the
/// prototype instead of adding a key; callers modelling assignment must skip
/// that key themselves.
pub fn insert_js_property<V>(map: &mut IndexMap<String, V>, key: String, value: V) {
    if let Some(existing) = map.get_mut(&key) {
        *existing = value;
        return;
    }
    let Some(index) = array_index(&key) else {
        map.insert(key, value);
        return;
    };
    // Fast path: every key so far is a smaller array index (or there is
    // none), so the new one goes last.
    let last_is_smaller_index = map
        .last()
        .is_none_or(|(k, _)| array_index(k).is_some_and(|i| i < index));
    if last_is_smaller_index {
        map.insert(key, value);
        return;
    }
    // The leading keys are the array indices in ascending order, so "is an
    // array index below `index`" holds for exactly a prefix.
    let position = map.partition_point(|k, _| array_index(k).is_some_and(|i| i < index));
    map.shift_insert(position, key, value);
}

/// The numeric value of an array-index key.
fn array_index(key: &str) -> Option<u32> {
    if is_array_index(key) {
        key.parse().ok()
    } else {
        None
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn quoting() {
        assert_eq!(
            quote("a\"b\\c\u{1}\u{1f}\u{7f}\u{2028}é😀"),
            "\"a\\\"b\\\\c\\u0001\\u001f\u{7f}\u{2028}é😀\""
        );
        assert_eq!(quote("\u{8}\u{c}\n\r\t"), r#""\b\f\n\r\t""#);
    }

    #[test]
    fn layout() {
        let mut object = IndexMap::new();
        object.insert(
            "a".to_owned(),
            JsonValue::Array(vec![JsonValue::Number(1.0), JsonValue::Null]),
        );
        object.insert("b".to_owned(), JsonValue::Object(IndexMap::new()));
        object.insert("c".to_owned(), JsonValue::Array(vec![]));
        let value = JsonValue::Object(object);
        assert_eq!(stringify(&value, None), r#"{"a":[1,null],"b":{},"c":[]}"#);
        assert_eq!(
            stringify(&value, Some("  ")),
            "{\n  \"a\": [\n    1,\n    null\n  ],\n  \"b\": {},\n  \"c\": []\n}"
        );
        assert_eq!(number(f64::INFINITY), "null");
        assert_eq!(number(-0.0), "0");
    }

    #[test]
    fn js_property_order() {
        let mut map = IndexMap::new();
        for key in [
            "zeta",
            "10",
            "2",
            "alpha",
            "01",
            "4294967295",
            "4294967294",
            "2",
        ] {
            insert_js_property(&mut map, key.to_owned(), key.len());
        }
        let keys: Vec<&str> = map.keys().map(String::as_str).collect();
        assert_eq!(
            keys,
            ["2", "10", "4294967294", "zeta", "alpha", "01", "4294967295"]
        );
    }

    #[test]
    fn gaps() {
        assert_eq!(gap_from_spaces(4.0).as_deref(), Some("    "));
        assert_eq!(gap_from_spaces(20.0), Some(" ".repeat(10)));
        assert_eq!(gap_from_spaces(0.5).as_deref(), Some(""));
        assert_eq!(gap_from_spaces(0.0), None);
        assert_eq!(gap_from_spaces(f64::NAN), None);
        assert_eq!(gap_from_str("\t").as_deref(), Some("\t"));
        assert_eq!(gap_from_str(""), None);
        assert_eq!(
            gap_from_str("abcdefghijklmno").as_deref(),
            Some("abcdefghij")
        );
        assert_eq!(gap_from_str("123456789😀").as_deref(), Some("123456789"));
    }
}
