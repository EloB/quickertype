//! Port of `packages/quicktype-core/src/Run.ts`: the pipeline driver.
//!
//! [`quicktype_multi_file`] (and its synchronous twin
//! [`quicktype_multi_file_sync`]) turn [`Options`] into generated files:
//!
//! 1. *pre-run*: reset the random type names, and pass a single JSON Schema
//!    through unchanged when the target is JSON Schema and no input needs
//!    the IR;
//! 2. *make graph*: let every input add its types to a fresh
//!    [`TypeBuilder`] ("read input"), then run the rewrite passes in
//!    TypeScript's exact order, including its fixed-point loops (see
//!    `docs/research/01-type-graph-and-pipeline.md`, section 1);
//! 3. *render*: gather names and render with the target language, or
//!    produce `Done.` with [`Options::no_render`].
//!
//! [`quicktype`] does the same and concatenates the files with
//! [`combine_render_results`]. [`RunContext`] is what inputs receive from
//! the run (TS `interface RunContext`, which `Run` implements).
use std::convert::Infallible;
use std::fmt;
use std::future::Future;
use std::pin::Pin;
use std::rc::Rc;
use std::task::{Context, Poll};

use quicktype_js_compat::json;

use crate::attributes::type_names::{TypeNameGenerator, with_type_name_generator};
use crate::gather_names::gather_names;
use crate::inference::{INFERENCE_FLAGS, InferenceFlags};
use crate::input::inputs::InputData;
use crate::language::all::{default_target_languages, language_named};
use crate::language::typescript_flow::language::TypeScriptTargetLanguage;
use crate::make_transformations::make_transformations;
use crate::messages::{JsErrorName, QuickTypeError, Result};
use crate::renderer_options::RendererOptions;
use crate::rewrites::combine_classes::combine_classes;
use crate::rewrites::expand_strings::{EnumInference, expand_strings};
use crate::rewrites::flatten_strings::flatten_strings;
use crate::rewrites::flatten_unions::flatten_unions;
use crate::rewrites::infer_maps::infer_maps;
use crate::rewrites::replace_object_type::replace_object_type;
use crate::rewrites::resolve_intersections::resolve_intersections;
use crate::source::{Annotation, Location, SerializedRenderResult, Span};
use crate::support::comments::Comment;
use crate::support::support::{assert, console_log};
use crate::target_language::{MultiFileRenderResult, TargetLanguage};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_builder::TypeBuilder;
use crate::ty::type_builder_utils::StringTypeMapping;
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_graph_utils::{
    none_to_any, optional_to_nullable, remove_indirection_intersections,
};

/// The duration of one pipeline pass (TS `QuicktypeTiming`), reported to
/// [`RunContext::on_timing`].
#[non_exhaustive]
#[derive(Clone, Debug, PartialEq)]
pub struct QuicktypeTiming {
    /// The pass, e.g. `"read input"`.
    pub name: String,
    /// How long it took.
    pub milliseconds: f64,
}

/// A monotonic clock in milliseconds (TS `performance.now()`).
pub type Clock = Rc<dyn Fn() -> f64>;

/// A callback for each timed pass (TS `onTiming`).
pub type TimingCallback = Rc<dyn Fn(&QuicktypeTiming)>;

