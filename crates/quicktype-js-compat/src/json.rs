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

use std::fmt;

/// The map type of [`JsonValue::Object`], re-exported for building values.
pub use indexmap::IndexMap;

pub use self::parse::{JsonParseError, parse};

use crate::number;

pub mod parse;

/// A JSON value. Objects keep their keys in insertion order.
///
/// `Clone`, `Drop`, `PartialEq` and `Debug` are written out, without
/// recursion, so that the arbitrarily deep values [`parse()`] accepts cannot
/// overflow the stack.
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

/// Dropping a value never recurses (the derived drop glue would, once per
/// nesting level), so the arbitrarily deep values [`parse()`] accepts
/// cannot overflow the stack.
impl Drop for JsonValue {
    fn drop(&mut self) {
        let mut children: Vec<JsonValue> = match self {
            JsonValue::Array(items) if items.iter().any(JsonValue::has_children) => {
                std::mem::take(items)
            }
            JsonValue::Object(map) if map.values().any(JsonValue::has_children) => {
                std::mem::take(map).into_values().collect()
            }
            _ => return,
        };
        while let Some(mut child) = children.pop() {
            match &mut child {
                JsonValue::Array(items) => children.append(items),
                JsonValue::Object(map) => children.extend(std::mem::take(map).into_values()),
                _ => {}
            }
            // `child` is now childless and drops without recursing.
        }
    }
}

/// Cloning never recurses either (the derived `clone` would, once per
/// nesting level): a deep GraphQL schema shared by the queries of a
/// directory used to overflow the stack here.
impl Clone for JsonValue {
    fn clone(&self) -> Self {
        /// A collection being copied: what is done, and what is left.
        enum Frame<'a> {
            Array(Vec<JsonValue>, std::slice::Iter<'a, JsonValue>),
            Object(
                IndexMap<String, JsonValue>,
                Option<&'a String>,
                indexmap::map::Iter<'a, String, JsonValue>,
            ),
        }

        /// A copied leaf, or the frame for a collection.
        fn start(value: &JsonValue) -> Result<JsonValue, Frame<'_>> {
            match value {
                JsonValue::Null => Ok(JsonValue::Null),
                JsonValue::Bool(b) => Ok(JsonValue::Bool(*b)),
                JsonValue::Number(n) => Ok(JsonValue::Number(*n)),
                JsonValue::String(s) => Ok(JsonValue::String(s.clone())),
                JsonValue::Array(items) => {
                    Err(Frame::Array(Vec::with_capacity(items.len()), items.iter()))
                }
                JsonValue::Object(map) => Err(Frame::Object(
                    IndexMap::with_capacity(map.len()),
                    None,
                    map.iter(),
                )),
            }
        }

        let mut stack = match start(self) {
            Ok(leaf) => return leaf,
            Err(frame) => vec![frame],
        };
        let mut done: Option<JsonValue> = None;
        while let Some(frame) = stack.last_mut() {
            // Store the value just copied, then take the next child.
            let next = match frame {
                Frame::Array(items, rest) => {
                    if let Some(value) = done.take() {
                        items.push(value);
                    }
                    rest.next()
                }
                Frame::Object(map, key, rest) => {
                    if let (Some(value), Some(k)) = (done.take(), key.take()) {
                        map.insert(k.clone(), value);
                    }
                    rest.next().map(|(k, v)| {
                        *key = Some(k);
                        v
                    })
                }
            };
            match next {
                Some(child) => match start(child) {
                    Ok(leaf) => done = Some(leaf),
                    Err(frame) => stack.push(frame),
                },
                None => {
                    done = match stack.pop() {
                        Some(Frame::Array(items, _)) => Some(JsonValue::Array(items)),
                        Some(Frame::Object(map, _, _)) => Some(JsonValue::Object(map)),
                        None => None,
                    };
                }
            }
        }
        done.unwrap_or(JsonValue::Null)
    }
}

