//! A large sample read in parts on several Web Workers, each with an
//! instance of its own (quickertype-core's `input/parts.rs`, which has the
//! rules and the argument; the facade's `src/native/parallel.ts` drives
//! it). Not the facade's public API: the playground's workers use it.
//!
//! Every instance has the split search: [`split_plan`] cuts a sample into
//! ranges as the CLI does, [`split_summarize`] summarizes one,
//! [`split_resolve`] gives each range's state at its start from all the
//! summaries in order, [`split_find`] finds a range's first split, and
//! [`split_parts`] forms the parts between consecutive splits, or says why
//! the sample is to be read in one go instead; after the first parts are
//! measured, [`split_decide`] says so too where the CLI would.
//!
//! The parts are read into tallies ([`parts_create`], [`parts_read`]): on
//! a worker, which hands them over as bytes ([`parts_export`]), and on the
//! instance that runs on the sample, which reads the first parts itself to
//! measure their trees ([`parts_read_measured`]) and appends the others'
//! bytes in order ([`parts_append`]). Then [`parts_finish`] keeps the
//! tallies for runs, which take a lease on them when the facade encodes
//! them ([`parts_acquire`], as for compressed forms in [`crate::samples`]):
//! a run's request names them as an input of kind `jsonTallies`.
//!
//! Every function here is total: what it is not given as it expects is an
//! error code or `undefined`, never a trap. A part that is not read is no
//! error either: the facade then reads the whole sample in one go, which
//! reports what reading in one go reports.

use std::cell::RefCell;

use js_sys::{Float64Array, Object, Reflect};
use quicktype_core::input::parts::{
    self, NotRead, Part, PartTallies, Plan, Probe, RangeSummary, SharedTallies, SplitState,
};
use wasm_bindgen::prelude::*;

use crate::samples::{LIMITS, Reading};
use crate::slots::Slots;

/// Parts' tallies: being read, or read and kept for runs.
enum Entry {
    Reading(Box<PartTallies>, Reading),
    Read(SharedTallies, Reading),
}

thread_local! {
    /// The parts' tallies, by id; `None` while one is being read into (and
    /// for good, should the instance trap meanwhile).
    static PARTS: RefCell<Slots<Option<Entry>>> = const { RefCell::new(Slots::new()) };
    /// The runs' holds on kept tallies, until the run starts
    /// ([`take_lease`]) or the facade lets go of them.
    static LEASES: RefCell<Slots<(SharedTallies, Reading)>> = const { RefCell::new(Slots::new()) };
}

// ---- The split search ------------------------------------------------------

/// The plan as numbers, which [`plan_of`] reads back.
fn plan_numbers(plan: &Plan) -> [f64; 7] {
    [
        plan.range as f64,
        plan.head as f64,
        plan.ranges as f64,
        plan.probe as f64,
        plan.threads as f64,
        plan.budget as f64,
        plan.len as f64,
    ]
}

/// The plan [`plan_numbers`] gave `numbers`, if they are such numbers.
fn plan_of(numbers: &[f64]) -> Option<Plan> {
    let &[range, head, ranges, probe, threads, budget, len] = numbers else {
        return None;
    };
    let plan = Plan {
        range: whole(range)?,
        head: whole(head)?,
        ranges: usize::try_from(whole(ranges)?).ok()?,
        probe: whole(probe)?,
        threads: usize::try_from(whole(threads)?).ok()?,
        budget: whole(budget)?,
        len: whole(len)?,
    };
    // As a plan is: ranges that cover the sample, at least one.
    let covered = plan.ranges >= 1
        && plan.range >= 1
        && plan.head <= plan.len
        && plan.head + (plan.ranges as u64 - 1).saturating_mul(plan.range) >= plan.len;
    covered.then_some(plan)
}

fn set(object: &Object, name: &str, value: &JsValue) {
    // Setting a property of a new plain object cannot fail.
    let _ = Reflect::set(object, &JsValue::from_str(name), value);
}

