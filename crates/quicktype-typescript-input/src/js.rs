//! JavaScript value semantics that typescript-json-schema's output depends on.
//!
//! typescript-json-schema builds the schema out of plain JavaScript objects
//! and arrays that it shares and mutates by reference (a definition is
//! stored in `reffedDefinitions` and filled in afterwards, `items` and the
//! tuple element list are the same array, …), and quicktype serializes the
//! result with `JSON.stringify`. [`Value`] therefore models JavaScript
//! values with reference semantics (`Rc<RefCell<…>>`), and [`JsObject`]
//! reproduces JavaScript's own-property order: integer-like keys first in
//! ascending order, then the remaining keys in insertion order.
//!
//! String escaping, number formatting, UTF-16 ordering and JavaScript
//! whitespace come from `quicktype-js-compat`; this module adds the shared
//! object graph, `JSON.parse` and `parseFloat`.

use quicktype_js_compat::hash::HashMap;
use std::cell::RefCell;
use std::cmp::Ordering;
use std::rc::Rc;

pub use quicktype_js_compat::json::quote;
use quicktype_js_compat::json::{JsonValue, is_array_index};
pub use quicktype_js_compat::number::to_string as number_to_string;
pub use quicktype_js_compat::sort::compare_utf16;
pub use quicktype_js_compat::whitespace::{
    is_line_terminator, is_whitespace as is_js_whitespace, trim,
};

/// A shared, mutable JavaScript object.
pub type Obj = Rc<RefCell<JsObject>>;
/// A shared, mutable JavaScript array.
pub type Arr = Rc<RefCell<Vec<Value>>>;

/// A JavaScript value, as far as JSON schemas need one.
#[derive(Clone, Debug)]
pub enum Value {
    /// `undefined`: skipped by `JSON.stringify` in objects, `null` in arrays.
    Undefined,
    /// `null`.
    Null,
    /// A boolean.
    Bool(bool),
    /// A number (always a double in JavaScript).
    Number(f64),
    /// A string.
    String(String),
    /// An array, shared by reference.
    Array(Arr),
    /// An object, shared by reference.
    Object(Obj),
    /// A value `JSON.stringify` drops (a function or symbol); the string is
    /// what `String(value)` gives.
    Opaque(String),
}

impl Value {
    /// A new, empty object.
    pub fn object() -> Obj {
        Rc::new(RefCell::new(JsObject::default()))
    }

    /// A new array holding `items`.
    pub fn array(items: Vec<Value>) -> Value {
        Value::Array(Rc::new(RefCell::new(items)))
    }

    /// A string value.
    pub fn str(s: impl Into<String>) -> Value {
        Value::String(s.into())
    }

    /// `typeof value`.
    pub fn type_of(&self) -> &'static str {
        match self {
            Value::Undefined => "undefined",
            Value::Null | Value::Array(_) | Value::Object(_) => "object",
            Value::Bool(_) => "boolean",
            Value::Number(_) => "number",
            Value::String(_) => "string",
            Value::Opaque(_) => "function",
        }
    }

    /// JavaScript truthiness.
    pub fn truthy(&self) -> bool {
        match self {
            Value::Undefined | Value::Null => false,
            Value::Bool(b) => *b,
            Value::Number(n) => quicktype_js_compat::json::is_truthy_number(*n),
            Value::String(s) => !s.is_empty(),
            Value::Array(_) | Value::Object(_) | Value::Opaque(_) => true,
        }
    }

    /// The string, if this is one.
    pub fn as_str(&self) -> Option<&str> {
        match self {
            Value::String(s) => Some(s),
            _ => None,
        }
    }

    /// The object, if this is one.
    pub fn as_object(&self) -> Option<&Obj> {
        match self {
            Value::Object(o) => Some(o),
            _ => None,
        }
    }

    /// `===`: identity for objects and arrays, value equality otherwise
    /// (`NaN !== NaN`).
    pub fn strict_equals(&self, other: &Value) -> bool {
        match (self, other) {
            (Value::Undefined, Value::Undefined) | (Value::Null, Value::Null) => true,
            (Value::Bool(a), Value::Bool(b)) => a == b,
            (Value::Number(a), Value::Number(b)) => a == b,
            (Value::String(a), Value::String(b)) => a == b,
            (Value::Array(a), Value::Array(b)) => Rc::ptr_eq(a, b),
            (Value::Object(a), Value::Object(b)) => Rc::ptr_eq(a, b),
            _ => false,
        }
    }

    /// `String(value)`.
    pub fn to_js_string(&self) -> String {
        match self {
            Value::Undefined => "undefined".into(),
            Value::Null => "null".into(),
            Value::Bool(b) => b.to_string(),
            Value::Number(n) => number_to_string(*n),
            Value::String(s) => s.clone(),
            Value::Array(a) => a
                .borrow()
                .iter()
                .map(|v| match v {
                    Value::Undefined | Value::Null => String::new(),
                    v => v.to_js_string(),
                })
                .collect::<Vec<_>>()
                .join(","),
            Value::Object(_) => "[object Object]".into(),
            Value::Opaque(s) => s.clone(),
        }
    }
}

