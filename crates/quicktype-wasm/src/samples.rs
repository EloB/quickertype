//! JSON samples read as they are added: `JSONInput.addSource(Sync)` of the
//! facade hands each string sample of a `CompressedJSONFromString` to
//! [`json_read`] instead of `JSON.parse`, and the compressed form stays here,
//! in one [`CompressedJson`] per JavaScript `CompressedJSON`, for every run
//! that uses the input (`kind: "jsonShared"` in the request). The facade
//! keeps the JavaScript side in step (`npm/quicktype-core/src/native/samples.ts`):
//! if something reads the JavaScript tables, it fills them from here
//! ([`json_export`]), and they are the tables TypeScript would have built.
//!
//! What a sample's root value is in TypeScript (`tag | index << 4`) is
//! returned as it is computed there. Samples whose root is a string are not
//! read here (the facade reads those, and every sample after them, with
//! TypeScript); neither are samples the engine could not read exactly:
//! nested deeper than [`MAX_DEPTH`] (TypeScript's recursive `process` may
//! run out of stack where this reader would not), or with a `\u` escape
//! that leaves a surrogate unpaired (a Rust string cannot hold it).
//!
//! A run takes its hold on the samples ([`json_acquire`], a *lease*) when
//! the facade encodes it, so it keeps the samples it was encoded with
//! whatever happens to the compressed form before it starts: the facade
//! may drop it ([`json_drop`]), and its id is never reused for another
//! (see [`crate::slots`]). While a run holds a compressed form, no sample
//! is added to it.

use std::cell::RefCell;
use std::rc::Rc;

use js_sys::{Int32Array, Object, Reflect, Uint32Array};
use quicktype_core::input::compressed_json::{
    CompressedJson, ParseError, ReadStringError, StringSampleLimits, TableCounts, Value,
};
use quicktype_core::support::integer_range::IntegerRange;
use quicktype_js_compat::utf16;
use wasm_bindgen::prelude::*;

use crate::slots::Slots;
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
/// fills its tables ([`json_export`]) and reads it, and every sample after
/// it, with TypeScript.
pub const DECLINED: i32 = -1;

/// A JavaScript `CompressedJSON`'s samples.
struct Samples {
    cjson: Rc<CompressedJson>,
    /// The tables after the last sample [`json_read`] returned a value for:
    /// what the JavaScript tables are. A sample it declined after reading
    /// it (a string root) may have added to the compressed form.
    committed: TableCounts,
    /// Set once the compressed form went past `committed`: it takes no
    /// more samples.
    closed: bool,
}

thread_local! {
    /// The compressed forms, by id.
    static SAMPLES: RefCell<Slots<Samples>> = const { RefCell::new(Slots::new()) };
    /// The runs' holds on compressed forms, by lease id, until the run
    /// starts ([`take_lease`]) or the facade lets go of it.
    static LEASES: RefCell<Slots<Rc<CompressedJson>>> = const { RefCell::new(Slots::new()) };
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
) -> std::result::Result<f64, JsValue> {
    let recognizer = DateTimeKind::from_name(date_time)
        .ok_or_else(|| JsValue::from_str("unknown date/time recognizer"))?
        .recognizer()
        .map_err(|e| JsValue::from_str(e.user_message()))?;
    let range = match (min, max) {
        (Some(min), Some(max)) => Some(IntegerRange::new(min, max)),
        _ => None,
    };
    let samples = Samples {
        cjson: Rc::new(CompressedJson::new(recognizer, handle_refs, range)),
        committed: TableCounts::default(),
        closed: false,
    };
    SAMPLES
        .with(|all| all.borrow_mut().insert(samples))
        .map_err(|_| JsValue::from_str("too many JSON inputs"))
}

/// `parseSync(text)` on compressed form `id`: the sample's root value as
/// TypeScript encodes it (a positive number), [`INVALID`] or
/// [`DECLINED`].
#[wasm_bindgen(js_name = jsonRead)]
pub fn json_read(id: f64, text: &str) -> i32 {
    SAMPLES.with(|all| {
        let mut all = all.borrow_mut();
        let Some(samples) = all.get_mut(id) else {
            return DECLINED;
        };
        if samples.closed {
            return DECLINED;
        }
        // In use by a run (which keeps the samples it was encoded with).
        let Some(cjson) = Rc::get_mut(&mut samples.cjson) else {
            return DECLINED;
        };
        match cjson.read_string_sample(text, LIMITS) {
            Ok(value) => match root_value(cjson, value) {
                Some(root) => {
                    samples.committed = cjson.table_counts();
                    root
                }
                None => {
                    samples.closed = true;
                    DECLINED
                }
            },
            Err(ReadStringError::Parse(ParseError::Js(_))) => INVALID,
            Err(ReadStringError::Declined(_)) => DECLINED,
            Err(ReadStringError::Parse(_)) => {
                // The commit failed part way.
                samples.closed = true;
                DECLINED
            }
        }
    })
}

