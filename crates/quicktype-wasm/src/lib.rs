//! WebAssembly bindings for `quicktype-core`: the engine behind the
//! JavaScript facade in `npm/quicktype-core`.
//!
//! The facade is quicktype's own TypeScript API (research 05, §4). It
//! collects the inputs, normalizes options, parses JSON samples and schema
//! text, and does all I/O in JavaScript, then hands each run to the engine
//! in **one request**:
//!
//! - [`run_sync`] (for `quicktypeMultiFileSync()`) runs it to the end;
//! - [`start`], [`poll`] and [`settle`] (for `quicktype()` and
//!   `quicktypeMultiFile()`) run it as a future that the facade drives:
//!   JSON Schema documents are fetched while types are built, through the
//!   facade's own store, at exactly the points where TypeScript awaits
//!   `JSONSchemaStore.get`. When a fetch settles, the facade calls
//!   [`settle`] and polls again.
//!
//! Driving the future from JavaScript (rather than from a microtask
//! executor) means every poll is a call the facade makes and can guard: if
//! the engine ever traps, the exception surfaces there, not in a microtask
//! where it would leave the run's promise pending forever.
//!
//! The request and result formats are in [`wire`] (decoded in [`js`]);
//! [`assemble`] builds the engine's options from them.
//!
//! # Outcomes
//!
//! A finished run is `{ files }`, `{ error }` (`{ qt: { kind, properties }
//! }` for quicktype's messages, rebuilt with the JavaScript `messageError`;
//! `{ js: { name, message } }` for JavaScript exceptions), `{ thrown }`,
//! the very value a host callback threw, or `{ unsupported: feature }` for
//! something the port cannot do yet, which the facade then runs on the
//! TypeScript engine (it asks [`supports_language`] first, so that only
//! features found mid-run come back this way). The engine never panics on
//! purpose; should it, the panic hook reports the message to the facade
//! (`host.panicked`) before the instance traps (release builds abort on
//! panic), and the facade discards the instance and reports an
//! `InternalError`.
//!
//! # Concurrency
//!
//! Several runs can be in flight at once: while one waits for a schema
//! fetch, JavaScript can start and poll another, or call [`run_sync`] from
//! inside a store. Each run's state is owned by its future and its
//! [`JsHost`]; no borrow of the run table is held while a run is polled.
//! The only other thread-local state is the stack of runs being polled,
//! which routes the engine's `console.log` output to the run that printed
//! it.

#[cfg(target_arch = "wasm32")]
mod allocator;
pub mod assemble;
pub mod js;
pub mod samples;
pub mod wire;

use std::cell::{Cell, RefCell};
use std::future::Future;
use std::pin::Pin;
use std::rc::Rc;
use std::task::{Context, Poll, Waker};

use wasm_bindgen::prelude::*;

use crate::js::JsHost;

type RunFuture = Pin<Box<dyn Future<Output = JsValue>>>;

/// A run in flight: its future (absent while it is being polled) and host.
struct PendingRun {
    future: Option<RunFuture>,
    host: Rc<JsHost>,
}

thread_local! {
    /// The runs started with [`start`] and not finished, by run id.
    static RUNS: RefCell<Vec<Option<PendingRun>>> = const { RefCell::new(Vec::new()) };
    /// The runs executing right now, innermost last (a run that calls into
    /// JavaScript can be re-entered).
    static ACTIVE: RefCell<Vec<Rc<JsHost>>> = const { RefCell::new(Vec::new()) };
    static INSTALLED: Cell<bool> = const { Cell::new(false) };
}

/// Makes `host` the active run while `f` runs.
fn with_active<R>(host: &Rc<JsHost>, f: impl FnOnce() -> R) -> R {
    struct Pop;
    impl Drop for Pop {
        fn drop(&mut self) {
            ACTIVE.with(|a| {
                a.borrow_mut().pop();
            });
        }
    }
    ACTIVE.with(|a| a.borrow_mut().push(Rc::clone(host)));
    let _pop = Pop;
    f()
}

fn active() -> Option<Rc<JsHost>> {
    ACTIVE.with(|a| a.borrow().last().cloned())
}

/// Installs the console sinks and the panic hook, once.
fn install() {
    if INSTALLED.with(|i| i.replace(true)) {
        return;
    }
    quicktype_core::set_console_sink(Some(Box::new(|line| {
        if let Some(host) = active() {
            host.buffer_line(false, line);
        }
    })));
    quicktype_core::internal::set_console_error_sink(Some(Box::new(|line| {
        if let Some(host) = active() {
            host.buffer_line(true, line);
        }
    })));
    std::panic::set_hook(Box::new(|info| {
        if let Some(host) = active() {
            host.panicked(&info.to_string());
        }
    }));
}

/// The run as a future of its outcome.
fn run_future(request: JsValue, host: Rc<JsHost>) -> RunFuture {
    Box::pin(async move {
        let result = async {
            let request = js::decode_request(&request)?;
            let options = assemble::assemble(request, Rc::new(Rc::clone(&host)))?;
            quicktype_core::quicktype_multi_file(options).await
        }
        .await;
        host.finish(result)
    })
}

/// `Run.runSync()` after `preRun()`: returns the outcome (see the crate
/// documentation).
#[wasm_bindgen(js_name = runSync)]
pub fn run_sync(request: JsValue, host: JsValue) -> JsValue {
    install();
    let host = JsHost::new(host);
    with_active(&host, || {
        let result = js::decode_request(&request).and_then(|request| {
            let options = assemble::assemble(request, Rc::new(Rc::clone(&host)))?;
            quicktype_core::quicktype_multi_file_sync(options)
        });
        host.finish(result)
    })
}