/// How a sample of `size` bytes is read on at most `workers` workers, if
/// it has `min_len` bytes or more, with the CLI's ranges or (for tests)
/// ranges of at most `range` bytes if `range` is positive:
/// `{ plan, threads, probe, budget, starts }`, where `plan` is to be passed
/// back as it is and `starts` holds each range's start and then the
/// sample's length; `undefined` for in one go.
#[wasm_bindgen(js_name = splitPlan)]
pub fn split_plan(size: f64, workers: u32, min_len: f64, range: f64) -> JsValue {
    let (Some(size), Some(min_len)) = (whole(size), whole(min_len)) else {
        return JsValue::UNDEFINED;
    };
    let range = whole(range).filter(|&r| r > 0);
    let Some(plan) = Plan::for_workers(size, workers as usize, min_len, range) else {
        return JsValue::UNDEFINED;
    };
    let mut starts: Vec<f64> = (0..plan.ranges).map(|k| plan.bounds(k).0 as f64).collect();
    starts.push(plan.len as f64);
    let object = Object::new();
    set(
        &object,
        "plan",
        &Float64Array::from(&plan_numbers(&plan)[..]).into(),
    );
    set(&object, "threads", &JsValue::from(plan.threads as f64));
    set(&object, "probe", &JsValue::from(plan.probe as f64));
    set(&object, "budget", &JsValue::from(plan.budget as f64));
    set(
        &object,
        "starts",
        &Float64Array::from(starts.as_slice()).into(),
    );
    object.into()
}

/// A whole number of at most 2^53, as a `u64`.
fn whole(x: f64) -> Option<u64> {
    (x >= 0.0 && x.fract() == 0.0 && x <= 2f64.powi(53)).then_some(x as u64)
}

/// The summary of `range`, which `before` (the up to 64 bytes before it,
/// fewer only at the sample's start, `at_start`) comes before, as numbers
/// ([`RangeSummary::NUMBERS`] of them) for [`split_resolve`].
#[wasm_bindgen(js_name = splitSummarize)]
pub fn split_summarize(before: &[u8], at_start: bool, range: &[u8]) -> Vec<f64> {
    parts::summarize(before, at_start, range)
        .to_numbers()
        .to_vec()
}

/// Every range's state at its start and whether it may hold a split, from
/// the summaries of all of them in order (`splitSummarize`'s numbers, one
/// after the other): four numbers a range (whether its first byte is
/// escaped, whether it is in a string, the depth, whether it may split);
/// `undefined` for numbers that are not summaries.
#[wasm_bindgen(js_name = splitResolve)]
pub fn split_resolve(summaries: &[f64], lines: bool) -> Option<Vec<f64>> {
    if summaries.len() % RangeSummary::NUMBERS != 0 {
        return None;
    }
    let summaries = summaries
        .chunks(RangeSummary::NUMBERS)
        .map(RangeSummary::from_numbers)
        .collect::<Option<Vec<_>>>()?;
    Some(
        parts::resolve(&summaries, lines)
            .into_iter()
            .flat_map(|(state, may_split)| {
                [
                    f64::from(u8::from(state.escaped)),
                    f64::from(u8::from(state.in_string)),
                    state.depth as f64,
                    f64::from(u8::from(may_split)),
                ]
            })
            .collect(),
    )
}

/// The first split in `range`, which starts in the state given (as
/// `splitResolve` gives it): its index in the range, or -1.
#[wasm_bindgen(js_name = splitFind)]
pub fn split_find(range: &[u8], escaped: bool, in_string: bool, depth: f64, lines: bool) -> f64 {
    if depth.fract() != 0.0 || depth.abs() > 2f64.powi(53) {
        return -1.0;
    }
    let state = SplitState {
        escaped,
        in_string,
        depth: depth as i64,
    };
    parts::find_split(range, state, lines).map_or(-1.0, |i| i as f64)
}

/// Where a top-level array's first part starts, in a sample whose bytes
/// start with `head`; -1 if its value is not an array (or `head` ends
/// before its first byte).
#[wasm_bindgen(js_name = splitArrayStart)]
pub fn split_array_start(head: &[u8]) -> f64 {
    parts::array_start(head).map_or(-1.0, |at| at as f64)
}

/// The parts between consecutive splits of a sample read with `plan`
/// (`splitPlan`'s), from `first` (where the first part starts) and
/// `splits` (each range's first split, or -1): `{ parts }`, three numbers
/// a part (from, to or -1 for the last, whether it is the first), or
/// `{ inOneGo }`, why the sample is to be read in one go instead.
#[wasm_bindgen(js_name = splitParts)]
pub fn split_parts(plan: &[f64], first: f64, splits: &[f64], lines: bool) -> JsValue {
    let object = Object::new();
    let formed = (|| {
        let plan = plan_of(plan).ok_or("not a plan")?;
        let first = whole(first).ok_or("not a start")?;
        if splits.len() != plan.ranges {
            return Err("not a split a range");
        }
        let splits: Vec<Option<u64>> = splits
            .iter()
            .map(|&s| if s < 0.0 { None } else { whole(s) })
            .collect();
        parts::form_parts(&plan, first, &splits, lines)
    })();
    match formed {
        Ok(parts) => {
            let numbers: Vec<f64> = parts.iter().flat_map(part_numbers).collect();
            set(
                &object,
                "parts",
                &Float64Array::from(numbers.as_slice()).into(),
            );
        }
        Err(why) => set(&object, "inOneGo", &JsValue::from_str(why)),
    }
    object.into()
}