/// `ctx.time` as a value an input can keep (the JSON Schema input times
/// the parsing of schema text with it): runs the function once, reporting
/// how long it took.
pub type Timer = Rc<dyn Fn(&str, &mut dyn FnMut())>;

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
        match self.time_result(name, || Ok::<T, Infallible>(f())) {
            Ok(result) => result,
            Err(never) => match never {},
        }
    }

    /// `time(name, f)` for a pass that can fail: as in TypeScript, where
    /// the pass throws, a failed pass is not reported.
    pub fn time_result<T, E>(
        &self,
        name: &str,
        f: impl FnOnce() -> std::result::Result<T, E>,
    ) -> std::result::Result<T, E> {
        let start = (self.clock)();
        let result = f()?;
        self.report(name, (self.clock)() - start);
        Ok(result)
    }

    /// `timeSync(name, f)` (which, despite its name, times an async pass);
    /// like [`time_result`](Self::time_result), a failed pass is not
    /// reported.
    pub async fn time_async<T, E>(
        &self,
        name: &str,
        f: impl Future<Output = std::result::Result<T, E>>,
    ) -> std::result::Result<T, E> {
        let start = (self.clock)();
        let result = f.await?;
        self.report(name, (self.clock)() - start);
        Ok(result)
    }

    /// `time` as a [`Timer`] that outlives this borrow of the context.
    pub fn timer(&self) -> Timer {
        let clock = Rc::clone(&self.clock);
        let on_timing = self.on_timing.clone();
        let print_times = self.debug_print_times;
        Rc::new(move |name, f| {
            let start = clock();
            f();
            report(print_times, on_timing.as_ref(), name, clock() - start);
        })
    }

    fn report(&self, name: &str, milliseconds: f64) {
        report(
            self.debug_print_times,
            self.on_timing.as_ref(),
            name,
            milliseconds,
        );
    }
}

/// Reports a timed pass: prints it with `--debug print-times` and calls
/// `onTiming`.
fn report(print_times: bool, on_timing: Option<&TimingCallback>, name: &str, milliseconds: f64) {
    if print_times {
        // `milliseconds.toFixed(3)`; Rust rounds exact ties to even where
        // JavaScript rounds them up, which only a measured time that is an
        // exact binary fraction could show.
        console_log(&format!("{name} took {milliseconds:.3}ms"));
    }
    if let Some(on_timing) = on_timing {
        on_timing(&QuicktypeTiming {
            name: name.to_owned(),
            milliseconds,
        });
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
    Rc::new(move || start.elapsed().as_secs_f64() * 1000.0)
}

#[cfg(target_arch = "wasm32")]
fn default_clock() -> Clock {
    // The WebAssembly bindings pass `performance.now` as the clock.
    Rc::new(|| 0.0)
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

/// `getTargetLanguage(name)`: the built-in language with `name` among its
/// names.
///
/// For an unknown name, TypeScript's `languageNamed` throws a plain
/// `Error` before `getTargetLanguage` gets to report
/// `DriverUnknownOutputLanguage`, so that is the error here too.
///
/// ```
/// let rust = quicktype_core::get_target_language("rs").unwrap();
/// assert_eq!(rust.name(), "rust");
/// let error = quicktype_core::get_target_language("cobol").unwrap_err();
/// assert_eq!(error.user_message(), "Unknown language name: cobol");
/// ```
pub fn get_target_language(name: &str) -> Result<&'static dyn TargetLanguage> {
    language_named(name, default_target_languages()).ok_or_else(|| {
        QuickTypeError::js_exception(JsErrorName::Error, format!("Unknown language name: {name}"))
    })
}

/// The `--debug` switches of a run (the `debugPrint*` options of TS
/// `Options`); all off by default. Everything they print goes to
/// [`console_log`].
#[non_exhaustive]
#[derive(Clone, Copy, Debug, Default, PartialEq, Eq)]
pub struct DebugOptions {
    /// `debugPrintGraph`: print the type graph after every rewrite.
    pub print_graph: bool,
    /// `debugPrintReconstitution`: print how types are rebuilt.
    pub print_reconstitution: bool,
    /// `debugPrintGatherNames`: print the names gathered for each type.
    pub print_gather_names: bool,
    /// `debugPrintTransformations`: print the transformations made.
    pub print_transformations: bool,
    /// `debugPrintSchemaResolving`: print how JSON Schema `$ref`s resolve.
    pub print_schema_resolving: bool,
    /// `debugPrintTimes`: print how long each pass took.
    pub print_times: bool,
}

/// What to generate, from what, and how (TS `Options`).
///
/// Build it with [`Options::new`] (or [`Default`], which targets
/// TypeScript like quicktype's `defaultOptions`) and the `with_*` methods,
/// or set the fields:
///
/// ```
/// use quicktype_core::{InputData, Options, get_target_language};
///
/// let options = Options::new(get_target_language("rust").unwrap(), InputData::new())
///     .with_alphabetize_properties(true)
///     .with_output_filename("person.rs");
/// assert_eq!(options.lang.name(), "rust");
/// assert_eq!(options.output_filename, "person.rs");
/// ```
#[non_exhaustive]
pub struct Options<'a> {
    /// `lang`: the target language.
    pub lang: &'a dyn TargetLanguage,
    /// `inputData`: the input from which to produce types.
    pub input_data: InputData,
    /// The inference flags (TS `InferenceFlags`, spread into `Options`).
    pub inference_flags: InferenceFlags,
    /// `alphabetizeProperties`: put class properties in alphabetical order
    /// instead of the order found in the input.
    pub alphabetize_properties: bool,
    /// `allPropertiesOptional`: make all class properties optional.
    pub all_properties_optional: bool,
    /// `fixedTopLevels`: keep top-level classes from JSON separate even if
    /// they are identical.
    pub fixed_top_levels: bool,
    /// `noRender`: don't render; the result is the single line `Done.`.
    pub no_render: bool,
    /// `leadingComments`: comments for the beginning of the main output
    /// file.
    pub leading_comments: Option<Vec<Comment>>,
    /// `rendererOptions`: the target language's options, untyped like the
    /// TypeScript `Record<string, unknown>`.
    pub renderer_options: RendererOptions,
    /// `indentation`: one indentation level; the language's default if
    /// `None`.
    pub indentation: Option<String>,
    /// `outputFilename`: the name of the main output file. quicktype does
    /// not write it, but it keys the result and appears in some outputs.
    pub output_filename: String,
    /// `checkProvenance`: check that every rewrite carries all type
    /// attributes over (`--debug provenance`).
    pub check_provenance: bool,
    /// The `debugPrint*` switches.
    pub debug: DebugOptions,
    /// `onTiming`: called after each measured pass.
    pub on_timing: Option<TimingCallback>,
    /// The clock passes are timed with; [`std::time::Instant`] natively if
    /// `None`.
    pub clock: Option<Clock>,
}