/// A JavaScript object's own enumerable string-keyed properties.
#[derive(Default, Debug)]
pub struct JsObject {
    /// In insertion order.
    entries: Vec<(String, Value)>,
    /// Positions in `entries` by key, once there are enough entries that a
    /// linear search costs more than hashing (the schema's `definitions`
    /// hold one entry per type).
    index: Option<HashMap<String, usize>>,
    /// Whether some key is an array index (and `keys` must sort).
    has_index_keys: bool,
}

/// Entries from which a [`JsObject`] keeps a hash index.
const INDEXED_FROM: usize = 16;

impl JsObject {
    fn position(&self, key: &str) -> Option<usize> {
        match &self.index {
            Some(index) => index.get(key).copied(),
            None => self.entries.iter().position(|(k, _)| k == key),
        }
    }

    /// The value of own property `key`.
    pub fn get(&self, key: &str) -> Option<Value> {
        self.position(key).map(|i| self.entries[i].1.clone())
    }

    /// `hasOwnProperty(key)`.
    pub fn has(&self, key: &str) -> bool {
        self.position(key).is_some()
    }

    /// Defines own property `key` (`CreateDataProperty`: object literals,
    /// spread, `JSON.parse`); an existing key keeps its position.
    pub fn define(&mut self, key: &str, value: Value) {
        match self.position(key) {
            Some(i) => self.entries[i].1 = value,
            None => {
                self.has_index_keys |= is_array_index(key);
                self.entries.push((key.to_owned(), value));
                let at = self.entries.len() - 1;
                match &mut self.index {
                    Some(index) => {
                        index.insert(key.to_owned(), at);
                    }
                    None if self.entries.len() >= INDEXED_FROM => self.reindex(),
                    None => {}
                }
            }
        }
    }

    fn reindex(&mut self) {
        self.index = Some(
            self.entries
                .iter()
                .enumerate()
                .map(|(i, (k, _))| (k.clone(), i))
                .collect(),
        );
    }

    /// `obj[key] = value`. Assigning `__proto__` changes the prototype rather
    /// than creating a property, so it leaves no trace in the output.
    pub fn set(&mut self, key: &str, value: Value) {
        if key != "__proto__" {
            self.define(key, value);
        }
    }

    /// `delete obj[key]`.
    pub fn remove(&mut self, key: &str) {
        if let Some(i) = self.position(key) {
            self.entries.remove(i);
            if self.index.is_some() {
                self.reindex();
            }
        }
    }

    /// Positions in `entries`, in `Object.keys` order: array indices
    /// ascending, then the other keys in insertion order.
    fn order(&self) -> Vec<usize> {
        if !self.has_index_keys {
            return (0..self.entries.len()).collect();
        }
        let mut indices: Vec<(u64, usize)> = self
            .entries
            .iter()
            .enumerate()
            .filter(|(_, (k, _))| is_array_index(k))
            .map(|(i, (k, _))| (k.parse().unwrap_or(0), i))
            .collect();
        indices.sort_by_key(|(n, _)| *n);
        let mut order: Vec<usize> = indices.into_iter().map(|(_, i)| i).collect();
        order.extend(
            self.entries
                .iter()
                .enumerate()
                .filter(|(_, (k, _))| !is_array_index(k))
                .map(|(i, _)| i),
        );
        order
    }

    /// `Object.keys(obj)`: array indices ascending, then insertion order.
    pub fn keys(&self) -> Vec<String> {
        self.order()
            .into_iter()
            .map(|i| self.entries[i].0.clone())
            .collect()
    }

    /// `Object.entries(obj)`.
    pub fn entries(&self) -> Vec<(String, Value)> {
        self.order()
            .into_iter()
            .map(|i| self.entries[i].clone())
            .collect()
    }

    /// The number of own properties.
    pub fn len(&self) -> usize {
        self.entries.len()
    }

    /// Whether there are no own properties.
    pub fn is_empty(&self) -> bool {
        self.entries.is_empty()
    }
}