/// The derived equality (numbers as `f64`, so `NaN` is unequal to itself;
/// objects equal with the same entries in any order, as `IndexMap`'s), but
/// iterative.
impl PartialEq for JsonValue {
    fn eq(&self, other: &Self) -> bool {
        let mut pending = vec![(self, other)];
        while let Some(pair) = pending.pop() {
            match pair {
                (JsonValue::Null, JsonValue::Null) => {}
                (JsonValue::Bool(a), JsonValue::Bool(b)) if a == b => {}
                (JsonValue::Number(a), JsonValue::Number(b)) if a == b => {}
                (JsonValue::String(a), JsonValue::String(b)) if a == b => {}
                (JsonValue::Array(a), JsonValue::Array(b)) if a.len() == b.len() => {
                    pending.extend(a.iter().zip(b));
                }
                (JsonValue::Object(a), JsonValue::Object(b)) if a.len() == b.len() => {
                    for (key, value) in a {
                        let Some(other) = b.get(key) else {
                            return false;
                        };
                        pending.push((value, other));
                    }
                }
                _ => return false,
            }
        }
        true
    }
}

/// How deeply [`JsonValue`]'s `Debug` output goes: non-empty arrays and
/// objects nested deeper are elided as `Array([..])` and `Object({..})`.
const DEBUG_MAX_DEPTH: usize = 100;

