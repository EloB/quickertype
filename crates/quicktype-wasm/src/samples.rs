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
//!
//! A run over a compressed form keeps the tallies it inferred the types
//! from with the form (`JsonInput::from_shared`), for the next run over
//! the same samples; the next sample read into the form drops them. They
//! count in the form's bytes ([`recount`] after each run, [`json_bytes`]).
//!
//! The facade bounds what the compressed forms hold together
//! ([`json_held`]): past its limit, it fills the tables of the least
//! recently used and drops them here, tallies and all.
//!
//! No borrow of the tables here spans a read: [`json_read`] takes the
//! compressed form out for it. Should the instance trap during a read (run
//! out of memory), the other inputs' tables can still be exported from its
//! memory ([`json_export`]), which is how the facade recovers them; the
//! input being read is lost with the read.
//!
//! When a table is full (2^21 inputs at once), [`json_create`] returns
//! `undefined`, and the facade reads that input with TypeScript.

use std::cell::{Cell, RefCell};
use std::rc::Rc;

use js_sys::{Int32Array, Object, Reflect, Uint32Array};
use quicktype_core::input::compressed_json::{
    CompressedJson, ParseError, ReadStringError, StringSampleLimits, TableCounts, Value,
};
use quicktype_core::support::integer_range::IntegerRange;
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

/// [`json_read_bytes`]: the bytes are not UTF-8; nothing was read. The
/// facade decodes them (as `TextDecoder` does, which replaces what is not
/// UTF-8) and reads the text with [`json_read`].
pub const NOT_UTF8: i32 = -2;

/// A JavaScript `CompressedJSON`'s samples.
struct Samples {
    /// `None` while [`json_read`] reads a sample into it (and for good if
    /// the instance trapped meanwhile).
    cjson: Option<Rc<CompressedJson>>,
    /// The tables after the last sample [`json_read`] returned a value for:
    /// what the JavaScript tables are. A sample it declined after reading
    /// it (a string root) may have added to the compressed form.
    committed: TableCounts,
    /// Set once the compressed form went past `committed`: it takes no
    /// more samples.
    closed: bool,
    /// Its [`heap_size`](CompressedJson::heap_size) (with the tallies a
    /// run kept with it) after the last read or run, counted in [`HELD`].
    bytes: usize,
}

thread_local! {
    /// The compressed forms, by id.
    static SAMPLES: RefCell<Slots<Samples>> = const { RefCell::new(Slots::new()) };
    /// The runs' holds on compressed forms (with the forms' ids), by lease
    /// id, until the run starts ([`take_lease`]) or the facade lets go of
    /// it.
    static LEASES: RefCell<Slots<(f64, Rc<CompressedJson>)>> = const { RefCell::new(Slots::new()) };
    /// The bytes of every compressed form in [`SAMPLES`] ([`json_held`]).
    static HELD: Cell<usize> = const { Cell::new(0) };
}

/// `new CompressedJSONFromString(dateTimeRecognizer, handleRefs,
/// supportedIntegerRange)` without samples yet: returns its id, or
/// `undefined` if there are as many as the table takes (the facade reads
/// that input with TypeScript). `date_time` names a built-in recognizer (as
/// in the request), and the range is `null` (arbitrary precision) unless
/// both bounds are given.
#[wasm_bindgen(js_name = jsonCreate)]
pub fn json_create(
    date_time: &str,
    handle_refs: bool,
    min: Option<String>,
    max: Option<String>,
) -> std::result::Result<Option<f64>, JsValue> {
    let recognizer = DateTimeKind::from_name(date_time)
        .ok_or_else(|| JsValue::from_str("unknown date/time recognizer"))?
        .recognizer()
        .map_err(|e| JsValue::from_str(e.user_message()))?;
    let range = match (min, max) {
        (Some(min), Some(max)) => Some(IntegerRange::new(min, max)),
        _ => None,
    };
    let cjson = CompressedJson::new(recognizer, handle_refs, range);
    let bytes = cjson.heap_size();
    let samples = Samples {
        cjson: Some(Rc::new(cjson)),
        committed: TableCounts::default(),
        closed: false,
        bytes,
    };
    let id = SAMPLES.with(|all| all.borrow_mut().insert(samples)).ok();
    if id.is_some() {
        HELD.with(|held| held.set(held.get() + bytes));
    }
    Ok(id)
}