fn part_numbers(part: &Part) -> [f64; 3] {
    [
        part.from as f64,
        part.to.map_or(-1.0, |to| to as f64),
        f64::from(u8::from(part.first)),
    ]
}

/// Once the first `probed` of `parts` (`splitParts`' numbers) are read
/// and measured (their text, their trees' bytes together, the smallest
/// tree): why the sample is to be read in one go after all, where the CLI
/// would, or `undefined` to read the rest in parts.
#[wasm_bindgen(js_name = splitDecide)]
pub fn split_decide(
    plan: &[f64],
    parts: &[f64],
    probed: u32,
    text: f64,
    trees: f64,
    smallest: f64,
) -> Option<String> {
    let decided = (|| {
        let plan = plan_of(plan).ok_or("not a plan")?;
        if parts.len() % 3 != 0 {
            return Err("not parts");
        }
        let parts = parts
            .chunks(3)
            .map(|p| {
                Some(Part {
                    from: whole(p[0])?,
                    to: if p[1] < 0.0 { None } else { Some(whole(p[1])?) },
                    first: p[2] == 1.0,
                })
            })
            .collect::<Option<Vec<_>>>()
            .ok_or("not parts")?;
        let probe = Probe {
            text: whole(text).ok_or("not a probe")?,
            trees: whole(trees).ok_or("not a probe")?,
            smallest: whole(smallest).ok_or("not a probe")?,
        };
        parts::decide(&plan, &parts, probed as usize, probe)
    })();
    decided.err().map(str::to_owned)
}

// ---- The parts' tallies ----------------------------------------------------

/// What [`parts_read`] returns for a part read and appended. Every reason
/// it was not is negative (as [`parts_read_measured`] returns them beside
/// the sizes of trees).
pub const READ: i32 = 1;
/// Its bytes are not UTF-8.
pub const NOT_UTF8: i32 = -1;
/// It is empty, starts with `]` where a value must come, or with a byte
/// order mark where only the first part may.
pub const NOT_A_PART: i32 = -2;
/// The reader failed on it, or declined it (the engine's limits).
pub const NOT_READ: i32 = -3;
/// Appending it failed.
pub const NOT_APPENDED: i32 = -4;
/// No parts' tallies have that id (or they are kept for runs already).
pub const UNKNOWN: i32 = -5;

fn code(not_read: NotRead) -> i32 {
    match not_read {
        NotRead::NotUtf8 => NOT_UTF8,
        NotRead::NotAPart => NOT_A_PART,
        NotRead::NotRead => NOT_READ,
        NotRead::NotAppended => NOT_APPENDED,
    }
}

/// Tallies for the parts of a sample read as a `CompressedJSON` with
/// these arguments reads (see `jsonCreate`): their id, or `undefined` if
/// there are as many as the table takes.
#[wasm_bindgen(js_name = partsCreate)]
pub fn parts_create(
    date_time: &str,
    handle_refs: bool,
    min: Option<String>,
    max: Option<String>,
) -> std::result::Result<Option<f64>, JsValue> {
    let reading = Reading::new(date_time, handle_refs, min, max)?;
    let config = reading.config_for_js()?;
    let entry = Entry::Reading(Box::new(PartTallies::new(config, LIMITS)), reading);
    Ok(PARTS.with(|all| all.borrow_mut().insert(Some(entry))).ok())
}

/// Runs `f` on parts' tallies `id`, if they are being read. They are taken
/// out of the table meanwhile, so that no borrow spans the reading.
fn with_reading<R>(id: f64, f: impl FnOnce(&mut PartTallies) -> R) -> Option<R> {
    let mut entry = PARTS.with(|all| all.borrow_mut().get_mut(id)?.take())?;
    let result = match &mut entry {
        Entry::Reading(tallies, _) => Some(f(tallies)),
        Entry::Read(..) => None,
    };
    put_back(id, entry);
    result
}

