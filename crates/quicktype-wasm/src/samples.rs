//! JSON samples read as they are added: `JSONInput.addSource(Sync)` of the
//! facade hands each string sample of a `CompressedJSONFromString` to
//! [`json_read`] instead of `JSON.parse`, and the compressed form stays here,
//! in one [`CompressedJson`] per JavaScript `CompressedJSON`, for every run
//! that uses the input (`kind: "jsonShared"` in the request). The facade
//! keeps the JavaScript side in step (`npm/quicktype-core/src/native/samples.ts`):
//! it fills the JavaScript tables only if something reads them, by reading
//! the same texts with TypeScript's own code.
//!
//! What a sample's root value is in TypeScript (`tag | index << 4`) is
//! returned as it is computed there: objects and arrays are numbered as
//! TypeScript numbers them (in the order they end), and samples whose root
//! is a string (whose index depends on TypeScript's string table) are not
//! read here. Neither are samples the engine could not read exactly: nested
//! deeper than [`MAX_DEPTH`] (TypeScript's recursive `process` may run out
//! of stack where this reader would not), or with a `\u` escape that leaves
//! a surrogate unpaired (a Rust string cannot hold it).

use std::cell::RefCell;
use std::rc::Rc;

use quicktype_core::input::compressed_json::{
    CompressedJson, ParseError, ReadStringError, StringSampleLimits, Value,
};
use quicktype_core::support::integer_range::IntegerRange;
use wasm_bindgen::prelude::*;

use crate::wire::DateTimeKind;

/// The deepest nesting of objects and arrays read here. Node's default
/// stack lets TypeScript's `process` go about 2,500 to 5,000 levels deep
/// (less in a host with a smaller stack, or when called on a deep stack);
/// a sample deeper than this is left to TypeScript, which fails (or not)
/// as it does.
pub const MAX_DEPTH: usize = 256;

const LIMITS: StringSampleLimits = StringSampleLimits {
    max_depth: Some(MAX_DEPTH),
    lone_surrogates: false,
};

/// [`json_read`]: the sample is not JSON; nothing was read (TypeScript's
/// `JSON.parse` throws its error).
pub const INVALID: i32 = 0;

/// [`json_read`]: the sample is not read here (see the module
/// documentation), or the compressed form is in use by a run; the facade
/// reads it, and those before it, with TypeScript from now on.
pub const DECLINED: i32 = -1;

thread_local! {
    /// The compressed forms, by id; a run holds its own reference while it
    /// uses one.
    static SAMPLES: RefCell<Vec<Option<Rc<CompressedJson>>>> = const { RefCell::new(Vec::new()) };
}

/// `new CompressedJSONFromString(dateTimeRecognizer, handleRefs,
/// supportedIntegerRange)` without samples yet: returns its id.
/// `date_time` names a built-in recognizer (as in the request), and the
/// range is `null` (arbitrary precision) unless both bounds are given.
#[wasm_bindgen(js_name = jsonCreate)]
pub fn json_create(
    date_time: &str,
    handle_refs: bool,
    min: Option<String>,
    max: Option<String>,
) -> std::result::Result<u32, JsValue> {
    let recognizer = DateTimeKind::from_name(date_time)
        .ok_or_else(|| JsValue::from_str("unknown date/time recognizer"))?
        .recognizer()
        .map_err(|e| JsValue::from_str(e.user_message()))?;
    let range = match (min, max) {
        (Some(min), Some(max)) => Some(IntegerRange::new(min, max)),
        _ => None,
    };
    let cjson = Rc::new(CompressedJson::new(recognizer, handle_refs, range));
    Ok(SAMPLES.with(|samples| {
        let mut samples = samples.borrow_mut();
        match samples.iter().position(Option::is_none) {
            Some(free) => {
                samples[free] = Some(cjson);
                free as u32
            }
            None => {
                samples.push(Some(cjson));
                (samples.len() - 1) as u32
            }
        }
    }))
}