/// Whether `key` names a property of `Object.prototype`, which a lookup on a
/// plain JavaScript object (`table[key]`) finds even when the object has no
/// such own property.
pub fn is_object_prototype_key(key: &str) -> bool {
    matches!(
        key,
        "constructor"
            | "__defineGetter__"
            | "__defineSetter__"
            | "hasOwnProperty"
            | "__lookupGetter__"
            | "__lookupSetter__"
            | "isPrototypeOf"
            | "propertyIsEnumerable"
            | "toString"
            | "valueOf"
            | "__proto__"
            | "toLocaleString"
    )
}

/// `{...a, ...b}` for objects: a new object with `a`'s and then `b`'s own
/// properties. `None` (spreading `undefined`) contributes nothing.
pub fn spread(parts: &[Option<&Obj>]) -> Obj {
    let out = Value::object();
    for part in parts.iter().flatten() {
        for (k, v) in part.borrow().entries() {
            out.borrow_mut().define(&k, v);
        }
    }
    out
}

/// `JSON.stringify(value)` (compact).
pub fn stringify(value: &Value) -> String {
    let mut out = String::new();
    write_json(&mut out, value);
    out
}

fn write_json(out: &mut String, value: &Value) {
    match value {
        Value::Undefined | Value::Opaque(_) | Value::Null => out.push_str("null"),
        Value::Bool(b) => out.push_str(if *b { "true" } else { "false" }),
        Value::Number(n) => out.push_str(&quicktype_js_compat::json::number(*n)),
        Value::String(s) => out.push_str(&quote(s)),
        Value::Array(a) => {
            out.push('[');
            for (i, v) in a.borrow().iter().enumerate() {
                if i > 0 {
                    out.push(',');
                }
                write_json(out, v);
            }
            out.push(']');
        }
        Value::Object(o) => {
            out.push('{');
            let mut first = true;
            for (k, v) in o.borrow().entries() {
                if matches!(v, Value::Undefined | Value::Opaque(_)) {
                    continue;
                }
                if !first {
                    out.push(',');
                }
                first = false;
                out.push_str(&quote(&k));
                out.push(':');
                write_json(out, &v);
            }
            out.push('}');
        }
    }
}

/// `Array.prototype.sort()` without a comparator: elements compared as
/// strings by UTF-16 code units, `undefined` last; stable.
pub fn default_sort(values: &mut [Value]) {
    quicktype_js_compat::sort::sort_by(values, |a, b| match (a, b) {
        (Value::Undefined, Value::Undefined) => Ordering::Equal,
        (Value::Undefined, _) => Ordering::Greater,
        (_, Value::Undefined) => Ordering::Less,
        _ => compare_utf16(&a.to_js_string(), &b.to_js_string()),
    });
}

/// `encodeURIComponent(s)`.
pub fn encode_uri_component(s: &str) -> String {
    let mut out = String::with_capacity(s.len());
    for b in s.bytes() {
        if b.is_ascii_alphanumeric() || b"-_.!~*'()".contains(&b) {
            out.push(b as char);
        } else {
            out.push_str(&format!("%{b:02X}"));
        }
    }
    out
}

/// `parseFloat(s)`.
pub fn parse_float(s: &str) -> f64 {
    let s = s.trim_start_matches(is_js_whitespace);
    let b = s.as_bytes();
    let mut i = 0;
    if i < b.len() && (b[i] == b'+' || b[i] == b'-') {
        i += 1;
    }
    if s[i..].starts_with("Infinity") {
        return if b.first() == Some(&b'-') {
            f64::NEG_INFINITY
        } else {
            f64::INFINITY
        };
    }
    let start_digits = i;
    while i < b.len() && b[i].is_ascii_digit() {
        i += 1;
    }
    let mut digits = i - start_digits;
    if i < b.len() && b[i] == b'.' {
        let dot = i;
        i += 1;
        let frac = i;
        while i < b.len() && b[i].is_ascii_digit() {
            i += 1;
        }
        digits += i - frac;
        if digits == 0 {
            i = dot;
        }
    }
    if digits == 0 {
        return f64::NAN;
    }
    if i < b.len() && (b[i] == b'e' || b[i] == b'E') {
        let mut j = i + 1;
        if j < b.len() && (b[j] == b'+' || b[j] == b'-') {
            j += 1;
        }
        let exp_digits = j;
        while j < b.len() && b[j].is_ascii_digit() {
            j += 1;
        }
        if j > exp_digits {
            i = j;
        }
    }
    s[..i].parse::<f64>().unwrap_or(f64::NAN)
}