/// The derived format (`Array([Number(1.0), Null])`, or indented with
/// `{:#?}`), written without recursing, down to [`DEBUG_MAX_DEPTH`]
/// levels: deeper collections are elided (indented output of a deep value
/// would be quadratic in its depth).
impl fmt::Debug for JsonValue {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        /// What is left to write, last first.
        enum Step<'a> {
            /// A value, at a depth (1 for the outermost) and an
            /// indentation level (for `{:#?}`).
            Value(&'a JsonValue, usize, usize),
            /// An object key and the `": "` after it.
            Key(&'a str),
            Text(&'static str),
            /// `{:#?}`: a line break, then the indentation of a level.
            Line(usize),
        }

        /// A line break and the indentation of `level`.
        fn line(f: &mut fmt::Formatter<'_>, level: usize) -> fmt::Result {
            f.write_str("\n")?;
            for _ in 0..level {
                f.write_str("    ")?;
            }
            Ok(())
        }

        let pretty = f.alternate();
        let mut steps = vec![Step::Value(self, 1, 0)];
        while let Some(step) = steps.pop() {
            let (value, depth, level) = match step {
                Step::Value(value, depth, level) => (value, depth, level),
                Step::Key(key) => {
                    fmt::Debug::fmt(key, f)?;
                    f.write_str(": ")?;
                    continue;
                }
                Step::Text(text) => {
                    f.write_str(text)?;
                    continue;
                }
                Step::Line(level) => {
                    line(f, level)?;
                    continue;
                }
            };
            let (name, open, close, entries): (_, _, _, Vec<(Option<&str>, &JsonValue)>) =
                match value {
                    JsonValue::Null => {
                        f.write_str("Null")?;
                        continue;
                    }
                    JsonValue::Array(items) if depth > DEBUG_MAX_DEPTH && !items.is_empty() => {
                        f.write_str("Array([..])")?;
                        continue;
                    }
                    JsonValue::Object(map) if depth > DEBUG_MAX_DEPTH && !map.is_empty() => {
                        f.write_str("Object({..})")?;
                        continue;
                    }
                    JsonValue::Array(items) => {
                        ("Array", "[", "]", items.iter().map(|v| (None, v)).collect())
                    }
                    JsonValue::Object(map) => (
                        "Object",
                        "{",
                        "}",
                        map.iter().map(|(k, v)| (Some(k.as_str()), v)).collect(),
                    ),
                    leaf => {
                        // `Name(leaf)`, or indented `Name(\n    leaf,\n)`.
                        let name = match leaf {
                            JsonValue::Bool(_) => "Bool",
                            JsonValue::Number(_) => "Number",
                            _ => "String",
                        };
                        f.write_str(name)?;
                        f.write_str("(")?;
                        if pretty {
                            line(f, level + 1)?;
                        }
                        match leaf {
                            JsonValue::Bool(b) => fmt::Debug::fmt(b, f)?,
                            JsonValue::Number(n) => fmt::Debug::fmt(n, f)?,
                            JsonValue::String(s) => fmt::Debug::fmt(s, f)?,
                            _ => {}
                        }
                        if pretty {
                            f.write_str(",")?;
                            line(f, level)?;
                        }
                        f.write_str(")")?;
                        continue;
                    }
                };
            // `Name([a, b])`, or indented
            // `Name(\n    [\n        a,\n        b,\n    ],\n)`; pushed in
            // reverse.
            f.write_str(name)?;
            f.write_str("(")?;
            if pretty {
                steps.extend([Step::Text(")"), Step::Line(level), Step::Text(",")]);
                steps.push(Step::Text(close));
                if !entries.is_empty() {
                    steps.push(Step::Line(level + 1));
                }
                for (key, value) in entries.into_iter().rev() {
                    steps.push(Step::Text(","));
                    steps.push(Step::Value(value, depth + 1, level + 2));
                    steps.extend(key.map(Step::Key));
                    steps.push(Step::Line(level + 2));
                }
                steps.push(Step::Text(open));
                steps.push(Step::Line(level + 1));
            } else {
                steps.extend([Step::Text(")"), Step::Text(close)]);
                for (i, (key, value)) in entries.into_iter().enumerate().rev() {
                    steps.push(Step::Value(value, depth + 1, level));
                    steps.extend(key.map(Step::Key));
                    if i > 0 {
                        steps.push(Step::Text(", "));
                    }
                }
                steps.push(Step::Text(open));
            }
        }
        Ok(())
    }
}

impl JsonValue {
    /// Whether this is a non-empty array or object.
    fn has_children(&self) -> bool {
        match self {
            JsonValue::Array(items) => !items.is_empty(),
            JsonValue::Object(map) => !map.is_empty(),
            _ => false,
        }
    }
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

/// `!!x` for a number: everything but `0`, `-0` and `NaN` is truthy.
pub fn is_truthy_number(x: f64) -> bool {
    x != 0.0 && !x.is_nan()
}

/// How deeply `value` nests: 1 for a scalar or an empty array or object,
/// one more for each level of arrays and objects. Iterative.
pub fn depth(value: &JsonValue) -> usize {
    let mut deepest = 0;
    let mut pending = vec![(value, 1)];
    while let Some((value, depth)) = pending.pop() {
        deepest = deepest.max(depth);
        match value {
            JsonValue::Array(items) => pending.extend(items.iter().map(|v| (v, depth + 1))),
            JsonValue::Object(map) => pending.extend(map.values().map(|v| (v, depth + 1))),
            _ => {}
        }
    }
    deepest
}

/// `!!value`: JavaScript truthiness. `null`, `false`, `0`, `-0`, `NaN` and
/// `""` are falsy; arrays and objects (even empty ones) are truthy.
pub fn is_truthy(value: &JsonValue) -> bool {
    match value {
        JsonValue::Null => false,
        JsonValue::Bool(b) => *b,
        JsonValue::Number(x) => is_truthy_number(*x),
        JsonValue::String(s) => !s.is_empty(),
        JsonValue::Array(_) | JsonValue::Object(_) => true,
    }
}

/// The `TypeError` JavaScript throws for reading a property of
/// `undefined` or `null`, e.g. `Cannot read properties of null (reading
/// 'name')`.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct PropertyReadError {
    message: String,
}

impl PropertyReadError {
    /// Reading `key` of `undefined`.
    pub fn of_undefined(key: &str) -> Self {
        PropertyReadError {
            message: format!("Cannot read properties of undefined (reading '{key}')"),
        }
    }

    /// Reading `key` of `null`.
    pub fn of_null(key: &str) -> Self {
        PropertyReadError {
            message: format!("Cannot read properties of null (reading '{key}')"),
        }
    }

    /// The error's `message`.
    pub fn message(&self) -> &str {
        &self.message
    }
}

impl fmt::Display for PropertyReadError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.write_str(&self.message)
    }
}

impl std::error::Error for PropertyReadError {}