/// `parseSync(text)` on compressed form `id`: the sample's root value as
/// TypeScript encodes it (a positive number), [`INVALID`] or
/// [`DECLINED`].
#[wasm_bindgen(js_name = jsonRead)]
pub fn json_read(id: u32, text: &str) -> i32 {
    SAMPLES.with(|samples| {
        let mut samples = samples.borrow_mut();
        let Some(Some(shared)) = samples.get_mut(id as usize) else {
            return DECLINED;
        };
        // In use by a run (which keeps the samples it started with).
        let Some(cjson) = Rc::get_mut(shared) else {
            return DECLINED;
        };
        match cjson.read_string_sample(text, LIMITS) {
            Ok(value) => typescript_value(value).unwrap_or(DECLINED),
            Err(ReadStringError::Parse(ParseError::Js(_))) => INVALID,
            Err(_) => DECLINED,
        }
    })
}

/// Drops compressed form `id`: the JavaScript `CompressedJSON` is gone, or
/// has its own tables now. Runs still using it keep it until they end.
#[wasm_bindgen(js_name = jsonDrop)]
pub fn json_drop(id: u32) {
    let dropped = SAMPLES.with(|samples| {
        samples
            .borrow_mut()
            .get_mut(id as usize)
            .and_then(Option::take)
    });
    drop(dropped);
}

/// How many compressed forms are kept (for the facade's tests).
#[doc(hidden)]
#[wasm_bindgen(js_name = __jsonCount)]
pub fn json_count() -> u32 {
    SAMPLES.with(|samples| samples.borrow().iter().filter(|s| s.is_some()).count() as u32)
}

/// Compressed form `id`, for a run.
pub fn shared(id: u32) -> Option<Rc<CompressedJson>> {
    SAMPLES.with(|samples| samples.borrow().get(id as usize).cloned().flatten())
}

/// `makeValue(tag, index)` for a root value that does not depend on the
/// string table; `None` for strings, and for indexes TypeScript cannot
/// encode (`index << 4` overflows 32 bits).
fn typescript_value(value: Value) -> Option<i32> {
    let (tag, index) = match value {
        Value::Null => (1, 0),
        Value::False => (2, 0),
        Value::True => (3, 0),
        Value::Integer => (4, 0),
        Value::Double => (5, 0),
        Value::UninternedString => (7, 0),
        Value::Object(i) => (8, i),
        Value::Array(i) => (9, i),
        Value::InternedString(_) | Value::StringFormat(_) | Value::TransformedString(_) => {
            return None;
        }
    };
    (index < 1 << 27).then_some(tag | ((index as i32) << 4))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn root_values_as_typescript_encodes_them() {
        let id = json_create("default", false, None, None).unwrap();
        assert_eq!(json_read(id, "null"), 1);
        assert_eq!(json_read(id, "1.5"), 5);
        assert_eq!(json_read(id, r#"[{"a": [1]}, {}]"#), 9 | (1 << 4));
        assert_eq!(json_read(id, r#"{"a": {}}"#), 8 | (3 << 4));
        assert_eq!(json_read(id, &format!("\"{}\"", "x".repeat(65))), 7);
        assert_eq!(json_read(id, "[1,"), INVALID);
        assert_eq!(json_read(id, r#""short""#), DECLINED);
        assert_eq!(json_read(id, r#"["\ud800"]"#), DECLINED);
        let deep = format!("{}{}", "[".repeat(MAX_DEPTH + 1), "]".repeat(MAX_DEPTH + 1));
        assert_eq!(json_read(id, &deep), DECLINED);
        let deep = format!("{}{}", "[".repeat(MAX_DEPTH), "]".repeat(MAX_DEPTH));
        assert!(json_read(id, &deep) > 0);
        // A run holds it: no more samples.
        let held = shared(id).unwrap();
        assert_eq!(json_read(id, "[]"), DECLINED);
        drop(held);
        assert!(json_read(id, "[]") > 0);
        json_drop(id);
        assert_eq!(json_read(id, "[]"), DECLINED);
        assert!(shared(id).is_none());
    }

    #[test]
    fn integer_ranges() {
        let int32 = json_create(
            "default",
            false,
            Some("-2147483648".into()),
            Some("2147483647".into()),
        )
        .unwrap();
        assert_eq!(json_read(int32, "2147483648"), 5);
        assert_eq!(json_read(int32, "2147483647"), 4);
        let unbounded = json_create("swift", true, None, None).unwrap();
        assert_eq!(json_read(unbounded, "1e400"), 4);
    }
}