/// `Run.run()` after `preRun()`: registers the run and returns its id. Call
/// [`poll`] to make progress.
#[wasm_bindgen]
pub fn start(request: JsValue, host: JsValue) -> u32 {
    install();
    let host = JsHost::new(host);
    let run = PendingRun {
        future: Some(run_future(request, Rc::clone(&host))),
        host,
    };
    RUNS.with(|runs| {
        let mut runs = runs.borrow_mut();
        match runs.iter().position(Option::is_none) {
            Some(free) => {
                runs[free] = Some(run);
                free as u32
            }
            None => {
                runs.push(Some(run));
                (runs.len() - 1) as u32
            }
        }
    })
}

/// Runs run `id` until it finishes or waits for a host call: returns the
/// outcome, or `undefined` while it waits (the facade polls again after
/// [`settle`]).
#[wasm_bindgen]
pub fn poll(id: u32) -> JsValue {
    let taken = RUNS.with(|runs| {
        let mut runs = runs.borrow_mut();
        let run = runs.get_mut(id as usize)?.as_mut()?;
        Some((run.future.take()?, Rc::clone(&run.host)))
    });
    let Some((mut future, host)) = taken else {
        return js::internal_error_outcome("Polled a run that is not pending");
    };
    let mut cx = Context::from_waker(Waker::noop());
    let polled = with_active(&host, || {
        let polled = future.as_mut().poll(&mut cx);
        // What the run printed before it began to wait, before the facade
        // starts the fetch it waits for.
        host.flush();
        polled
    });
    match polled {
        Poll::Ready(outcome) => {
            RUNS.with(|runs| runs.borrow_mut()[id as usize] = None);
            outcome
        }
        Poll::Pending if host.waiting() => {
            RUNS.with(|runs| {
                if let Some(Some(run)) = runs.borrow_mut().get_mut(id as usize) {
                    run.future = Some(future);
                }
            });
            JsValue::UNDEFINED
        }
        Poll::Pending => {
            RUNS.with(|runs| runs.borrow_mut()[id as usize] = None);
            js::internal_error_outcome("The engine is waiting for nothing")
        }
    }
}

/// Drops run `id`: the facade gave up on it (its promise can no longer be
/// observed), so its future and host objects need not be kept.
#[wasm_bindgen]
pub fn cancel(id: u32) {
    let dropped = RUNS.with(|runs| {
        runs.borrow_mut()
            .get_mut(id as usize)
            .and_then(Option::take)
    });
    // Dropped outside the borrow: dropping runs no JavaScript, but keep the
    // table free either way.
    drop(dropped);
}

/// How many runs are pending (for the facade's tests).
#[doc(hidden)]
#[wasm_bindgen(js_name = __pendingRuns)]
pub fn pending_runs() -> u32 {
    RUNS.with(|runs| runs.borrow().iter().filter(|r| r.is_some()).count() as u32)
}

/// Settles host call `call_id` of run `id` with `value` (`ok`) or the
/// exception it threw.
#[wasm_bindgen]
pub fn settle(id: u32, call_id: u32, ok: bool, value: JsValue) {
    let host = RUNS.with(|runs| {
        runs.borrow()
            .get(id as usize)
            .and_then(Option::as_ref)
            .map(|run| Rc::clone(&run.host))
    });
    if let Some(host) = host {
        host.settle(call_id, if ok { Ok(value) } else { Err(value) });
    }
}

/// Whether the engine has the renderer of the built-in language `name`
/// ([`has_renderer`](quicktype_core::internal::has_renderer)); the facade
/// runs the TypeScript engine for those it lacks, before the run has any
/// side effects. Unknown names are not supported.
#[wasm_bindgen(js_name = supportsLanguage)]
pub fn supports_language(name: &str) -> bool {
    thread_local! {
        static SUPPORTED: RefCell<std::collections::HashMap<String, bool>> =
            RefCell::new(std::collections::HashMap::new());
    }
    if let Some(known) = SUPPORTED.with(|s| s.borrow().get(name).copied()) {
        return known;
    }
    let supported = quicktype_core::get_target_language(name)
        .map(quicktype_core::internal::has_renderer)
        .unwrap_or(false);
    SUPPORTED.with(|s| s.borrow_mut().insert(name.to_owned(), supported));
    supported
}

/// The engine's version (the workspace version, which is quicktype's).
#[wasm_bindgen(js_name = engineVersion)]
pub fn engine_version() -> String {
    env!("CARGO_PKG_VERSION").to_owned()
}

/// JavaScript `x ** y` as the engine computes it, for the facade's tests
/// (`quicktype_js_compat::number::pow`).
#[doc(hidden)]
#[wasm_bindgen(js_name = __pow)]
pub fn pow_for_tests(x: f64, y: f64) -> f64 {
    quicktype_js_compat::number::pow(x, y)
}

/// How often the WebAssembly memory grew, for the facade's test that it
/// grows geometrically ([`allocator`]); 0 outside WebAssembly.
#[doc(hidden)]
#[wasm_bindgen(js_name = __memoryGrowths)]
pub fn memory_growths() -> u32 {
    #[cfg(target_arch = "wasm32")]
    return allocator::growths();
    #[cfg(not(target_arch = "wasm32"))]
    0
}

/// Panics, for the facade's test of what happens when the engine traps
/// (release builds abort on panic): the facade must discard the instance
/// and use a fresh one.
#[doc(hidden)]
#[wasm_bindgen(js_name = __panicForTests)]
pub fn panic_for_tests() {
    std::panic::panic_any("quicktype-wasm test panic");
}