/// `parseSync(text)` on compressed form `id`: the sample's root value as
/// TypeScript encodes it (a positive number), [`INVALID`] or
/// [`DECLINED`].
#[wasm_bindgen(js_name = jsonRead)]
pub fn json_read(id: f64, text: &str) -> i32 {
    let _span = quicktype_core::trace::span("jsonRead");
    read_with(id, |cjson| cjson.read_string_sample(text, LIMITS))
}

/// [`json_read`] for a sample given as bytes: the text that `new
/// TextDecoder().decode(bytes)` gives, read without decoding the bytes into
/// a JavaScript string and encoding that again into WebAssembly memory. A
/// leading byte order mark is not part of the text, as for the decoder.
/// Bytes that are not UTF-8 are not read ([`NOT_UTF8`]): the decoder would
/// replace what is not UTF-8 with U+FFFD, and the facade does that.
#[wasm_bindgen(js_name = jsonReadBytes)]
pub fn json_read_bytes(id: f64, bytes: &[u8]) -> i32 {
    let _span = quicktype_core::trace::span("jsonRead");
    let bytes = bytes.strip_prefix(b"\xEF\xBB\xBF").unwrap_or(bytes);
    let span = quicktype_core::trace::span("read: check UTF-8");
    let text = std::str::from_utf8(bytes);
    drop(span);
    match text {
        Ok(text) => read_with(id, |cjson| cjson.read_string_sample(text, LIMITS)),
        Err(_) => NOT_UTF8,
    }
}

/// [`json_read`] with `read` reading the sample. The compressed form is
/// taken out of [`SAMPLES`] for the read, so that no borrow spans it.
fn read_with(
    id: f64,
    read: impl FnOnce(&mut CompressedJson) -> Result<Value, ReadStringError>,
) -> i32 {
    let taken = SAMPLES.with(|all| {
        let mut all = all.borrow_mut();
        let samples = all.get_mut(id)?;
        // In use by a run (which keeps the samples it was encoded with).
        if samples.closed || Rc::get_mut(samples.cjson.as_mut()?).is_none() {
            return None;
        }
        samples.cjson.take()
    });
    let Some(mut held) = taken else {
        return DECLINED;
    };
    let Some(cjson) = Rc::get_mut(&mut held) else {
        return DECLINED;
    };
    // Whether the compressed form went past what TypeScript's tables
    // would be (see `Samples::closed`).
    let (result, closed) = match read(cjson) {
        Ok(value) => match root_value(cjson, value) {
            Some(root) => (root, false),
            // A string root.
            None => (DECLINED, true),
        },
        // Nothing was committed.
        Err(ReadStringError::Parse(ParseError::Js(_))) => (INVALID, false),
        Err(ReadStringError::Declined(_)) => (DECLINED, false),
        // The commit failed part way.
        Err(ReadStringError::Parse(_)) => (DECLINED, true),
    };
    let counts = cjson.table_counts();
    let bytes = cjson.heap_size();
    SAMPLES.with(|all| {
        // Still there: no JavaScript ran during the read.
        let mut all = all.borrow_mut();
        let Some(samples) = all.get_mut(id) else {
            return;
        };
        if result > 0 {
            samples.committed = counts;
        }
        samples.closed = closed;
        HELD.with(|all| all.set(all.get() + bytes - samples.bytes));
        samples.bytes = bytes;
        samples.cjson = Some(held);
    });
    result
}

/// Reads `text` into compressed form `id` and panics before the read
/// returns, as an instance that runs out of memory while it reads does
/// (it traps): for the facade's test that the other inputs' tables can
/// still be had from the instance.
#[doc(hidden)]
#[wasm_bindgen(js_name = __jsonReadTrapForTests)]
pub fn json_read_trap_for_tests(id: f64, text: &str) -> i32 {
    read_with(id, |cjson| {
        let _ = cjson.read_string_sample(text, LIMITS);
        std::panic::panic_any("quicktype-wasm test panic while reading a sample")
    })
}

