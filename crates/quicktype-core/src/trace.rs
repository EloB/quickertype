//! Not a quicktype file: where a run's time goes, for measurements
//! (docs/BENCHMARKS.md, "Where the WebAssembly engine's time goes").
//!
//! With the `trace` feature, each [`span`] records its name, start and end
//! in a buffer that is allocated once and read out once, after the work,
//! with [`take`]: nothing crosses into JavaScript while a run is timed.
//! Without the feature, [`span`] is empty and compiles away, and [`take`]
//! returns nothing.
//!
//! Spans are for phases (a pass, a reader's pass over a sample), not for
//! hot inner loops: recording one costs a clock read at each end, and a
//! name lookup among the few names seen so far. In WebAssembly the clock is
//! `performance.now()`, which the bindings set ([`set_clock`]); Chrome
//! coarsens it to 100 µs unless the page is cross-origin isolated (then 5
//! µs). Natively it is [`std::time::Instant`].

/// A phase being timed: it ends when this is dropped.
#[must_use = "a span ends when it is dropped"]
pub struct Span {
    #[cfg(feature = "trace")]
    name: u32,
    #[cfg(feature = "trace")]
    start: f64,
}

#[cfg(not(feature = "trace"))]
impl Drop for Span {
    /// Nothing: spans are recorded only with the `trace` feature (an empty
    /// `Drop` lets callers end a span with `drop` either way).
    #[inline(always)]
    fn drop(&mut self) {}
}

/// Starts timing phase `name`.
#[inline(always)]
pub fn span(name: &str) -> Span {
    #[cfg(feature = "trace")]
    return enabled::start(name);
    #[cfg(not(feature = "trace"))]
    {
        let _ = name;
        Span {}
    }
}

/// The spans recorded since the last call, in the order they ended: their
/// names, starts and ends (in milliseconds), and how many did not fit in
/// the buffer.
pub fn take() -> (Vec<(String, f64, f64)>, usize) {
    #[cfg(feature = "trace")]
    return enabled::take();
    #[cfg(not(feature = "trace"))]
    (Vec::new(), 0)
}

/// Sets the clock spans read, in milliseconds (`performance.now` in
/// WebAssembly, which has no clock of its own).
pub fn set_clock(clock: fn() -> f64) {
    #[cfg(feature = "trace")]
    enabled::set_clock(clock);
    #[cfg(not(feature = "trace"))]
    let _ = clock;
}

/// Whether spans are recorded (the `trace` feature).
pub const ENABLED: bool = cfg!(feature = "trace");

#[cfg(feature = "trace")]
mod enabled {
    use std::cell::{Cell, RefCell};

    use super::Span;

    /// How many spans the buffer holds; later ones are counted, not kept.
    const CAPACITY: usize = 1 << 16;

    #[derive(Default)]
    struct Trace {
        names: Vec<String>,
        spans: Vec<(u32, f64, f64)>,
        dropped: usize,
    }

    thread_local! {
        static TRACE: RefCell<Trace> = RefCell::new(Trace {
            spans: Vec::with_capacity(CAPACITY),
            ..Trace::default()
        });
        static CLOCK: Cell<Option<fn() -> f64>> = const { Cell::new(None) };
    }

    pub(super) fn set_clock(clock: fn() -> f64) {
        CLOCK.with(|c| c.set(Some(clock)));
    }

    fn now() -> f64 {
        match CLOCK.with(Cell::get) {
            Some(clock) => clock(),
            None => native_now(),
        }
    }

    #[cfg(not(target_arch = "wasm32"))]
    fn native_now() -> f64 {
        use std::sync::OnceLock;
        use std::time::Instant;
        static START: OnceLock<Instant> = OnceLock::new();
        START.get_or_init(Instant::now).elapsed().as_secs_f64() * 1000.0
    }

    #[cfg(target_arch = "wasm32")]
    fn native_now() -> f64 {
        f64::NAN
    }

    pub(super) fn start(name: &str) -> Span {
        let name = TRACE.with(|t| {
            let mut t = t.borrow_mut();
            match t.names.iter().position(|n| n == name) {
                Some(i) => i as u32,
                None => {
                    t.names.push(name.to_owned());
                    (t.names.len() - 1) as u32
                }
            }
        });
        Span { name, start: now() }
    }

    impl Drop for Span {
        fn drop(&mut self) {
            let end = now();
            TRACE.with(|t| {
                let mut t = t.borrow_mut();
                if t.spans.len() < CAPACITY {
                    t.spans.push((self.name, self.start, end));
                } else {
                    t.dropped += 1;
                }
            });
        }
    }

    pub(super) fn take() -> (Vec<(String, f64, f64)>, usize) {
        TRACE.with(|t| {
            let mut t = t.borrow_mut();
            let spans = t
                .spans
                .iter()
                .map(|&(name, start, end)| (t.names[name as usize].clone(), start, end))
                .collect();
            t.spans.clear();
            let dropped = std::mem::take(&mut t.dropped);
            (spans, dropped)
        })
    }
}

#[cfg(all(test, feature = "trace"))]
mod tests {
    use super::*;

    #[test]
    fn spans_in_the_order_they_end() {
        let _ = take();
        {
            let _outer = span("outer");
            let _inner = span("inner");
        }
        let (spans, dropped) = take();
        assert_eq!(dropped, 0);
        let names: Vec<&str> = spans.iter().map(|(n, ..)| n.as_str()).collect();
        assert_eq!(names, ["inner", "outer"]);
        assert!(spans.iter().all(|(_, start, end)| start <= end));
        assert!(take().0.is_empty());
    }
}
