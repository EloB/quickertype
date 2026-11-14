//! Switches and counters that this crate's tests use to check its
//! shortcuts against the compiler. Not part of the API: they apply to the
//! sessions of the thread that sets them, and change no result.

use std::cell::{Cell, RefCell};
use std::collections::BTreeMap;

thread_local! {
    static VERIFY: Cell<bool> = const { Cell::new(false) };
    static RECORD_MISSES: Cell<bool> = const { Cell::new(false) };
    static MISSES: RefCell<BTreeMap<String, u64>> = const { RefCell::new(BTreeMap::new()) };
}

/// Also asks the compiler every question the session answers itself (the
/// JSDoc it knows cannot exist, a property's declared type) and panics when
/// the compiler's answer differs. Inherited documentation is TypeScript
/// 5.9's, which TypeScript 7 does not give; it is built from compiler
/// answers and the syntax tree only, and the differential corpus checks it
/// against the recorded reference.
pub fn verify_local_answers(on: bool) {
    VERIFY.with(|v| v.set(on));
}

pub(crate) fn verifying() -> bool {
    VERIFY.with(Cell::get)
}

/// Counts the questions the generator had to ask the compiler itself
/// after the prefetch, by method, for the sessions of the current thread;
/// see [`take_misses`].
pub fn record_misses(on: bool) {
    RECORD_MISSES.with(|r| r.set(on));
}

pub(crate) fn record_miss(method: &str) {
    if RECORD_MISSES.with(Cell::get) {
        MISSES.with(|m| *m.borrow_mut().entry(method.to_owned()).or_default() += 1);
    }
}

/// The misses this thread recorded since the last call, by method.
pub fn take_misses() -> BTreeMap<String, u64> {
    MISSES.with(|m| std::mem::take(&mut *m.borrow_mut()))
}