/// Drops compressed form `id`: the JavaScript `CompressedJSON` is gone, or
/// has its own tables now. Runs that hold it keep it until they end.
#[wasm_bindgen(js_name = jsonDrop)]
pub fn json_drop(id: f64) {
    let dropped = SAMPLES.with(|all| all.borrow_mut().remove(id));
    if let Some(samples) = &dropped {
        HELD.with(|held| held.set(held.get() - samples.bytes));
    }
    drop(dropped);
}

/// About how many bytes the compressed forms hold together (their
/// [`heap_size`](CompressedJson::heap_size) after their last read or run,
/// which counts the tallies a run kept with a form), which the facade
/// keeps within its limit by filling the tables of the least recently used
/// and dropping them. A form dropped while a run holds it is no longer
/// counted; it is freed when the run ends.
#[wasm_bindgen(js_name = jsonHeld)]
pub fn json_held() -> f64 {
    HELD.with(Cell::get) as f64
}

/// The bytes of compressed form `id` as [`json_held`] counts them, or
/// `undefined` for an id that is gone: what a run kept with it is counted
/// when the run ends ([`recount`]), so the facade asks after each run.
#[wasm_bindgen(js_name = jsonBytes)]
pub fn json_bytes(id: f64) -> Option<f64> {
    SAMPLES.with(|all| all.borrow().get(id).map(|samples| samples.bytes as f64))
}

/// Counts the bytes of the compressed forms `ids` again, after a run that
/// used them: it may have kept the tallies it made of them (a form a run
/// holds takes no samples, so nothing else changes it meanwhile).
pub fn recount(ids: &[f64]) {
    SAMPLES.with(|all| {
        let mut all = all.borrow_mut();
        for &id in ids {
            let Some(samples) = all.get_mut(id) else {
                continue;
            };
            let Some(cjson) = &samples.cjson else {
                continue;
            };
            let bytes = cjson.heap_size();
            HELD.with(|held| held.set(held.get() + bytes - samples.bytes));
            samples.bytes = bytes;
        }
    });
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
        let all = all.borrow();
        let samples = all.get(id)?;
        Some((Rc::clone(samples.cjson.as_ref()?), samples.committed))
    }) else {
        return JsValue::UNDEFINED;
    };
    let tables = cjson.joined_tables_up_to(committed);
    drop(cjson);
    let object = Object::new();
    let set = |name: &str, value: &JsValue| {
        // Setting a property of a new plain object cannot fail.
        let _ = Reflect::set(&object, &JsValue::from_str(name), value);
    };
    set("strings", &JsValue::from_str(&tables.strings));
    drop(tables.strings);
    set(
        "stringLengths",
        &Uint32Array::from(tables.string_lengths.as_slice()),
    );
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
        let all = all.borrow();
        Some(Rc::clone(all.get(id)?.cjson.as_ref()?))
    })?;
    LEASES.with(|leases| leases.borrow_mut().insert((id, cjson)).ok())
}

/// Lets go of a lease whose run did not start.
#[wasm_bindgen(js_name = jsonRelease)]
pub fn json_release(lease: f64) {
    drop(take_lease(lease));
}