/// Drops compressed form `id`: the JavaScript `CompressedJSON` is gone, or
/// has its own tables now. Runs that hold it keep it until they end.
#[wasm_bindgen(js_name = jsonDrop)]
pub fn json_drop(id: f64) {
    let dropped = SAMPLES.with(|all| all.borrow_mut().remove(id));
    drop(dropped);
}

/// The tables of compressed form `id` as the JavaScript `CompressedJSON`
/// holds them, `{ strings, stringLengths, objects, objectOffsets, arrays,
/// arrayOffsets }` (the strings joined, with their lengths in UTF-16 code
/// units; values encoded as TypeScript encodes them, each object's keys
/// and values in turn), or `undefined` for an id that is gone.
#[wasm_bindgen(js_name = jsonExport)]
pub fn json_export(id: f64) -> JsValue {
    // Not borrowed while the tables are built.
    let Some((cjson, committed)) = SAMPLES.with(|all| {
        all.borrow()
            .get(id)
            .map(|samples| (Rc::clone(&samples.cjson), samples.committed))
    }) else {
        return JsValue::UNDEFINED;
    };
    let (tables, _) = cjson.tables_up_to(committed, &[]);
    drop(cjson);
    let lengths: Vec<u32> = tables
        .strings
        .iter()
        .map(|s| utf16::len(s) as u32)
        .collect();
    let strings = tables.strings.concat();
    let object = Object::new();
    let set = |name: &str, value: &JsValue| {
        // Setting a property of a new plain object cannot fail.
        let _ = Reflect::set(&object, &JsValue::from_str(name), value);
    };
    set("strings", &JsValue::from_str(&strings));
    drop(strings);
    set("stringLengths", &Uint32Array::from(lengths.as_slice()));
    set("objects", &Int32Array::from(tables.objects.as_slice()));
    set(
        "objectOffsets",
        &Uint32Array::from(tables.object_offsets.as_slice()),
    );
    set("arrays", &Int32Array::from(tables.arrays.as_slice()));
    set(
        "arrayOffsets",
        &Uint32Array::from(tables.array_offsets.as_slice()),
    );
    object.into()
}

/// A run's hold on compressed form `id`, taken when the facade encodes the
/// run: the id of the lease, which the run's request carries, or
/// `undefined` for an id that is gone. The run takes it over when it
/// starts ([`take_lease`]); a run that does not start lets go of it
/// ([`json_release`]).
#[wasm_bindgen(js_name = jsonAcquire)]
pub fn json_acquire(id: f64) -> Option<f64> {
    let cjson = SAMPLES.with(|all| {
        all.borrow()
            .get(id)
            .map(|samples| Rc::clone(&samples.cjson))
    })?;
    LEASES.with(|leases| leases.borrow_mut().insert(cjson).ok())
}

/// Lets go of a lease whose run did not start.
#[wasm_bindgen(js_name = jsonRelease)]
pub fn json_release(lease: f64) {
    drop(take_lease(lease));
}

/// The compressed form a lease holds, for the run that carries it; the
/// lease is gone afterwards.
pub fn take_lease(lease: f64) -> Option<Rc<CompressedJson>> {
    LEASES.with(|leases| leases.borrow_mut().remove(lease))
}

/// How many compressed forms are kept (for the facade's tests).
#[doc(hidden)]
#[wasm_bindgen(js_name = __jsonCount)]
pub fn json_count() -> u32 {
    SAMPLES.with(|all| all.borrow().len() as u32)
}

/// How many leases are held (for the facade's tests).
#[doc(hidden)]
#[wasm_bindgen(js_name = __jsonLeases)]
pub fn json_leases() -> u32 {
    LEASES.with(|leases| leases.borrow().len() as u32)
}