/// `value[key]`, `value` being `undefined` (`None`) or a JSON value, for a
/// key that no prototype in the way has (not `length`, `map`, `toString`
/// or the like): the object's own property, `None` (`undefined`) for
/// anything else, the `TypeError` for `undefined` and `null`.
pub fn get_property<'a>(
    value: Option<&'a JsonValue>,
    key: &str,
) -> Result<Option<&'a JsonValue>, PropertyReadError> {
    match value {
        None => Err(PropertyReadError::of_undefined(key)),
        Some(JsonValue::Null) => Err(PropertyReadError::of_null(key)),
        Some(JsonValue::Object(map)) => Ok(map.get(key)),
        Some(_) => Ok(None),
    }
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
pub(crate) fn array_index(key: &str) -> Option<u32> {
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
    fn depth_counts_levels() {
        let depth_of = |text: &str| depth(&parse(text).unwrap());
        assert_eq!(depth_of("1"), 1);
        assert_eq!(depth_of("[]"), 1);
        assert_eq!(depth_of("{}"), 1);
        assert_eq!(depth_of("[1]"), 2);
        assert_eq!(depth_of(r#"[1, {"a": [[]], "b": 2}, []]"#), 4);
        let n = 1_000_000;
        assert_eq!(depth_of(&format!("{}{}", "[".repeat(n), "]".repeat(n))), n);
    }

    #[test]
    fn clones_keep_order_and_never_recurse() {
        let v = parse(r#"{"b": [1, {"2": null, "a": "x"}, []], "1": true, "": {}}"#).unwrap();
        assert_eq!(v.clone(), v);
        assert_eq!(stringify(&v.clone(), None), stringify(&v, None));
        assert_eq!(JsonValue::Number(-0.0).clone(), JsonValue::Number(0.0));

        // A million levels, on the test thread's small stack.
        let depth = 1_000_000;
        let deep = parse(&format!(
            "{}1{}",
            r#"[{"a":"#.repeat(depth),
            "}]".repeat(depth)
        ))
        .unwrap();
        let mut copy = &deep.clone();
        let mut levels = 0;
        loop {
            copy = match copy {
                JsonValue::Array(items) if items.len() == 1 => &items[0],
                JsonValue::Object(map) if map.len() == 1 => &map["a"],
                _ => break,
            };
            levels += 1;
        }
        assert_eq!(levels, 2 * depth);
        assert_eq!(*copy, JsonValue::Number(1.0));
    }

    /// `JsonValue` as the derived `Debug` writes it.
    #[derive(Debug)]
    #[allow(dead_code)] // Read by `Debug` only.
    enum Derived {
        Null,
        Bool(bool),
        Number(f64),
        String(String),
        Array(Vec<Derived>),
        Object(IndexMap<String, Derived>),
    }

    impl Derived {
        fn of(value: &JsonValue) -> Derived {
            match value {
                JsonValue::Null => Derived::Null,
                JsonValue::Bool(b) => Derived::Bool(*b),
                JsonValue::Number(n) => Derived::Number(*n),
                JsonValue::String(s) => Derived::String(s.clone()),
                JsonValue::Array(items) => Derived::Array(items.iter().map(Derived::of).collect()),
                JsonValue::Object(map) => Derived::Object(
                    map.iter()
                        .map(|(k, v)| (k.clone(), Derived::of(v)))
                        .collect(),
                ),
            }
        }
    }

    /// A million levels of `[{"a": …}]` around `1`.
    fn million_levels() -> JsonValue {
        let depth = 1_000_000;
        parse(&format!(
            "{}1{}",
            r#"[{"a":"#.repeat(depth),
            "}]".repeat(depth)
        ))
        .unwrap()
    }

    #[test]
    fn equality_and_debug_never_recurse() {
        // On the test thread's small stack.
        let deep = million_levels();
        let copy = deep.clone();
        assert!(deep == copy);
        let mut other = million_levels();
        let mut innermost = &mut other;
        loop {
            innermost = match innermost {
                JsonValue::Array(items) => &mut items[0],
                JsonValue::Object(map) => map.get_index_mut(0).unwrap().1,
                leaf => break *leaf = JsonValue::Number(2.0),
            };
        }
        assert!(deep != other);

        let compact = format!("{deep:?}");
        let elided = "Array([Object({\"a\": ".repeat(50) + "Array([..])" + &"})])".repeat(50);
        assert_eq!(compact, elided);
        let pretty = format!("{deep:#?}");
        assert!(
            pretty.starts_with("Array(\n    [\n        Object(\n"),
            "{pretty:.40}"
        );
        assert!(pretty.contains("Array([..])"));
    }

    #[test]
    fn equality_is_the_derived_one() {
        let v = |text: &str| parse(text).unwrap();
        assert_eq!(
            v(r#"{"a": 1, "b": [true, null]}"#),
            v(r#"{"b": [true, null], "a": 1}"#)
        );
        assert_ne!(v(r#"{"a": 1}"#), v(r#"{"a": 1, "b": 1}"#));
        assert_ne!(v(r#"{"a": 1, "c": 1}"#), v(r#"{"a": 1, "b": 1}"#));
        assert_ne!(v("[1, 2]"), v("[2, 1]"));
        assert_ne!(v("[1]"), v("[1, 1]"));
        assert_ne!(v("[]"), v("{}"));
        assert_ne!(v("0"), v("false"));
        assert_ne!(v(r#""""#), v("null"));
        assert_eq!(v("-0"), v("0"));
        assert_ne!(JsonValue::Number(f64::NAN), JsonValue::Number(f64::NAN));
    }

    #[test]
    fn debug_is_the_derived_format() {
        for text in [
            "null",
            "true",
            "-0.5",
            r#""a\"b\n""#,
            "[]",
            "{}",
            "[[]]",
            r#"[1, null, "x", [false, {}], {"k\n": [2]}]"#,
            r#"{"a": {"b": [1, {"c": null}]}, "": [[], [[3]]]}"#,
        ] {
            let value = parse(text).unwrap();
            let derived = Derived::of(&value);
            assert_eq!(format!("{value:?}"), format!("{derived:?}"), "{text}");
            assert_eq!(format!("{value:#?}"), format!("{derived:#?}"), "{text}");
        }
        // Down to the elided depth.
        let deep = parse(&format!("{}{}", "[".repeat(100), "]".repeat(100))).unwrap();
        assert_eq!(format!("{deep:#?}"), format!("{:#?}", Derived::of(&deep)));
        let deeper = parse(&format!("{}{}", "[".repeat(102), "]".repeat(102))).unwrap();
        let elided = "Array([".repeat(100) + "Array([..])" + &"])".repeat(100);
        assert_eq!(format!("{deeper:?}"), elided);
    }

    #[test]
    fn truthiness_and_property_reads_are_javascript_s() {
        let v = parse(r#"[null, false, 0, -0, "", true, 1, "0", [], {}]"#).unwrap();
        let JsonValue::Array(items) = &v else {
            panic!("an array");
        };
        let truthy: Vec<bool> = items.iter().map(is_truthy).collect();
        assert_eq!(
            truthy,
            [
                false, false, false, false, false, true, true, true, true, true
            ]
        );
        assert!(!is_truthy_number(f64::NAN));

        let o = parse(r#"{"a": {"b": 1}, "n": null, "s": "x"}"#).unwrap();
        assert_eq!(get_property(Some(&o), "a").unwrap(), o_get(&o, "a"));
        assert_eq!(get_property(Some(&o), "zz").unwrap(), None);
        assert_eq!(get_property(o_get(&o, "s"), "length").unwrap(), None);
        assert_eq!(
            get_property(o_get(&o, "n"), "b").unwrap_err().message(),
            "Cannot read properties of null (reading 'b')"
        );
        assert_eq!(
            get_property(None, "b").unwrap_err().to_string(),
            "Cannot read properties of undefined (reading 'b')"
        );
    }

    fn o_get<'a>(o: &'a JsonValue, key: &str) -> Option<&'a JsonValue> {
        match o {
            JsonValue::Object(map) => map.get(key),
            _ => None,
        }
    }

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