/// Puts `entry` back in its slot, which was emptied for a while.
fn put_back(id: f64, entry: Entry) {
    PARTS.with(|all| {
        if let Some(slot) = all.borrow_mut().get_mut(id) {
            *slot = Some(entry);
        }
    });
}

/// Reads part `bytes` into tallies `id`, after the parts read before it
/// (which must be the parts before it in the sample): as an array's
/// elements, or JSON Lines (`lines`); `first` and `last` say whether it is
/// the sample's first or last part. [`READ`], or why it was not read
/// (nothing is appended then).
#[wasm_bindgen(js_name = partsRead)]
pub fn parts_read(id: f64, bytes: &[u8], lines: bool, first: bool, last: bool) -> i32 {
    crate::install_clock();
    let _span = quicktype_core::trace::span("read a part");
    with_reading(id, |tallies| {
        match tallies.read(bytes, lines, first, last) {
            Ok(()) => READ,
            Err(e) => code(e),
        }
    })
    .unwrap_or(UNKNOWN)
}

/// [`parts_read`], measuring the part's tree as the CLI measures the first
/// parts: the bytes of its tree, or (as a negative number) why it was not
/// read.
#[wasm_bindgen(js_name = partsReadMeasured)]
pub fn parts_read_measured(id: f64, bytes: &[u8], lines: bool, first: bool, last: bool) -> f64 {
    crate::install_clock();
    let _span = quicktype_core::trace::span("read a part");
    with_reading(id, |tallies| {
        match tallies.read_measured(bytes, lines, first, last) {
            Ok(size) => size as f64,
            Err(e) => f64::from(code(e)),
        }
    })
    .unwrap_or(f64::from(UNKNOWN))
}

/// About how many bytes tallies `id` hold, or `undefined`.
#[wasm_bindgen(js_name = partsBytes)]
pub fn parts_bytes(id: f64) -> Option<f64> {
    PARTS.with(|all| {
        all.borrow().get(id)?.as_ref().map(|entry| match entry {
            Entry::Reading(tallies, _) => tallies.heap_size() as f64,
            Entry::Read(tallies, _) => tallies.heap_size() as f64,
        })
    })
}

/// The tree of the parts read into tallies `id`, as bytes for
/// [`parts_append`] in another instance; the tallies are gone afterwards.
/// `undefined` if there are none, or no part was read.
#[wasm_bindgen(js_name = partsExport)]
pub fn parts_export(id: f64) -> Option<Vec<u8>> {
    let entry = PARTS.with(|all| all.borrow_mut().remove(id))??;
    let Entry::Reading(tallies, _) = entry else {
        return None;
    };
    let _span = quicktype_core::trace::span("export parts");
    (*tallies).export().ok()
}

/// Appends to tallies `id` the parts another instance exported as `bytes`,
/// which come right after the parts so far: whether that worked (if not,
/// the tallies are as they were).
#[wasm_bindgen(js_name = partsAppend)]
pub fn parts_append(id: f64, bytes: &[u8]) -> bool {
    crate::install_clock();
    let _span = quicktype_core::trace::span("append parts");
    with_reading(id, |tallies| tallies.append(bytes).is_ok()).unwrap_or(false)
}

/// The index TypeScript's `CompressedJSON` gives the root array of the
/// sample whose parts tallies `id` hold, or `undefined`.
#[wasm_bindgen(js_name = partsRootIndex)]
pub fn parts_root_index(id: f64) -> Option<f64> {
    PARTS.with(|all| match all.borrow().get(id)?.as_ref()? {
        Entry::Reading(tallies, _) => Some(tallies.root_index() as f64),
        Entry::Read(..) => None,
    })
}

/// Keeps tallies `id`, with every part of the sample appended, for runs
/// (see [`parts_acquire`]): whether they are kept (not if no part was
/// read). They take no more parts.
#[wasm_bindgen(js_name = partsFinish)]
pub fn parts_finish(id: f64) -> bool {
    let Some(entry) = PARTS.with(|all| all.borrow_mut().get_mut(id)?.take()) else {
        return false;
    };
    match entry {
        Entry::Reading(tallies, reading) => match (*tallies).into_shared() {
            Some(shared) => {
                put_back(id, Entry::Read(shared, reading));
                true
            }
            None => {
                parts_drop(id);
                false
            }
        },
        read @ Entry::Read(..) => {
            put_back(id, read);
            true
        }
    }
}

