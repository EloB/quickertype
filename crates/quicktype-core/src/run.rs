//! Port of `packages/quicktype-core/src/Run.ts`.
//!
//! Ported so far: [`RunContext`], what the inputs receive from the run
//! (TS `interface RunContext`), and [`string_type_mapping`], the
//! `stringTypeMapping` getter of `Run` that it carries.
//!
//! TODO(run): the rest of `Run.ts` is Phase 3: `Options` and the defaults,
//! `getTargetLanguage`, `Run` itself (`preRun`, `makeGraph`, `processGraph`,
//! `renderGraph`), `quicktype`, `quicktypeMultiFile`(`Sync`) and
//! `combineRenderResults`.

use std::fmt;
use std::future::Future;

use crate::inference::{INFERENCE_FLAGS, InferenceFlags};
use crate::support::support::console_log;
use crate::target_language::TargetLanguage;
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_builder_utils::StringTypeMapping;

/// The duration of one pipeline pass (TS `QuicktypeTiming`), reported to
/// [`RunContext::on_timing`].
#[derive(Clone, Debug, PartialEq)]
pub struct QuicktypeTiming {
    /// The pass, e.g. `"read input"`.
    pub name: String,
    /// How long it took.
    pub milliseconds: f64,
}

/// A monotonic clock in milliseconds (TS `performance.now()`).
pub type Clock = Box<dyn Fn() -> f64>;

/// A callback for each timed pass (TS `onTiming`).
pub type TimingCallback = Box<dyn Fn(&QuicktypeTiming)>;

/// What inputs receive from the run (TS `RunContext`, which `Run`
/// implements): the effective string type mapping, the debug switches and
/// the timing hook.
pub struct RunContext {
    /// `stringTypeMapping`, see [`string_type_mapping`].
    pub string_type_mapping: StringTypeMapping,
    /// `debugPrintReconstitution`.
    pub debug_print_reconstitution: bool,
    /// `debugPrintSchemaResolving`.
    pub debug_print_schema_resolving: bool,
    /// `debugPrintTransformations`.
    pub debug_print_transformations: bool,
    /// `debugPrintTimes`: print `<pass> took <ms>ms` after each timed pass.
    pub debug_print_times: bool,
    /// `onTiming`.
    pub on_timing: Option<TimingCallback>,
    /// The clock timings are measured with. The default is
    /// [`std::time::Instant`] natively and a clock stuck at 0 on
    /// WebAssembly, which has no `Instant` (the JS facade passes
    /// `performance.now`).
    pub clock: Clock,
}

impl RunContext {
    /// A context with `string_type_mapping` and every debug switch off.
    pub fn new(string_type_mapping: StringTypeMapping) -> Self {
        RunContext {
            string_type_mapping,
            debug_print_reconstitution: false,
            debug_print_schema_resolving: false,
            debug_print_transformations: false,
            debug_print_times: false,
            on_timing: None,
            clock: default_clock(),
        }
    }

    /// The context `Run` provides for `target_language` and `flags`.
    pub fn for_target_language(
        target_language: &dyn TargetLanguage,
        flags: &InferenceFlags,
    ) -> Self {
        Self::new(string_type_mapping(target_language, flags))
    }

    /// `time(name, f)`: runs `f` and reports how long it took.
    pub fn time<T>(&self, name: &str, f: impl FnOnce() -> T) -> T {
        let start = (self.clock)();
        let result = f();
        self.report(name, (self.clock)() - start);
        result
    }

    /// `timeSync(name, f)` (which, despite its name, times an async pass).
    pub async fn time_async<T>(&self, name: &str, f: impl Future<Output = T>) -> T {
        let start = (self.clock)();
        let result = f.await;
        self.report(name, (self.clock)() - start);
        result
    }

    fn report(&self, name: &str, milliseconds: f64) {
        if self.debug_print_times {
            // `milliseconds.toFixed(3)`; Rust rounds exact ties to even
            // where JavaScript rounds them up, which only a measured time
            // that is an exact binary fraction could show.
            console_log(&format!("{name} took {milliseconds:.3}ms"));
        }
        if let Some(on_timing) = &self.on_timing {
            on_timing(&QuicktypeTiming {
                name: name.to_owned(),
                milliseconds,
            });
        }
    }
}

impl fmt::Debug for RunContext {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.debug_struct("RunContext")
            .field("string_type_mapping", &self.string_type_mapping)
            .field(
                "debug_print_reconstitution",
                &self.debug_print_reconstitution,
            )
            .field(
                "debug_print_schema_resolving",
                &self.debug_print_schema_resolving,
            )
            .field(
                "debug_print_transformations",
                &self.debug_print_transformations,
            )
            .field("debug_print_times", &self.debug_print_times)
            .finish_non_exhaustive()
    }
}

#[cfg(not(target_arch = "wasm32"))]
fn default_clock() -> Clock {
    let start = std::time::Instant::now();
    Box::new(move || start.elapsed().as_secs_f64() * 1000.0)
}

#[cfg(target_arch = "wasm32")]
fn default_clock() -> Clock {
    // TODO(wasm): the facade passes `performance.now`.
    Box::new(|| 0.0)
}

/// `Run.stringTypeMapping`: the target language's mapping, with the
/// string kind of every inference flag that is off mapped to `string`.
/// Only the flag's own kind is remapped: turning off `inferDateTimes` maps
/// `date-time`, not `date` or `time`.
pub fn string_type_mapping(
    target_language: &dyn TargetLanguage,
    flags: &InferenceFlags,
) -> StringTypeMapping {
    let mut mapping = target_language.string_type_mapping();
    for flag in &INFERENCE_FLAGS {
        match flag.string_type {
            Some(string_type) if !flags.get(flag.name) => {
                mapping.set(string_type, TypeKind::String);
            }
            _ => {}
        }
    }
    mapping
}

#[cfg(test)]
mod tests {
    use std::cell::RefCell;
    use std::rc::Rc;

    use super::*;
    use crate::language::csharp::language::CSharpTargetLanguage;

    #[test]
    fn disabled_flags_map_their_kind_to_string() {
        let flags = InferenceFlags {
            infer_date_times: false,
            infer_uuids: false,
            ..InferenceFlags::default()
        };
        let mapping = string_type_mapping(&CSharpTargetLanguage, &flags);
        assert_eq!(mapping.get(TypeKind::DateTime), TypeKind::String);
        assert_eq!(mapping.get(TypeKind::Uuid), TypeKind::String);
        // Only `date-time` itself is remapped.
        assert_eq!(mapping.get(TypeKind::Date), TypeKind::DateTime);
        assert_eq!(
            mapping.get(TypeKind::IntegerString),
            TypeKind::IntegerString
        );
    }

    #[test]
    fn timing_reports_each_pass() {
        let seen = Rc::new(RefCell::new(Vec::new()));
        let mut ctx = RunContext::new(StringTypeMapping::new());
        let sink = Rc::clone(&seen);
        ctx.on_timing = Some(Box::new(move |t| sink.borrow_mut().push(t.name.clone())));
        let ticks = Rc::new(RefCell::new(0.0));
        let clock = Rc::clone(&ticks);
        ctx.clock = Box::new(move || {
            *clock.borrow_mut() += 1.5;
            *clock.borrow()
        });
        assert_eq!(ctx.time("read input", || 42), 42);
        assert_eq!(*seen.borrow(), ["read input"]);
    }
}