/// `makeValue(tag, index)` for a root value, if TypeScript's value does
/// not depend on its string table (the root is not a string) and decodes
/// back to it (`index << 4` fits in 32 bits).
fn root_value(cjson: &CompressedJson, value: Value) -> Option<i32> {
    if matches!(
        value,
        Value::InternedString(_) | Value::StringFormat(_) | Value::TransformedString(_)
    ) {
        return None;
    }
    let encoded = cjson.encode_value(value)?;
    let (objects, arrays) = cjson.counts();
    (cjson.decode_value(encoded, objects, arrays).ok() == Some(value)).then_some(encoded)
}

#[cfg(test)]
mod tests {
    use super::*;

    fn create(date_time: &str, min: Option<&str>, max: Option<&str>) -> f64 {
        json_create(date_time, false, min.map(Into::into), max.map(Into::into)).unwrap()
    }

    #[test]
    fn root_values_as_typescript_encodes_them() {
        let id = create("default", None, None);
        assert_eq!(json_read(id, "null"), 1);
        assert_eq!(json_read(id, "1.5"), 5);
        assert_eq!(json_read(id, r#"[{"a": [1]}, {}]"#), 9 | (1 << 4));
        assert_eq!(json_read(id, r#"{"a": {}}"#), 8 | (3 << 4));
        assert_eq!(json_read(id, &format!("\"{}\"", "x".repeat(65))), 7);
        assert_eq!(json_read(id, "[1,"), INVALID);
        assert_eq!(json_read(id, r#"["\ud800"]"#), DECLINED);
        let deep = format!("{}{}", "[".repeat(MAX_DEPTH + 1), "]".repeat(MAX_DEPTH + 1));
        assert_eq!(json_read(id, &deep), DECLINED);
        let deep = format!("{}{}", "[".repeat(MAX_DEPTH), "]".repeat(MAX_DEPTH));
        assert!(json_read(id, &deep) > 0);
        // A run holds it: no more samples.
        let lease = json_acquire(id).unwrap();
        assert_eq!(json_read(id, "[]"), DECLINED);
        json_release(lease);
        assert!(json_read(id, "[]") > 0);
        // A string root: read, but declined, and the form is closed.
        assert_eq!(json_read(id, r#""short""#), DECLINED);
        assert_eq!(json_read(id, "[]"), DECLINED);
        json_drop(id);
        assert_eq!(json_read(id, "[]"), DECLINED);
        assert!(json_acquire(id).is_none());
    }

    #[test]
    fn integer_ranges() {
        let int32 = create("default", Some("-2147483648"), Some("2147483647"));
        assert_eq!(json_read(int32, "2147483648"), 5);
        assert_eq!(json_read(int32, "2147483647"), 4);
        let unbounded = json_create("swift", true, None, None).unwrap();
        assert_eq!(json_read(unbounded, "1e400"), 4);
    }

    /// A lease keeps the samples its run was encoded with: the compressed
    /// form may be dropped and its slot taken by another meanwhile.
    #[test]
    fn a_lease_outlives_its_id() {
        let id = create("default", None, None);
        assert!(json_read(id, r#"{"a": [1]}"#) > 0);
        let lease = json_acquire(id).unwrap();
        json_drop(id);
        let other = create("default", None, None);
        assert!(json_read(other, r#"{"b": "x"}"#) > 0);
        assert!(json_read(id, "[]") == DECLINED);
        let held = take_lease(lease).unwrap();
        let (tables, _) = held.to_tables(&[]);
        assert_eq!(tables.strings, ["a"]);
        assert!(take_lease(lease).is_none());
        json_drop(other);
    }

    /// The tables up to the last sample read, without a string root read
    /// after it.
    #[test]
    fn committed_tables() {
        let id = create("default", None, None);
        let cjson = |id| SAMPLES.with(|all| Rc::clone(&all.borrow().get(id).unwrap().cjson));
        assert!(json_read(id, r#"{"a": "2020-01-01", "b": ["x"]}"#) > 0);
        assert_eq!(json_read(id, r#""not a root here""#), DECLINED);
        let all = cjson(id).to_tables(&[]).0;
        let committed = SAMPLES.with(|s| s.borrow().get(id).unwrap().committed);
        let exported = cjson(id).tables_up_to(committed, &[]).0;
        assert_eq!(exported.strings, ["date", "a", "x", "b"]);
        assert_eq!(all.strings.len(), 5);
        assert_eq!(exported.objects, all.objects);
        json_drop(id);
    }
}
