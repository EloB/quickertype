//! Port of `packages/quicktype-core/src/support/Support.ts`.
//!
//! The TypeScript helpers `assert`, `defined`, `panic` and friends throw a
//! `QuickTypeError` of kind `InternalError`. Here they return
//! `Err(QuickTypeError)` instead, so callers propagate them with `?` and the
//! process never aborts on them. The JSON-value checkers (`isStringMap`,
//! `checkStringMap`, `checkArray`, `checkString`) belong with the JSON value
//! type of the input work package and are not ported here.

use std::cell::RefCell;
use std::io::Write;

use crate::messages::{ErrorKind, QuickTypeError, Result};

/// `assert(condition, message)`: `Err(InternalError)` if `condition` is false.
pub fn assert(condition: bool, message: &str) -> Result<()> {
    if condition {
        Ok(())
    } else {
        Err(QuickTypeError::internal(message))
    }
}

/// `assert(condition)` with the default message `"Assertion failed"`.
pub fn assert_default(condition: bool) -> Result<()> {
    assert(condition, "Assertion failed")
}

/// `panic(message)`: always `Err(InternalError)`. Despite its name it does
/// not panic the Rust process.
pub fn panic<T>(message: impl Into<String>) -> Result<T> {
    Err(QuickTypeError::internal(message))
}

/// `defined(x)`: the value, or `Err` if it is `undefined`.
pub fn defined<T>(x: Option<T>) -> Result<T> {
    match x {
        Some(v) => Ok(v),
        None => panic("Defined value expected, but got undefined"),
    }
}

/// `nonNull(x)`: the value, or `Err` if it is `null`.
pub fn non_null<T>(x: Option<T>) -> Result<T> {
    match x {
        Some(v) => Ok(v),
        None => panic("Non-null value expected, but got null"),
    }
}

/// `assertNever(x)`: always `Err`, mentioning the unexpected value.
pub fn assert_never<T>(x: impl std::fmt::Display) -> Result<T> {
    Err(QuickTypeError::new(
        ErrorKind::InternalError,
        vec![("message", format!("Unexpected object {x}").into())],
    ))
}

/// `mustNotHappen()`.
pub fn must_not_happen<T>() -> Result<T> {
    panic("This must not happen")
}

/// `repeated(n, value)`.
pub fn repeated<T: Clone>(n: usize, value: T) -> Vec<T> {
    vec![value; n]
}

/// `repeatedCall(n, producer)`.
pub fn repeated_call<T>(n: usize, producer: impl FnMut() -> T) -> Vec<T> {
    std::iter::repeat_with(producer).take(n).collect()
}

/// `errorMessage(e)`: the message of an error.
pub fn error_message(e: &dyn std::error::Error) -> String {
    e.to_string()
}

/// `indentationString(level)`: two spaces per level.
pub fn indentation_string(level: usize) -> String {
    "  ".repeat(level)
}

/// A receiver for [`console_log`] lines.
pub type ConsoleSink = Box<dyn FnMut(&str)>;

thread_local! {
    static CONSOLE_SINK: RefCell<Option<ConsoleSink>> = const { RefCell::new(None) };
}

/// `console.log(line)`: quicktype's debug output (`--debug print-graph`,
/// `print-reconstitution`, ...). Writes `line` and a newline to stdout,
/// ignoring write errors, unless [`set_console_sink`] installed a sink on
/// this thread.
pub fn console_log(line: &str) {
    let handled = CONSOLE_SINK.with(|sink| {
        if let Some(sink) = sink.borrow_mut().as_mut() {
            sink(line);
            true
        } else {
            false
        }
    });
    if !handled {
        let mut stdout = std::io::stdout().lock();
        let _ = stdout.write_all(line.as_bytes());
        let _ = stdout.write_all(b"\n");
    }
}

/// Routes [`console_log`] output on this thread to `sink` (for tests and for
/// the WebAssembly build), or back to stdout with `None`.
pub fn set_console_sink(sink: Option<ConsoleSink>) {
    CONSOLE_SINK.with(|s| *s.borrow_mut() = sink);
}

/// Runs `f` and returns everything it wrote with [`console_log`], one entry
/// per line.
pub fn capture_console<R>(f: impl FnOnce() -> R) -> (R, Vec<String>) {
    use std::rc::Rc;
    let lines = Rc::new(RefCell::new(Vec::new()));
    let sink_lines = Rc::clone(&lines);
    let previous = CONSOLE_SINK.with(|s| s.borrow_mut().take());
    set_console_sink(Some(Box::new(move |line| {
        sink_lines.borrow_mut().push(line.to_owned())
    })));
    let result = f();
    set_console_sink(previous);
    let lines = lines.borrow().clone();
    (result, lines)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn helpers_return_internal_errors() {
        assert!(assert(true, "x").is_ok());
        let e = assert(false, "Something broke").unwrap_err();
        assert_eq!(e.kind(), ErrorKind::InternalError);
        assert_eq!(e.user_message(), "Internal error: Something broke");
        assert_eq!(
            assert_default(false).unwrap_err().user_message(),
            "Internal error: Assertion failed"
        );
        assert_eq!(
            defined::<u8>(None).unwrap_err().user_message(),
            "Internal error: Defined value expected, but got undefined"
        );
        assert_eq!(defined(Some(3)).unwrap(), 3);
        assert_eq!(
            must_not_happen::<()>().unwrap_err().user_message(),
            "Internal error: This must not happen"
        );
        assert_eq!(
            assert_never::<()>("x").unwrap_err().user_message(),
            "Internal error: Unexpected object x"
        );
        assert_eq!(indentation_string(3), "      ");
        assert_eq!(repeated(2, 'a'), vec!['a', 'a']);
    }

    #[test]
    fn console_can_be_captured() {
        let ((), lines) = capture_console(|| {
            console_log("one");
            console_log("two");
        });
        assert_eq!(lines, vec!["one", "two"]);
    }
}
