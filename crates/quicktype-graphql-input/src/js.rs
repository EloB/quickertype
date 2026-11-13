//! JavaScript semantics for reading the introspection JSON.
//!
//! The TypeScript input types the schema as `any` and walks it with plain
//! property reads, so a malformed schema fails the way JavaScript fails:
//! `Cannot read properties of undefined (reading '__schema')`,
//! `schema.__schema.types is not iterable`, `f.args.map is not a function`.
//! [`JsVal`] is a value read from the JSON (or `undefined`) with exactly
//! those reads, truthiness, `===`, and `String(value)` for the template
//! literals of quicktype's messages.

use quicktype_core::{JsErrorName, QuickTypeError, Result};
use quicktype_js_compat::json::JsonValue;

/// A JavaScript value: `undefined`, a value of the parsed JSON, or a
/// string that is not in the JSON (the name of a built-in function).
#[derive(Clone, Copy, Debug)]
pub(crate) enum JsVal<'a> {
    /// `undefined`.
    Undefined,
    /// A JSON value.
    Json(&'a JsonValue),
    /// A string from elsewhere.
    Str(&'static str),
}

/// A JavaScript `TypeError`.
pub(crate) fn type_error(message: impl Into<String>) -> QuickTypeError {
    QuickTypeError::js_exception(JsErrorName::TypeError, message)
}

impl<'a> JsVal<'a> {
    /// `value[key]` for a key no prototype in the way has: `undefined`
    /// unless the value is an object with that own property, a
    /// `TypeError` for `undefined` and `null`.
    pub(crate) fn get(self, key: &str) -> Result<JsVal<'a>> {
        match self {
            JsVal::Undefined => Err(type_error(format!(
                "Cannot read properties of undefined (reading '{key}')"
            ))),
            JsVal::Json(JsonValue::Null) => Err(type_error(format!(
                "Cannot read properties of null (reading '{key}')"
            ))),
            JsVal::Json(JsonValue::Object(map)) => {
                Ok(map.get(key).map_or(JsVal::Undefined, JsVal::Json))
            }
            JsVal::Json(_) | JsVal::Str(_) => Ok(JsVal::Undefined),
        }
    }

    /// The elements of `value.map(...)`, whose source text (for the error)
    /// is `expression` (e.g. `source.fields`).
    pub(crate) fn map_elements(self, expression: &str) -> Result<&'a [JsonValue]> {
        match self {
            JsVal::Json(JsonValue::Array(items)) => Ok(items),
            JsVal::Undefined | JsVal::Json(JsonValue::Null) => self.get("map").map(|_| &[][..]),
            _ => Err(type_error(format!("{expression}.map is not a function"))),
        }
    }

    /// The values `for (const x of value)` iterates (the code points of a
    /// string, the elements of an array), or the `TypeError` for anything
    /// else, whose source text is `expression`.
    pub(crate) fn iterate(self, expression: &str) -> Result<Vec<JsVal<'a>>> {
        match self {
            JsVal::Json(JsonValue::Array(items)) => Ok(items.iter().map(JsVal::Json).collect()),
            // Each code point is a string; nothing reads more than its
            // properties (all `undefined`), so any string stands in.
            JsVal::Json(JsonValue::String(s)) => Ok(s.chars().map(|_| JsVal::Str("")).collect()),
            _ => Err(type_error(format!("{expression} is not iterable"))),
        }
    }

    /// Whether the value is truthy.
    pub(crate) fn truthy(self) -> bool {
        match self {
            JsVal::Undefined => false,
            JsVal::Str(s) => !s.is_empty(),
            JsVal::Json(v) => match v {
                JsonValue::Null => false,
                JsonValue::Bool(b) => *b,
                JsonValue::Number(n) => *n != 0.0 && !n.is_nan(),
                JsonValue::String(s) => !s.is_empty(),
                JsonValue::Array(_) | JsonValue::Object(_) => true,
            },
        }
    }

    /// Whether the value is `null` (`=== null`).
    pub(crate) fn is_null(self) -> bool {
        matches!(self, JsVal::Json(JsonValue::Null))
    }

    /// The value if it is a string.
    pub(crate) fn as_str(self) -> Option<&'a str> {
        match self {
            JsVal::Json(JsonValue::String(s)) => Some(s),
            JsVal::Str(s) => Some(s),
            _ => None,
        }
    }

    /// `a === b`: strings, numbers and booleans by value, objects and
    /// arrays by identity.
    pub(crate) fn strict_equals(self, other: JsVal<'_>) -> bool {
        if let (Some(a), Some(b)) = (self.as_str(), other.as_str()) {
            return a == b;
        }
        match (self, other) {
            (JsVal::Undefined, JsVal::Undefined) => true,
            (JsVal::Json(a), JsVal::Json(b)) => match (a, b) {
                (JsonValue::Null, JsonValue::Null) => true,
                (JsonValue::Bool(x), JsonValue::Bool(y)) => x == y,
                (JsonValue::Number(x), JsonValue::Number(y)) => x == y,
                (JsonValue::Array(_), JsonValue::Array(_))
                | (JsonValue::Object(_), JsonValue::Object(_)) => std::ptr::eq(a, b),
                _ => false,
            },
            _ => false,
        }
    }

    /// `String(value)`, as a template literal converts it.
    pub(crate) fn to_js_string(self) -> String {
        match self {
            JsVal::Undefined => "undefined".to_owned(),
            JsVal::Str(s) => s.to_owned(),
            JsVal::Json(v) => json_to_string(v),
        }
    }
}

