//! Port of `packages/quicktype-core/src/input/io/` (`NodeIO.ts`), plus the
//! small async helpers the Rust port's I/O is built on.
//!
//! quicktype's JSON Schema input fetches documents lazily, *while* it builds
//! types, and the order of those fetches is observable (which `$id`s are
//! known when, the order of `--debug print-schema-resolving` lines, which
//! error comes first). So I/O is asynchronous at exactly the places it is
//! in TypeScript: [`JsonSchemaStore`](crate::input::json_schema_store::JsonSchemaStore)
//! and [`Io`](node_io::Io) return [`LocalBoxFuture`]s. Natively the futures
//! do blocking I/O and complete immediately; [`block_on`] runs them. A
//! WebAssembly host can implement the same traits with JavaScript promises.

use std::future::Future;
use std::pin::Pin;
use std::sync::Arc;
use std::task::{Context, Poll, Wake, Waker};
use std::thread::{self, Thread};

#[cfg(feature = "http")]
mod fetch;
pub mod node_io;

/// A boxed future that need not be `Send` (JavaScript values are not).
pub type LocalBoxFuture<'a, T> = Pin<Box<dyn Future<Output = T> + 'a>>;

/// Runs `f`, on a freshly allocated stack segment if the current stack is
/// nearly exhausted ([`recursion::grow_stack`](crate::support::recursion::grow_stack)).
///
/// quicktype's schema walks recurse once per nesting level. JavaScript
/// bounds that with its own stack (which the port models explicitly, see
/// `json_schema_input`), but some walks that TypeScript runs on a fresh
/// stack after every `await` nest Rust calls without limit. Growing the
/// stack on demand keeps every such walk from overflowing the native stack,
/// whatever the thread's stack size.
pub(crate) use crate::support::recursion::grow_stack;

/// A future whose every poll runs under [`grow_stack`]: nested futures that
/// complete synchronously poll each other recursively.
pub(crate) struct GrowStack<'a, T>(pub(crate) LocalBoxFuture<'a, T>);

impl<T> Future for GrowStack<'_, T> {
    type Output = T;

    fn poll(self: Pin<&mut Self>, cx: &mut Context<'_>) -> Poll<T> {
        let inner = &mut self.get_mut().0;
        grow_stack(|| inner.as_mut().poll(cx))
    }
}

/// Wakes a parked thread.
struct ThreadWaker(Thread);

impl Wake for ThreadWaker {
    fn wake(self: Arc<Self>) {
        self.0.unpark();
    }

    fn wake_by_ref(self: &Arc<Self>) {
        self.0.unpark();
    }
}

/// Runs `future` to completion on the current thread, parking it while the
/// future is pending. Native I/O completes synchronously, so this never
/// actually waits there; it is the executor for the native CLI and for
/// Rust API users who don't bring their own.
pub fn block_on<F: Future>(future: F) -> F::Output {
    let mut future = std::pin::pin!(future);
    let waker = Waker::from(Arc::new(ThreadWaker(thread::current())));
    let mut context = Context::from_waker(&waker);
    loop {
        match future.as_mut().poll(&mut context) {
            Poll::Ready(output) => return output,
            Poll::Pending => thread::park(),
        }
    }
}