impl<'a> Options<'a> {
    /// The default options (TS `defaultOptions` and `defaultInferenceFlags`)
    /// for `lang` and `input_data`: every inference flag on, everything else
    /// off, output file name `stdout`.
    pub fn new(lang: &'a dyn TargetLanguage, input_data: InputData) -> Self {
        Options {
            lang,
            input_data,
            inference_flags: InferenceFlags::default(),
            alphabetize_properties: false,
            all_properties_optional: false,
            fixed_top_levels: false,
            no_render: false,
            leading_comments: None,
            renderer_options: RendererOptions::new(),
            indentation: None,
            output_filename: "stdout".to_owned(),
            check_provenance: false,
            debug: DebugOptions::default(),
            on_timing: None,
            clock: None,
        }
    }
}

/// `with_<field>(value)`: sets the field and returns the options.
macro_rules! with_methods {
    ($($(#[$doc:meta])* $method:ident($field:ident: $ty:ty)),* $(,)?) => {
        $(
            $(#[$doc])*
            #[must_use]
            pub fn $method(mut self, $field: $ty) -> Self {
                self.$field = $field;
                self
            }
        )*
    };
}

impl<'a> Options<'a> {
    with_methods! {
        /// Sets [`inference_flags`](Self::inference_flags).
        with_inference_flags(inference_flags: InferenceFlags),
        /// Sets [`alphabetize_properties`](Self::alphabetize_properties).
        with_alphabetize_properties(alphabetize_properties: bool),
        /// Sets [`all_properties_optional`](Self::all_properties_optional).
        with_all_properties_optional(all_properties_optional: bool),
        /// Sets [`fixed_top_levels`](Self::fixed_top_levels).
        with_fixed_top_levels(fixed_top_levels: bool),
        /// Sets [`no_render`](Self::no_render).
        with_no_render(no_render: bool),
        /// Sets [`leading_comments`](Self::leading_comments).
        with_leading_comments(leading_comments: Option<Vec<Comment>>),
        /// Sets [`renderer_options`](Self::renderer_options).
        with_renderer_options(renderer_options: RendererOptions),
        /// Sets [`indentation`](Self::indentation).
        with_indentation(indentation: Option<String>),
        /// Sets [`check_provenance`](Self::check_provenance).
        with_check_provenance(check_provenance: bool),
        /// Sets [`debug`](Self::debug).
        with_debug(debug: DebugOptions),
        /// Sets [`on_timing`](Self::on_timing).
        with_on_timing(on_timing: Option<TimingCallback>),
        /// Sets [`clock`](Self::clock).
        with_clock(clock: Option<Clock>),
    }

    /// Sets [`output_filename`](Self::output_filename).
    #[must_use]
    pub fn with_output_filename(mut self, output_filename: impl Into<String>) -> Self {
        self.output_filename = output_filename.into();
        self
    }
}

impl DebugOptions {
    /// Every switch on (`--debug all`, without `provenance`, which is
    /// [`Options::check_provenance`]).
    pub fn all() -> Self {
        DebugOptions {
            print_graph: true,
            print_reconstitution: true,
            print_gather_names: true,
            print_transformations: true,
            print_schema_resolving: true,
            print_times: true,
        }
    }

    with_methods! {
        /// Sets [`print_graph`](Self::print_graph).
        with_print_graph(print_graph: bool),
        /// Sets [`print_reconstitution`](Self::print_reconstitution).
        with_print_reconstitution(print_reconstitution: bool),
        /// Sets [`print_gather_names`](Self::print_gather_names).
        with_print_gather_names(print_gather_names: bool),
        /// Sets [`print_transformations`](Self::print_transformations).
        with_print_transformations(print_transformations: bool),
        /// Sets [`print_schema_resolving`](Self::print_schema_resolving).
        with_print_schema_resolving(print_schema_resolving: bool),
        /// Sets [`print_times`](Self::print_times).
        with_print_times(print_times: bool),
    }
}

impl Default for Options<'_> {
    /// TS `defaultOptions`: TypeScript output (`lang: "ts"`) from an empty
    /// [`InputData`].
    fn default() -> Self {
        Options::new(&TypeScriptTargetLanguage, InputData::new())
    }
}

impl fmt::Debug for Options<'_> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.debug_struct("Options")
            .field("lang", &self.lang.name())
            .field("input_data", &self.input_data)
            .field("inference_flags", &self.inference_flags)
            .field("alphabetize_properties", &self.alphabetize_properties)
            .field("all_properties_optional", &self.all_properties_optional)
            .field("fixed_top_levels", &self.fixed_top_levels)
            .field("no_render", &self.no_render)
            .field("leading_comments", &self.leading_comments)
            .field("renderer_options", &self.renderer_options)
            .field("indentation", &self.indentation)
            .field("output_filename", &self.output_filename)
            .field("check_provenance", &self.check_provenance)
            .field("debug", &self.debug)
            .finish_non_exhaustive()
    }
}

