//! JavaScript's stack overflow for recursions over the type graph.
//!
//! TypeScript functions that recurse into a type's children (a renderer's
//! "type to source" function, C#'s `needTransformerForType`, ...) never end
//! on a graph that cycles without passing a named type, e.g. a nullable
//! union whose member is an array of the union itself: V8 runs out of stack
//! and throws `RangeError: Maximum call stack size exceeded`, which the CLI
//! prints as `Error: Maximum call stack size exceeded.`. The same Rust
//! recursion would overflow the native stack, which aborts the process.
//!
//! [`guard`] runs one level of such a recursion: it counts the guarded calls
//! active on the current thread and fails with that `RangeError` once
//! [`MAX_DEPTH`] of them are nested, and it grows the native stack as needed
//! so that the limit, not the thread's stack size, ends the recursion.
//! Every recursive function from a type to its source (or to anything else
//! derived from the type's children) wraps its body in [`guard`]; see
//! `docs/RENDERERS.md`.

use std::cell::Cell;

use quicktype_js_compat::json::StackOverflow;

use crate::messages::{JsErrorName, QuickTypeError, Result};

/// How many guarded calls may be nested on one thread.
///
/// Node 24 overflows its default stack after 971 nested calls of the Pike
/// renderer's `sourceFor` and 8,903 of C#'s `needTransformerForType`. An
/// endless recursion fails the same way at any limit, and TypeScript's graph
/// rewriting already overflows at about 335 nested arrays, so no finite graph
/// that deep reaches a TypeScript renderer. See "Known gaps" in
/// `docs/PARITY.md`.
pub const MAX_DEPTH: usize = 1_000;

/// The stack left free before [`guard`] switches to a new segment.
const RED_ZONE: usize = 256 * 1024;

/// The size of each new stack segment.
const STACK_SEGMENT: usize = 4 * 1024 * 1024;

thread_local! {
    /// The number of [`guard`] calls active on this thread.
    static DEPTH: Cell<usize> = const { Cell::new(0) };
}

/// V8's `RangeError: Maximum call stack size exceeded`, wherever the port
/// reports Node's stack running out.
pub fn stack_overflow() -> QuickTypeError {
    QuickTypeError::js_exception(JsErrorName::RangeError, "Maximum call stack size exceeded")
}

/// js-compat's iterative models of JavaScript recursions (e.g.
/// `json::to_js_string`) fail with [`stack_overflow`].
impl From<StackOverflow> for QuickTypeError {
    fn from(_: StackOverflow) -> Self {
        stack_overflow()
    }
}

/// Leaves a guarded call, also when it unwinds.
struct Leave;

impl Drop for Leave {
    fn drop(&mut self) {
        DEPTH.with(|d| d.set(d.get().saturating_sub(1)));
    }
}

/// Runs `f`, one level of a recursion over the type graph: fails with
/// [`stack_overflow`] if [`MAX_DEPTH`] guarded calls are already active on
/// this thread, and runs `f` on a fresh stack segment if the native stack is
/// nearly exhausted.
pub fn guard<T>(f: impl FnOnce() -> Result<T>) -> Result<T> {
    let depth = DEPTH.with(Cell::get);
    if depth >= MAX_DEPTH {
        return Err(stack_overflow());
    }
    DEPTH.with(|d| d.set(depth + 1));
    let _leave = Leave;
    grow_stack(f)
}

/// Runs `f`, one level of a recursion that must not overflow the native
/// stack but has no depth limit of its own: on a fresh stack segment if
/// the current stack is nearly exhausted. For recursions whose depth the
/// input bounds (nesting in a document) where the port deliberately goes
/// deeper than Node's stack; see "Known gaps" in `docs/PARITY.md`.
pub fn grow_stack<R>(f: impl FnOnce() -> R) -> R {
    stacker::maybe_grow(RED_ZONE, STACK_SEGMENT, f)
}

/// The number of [`guard`] calls active on this thread (for tests).
pub fn depth() -> usize {
    DEPTH.with(Cell::get)
}

#[cfg(test)]
mod tests {
    use super::*;

    fn endless() -> Result<usize> {
        guard(endless)
    }

    fn bounded(n: usize) -> Result<usize> {
        guard(|| if n == 0 { Ok(depth()) } else { bounded(n - 1) })
    }

    #[test]
    fn endless_recursion_is_a_range_error() {
        let e = endless().unwrap_err();
        let js = e.as_js_exception().unwrap();
        assert_eq!(js.name(), JsErrorName::RangeError);
        assert_eq!(js.message(), "Maximum call stack size exceeded");
        assert_eq!(depth(), 0);
    }

    #[test]
    fn recursion_up_to_the_limit_succeeds() {
        assert_eq!(bounded(MAX_DEPTH - 1).unwrap(), MAX_DEPTH);
        assert!(bounded(MAX_DEPTH).is_err());
        assert_eq!(depth(), 0);
    }
}