/// `String(value)` of a JSON value: arrays joined with commas (`null`
/// elements empty), objects `[object Object]`.
fn json_to_string(value: &JsonValue) -> String {
    match value {
        JsonValue::Null => "null".to_owned(),
        JsonValue::Bool(b) => b.to_string(),
        JsonValue::Number(n) => quicktype_js_compat::number::to_string(*n),
        JsonValue::String(s) => s.clone(),
        JsonValue::Array(items) => items
            .iter()
            .map(|item| match item {
                JsonValue::Null => String::new(),
                other => json_to_string(other),
            })
            .collect::<Vec<_>>()
            .join(","),
        JsonValue::Object(_) => "[object Object]".to_owned(),
    }
}

/// The names of the functions on `Object.prototype` (what
/// `obj[key]` finds for those keys when `obj` lacks them), as each
/// function's `name` gives it. `__proto__` is `Object.prototype` itself.
pub(crate) fn object_prototype_function(key: &str) -> Option<&'static str> {
    Some(match key {
        "constructor" => "Object",
        "__defineGetter__" => "__defineGetter__",
        "__defineSetter__" => "__defineSetter__",
        "hasOwnProperty" => "hasOwnProperty",
        "__lookupGetter__" => "__lookupGetter__",
        "__lookupSetter__" => "__lookupSetter__",
        "isPrototypeOf" => "isPrototypeOf",
        "propertyIsEnumerable" => "propertyIsEnumerable",
        "toString" => "toString",
        "valueOf" => "valueOf",
        "toLocaleString" => "toLocaleString",
        _ => return None,
    })
}

#[cfg(test)]
mod tests {
    use super::*;
    use quicktype_js_compat::json::parse;

    #[test]
    fn strings_like_javascript() {
        let v = parse(r#"[1, null, "a", [2, [3]], {"x": 1}, true, 1e21]"#).unwrap();
        assert_eq!(
            JsVal::Json(&v).to_js_string(),
            "1,,a,2,3,[object Object],true,1e+21"
        );
        assert_eq!(JsVal::Undefined.to_js_string(), "undefined");
    }

    #[test]
    fn property_reads_and_iteration() {
        let v = parse(r#"{"a": null, "s": "xy", "o": {}}"#).unwrap();
        let o = JsVal::Json(&v);
        assert_eq!(
            o.get("a").unwrap().get("b").unwrap_err().user_message(),
            "Cannot read properties of null (reading 'b')"
        );
        assert_eq!(o.get("s").unwrap().iterate("x").unwrap().len(), 2);
        assert_eq!(
            o.get("o")
                .unwrap()
                .iterate("o.o")
                .unwrap_err()
                .user_message(),
            "o.o is not iterable"
        );
        assert_eq!(
            o.get("s")
                .unwrap()
                .map_elements("o.s")
                .unwrap_err()
                .user_message(),
            "o.s.map is not a function"
        );
    }
}