/// TS `GraphInputs`: what `makeGraphInputs` prepares for building and
/// processing the graph.
struct GraphInputs {
    conflate_numbers: bool,
    type_builder: TypeBuilder<'static>,
}

/// TS class `Run`: one conversion.
struct Run<'a> {
    lang: &'a dyn TargetLanguage,
    input_data: InputData,
    flags: InferenceFlags,
    alphabetize_properties: bool,
    all_properties_optional: bool,
    fixed_top_levels: bool,
    no_render: bool,
    leading_comments: Option<Vec<Comment>>,
    renderer_options: RendererOptions,
    indentation: Option<String>,
    output_filename: String,
    check_provenance: bool,
    debug: DebugOptions,
    /// The run as the inputs see it (`this` as a `RunContext`).
    ctx: RunContext,
}

impl<'a> Run<'a> {
    fn new(options: Options<'a>) -> Self {
        let Options {
            lang,
            input_data,
            inference_flags,
            alphabetize_properties,
            all_properties_optional,
            fixed_top_levels,
            no_render,
            leading_comments,
            renderer_options,
            indentation,
            output_filename,
            check_provenance,
            debug,
            on_timing,
            clock,
        } = options;
        let mut ctx = RunContext::for_target_language(lang, &inference_flags);
        ctx.debug_print_reconstitution = debug.print_reconstitution;
        ctx.debug_print_schema_resolving = debug.print_schema_resolving;
        ctx.debug_print_transformations = debug.print_transformations;
        ctx.debug_print_times = debug.print_times;
        ctx.on_timing = on_timing;
        if let Some(clock) = clock {
            ctx.clock = clock;
        }
        Run {
            lang,
            input_data,
            flags: inference_flags,
            alphabetize_properties,
            all_properties_optional,
            fixed_top_levels,
            no_render,
            leading_comments,
            renderer_options,
            indentation,
            output_filename,
            check_provenance,
            debug,
            ctx,
        }
    }