/// The compressed form a lease holds, and its id, for the run that carries
/// it; the lease is gone afterwards.
pub fn take_lease(lease: f64) -> Option<(f64, Rc<CompressedJson>)> {
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
        json_create(date_time, false, min.map(Into::into), max.map(Into::into))
            .unwrap()
            .unwrap()
    }

    fn form(id: f64) -> Rc<CompressedJson> {
        SAMPLES.with(|all| Rc::clone(all.borrow().get(id).unwrap().cjson.as_ref().unwrap()))
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

    /// Bytes are read as the UTF-8 text a `TextDecoder` gives: a leading
    /// byte order mark is not part of it, and bytes that are not UTF-8 are
    /// left to the facade, with nothing read.
    #[test]
    fn bytes() {
        let tables = |read: &dyn Fn(f64) -> i32| {
            let id = create("default", None, None);
            let root = read(id);
            let tables = (root > 0).then(|| form(id).to_tables(&[]).0);
            json_drop(id);
            (root, tables.map(|t| (t.strings, t.objects, t.arrays)))
        };
        let text = r#"{"a": ["é", 1, {"b": "2020-01-01"}]}"#;
        let expected = tables(&|id| json_read(id, text));
        assert!(expected.0 > 0);
        assert_eq!(tables(&|id| json_read_bytes(id, text.as_bytes())), expected);
        let bom = [b"\xEF\xBB\xBF".as_slice(), text.as_bytes()].concat();
        assert_eq!(tables(&|id| json_read_bytes(id, &bom)), expected);
        // Only one byte order mark is not part of the text; as a string,
        // U+FEFF is not JSON.
        let two = [b"\xEF\xBB\xBF".as_slice(), &bom].concat();
        assert_eq!(tables(&|id| json_read_bytes(id, &two)), (INVALID, None));
        assert_eq!(
            tables(&|id| json_read(id, &format!("\u{feff}{text}"))),
            (INVALID, None)
        );
        for bad in [
            &b"[\"\xFF\"]"[..],
            b"[\"\xED\xA0\x80\"]",
            b"{\"a\xC3\": 1}",
            b"[1, \xFF]",
        ] {
            let id = create("default", None, None);
            let before = form(id).heap_size();
            assert_eq!(json_read_bytes(id, bad), NOT_UTF8);
            assert_eq!(form(id).heap_size(), before);
            assert!(json_read(id, "[1]") > 0);
            json_drop(id);
        }
        assert_eq!(tables(&|id| json_read_bytes(id, b"")), (INVALID, None));
        assert_eq!(
            tables(&|id| json_read_bytes(id, b"\xEF\xBB\xBF")),
            (INVALID, None)
        );
    }

    #[test]
    fn integer_ranges() {
        let int32 = create("default", Some("-2147483648"), Some("2147483647"));
        assert_eq!(json_read(int32, "2147483648"), 5);
        assert_eq!(json_read(int32, "2147483647"), 4);
        let unbounded = json_create("swift", true, None, None).unwrap().unwrap();
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
        let (form, held) = take_lease(lease).unwrap();
        assert_eq!(form, id);
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
        assert!(json_read(id, r#"{"a": "2020-01-01", "b": ["x"]}"#) > 0);
        assert_eq!(json_read(id, r#""not a root here""#), DECLINED);
        let all = form(id).to_tables(&[]).0;
        let committed = SAMPLES.with(|s| s.borrow().get(id).unwrap().committed);
        let exported = form(id).joined_tables_up_to(committed);
        assert_eq!(exported.strings, "dateaxb");
        assert_eq!(exported.string_lengths, [4, 1, 1, 1]);
        assert_eq!(all.strings.len(), 5);
        assert_eq!(exported.objects, all.objects);
        assert_eq!(exported.object_offsets, all.object_offsets);
        assert_eq!(exported.arrays, all.arrays);
        assert_eq!(exported.array_offsets, all.array_offsets);
        json_drop(id);
    }

    /// No borrow of the tables spans a read: should the read trap (in
    /// WebAssembly, a panic aborts without unwinding), the other inputs
    /// can still be exported and leased.
    #[test]
    fn a_read_holds_no_borrow() {
        let a = create("default", None, None);
        assert!(json_read(a, r#"{"a": [1]}"#) > 0);
        let b = create("default", None, None);
        let free = || {
            SAMPLES.with(|s| s.try_borrow_mut().is_ok())
                && LEASES.with(|l| l.try_borrow_mut().is_ok())
        };
        assert!(
            read_with(b, |cjson| {
                assert!(free());
                cjson.read_string_sample("[2]", LIMITS)
            }) > 0
        );
        let trapped = std::panic::catch_unwind(|| json_read_trap_for_tests(b, r#"{"b": "x"}"#));
        assert!(trapped.is_err());
        // The input being read is lost with the read; the others are not.
        assert!(SAMPLES.with(|s| s.borrow().get(b).unwrap().cjson.is_none()));
        assert_eq!(json_read(b, "[3]"), DECLINED);
        assert!(json_acquire(b).is_none());
        assert_eq!(form(a).to_tables(&[]).0.strings, ["a"]);
        let lease = json_acquire(a).unwrap();
        json_release(lease);
        assert!(json_read(a, "[4]") > 0);
        json_drop(a);
        json_drop(b);
    }

    /// A run keeps the tallies it made of a form with it: they are counted
    /// in the form's bytes once the run ends, the next run over the same
    /// samples uses them, and the next sample read drops them.
    #[test]
    fn kept_tallies_are_counted() {
        use quicktype_core::input::inputs::{CompressedTopLevel, JsonInference, JsonInput};
        use quicktype_core::ty::type_builder::TypeBuilder;
        use quicktype_core::{InferenceFlags, RunContext, get_target_language};

        let before = json_held();
        let id = create("default", None, None);
        let records: Vec<String> = (0..2_000)
            .map(|i| {
                format!(
                    r#"{{"id": {i}, "name": "n{}", "home": "https://h/{}.png"}}"#,
                    i % 9,
                    i % 5
                )
            })
            .collect();
        let root = json_read(id, &format!("[{}]", records.join(",")));
        assert!(root > 0);
        let read = json_bytes(id).unwrap();
        let lang = get_target_language("go").unwrap();
        let ctx = RunContext::for_target_language(lang, &InferenceFlags::default());
        // A run: a lease, an input over the form, its inference.
        let run = || {
            let (form, cjson) = take_lease(json_acquire(id).unwrap()).unwrap();
            let mut input = JsonInput::from_shared(
                cjson,
                vec![CompressedTopLevel {
                    name: "T".to_owned(),
                    description: None,
                    samples: vec![root],
                }],
            )
            .unwrap();
            let mut builder =
                TypeBuilder::new(ctx.string_type_mapping.clone(), false, false, false, false)
                    .unwrap();
            input
                .add_types_sync(&ctx, &mut builder, true, true, false)
                .unwrap();
            let graph = format!("{:?}", builder.finish().unwrap());
            let inferred_from = input.inferred_from();
            drop(input);
            recount(&[form]);
            (graph, inferred_from)
        };
        let (first, from) = run();
        assert_eq!(from, Some(JsonInference::CompressedTallies));
        let kept = json_bytes(id).unwrap();
        assert!(kept > read, "{kept} against {read}");
        assert_eq!(kept, form(id).heap_size() as f64);
        assert_eq!(json_held() - before, kept);
        let (second, from) = run();
        assert_eq!(from, Some(JsonInference::KeptTallies));
        assert_eq!(second, first);
        assert_eq!(json_bytes(id), Some(kept));
        // A sample read drops them.
        assert!(json_read(id, "[1]") > 0);
        let after = json_bytes(id).unwrap();
        assert!(after < kept, "{after} against {kept}");
        assert_eq!(after, form(id).heap_size() as f64);
        assert_eq!(json_held() - before, after);
        // And dropping the form drops what it holds, tallies and all.
        let (_, from) = run();
        assert_eq!(from, Some(JsonInference::CompressedTallies));
        json_drop(id);
        assert_eq!(json_held(), before);
        assert_eq!(json_bytes(id), None);
    }

    /// What the forms hold is counted as they grow and as they go.
    #[test]
    fn held_bytes() {
        let before = json_held();
        let id = create("default", None, None);
        let empty = json_held() - before;
        assert_eq!(empty, form(id).heap_size() as f64);
        let records: Vec<String> = (0..5_000)
            .map(|i| format!(r#"{{"id": {i}, "name": "n{i}"}}"#))
            .collect();
        assert!(json_read(id, &format!("[{}]", records.join(","))) > 0);
        let read = json_held() - before;
        assert_eq!(read, form(id).heap_size() as f64);
        assert!(read > empty + 100_000.0, "{read}");
        // Not JSON, declined: nothing committed, and the count follows
        // the reader's spare buffers.
        assert_eq!(json_read(id, "[1,"), INVALID);
        assert_eq!(json_read(id, r#"["\ud800"]"#), DECLINED);
        assert_eq!(json_held() - before, form(id).heap_size() as f64);
        json_drop(id);
        assert_eq!(json_held(), before);
    }
}