/// `JSON.parse(text)`, or `None` where it would throw.
pub fn parse_json(text: &str) -> Option<Value> {
    quicktype_js_compat::json::parse(text)
        .ok()
        .map(|value| from_json(&value))
}

/// The JavaScript value of a parsed JSON value. Object properties are
/// defined in the parsed order (`JSON.parse` defines, it does not assign,
/// so `"__proto__"` is an ordinary key).
fn from_json(value: &JsonValue) -> Value {
    // One level per call, on a stack that grows as needed.
    stacker::maybe_grow(256 * 1024, 4 * 1024 * 1024, || match value {
        JsonValue::Null => Value::Null,
        JsonValue::Bool(b) => Value::Bool(*b),
        JsonValue::Number(n) => Value::Number(*n),
        JsonValue::String(s) => Value::String(s.clone()),
        JsonValue::Array(items) => Value::array(items.iter().map(from_json).collect()),
        JsonValue::Object(map) => {
            let obj = Value::object();
            for (key, v) in map {
                obj.borrow_mut().define(key, from_json(v));
            }
            Value::Object(obj)
        }
    })
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn object_keys_follow_javascript_order() {
        let o = Value::object();
        for k in ["b", "1", "a", "0", "01", "4294967295"] {
            o.borrow_mut().set(k, Value::Null);
        }
        assert_eq!(o.borrow().keys(), ["0", "1", "b", "a", "01", "4294967295"]);
        o.borrow_mut().set("__proto__", Value::Null);
        assert!(!o.borrow().has("__proto__"));
    }

    #[test]
    fn large_objects_keep_order_through_the_index() {
        let o = Value::object();
        let mut expected: Vec<String> = Vec::new();
        for i in 0..40 {
            let k = if i % 7 == 0 {
                (100 - i).to_string()
            } else {
                format!("k{i}")
            };
            o.borrow_mut().set(&k, Value::Number(f64::from(i)));
            expected.push(k);
        }
        // Redefining keeps the position; removing shifts the rest.
        o.borrow_mut().set("k3", Value::str("x"));
        o.borrow_mut().remove("k5");
        o.borrow_mut().remove("absent");
        o.borrow_mut().set("k5", Value::Null);
        expected.retain(|k| k != "k5");
        expected.push("k5".into());
        let mut numeric: Vec<u64> = expected.iter().filter_map(|k| k.parse().ok()).collect();
        numeric.sort_unstable();
        let mut order: Vec<String> = numeric.iter().map(u64::to_string).collect();
        order.extend(
            expected
                .iter()
                .filter(|k| k.parse::<u64>().is_err())
                .cloned(),
        );
        let obj = o.borrow();
        assert_eq!(obj.keys(), order);
        assert_eq!(obj.len(), 40);
        assert_eq!(
            obj.get("k3").and_then(|v| v.as_str().map(str::to_owned)),
            Some("x".into())
        );
        assert!(obj.has("k5") && obj.has("93") && !obj.has("k100"));
        let entries: Vec<String> = obj.entries().into_iter().map(|(k, _)| k).collect();
        assert_eq!(entries, order);
    }

    #[test]
    fn json_round_trip() {
        let v = parse_json(r#" {"b": [1, 2.5e3, "xA"], "a": null, "0": true} "#).unwrap();
        assert_eq!(stringify(&v), r#"{"0":true,"b":[1,2500,"xA"],"a":null}"#);
        assert!(parse_json("01").is_none());
        assert!(parse_json("[1,]").is_none());
        assert!(parse_json("'x'").is_none());
    }

    #[test]
    fn parse_float_takes_the_longest_prefix() {
        assert_eq!(parse_float(" 12.5abc"), 12.5);
        assert_eq!(parse_float("1e3x"), 1000.0);
        assert_eq!(parse_float("1e"), 1.0);
        assert!(parse_float("abc").is_nan());
        assert!(parse_float(".").is_nan());
        assert_eq!(parse_float(".5"), 0.5);
    }

    #[test]
    fn default_sort_compares_strings() {
        let mut v = vec![
            Value::Number(10.0),
            Value::Number(9.0),
            Value::str("a"),
            Value::Bool(true),
        ];
        default_sort(&mut v);
        let s: Vec<String> = v.iter().map(Value::to_js_string).collect();
        assert_eq!(s, ["10", "9", "a", "true"]);
    }

    #[test]
    fn encodes_uri_components() {
        assert_eq!(encode_uri_component("Box<string>"), "Box%3Cstring%3E");
        assert_eq!(encode_uri_component("a b/ü"), "a%20b%2F%C3%BC");
    }
}