/// Drops tallies `id`. Runs that hold them keep them until they end.
#[wasm_bindgen(js_name = partsDrop)]
pub fn parts_drop(id: f64) {
    let dropped = PARTS.with(|all| all.borrow_mut().remove(id));
    drop(dropped);
}

/// A run's hold on kept tallies `id`, taken when the facade encodes the
/// run: the lease its request carries, or `undefined` if they are not kept
/// (gone, or still being read). The run takes it over when it starts
/// ([`take_lease`]); a run that does not start lets go of it
/// ([`parts_release`]).
#[wasm_bindgen(js_name = partsAcquire)]
pub fn parts_acquire(id: f64) -> Option<f64> {
    let held = PARTS.with(|all| match all.borrow().get(id)?.as_ref()? {
        Entry::Read(tallies, reading) => Some((tallies.clone(), reading.clone())),
        Entry::Reading(..) => None,
    })?;
    LEASES.with(|leases| leases.borrow_mut().insert(held).ok())
}

/// Lets go of a lease whose run did not start.
#[wasm_bindgen(js_name = partsRelease)]
pub fn parts_release(lease: f64) {
    drop(take_lease(lease));
}

/// The tallies a lease holds, for the run that carries it; the lease is
/// gone afterwards.
pub fn take_lease(lease: f64) -> Option<(SharedTallies, Reading)> {
    LEASES.with(|leases| leases.borrow_mut().remove(lease))
}

/// How many parts' tallies are kept, and how many leases are held (for
/// the facade's tests).
#[doc(hidden)]
#[wasm_bindgen(js_name = __partsCount)]
pub fn parts_count() -> Vec<u32> {
    vec![
        PARTS.with(|all| all.borrow().len() as u32),
        LEASES.with(|leases| leases.borrow().len() as u32),
    ]
}

#[cfg(test)]
mod tests {
    use super::*;

    fn create() -> f64 {
        parts_create("default", false, None, None).unwrap().unwrap()
    }

    /// Two instances' worth of parts: one reads the first part and appends
    /// the second's bytes; the other read the second. Then the tallies are
    /// kept, leased, and dropped.
    #[test]
    fn parts_read_exported_appended_kept() {
        let here = create();
        assert_eq!(
            parts_read(here, br#"{"a": 1}, [2]"#, false, true, false),
            READ
        );
        let there = create();
        assert_eq!(
            parts_read(there, br#"{"a": "x"}]"#, false, false, true),
            READ
        );
        let bytes = parts_export(there).unwrap();
        assert!(parts_export(there).is_none());
        assert!(parts_append(here, &bytes));
        assert!(!parts_append(here, b"not a tree"));
        // Arrays: [2] (and the root's).
        assert_eq!(parts_root_index(here), Some(1.0));
        assert!(parts_acquire(here).is_none());
        assert!(parts_finish(here));
        assert_eq!(parts_read(here, b"1]", false, false, true), UNKNOWN);
        let lease = parts_acquire(here).unwrap();
        parts_drop(here);
        let (tallies, reading) = take_lease(lease).unwrap();
        assert!(tallies.heap_size() > 0);
        assert!(reading.config().is_ok());
        assert!(take_lease(lease).is_none());
        // What does not read.
        let id = create();
        assert_eq!(parts_read(id, b" ]", false, false, false), NOT_A_PART);
        assert_eq!(parts_read(id, b"", false, false, false), NOT_A_PART);
        assert_eq!(parts_read(id, b"1 2", false, false, false), NOT_READ);
        assert_eq!(parts_read(id, b"[\"\xff\"]", false, false, false), NOT_UTF8);
        assert_eq!(
            parts_read(id, b"\xEF\xBB\xBF1", true, false, false),
            NOT_A_PART
        );
        assert_eq!(
            parts_read(id, b"\xEF\xBB\xBF\xEF\xBB\xBF1\n2", true, true, false),
            READ
        );
        assert!(!parts_finish(create()));
        parts_drop(id);
        assert_eq!(parts_count(), vec![0, 0]);
    }

    #[test]
    fn plans_as_numbers() {
        let plan = Plan::for_workers(100 << 20, 8, 0, None).unwrap();
        assert_eq!(plan_of(&plan_numbers(&plan)), Some(plan));
        let mut numbers = plan_numbers(&plan);
        numbers[6] += 1e9;
        assert_eq!(plan_of(&numbers), None);
        assert_eq!(plan_of(&numbers[1..]), None);
    }
}