    /// `makeGraphInputs()`.
    fn make_graph_inputs(&self) -> Result<GraphInputs> {
        let type_builder = TypeBuilder::new(
            self.ctx.string_type_mapping.clone(),
            self.alphabetize_properties,
            self.all_properties_optional,
            self.check_provenance,
            false,
        )?;
        Ok(GraphInputs {
            conflate_numbers: !self.lang.supports_unions_with_both_number_types(),
            type_builder,
        })
    }

    /// `makeGraph(allInputs)`.
    async fn make_graph(&mut self) -> Result<TypeGraph> {
        let mut graph_inputs = self.make_graph_inputs()?;
        let input_data = &mut self.input_data;
        self.ctx
            .time_async(
                "read input",
                input_data.add_types(
                    &self.ctx,
                    &mut graph_inputs.type_builder,
                    self.flags.infer_maps,
                    self.flags.infer_enums,
                    self.fixed_top_levels,
                ),
            )
            .await?;
        self.process_graph(graph_inputs)
    }

    /// `makeGraphSync(allInputs)`.
    fn make_graph_sync(&mut self) -> Result<TypeGraph> {
        let mut graph_inputs = self.make_graph_inputs()?;
        let input_data = &mut self.input_data;
        self.ctx.time_result("read input", || {
            input_data.add_types_sync(
                &self.ctx,
                &mut graph_inputs.type_builder,
                self.flags.infer_maps,
                self.flags.infer_enums,
                self.fixed_top_levels,
            )
        })?;
        self.process_graph(graph_inputs)
    }

