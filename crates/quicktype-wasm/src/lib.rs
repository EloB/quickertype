//! WebAssembly bindings for `quicktype-core`: the engine behind the
//! JavaScript facade in `npm/quicktype-core`.
//!
//! The facade is quicktype's own TypeScript API (research 05, §4). It
//! collects the inputs, normalizes options, parses JSON samples and schema
//! text, and does all I/O in JavaScript, then makes **one call per run**:
//!
//! - [`run`] (async, for `quicktype()` and `quicktypeMultiFile()`): JSON
//!   Schema `$ref`s are fetched while types are built, by awaiting the
//!   facade's store (`host.schemaGet`) at exactly the points where
//!   TypeScript awaits `JSONSchemaStore.get`;
//! - [`run_sync`] (for `quicktypeMultiFileSync()`): no awaits.
//!
//! The request and result formats are in [`wire`] (decoded in [`js`]);
//! [`assemble`] builds the engine's options from them.
//!
//! # Errors
//!
//! A run never panics on purpose: every failure is a
//! [`QuickTypeError`](quicktype_core::QuickTypeError) and comes back as a
//! rejected promise or thrown value: `{ qt: { kind, properties } }` for
//! quicktype's messages (rebuilt with the JavaScript `messageError`),
//! `{ js: { name, message } }` for JavaScript exceptions, or the very value
//! a host callback threw. Should the engine panic anyway, the panic hook
//! reports the message to the facade (`host.panicked`) before the instance
//! traps (release builds abort on panic); the facade then discards the
//! instance and reports an `InternalError`.
//!
//! # Concurrency
//!
//! Several runs can be in flight at once: while one awaits a schema fetch,
//! JavaScript can start another, or call [`run_sync`] from inside a store.
//! All run state is owned by the run's future; the only thread-local state
//! is the stack of active runs, which routes the engine's `console.log`
//! output to the run that printed it.

pub mod assemble;
pub mod js;
pub mod wire;

use std::cell::RefCell;
use std::future::Future;
use std::pin::Pin;
use std::rc::Rc;
use std::task::{Context, Poll};

use wasm_bindgen::prelude::*;

use crate::js::JsHost;

thread_local! {
    /// The runs executing right now, innermost last (a run that calls into
    /// JavaScript can be re-entered by [`run_sync`]).
    static ACTIVE: RefCell<Vec<Rc<JsHost>>> = const { RefCell::new(Vec::new()) };
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
    thread_local! {
        static INSTALLED: std::cell::Cell<bool> = const { std::cell::Cell::new(false) };
    }
    if INSTALLED.with(|i| i.replace(true)) {
        return;
    }
    quicktype_core::set_console_sink(Some(Box::new(|line| {
        if let Some(host) = active() {
            host.log(line);
        }
    })));
    quicktype_core::internal::set_console_error_sink(Some(Box::new(|line| {
        if let Some(host) = active() {
            host.error(line);
        }
    })));
    std::panic::set_hook(Box::new(|info| {
        if let Some(host) = active() {
            host.panicked(&info.to_string());
        }
    }));
}

/// A run's future, polled with its host active.
struct Active<F> {
    host: Rc<JsHost>,
    future: Pin<Box<F>>,
}

impl<F: Future> Future for Active<F> {
    type Output = F::Output;

    fn poll(self: Pin<&mut Self>, cx: &mut Context<'_>) -> Poll<F::Output> {
        let this = self.get_mut();
        with_active(&this.host, || this.future.as_mut().poll(cx))
    }
}

/// `Run.run()` after `preRun()`: resolves to `{ files }`, or rejects (see
/// the crate documentation).
#[wasm_bindgen]
pub async fn run(request: JsValue, host: JsValue) -> Result<JsValue, JsValue> {
    install();
    let host = JsHost::new(host);
    let future = {
        let host = Rc::clone(&host);
        async move {
            let request = js::decode_request(&request)?;
            let options = assemble::assemble(request, Rc::new(host))?;
            quicktype_core::quicktype_multi_file(options).await
        }
    };
    let result = Active {
        host: Rc::clone(&host),
        future: Box::pin(future),
    }
    .await;
    host.finish(result)
}

/// `Run.runSync()` after `preRun()`: returns `{ files }` or throws.
#[wasm_bindgen(js_name = runSync)]
pub fn run_sync(request: JsValue, host: JsValue) -> Result<JsValue, JsValue> {
    install();
    let host = JsHost::new(host);
    let result = with_active(&host, || {
        let request = js::decode_request(&request)?;
        let options = assemble::assemble(request, Rc::new(Rc::clone(&host)))?;
        quicktype_core::quicktype_multi_file_sync(options)
    });
    host.finish(result)
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