    /// `processGraph(allInputs, graphInputs)`: the rewrite passes, in
    /// TypeScript's order. TypeScript tells whether a pass changed the graph
    /// by object identity; here every pass returns `None` for "unchanged".
    fn process_graph(&self, graph_inputs: GraphInputs) -> Result<TypeGraph> {
        let GraphInputs {
            conflate_numbers,
            type_builder,
        } = graph_inputs;
        let stm = &self.ctx.string_type_mapping;
        let dpr = self.ctx.debug_print_reconstitution;
        let need_schema_processing = self.input_data.need_schema_processing();

        let did_add_forwarding_intersection = type_builder.did_add_forwarding_intersection();
        let mut graph = type_builder.finish()?;
        if self.debug.print_graph {
            graph.set_print_on_rewrite();
            graph.print_graph()?;
        }

        if did_add_forwarding_intersection || !self.flags.ignore_json_refs {
            if let Some(g) = self
                .ctx
                .time_result("remove indirection intersections", || {
                    remove_indirection_intersections(&graph, stm, dpr)
                })?
            {
                graph = g;
            }
        }

        let mut unions_done = false;
        if need_schema_processing || !self.flags.ignore_json_refs {
            let mut intersections_done = false;
            loop {
                let mut changed = false;
                if !intersections_done {
                    let (g, done) = self.ctx.time_result("resolve intersections", || {
                        resolve_intersections(&graph, stm, dpr)
                    })?;
                    if let Some(g) = g {
                        graph = g;
                        changed = true;
                    }
                    intersections_done = done;
                }
                if !unions_done {
                    let (g, done) = self.ctx.time_result("flatten unions", || {
                        flatten_unions(&graph, stm, conflate_numbers, true, dpr)
                    })?;
                    if let Some(g) = g {
                        graph = g;
                        changed = true;
                    }
                    unions_done = done;
                }
                if !changed {
                    assert(
                        intersections_done && unions_done,
                        "Graph didn't change but we're not done",
                    )?;
                }
                if intersections_done && unions_done {
                    break;
                }
            }
        }

        if let Some(g) = self.ctx.time_result("replace object type", || {
            replace_object_type(
                &graph,
                stm,
                conflate_numbers,
                self.lang.supports_full_object_type(),
                dpr,
            )
        })? {
            graph = g;
        }
        loop {
            let (g, done) = self.ctx.time_result("flatten unions", || {
                flatten_unions(&graph, stm, conflate_numbers, false, dpr)
            })?;
            if let Some(g) = g {
                graph = g;
            }
            if done {
                break;
            }
        }

        if self.flags.combine_classes {
            let combined = self.ctx.time_result("combine classes", || {
                combine_classes(
                    &self.ctx,
                    &graph,
                    self.alphabetize_properties,
                    true,
                    false,
                    dpr,
                )
            })?;
            if let Some(combined) = combined {
                let cleaned = self.ctx.time_result("combine classes cleanup", || {
                    combine_classes(
                        &self.ctx,
                        &combined,
                        self.alphabetize_properties,
                        false,
                        true,
                        dpr,
                    )
                })?;
                graph = cleaned.unwrap_or(combined);
            }
        }

        if self.flags.infer_maps {
            while let Some(g) = self
                .ctx
                .time_result("infer maps", || infer_maps(&graph, stm, true, dpr))?
            {
                graph = g;
            }
        }

        let enum_inference = if need_schema_processing {
            EnumInference::All
        } else if self.flags.infer_enums {
            EnumInference::Infer
        } else {
            EnumInference::None
        };
        if let Some(g) = self.ctx.time_result("expand strings", || {
            expand_strings(&graph, stm, dpr, enum_inference)
        })? {
            graph = g;
        }
        let (g, done) = self.ctx.time_result("flatten unions", || {
            flatten_unions(&graph, stm, conflate_numbers, false, dpr)
        })?;
        if let Some(g) = g {
            graph = g;
        }
        assert(
            done,
            "We should only have to flatten unions once after expanding strings",
        )?;

        if need_schema_processing {
            if let Some(g) = self
                .ctx
                .time_result("flatten strings", || flatten_strings(&graph, stm, dpr))?
            {
                graph = g;
            }
        }

        if let Some(g) = self
            .ctx
            .time_result("none to any", || none_to_any(&graph, stm, dpr))?
        {
            graph = g;
        }
        if !self.lang.supports_optional_class_properties() {
            if let Some(g) = self.ctx.time_result("optional to nullable", || {
                optional_to_nullable(&graph, stm, dpr)
            })? {
                graph = g;
            }
        }

        if let Some(g) = self
            .ctx
            .time_result("fixed point", || graph.rewrite_fixed_point(false, dpr))?
        {
            graph = g;
        }

        let lang = self.lang;
        if let Some(g) = self.ctx.time_result("make transformations", || {
            make_transformations(
                &graph,
                stm,
                &|g, t| lang.needs_transformer_for_type(g, t),
                dpr,
                self.ctx.debug_print_transformations,
            )
        })? {
            graph = g;
        }

        let (g, done) = self.ctx.time_result("flatten unions", || {
            flatten_unions(&graph, stm, conflate_numbers, false, dpr)
        })?;
        if let Some(g) = g {
            graph = g;
        }
        assert(
            done,
            "We should only have to flatten unions once after making transformations",
        )?;

        // TypeScript always garbage collects, to get a defined type order.
        graph = self.ctx.time_result("GC", || {
            graph.garbage_collect(self.alphabetize_properties, dpr)
        })?;

        if self.debug.print_graph {
            console_log("\n# gather names");
        }
        self.ctx.time_result("gather names", || {
            gather_names(
                &mut graph,
                !need_schema_processing,
                self.debug.print_gather_names,
            )
        })?;
        if self.debug.print_graph {
            graph.print_graph()?;
        }

        Ok(graph)
    }

    /// `makeSimpleTextResult(lines)`.
    fn make_simple_text_result(&self, lines: Vec<String>) -> MultiFileRenderResult {
        let mut result = MultiFileRenderResult::new();
        result.insert(
            self.output_filename.clone(),
            SerializedRenderResult {
                lines,
                annotations: Vec::new(),
            },
        );
        result
    }

    /// `preRun()`: when the target is JSON Schema and no input needs the
    /// IR, passes a single JSON Schema source through, reformatted like
    /// `JSON.stringify(JSON.parse(schema), undefined, 4)`.
    ///
    /// TypeScript also calls `initTypeNames()` here, resetting the global
    /// random-name generator (which makes it "not quite reentrant"); a Rust
    /// run starts with a fresh [`TypeNameGenerator`] of its own instead.
    fn pre_run(&self) -> Result<Option<MultiFileRenderResult>> {
        let need_ir = self.input_data.need_ir() || !self.lang.names().contains(&"schema");
        if need_ir {
            return Ok(None);
        }
        let Some(schema_string) = self.input_data.single_string_schema_source()? else {
            return Ok(None);
        };
        let value = json::parse(&schema_string)
            .map_err(|e| QuickTypeError::js_exception(JsErrorName::SyntaxError, e.message()))?;
        let mut lines: Vec<String> = json::stringify(&value, Some("    "))
            .split('\n')
            .map(str::to_owned)
            .collect();
        lines.push(String::new());
        Ok(Some(self.make_simple_text_result(lines)))
    }

    /// `run()`, with the run's own random type names installed whenever
    /// its future is polled.
    fn run(mut self) -> impl Future<Output = Result<MultiFileRenderResult>> + 'a {
        let type_names = Rc::new(TypeNameGenerator::new());
        WithTypeNames {
            type_names,
            future: Box::pin(async move {
                if let Some(result) = self.pre_run()? {
                    return Ok(result);
                }
                let graph = self.make_graph().await?;
                self.render_graph(&graph)
            }),
        }
    }

    /// `runSync()`, with the run's own random type names.
    fn run_sync(mut self) -> Result<MultiFileRenderResult> {
        with_type_name_generator(&Rc::new(TypeNameGenerator::new()), || {
            if let Some(result) = self.pre_run()? {
                return Ok(result);
            }
            let graph = self.make_graph_sync()?;
            self.render_graph(&graph)
        })
    }

    /// `renderGraph(targetLanguage, graph)`.
    fn render_graph(&self, graph: &TypeGraph) -> Result<MultiFileRenderResult> {
        self.ctx.time_result("render", || {
            if self.no_render {
                return Ok(self.make_simple_text_result(vec!["Done.".to_owned(), String::new()]));
            }
            self.lang.render_graph_and_serialize(
                graph,
                &self.output_filename,
                self.alphabetize_properties,
                self.leading_comments.as_deref(),
                &self.renderer_options,
                self.indentation.as_deref(),
            )
        })
    }
}

/// A run's future: every poll executes with the run's random type names,
/// so runs that interleave on one thread (awaiting `$ref` fetches) each
/// draw from their own generator.
struct WithTypeNames<'a, T> {
    type_names: Rc<TypeNameGenerator>,
    future: Pin<Box<dyn Future<Output = T> + 'a>>,
}

impl<T> Future for WithTypeNames<'_, T> {
    type Output = T;

    fn poll(self: Pin<&mut Self>, cx: &mut Context<'_>) -> Poll<T> {
        let this = self.get_mut();
        with_type_name_generator(&this.type_names, || this.future.as_mut().poll(cx))
    }
}

/// `quicktypeMultiFile(options)`: runs quicktype and returns every output
/// file, keyed by file name, in the order the renderer produced them.
///
/// The future only waits for the inputs (JSON Schema input fetches `$ref`ed
/// documents through its store); everything else is synchronous. Natively
/// any executor works, e.g. a minimal `block_on`.
pub async fn quicktype_multi_file(options: Options<'_>) -> Result<MultiFileRenderResult> {
    Run::new(options).run().await
}

/// `quicktypeMultiFileSync(options)`: [`quicktype_multi_file`] without
/// awaiting. Inputs that can only work asynchronously (JSON Schema) fail
/// with their `addTypesSync` error, as in TypeScript.
///
/// ```
/// use quicktype_core::{
///     InputData, JsonSourceData, Options, get_target_language, json_input_for_target_language,
///     quicktype_multi_file_sync,
/// };
///
/// let rust = get_target_language("rust").unwrap();
/// let mut input = json_input_for_target_language(rust, false, &Default::default());
/// input
///     .add_source_sync(JsonSourceData {
///         name: "Person".to_owned(),
///         samples: vec![r#"{"name": "Ann", "age": 7}"#.into()],
///         description: None,
///     })
///     .unwrap();
/// let mut input_data = InputData::new();
/// input_data.add_input(input);
///
/// let files = quicktype_multi_file_sync(Options::new(rust, input_data)).unwrap();
/// let code = files["stdout"].lines.join("\n");
/// assert!(code.contains("pub struct Person {"));
/// ```
pub fn quicktype_multi_file_sync(options: Options<'_>) -> Result<MultiFileRenderResult> {
    Run::new(options).run_sync()
}

/// `offsetSpan(span, lineOffset)`.
fn offset_span(span: Span, line_offset: usize) -> Span {
    let offset = |loc: Location| Location {
        line: loc.line + line_offset,
        column: loc.column,
    };
    Span {
        start: offset(span.start),
        end: offset(span.end),
    }
}

/// `combineRenderResults(result)`: the files of a multi-file result as one
/// output. A single file is returned as is; several are concatenated, each
/// preceded by a `// <filename>` line and an empty line, with the
/// annotation spans moved accordingly.
pub fn combine_render_results(result: MultiFileRenderResult) -> SerializedRenderResult {
    if result.len() <= 1 {
        return result.into_values().next().unwrap_or_default();
    }
    let mut lines: Vec<String> = Vec::new();
    let mut annotations: Vec<Annotation> = Vec::new();
    for (filename, srr) in result {
        let offset = lines.len() + 2;
        lines.push(format!("// {filename}"));
        lines.push(String::new());
        lines.extend(srr.lines);
        annotations.extend(srr.annotations.into_iter().map(|ann| Annotation {
            annotation: ann.annotation,
            span: offset_span(ann.span, offset),
        }));
    }
    SerializedRenderResult { lines, annotations }
}

/// `quicktype(options)`: [`quicktype_multi_file`], with several output
/// files squashed into one by [`combine_render_results`].
pub async fn quicktype(options: Options<'_>) -> Result<SerializedRenderResult> {
    Ok(combine_render_results(quicktype_multi_file(options).await?))
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
        ctx.on_timing = Some(Rc::new(move |t| sink.borrow_mut().push(t.name.clone())));
        let ticks = Rc::new(RefCell::new(0.0));
        let clock = Rc::clone(&ticks);
        ctx.clock = Rc::new(move || {
            *clock.borrow_mut() += 1.5;
            *clock.borrow()
        });
        assert_eq!(ctx.time("read input", || 42), 42);
        assert_eq!(*seen.borrow(), ["read input"]);
    }
}
