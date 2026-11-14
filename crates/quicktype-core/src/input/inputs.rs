//! Port of `packages/quicktype-core/src/input/Inputs.ts`.
//!
//! An [`Input`] turns the sources of one source language (JSON samples,
//! JSON Schema, GraphQL) into types in the run's [`TypeBuilder`].
//! [`InputData`] holds one input per kind and runs them in the order they
//! were added. [`JsonInput`] is the JSON samples input.
//!
//! # Sync and async
//!
//! As in TypeScript, both steps of an input exist in a synchronous and an
//! asynchronous variant: `add_source`/`add_source_sync` and
//! `add_types`/`add_types_sync`. Only inputs that wait for I/O need the
//! async ones (JSON Schema input fetches `$ref`ed schemas in `add_types`);
//! by default they run the sync variant. The futures are deliberately not
//! `Send`: inputs live on one thread, and on WebAssembly they await
//! JavaScript promises. Natively, drive them with any executor (a simple
//! `block_on` suffices, since nothing in the engine itself waits).

use std::any::Any;
use std::future::Future;
use std::pin::Pin;
use std::rc::Rc;
use std::sync::OnceLock;

use indexmap::{IndexMap, IndexSet};

use super::compressed_json::{
    CompressedJson, CompressedJsonTables, JsonSample, ParseError, Value, parse_string_into,
};
use super::compressed_json_from_stream::{parse_stream_into, parse_stream_reader_into};
use super::inference::TypeInference;
use super::tallies::{NodeId, RunningTallies, TallyBuilder, tally_compressed};
use super::tally_inference::TallyInference;
use crate::attributes::description::DescriptionTypeAttributeKind;
use crate::attributes::type_attributes::AttributeKind;
use crate::attributes::type_names::make_names_type_attributes;
use crate::date_time::DateTimeRecognizer;
use crate::language::all::{default_target_languages, language_named};
use crate::messages::{ErrorKind, MessageValue, QuickTypeError, Result, message_error};
use crate::renderer_options::RendererOptions;
use crate::run::RunContext;
use crate::support::support::{defined, panic};
use crate::target_language::TargetLanguage;
use crate::ty::type_builder::TypeBuilder;

/// A boxed future that need not be `Send`.
pub type LocalBoxFuture<'a, T> = Pin<Box<dyn Future<Output = T> + 'a>>;

/// An input of one source language (TS `Input<T>`, with `T` as
/// [`Source`](Self::Source)).
///
/// Implementations: [`JsonInput`],
/// [`JsonSchemaInput`](crate::input::json_schema_input::JsonSchemaInput)
/// and quicktype-graphql-input's `GraphQlInput`.
/// [`InputData`] stores inputs as trait objects and finds them again by
/// [`kind`](Self::kind) and concrete type, so an implementation must be
/// `'static`.
pub trait Input: 'static {
    /// The source type `add_source` takes (TS `T`), e.g. [`JsonSourceData`].
    type Source;

    /// `kind`: the source language, e.g. `"json"`, `"schema"` or
    /// `"graphql"`. [`InputData`] keeps one input per kind.
    fn kind(&self) -> &str;

    /// `needIR`: whether the input needs the IR pipeline (rather than being
    /// passed through, as a single JSON Schema can be for schema output).
    fn need_ir(&self) -> bool;

    /// `needSchemaProcessing`: whether the graph needs the schema rewrites
    /// (intersection resolution).
    fn need_schema_processing(&self) -> bool;

    /// `addSource(source)`. Defaults to [`add_source_sync`](Self::add_source_sync).
    fn add_source(&mut self, source: Self::Source) -> impl Future<Output = Result<()>> {
        std::future::ready(self.add_source_sync(source))
    }

    /// `addSourceSync(source)`.
    fn add_source_sync(&mut self, source: Self::Source) -> Result<()>;

    /// `addTypes(ctx, typeBuilder, inferMaps, inferEnums, fixedTopLevels)`:
    /// adds the types of all sources, and their top-levels, to
    /// `type_builder`. Defaults to [`add_types_sync`](Self::add_types_sync).
    fn add_types(
        &mut self,
        ctx: &RunContext,
        type_builder: &mut TypeBuilder<'_>,
        infer_maps: bool,
        infer_enums: bool,
        fixed_top_levels: bool,
    ) -> impl Future<Output = Result<()>> {
        std::future::ready(self.add_types_sync(
            ctx,
            type_builder,
            infer_maps,
            infer_enums,
            fixed_top_levels,
        ))
    }

    /// `addTypesSync(ctx, typeBuilder, inferMaps, inferEnums,
    /// fixedTopLevels)`. Inputs that can only work asynchronously return an
    /// error here, as TypeScript's JSON Schema input does.
    fn add_types_sync(
        &mut self,
        ctx: &RunContext,
        type_builder: &mut TypeBuilder<'_>,
        infer_maps: bool,
        infer_enums: bool,
        fixed_top_levels: bool,
    ) -> Result<()>;

    /// `singleStringSchemaSource()`: the schema text if the input is exactly
    /// one JSON Schema given as a string (for the schema passthrough).
    fn single_string_schema_source(&self) -> Option<String>;
}

/// The object-safe part of [`Input`], which [`InputData`] stores.
trait DynInput {
    fn kind(&self) -> &str;
    fn need_ir(&self) -> bool;
    fn need_schema_processing(&self) -> bool;
    fn single_string_schema_source(&self) -> Option<String>;
    fn add_types_boxed<'a>(
        &'a mut self,
        ctx: &'a RunContext,
        type_builder: &'a mut TypeBuilder<'_>,
        infer_maps: bool,
        infer_enums: bool,
        fixed_top_levels: bool,
    ) -> LocalBoxFuture<'a, Result<()>>;
    fn add_types_sync(
        &mut self,
        ctx: &RunContext,
        type_builder: &mut TypeBuilder<'_>,
        infer_maps: bool,
        infer_enums: bool,
        fixed_top_levels: bool,
    ) -> Result<()>;
    fn as_any_mut(&mut self) -> &mut dyn Any;
}

impl<I: Input> DynInput for I {
    fn kind(&self) -> &str {
        Input::kind(self)
    }

    fn need_ir(&self) -> bool {
        Input::need_ir(self)
    }

    fn need_schema_processing(&self) -> bool {
        Input::need_schema_processing(self)
    }

    fn single_string_schema_source(&self) -> Option<String> {
        Input::single_string_schema_source(self)
    }

    fn add_types_boxed<'a>(
        &'a mut self,
        ctx: &'a RunContext,
        type_builder: &'a mut TypeBuilder<'_>,
        infer_maps: bool,
        infer_enums: bool,
        fixed_top_levels: bool,
    ) -> LocalBoxFuture<'a, Result<()>> {
        Box::pin(Input::add_types(
            self,
            ctx,
            type_builder,
            infer_maps,
            infer_enums,
            fixed_top_levels,
        ))
    }

    fn add_types_sync(
        &mut self,
        ctx: &RunContext,
        type_builder: &mut TypeBuilder<'_>,
        infer_maps: bool,
        infer_enums: bool,
        fixed_top_levels: bool,
    ) -> Result<()> {
        Input::add_types_sync(
            self,
            ctx,
            type_builder,
            infer_maps,
            infer_enums,
            fixed_top_levels,
        )
    }

    fn as_any_mut(&mut self) -> &mut dyn Any {
        self
    }
}

/// The inputs of a run (TS `InputData`), in the order they were added.
#[derive(Default)]
pub struct InputData {
    inputs: Vec<Box<dyn DynInput>>,
}

impl std::fmt::Debug for InputData {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_list()
            .entries(self.inputs.iter().map(|i| i.kind()))
            .finish()
    }
}

impl InputData {
    /// `new InputData()`.
    pub fn new() -> Self {
        Self::default()
    }

    /// `addInput(input)`.
    pub fn add_input<I: Input>(&mut self, input: I) {
        self.inputs.push(Box::new(input));
    }

    /// `getOrAddInput(kind, makeInput)`: the input of `kind`, created with
    /// `make_input` if there is none yet. An existing input of `kind` must
    /// be an `I`.
    fn get_or_add_input<I: Input>(
        &mut self,
        kind: &str,
        make_input: impl FnOnce() -> I,
    ) -> Result<&mut I> {
        let position = match self.inputs.iter().position(|i| i.kind() == kind) {
            Some(position) => position,
            None => {
                self.add_input(make_input());
                self.inputs.len() - 1
            }
        };
        match self.inputs[position].as_any_mut().downcast_mut::<I>() {
            Some(input) => Ok(input),
            None => panic(format!(
                "The input of kind {kind} doesn't take this kind of source"
            )),
        }
    }

    /// `addSource(kind, source, makeInput)`: adds `source` to the input of
    /// `kind`, which `make_input` creates if necessary.
    pub async fn add_source<I: Input>(
        &mut self,
        kind: &str,
        source: I::Source,
        make_input: impl FnOnce() -> I,
    ) -> Result<()> {
        let input = self.get_or_add_input(kind, make_input)?;
        input.add_source(source).await
    }

    /// `addSourceSync(kind, source, makeInput)`.
    pub fn add_source_sync<I: Input>(
        &mut self,
        kind: &str,
        source: I::Source,
        make_input: impl FnOnce() -> I,
    ) -> Result<()> {
        self.get_or_add_input(kind, make_input)?
            .add_source_sync(source)
    }

    /// `addTypes(ctx, typeBuilder, inferMaps, inferEnums, fixedTopLevels)`:
    /// every input, in order, into the same builder.
    pub async fn add_types(
        &mut self,
        ctx: &RunContext,
        type_builder: &mut TypeBuilder<'_>,
        infer_maps: bool,
        infer_enums: bool,
        fixed_top_levels: bool,
    ) -> Result<()> {
        for input in &mut self.inputs {
            input
                .add_types_boxed(ctx, type_builder, infer_maps, infer_enums, fixed_top_levels)
                .await?;
        }
        Ok(())
    }

    /// `addTypesSync(ctx, typeBuilder, inferMaps, inferEnums,
    /// fixedTopLevels)`.
    pub fn add_types_sync(
        &mut self,
        ctx: &RunContext,
        type_builder: &mut TypeBuilder<'_>,
        infer_maps: bool,
        infer_enums: bool,
        fixed_top_levels: bool,
    ) -> Result<()> {
        for input in &mut self.inputs {
            input.add_types_sync(ctx, type_builder, infer_maps, infer_enums, fixed_top_levels)?;
        }
        Ok(())
    }

    /// `needIR`: whether any input needs the IR pipeline.
    pub fn need_ir(&self) -> bool {
        self.inputs.iter().any(|i| i.need_ir())
    }

    /// `needSchemaProcessing`: whether any input needs the schema rewrites.
    pub fn need_schema_processing(&self) -> bool {
        self.inputs.iter().any(|i| i.need_schema_processing())
    }

    /// `singleStringSchemaSource()`: the one string schema among the
    /// inputs, if any; an internal error if there are several different
    /// ones.
    pub fn single_string_schema_source(&self) -> Result<Option<String>> {
        let schema_strings: IndexSet<String> = self
            .inputs
            .iter()
            .filter_map(|i| i.single_string_schema_source())
            .collect();
        if schema_strings.len() > 1 {
            return panic("We have more than one input with a string schema source");
        }
        Ok(schema_strings.into_iter().next())
    }
}

/// The samples of one top-level (TS `JSONSourceData<T>`).
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct JsonSourceData<T = JsonSample> {
    /// The top-level's name.
    pub name: String,
    /// The JSON samples; there must be at least one.
    pub samples: Vec<T>,
    /// A description for the top-level type.
    pub description: Option<String>,
}

/// TS `JSONTopLevel`.
#[derive(Debug, Default)]
struct JsonTopLevel {
    description: Option<String>,
    /// The samples in the compressed form, when inferring from it.
    samples: Vec<Value>,
    /// The tally of all samples, when inferring from tallies.
    tally: Option<NodeId>,
}

/// A top-level of a JavaScript-built `CompressedJSON` (research 05, §4.2):
/// its samples are `Value`s encoded as `tag | index << 4`.
#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub struct CompressedTopLevel {
    /// The top-level's name.
    pub name: String,
    /// Its description, if any.
    pub description: Option<String>,
    /// Its samples' root values.
    pub samples: Vec<i32>,
}

/// Where a [`JsonInput`] inferred its types from, the last time it did
/// ([`JsonInput::inferred_from`]). All of them infer the same types.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
#[non_exhaustive]
pub enum JsonInference {
    /// Running tallies, counted while the samples were read (the default).
    RunningTallies,
    /// Tallies of the compressed form, made in one walk over it (see
    /// [`JsonInput::set_tally_compressed`]).
    CompressedTallies,
    /// The compressed form's values one by one, as quicktype does: the
    /// reference, or a form the walk declined (values no reader makes).
    CompressedValues,
}

/// The JSON samples input (TS `JSONInput<T>`).
///
/// Each sample says how to read it ([`JsonSample`]): `JSON.parse`
/// semantics, as quicktype-core's JavaScript API reads strings, or
/// stream-json semantics, as the CLI reads files. TypeScript has one
/// reader per input; here one input takes both, so [`InputData`] can add
/// either kind of source to its single `"json"` input, as TypeScript adds
/// every source to the existing input.
///
/// ```
/// use quicktype_core::input::inputs::{JsonSourceData, json_input_for_target_language};
/// use quicktype_core::language::rust::language::RustTargetLanguage;
/// use quicktype_core::renderer_options::RendererOptions;
///
/// let mut input = json_input_for_target_language(&RustTargetLanguage, false, &RendererOptions::new());
/// let error = input
///     .add_source_sync(JsonSourceData {
///         name: "Person".to_owned(),
///         samples: vec![r#"{"name": "Ann", }"#.into()],
///         description: None,
///     })
///     .unwrap_err();
/// assert_eq!(
///     error.user_message(),
///     "Syntax error in input JSON Person: Expected double-quoted property name in JSON at position 16 (line 1 column 17)"
/// );
/// ```
///
/// # Running tallies
///
/// Types are inferred from running tallies of the samples (see
/// `docs/STREAMING-INFERENCE.md`): every sample is counted while it is read
/// and never kept, so memory grows with the number of distinct places,
/// keys and strings in the samples rather than with their size (a sample
/// given as text, [`JsonSample::String`], is still read whole first: its
/// syntax is checked, as `JSON.parse` checks it, on a tape of the whole
/// sample). The types are the same as quicktype infers from the
/// compressed form of the samples, which an input keeps after
/// [`set_tally_inference(false)`](Self::set_tally_inference) (or with
/// `QUICKTYPE_INFERENCE=compressed-json` in the environment, for testing)
/// and an input built with [`from_shared`](Self::from_shared) or
/// [`from_compressed`](Self::from_compressed) has. Only such an input can
/// be exported with [`to_compressed`](Self::to_compressed). It infers from
/// that form's values one by one, as quicktype does, or from tallies made
/// of it in one walk when the types are inferred, the default of
/// `from_shared` and `from_compressed` (see
/// [`set_tally_compressed`](Self::set_tally_compressed)).
#[derive(Debug)]
pub struct JsonInput {
    /// How samples are read; with inference from the compressed form, also
    /// the samples. Shared with other inputs only when made with
    /// [`from_shared`](Self::from_shared).
    compressed_json: Rc<CompressedJson>,
    top_levels: IndexMap<String, JsonTopLevel>,
    /// The running tallies; `None` to keep the samples in the compressed
    /// form.
    tallies: Option<RunningTallies>,
    /// Without running tallies: whether the types are inferred from
    /// tallies of the compressed form, made when they are inferred, rather
    /// than from its values one by one (see
    /// [`set_tally_compressed`](Self::set_tally_compressed)).
    tally_compressed: bool,
    /// Where the types were inferred from last.
    inferred_from: Option<JsonInference>,
}

/// Whether `QUICKTYPE_INFERENCE=compressed-json` asks every new
/// [`JsonInput`] to infer from the compressed form of the samples, as
/// quicktype does, instead of from running tallies; read once. Only for
/// testing that both give the same results (the CLI, the benchmarks and
/// the Rust API alike); not a CLI option.
fn compressed_json_inference_requested() -> bool {
    static REQUESTED: OnceLock<bool> = OnceLock::new();
    *REQUESTED.get_or_init(|| {
        std::env::var_os("QUICKTYPE_INFERENCE").is_some_and(|v| v == "compressed-json")
    })
}

impl JsonInput {
    /// `new JSONInput(compressedJSON)`: `compressed_json` configures how
    /// samples are read. Types are inferred from running tallies, unless
    /// `QUICKTYPE_INFERENCE=compressed-json` is set (see
    /// [`set_tally_inference`](Self::set_tally_inference)).
    pub fn new(compressed_json: CompressedJson) -> Self {
        JsonInput {
            compressed_json: Rc::new(compressed_json),
            top_levels: IndexMap::new(),
            tallies: (!compressed_json_inference_requested()).then(RunningTallies::new),
            tally_compressed: false,
            inferred_from: None,
        }
    }

    /// A JSON input over samples read already, into a compressed form
    /// that other inputs may share: the WebAssembly engine reads the
    /// samples of a JavaScript `JSONInput` as they are added and keeps them
    /// for every run that uses the input. `top_levels` are its
    /// `_topLevels`, the samples encoded as in TypeScript; they cannot be
    /// strings (whose index in TypeScript's string table this compressed
    /// form does not know). The input cannot take more samples while the
    /// compressed form is shared. It infers from tallies of the compressed
    /// form (see [`set_tally_compressed`](Self::set_tally_compressed)).
    pub fn from_shared(
        compressed_json: Rc<CompressedJson>,
        top_levels: Vec<CompressedTopLevel>,
    ) -> Result<Self> {
        Self::over_compressed(compressed_json, top_levels, false)
    }

    /// An input that infers from `compressed_json`, with `top_levels`
    /// whose samples are encoded as in TypeScript; samples that are
    /// strings only if `allow_strings` (see [`from_shared`](Self::from_shared)).
    fn over_compressed(
        compressed_json: Rc<CompressedJson>,
        top_levels: Vec<CompressedTopLevel>,
        allow_strings: bool,
    ) -> Result<Self> {
        let (objects, arrays) = compressed_json.counts();
        let mut input = JsonInput {
            compressed_json,
            top_levels: IndexMap::new(),
            tallies: None,
            tally_compressed: !compressed_json_inference_requested(),
            inferred_from: None,
        };
        for top_level in top_levels {
            let values = top_level
                .samples
                .iter()
                .map(
                    |&v| match input.compressed_json.decode_value(v, objects, arrays)? {
                        Value::InternedString(_)
                        | Value::StringFormat(_)
                        | Value::TransformedString(_)
                            if !allow_strings =>
                        {
                            panic("A shared JSON sample cannot be an interned string")
                        }
                        value => Ok(value),
                    },
                )
                .collect::<Result<Vec<Value>>>()?;
            input.add_samples(&top_level.name, values, top_level.description.as_deref());
        }
        Ok(input)
    }

    /// Whether types are inferred from running tallies (`true`, the
    /// default) or, as quicktype does, from the compressed form of every
    /// sample (`false`): the reference the tallies are tested against,
    /// which keeps every sample in memory and is needed for
    /// [`to_compressed`](Self::to_compressed). Both infer the same types.
    /// Only before any source is added.
    pub fn set_tally_inference(&mut self, tallies: bool) -> Result<()> {
        if !self.top_levels.is_empty() {
            return panic("The inference source must be chosen before sources are added");
        }
        if tallies != self.tallies.is_some() {
            self.tallies = tallies.then(RunningTallies::new);
        }
        Ok(())
    }

    /// Whether types are inferred from running tallies.
    pub fn tally_inference(&self) -> bool {
        self.tallies.is_some()
    }

    /// For an input that keeps its samples in compressed form (made with
    /// [`from_shared`](Self::from_shared) or
    /// [`from_compressed`](Self::from_compressed), or after
    /// [`set_tally_inference(false)`](Self::set_tally_inference)): whether
    /// the types are inferred from tallies of the compressed form, made in
    /// one walk over it when they are inferred (`true`, the default of
    /// `from_shared` and `from_compressed`), or from its values one by one,
    /// as quicktype does (`false`, the reference, and the default after
    /// `set_tally_inference(false)` and with
    /// `QUICKTYPE_INFERENCE=compressed-json`). Both infer the same types;
    /// should the values not be a tree as a reader makes them (tables from
    /// elsewhere), they are inferred one by one either way. No effect on an
    /// input that infers from running tallies; can be changed any time.
    pub fn set_tally_compressed(&mut self, tally: bool) {
        self.tally_compressed = tally;
    }

    /// Whether types are inferred from tallies of the compressed form (see
    /// [`set_tally_compressed`](Self::set_tally_compressed)).
    pub fn tally_compressed(&self) -> bool {
        self.tally_compressed
    }

    /// Where the types were inferred from the last time
    /// [`add_types_sync`](Self::add_types_sync) inferred them (also if
    /// inference failed then); `None` before. Inferring from tallies of
    /// the compressed form falls back to its values only for values no
    /// reader makes, which this tells apart (for tests).
    pub fn inferred_from(&self) -> Option<JsonInference> {
        self.inferred_from
    }

    /// A JSON input from the tables and top-levels a JavaScript
    /// `CompressedJSON` and `JSONInput` built: the JavaScript facade reads
    /// the samples (with `JSON.parse` and its error messages) and sends the
    /// result this way (research 05, §4.2). It infers from tallies of the
    /// compressed form (see [`set_tally_compressed`](Self::set_tally_compressed)).
    pub fn from_compressed(
        tables: &CompressedJsonTables,
        handle_refs: bool,
        date_time_recognizer: Box<dyn DateTimeRecognizer>,
        top_levels: Vec<CompressedTopLevel>,
    ) -> Result<Self> {
        let compressed_json =
            CompressedJson::from_tables(date_time_recognizer, handle_refs, tables)?;
        Self::over_compressed(Rc::new(compressed_json), top_levels, true)
    }

    /// The inverse of [`from_compressed`](Self::from_compressed): the
    /// compressed samples as tables and encoded top-levels.
    ///
    /// Only an input that infers from the compressed form has the samples
    /// in that form: an error for one that infers from running tallies
    /// (the default; see [`set_tally_inference`](Self::set_tally_inference)).
    ///
    /// ```
    /// use quicktype_core::input::inputs::{JsonSourceData, json_input_for_target_language};
    /// use quicktype_core::language::rust::language::RustTargetLanguage;
    /// use quicktype_core::renderer_options::RendererOptions;
    ///
    /// let source = || JsonSourceData {
    ///     name: "Person".to_owned(),
    ///     samples: vec![r#"{"name": "Ann"}"#.into()],
    ///     description: None,
    /// };
    /// let mut input = json_input_for_target_language(&RustTargetLanguage, false, &RendererOptions::new());
    /// input.set_tally_inference(true).unwrap();
    /// input.add_source_sync(source()).unwrap();
    /// assert!(input.to_compressed().is_err());
    ///
    /// let mut input = json_input_for_target_language(&RustTargetLanguage, false, &RendererOptions::new());
    /// input.set_tally_inference(false).unwrap();
    /// input.add_source_sync(source()).unwrap();
    /// let (_tables, top_levels) = input.to_compressed().unwrap();
    /// assert_eq!(top_levels[0].samples.len(), 1);
    /// ```
    pub fn to_compressed(&self) -> Result<(CompressedJsonTables, Vec<CompressedTopLevel>)> {
        if self.tallies.is_some() {
            return panic(
                "JsonInput::to_compressed needs the samples in compressed form, which an input \
                 inferring from running tallies does not keep: call set_tally_inference(false) \
                 before adding sources",
            );
        }
        let roots: Vec<Value> = self
            .top_levels
            .values()
            .flat_map(|t| t.samples.iter().copied())
            .collect();
        let (tables, encoded) = self.compressed_json.to_tables(&roots);
        let mut encoded = encoded.into_iter();
        let top_levels = self
            .top_levels
            .iter()
            .map(|(name, t)| CompressedTopLevel {
                name: name.clone(),
                description: t.description.clone(),
                samples: encoded.by_ref().take(t.samples.len()).collect(),
            })
            .collect();
        Ok((tables, top_levels))
    }

    /// How samples are read, and the compressed samples when inferring
    /// from the compressed form.
    pub fn compressed_json(&self) -> &CompressedJson {
        &self.compressed_json
    }

    /// `addSamples(name, values, description)`.
    fn add_samples(&mut self, name: &str, values: Vec<Value>, description: Option<&str>) {
        for value in values {
            let top_level = self.top_levels.entry(name.to_owned()).or_default();
            top_level.samples.push(value);
            if let Some(description) = description {
                top_level.description = Some(description.to_owned());
            }
        }
    }

    /// `addSource(source)`. Reading is synchronous; the future exists for
    /// [`Input`]'s sake.
    pub async fn add_source(&mut self, source: JsonSourceData) -> Result<()> {
        self.add_source_sync(source)
    }

    /// `addSourceSync(source)`.
    pub fn add_source_sync(&mut self, source: JsonSourceData) -> Result<()> {
        let JsonSourceData {
            name,
            samples,
            description,
        } = source;
        if samples.is_empty() {
            return message_error(
                ErrorKind::DriverNoSamplesForTopLevel,
                vec![("name", name.into())],
            );
        }
        let report = |e: ParseError| match e {
            ParseError::Read(e) => e,
            e => message_parse_error(&name, description.as_deref(), &e),
        };
        let Some(tallies) = &mut self.tallies else {
            let Some(compressed_json) = Rc::get_mut(&mut self.compressed_json) else {
                return panic("Samples cannot be added to a JSON input whose samples are shared");
            };
            let mut values = Vec::with_capacity(samples.len());
            for sample in samples {
                values.push(compressed_json.parse_sample(sample).map_err(report)?);
            }
            self.add_samples(&name, values, description.as_deref());
            return Ok(());
        };

        // As in TypeScript, a source is added whole or not at all: each
        // sample is read into a tree of its own (which a failure frees),
        // appended to the source's tree, and that to the top-level's only
        // once all samples have been read (a failed merge changes nothing
        // and frees what it was given).
        let mut source: Option<NodeId> = None;
        for sample in samples {
            let mut builder = TallyBuilder::new(tallies, &self.compressed_json);
            let read = match sample {
                JsonSample::String(text) => parse_string_into(&mut builder, &text),
                JsonSample::Stream(bytes) => parse_stream_into(&mut builder, &bytes),
                JsonSample::Reader(reader) => match reader.take() {
                    Some(mut stream) => parse_stream_reader_into(&mut builder, &mut *stream),
                    None => Err(ParseError::Read(already_read())),
                },
            };
            drop(builder);
            let added = read.map_err(report).and_then(|tree| match source {
                Some(source) => tallies.tallies.merge(source, tree),
                None => {
                    source = Some(tree);
                    Ok(())
                }
            });
            if let Err(e) = added {
                if let Some(source) = source {
                    tallies.tallies.free_tree(source);
                }
                return Err(e);
            }
        }
        let tree = defined(source)?;
        let existing = self.top_levels.get(&name).and_then(|t| t.tally);
        if let Some(existing) = existing {
            tallies.tallies.merge(existing, tree)?;
        }
        let top_level = self.top_levels.entry(name).or_default();
        top_level.tally = Some(existing.unwrap_or(tree));
        if let Some(description) = description {
            top_level.description = Some(description);
        }
        Ok(())
    }

    /// `addTypesSync(ctx, typeBuilder, inferMaps, inferEnums,
    /// fixedTopLevels)`: infers each top-level's type from its samples, in
    /// the order the top-levels were first added.
    pub fn add_types_sync(
        &mut self,
        _ctx: &RunContext,
        type_builder: &mut TypeBuilder<'_>,
        infer_maps: bool,
        infer_enums: bool,
        fixed_top_levels: bool,
    ) -> Result<()> {
        enum Inference<'a> {
            Tallies(TallyInference<'a>),
            CompressedJson(TypeInference<'a>),
        }
        // Without running tallies, those of the compressed form: each
        // top-level's tree, in order. (An error making them is this way's.)
        let compressed_tallies = if self.tallies.is_none() && self.tally_compressed {
            self.inferred_from = Some(JsonInference::CompressedTallies);
            tally_compressed(
                &self.compressed_json,
                self.top_levels.values().map(|t| t.samples.as_slice()),
            )?
        } else {
            None
        };
        // The tallies, and the text of their keys and cases.
        let (tallies, compressed_roots, inferred_from) = match (&self.tallies, &compressed_tallies)
        {
            (Some(running), _) => (
                Some((&running.tallies, &running.strings)),
                None,
                JsonInference::RunningTallies,
            ),
            (None, Some((tallies, roots))) => (
                Some((tallies, self.compressed_json.strings())),
                Some(roots),
                JsonInference::CompressedTallies,
            ),
            (None, None) => (None, None, JsonInference::CompressedValues),
        };
        self.inferred_from = Some(inferred_from);
        let inference = match tallies {
            Some((tallies, strings)) => Inference::Tallies(TallyInference::new(
                tallies,
                strings,
                self.compressed_json.handle_refs(),
                infer_maps,
                infer_enums,
            )),
            None => Inference::CompressedJson(TypeInference::new(
                &self.compressed_json,
                infer_maps,
                infer_enums,
            )),
        };
        for (i, (name, top_level)) in self.top_levels.iter().enumerate() {
            let attributes = make_names_type_attributes(name, false);
            let tref = match &inference {
                Inference::Tallies(inference) => inference.infer_top_level_type(
                    type_builder,
                    attributes,
                    match compressed_roots {
                        Some(roots) => *defined(roots.get(i))?,
                        None => defined(top_level.tally)?,
                    },
                    fixed_top_levels,
                )?,
                Inference::CompressedJson(inference) => inference.infer_top_level_type(
                    type_builder,
                    attributes,
                    &top_level.samples,
                    fixed_top_levels,
                )?,
            };
            type_builder.add_top_level(name, tref)?;
            if let Some(description) = &top_level.description {
                let attributes = DescriptionTypeAttributeKind
                    .make_attributes([description.clone()].into_iter().collect());
                type_builder.add_attributes(tref, &attributes)?;
            }
        }
        Ok(())
    }
}

impl Input for JsonInput {
    type Source = JsonSourceData;

    fn kind(&self) -> &str {
        "json"
    }

    fn need_ir(&self) -> bool {
        true
    }

    fn need_schema_processing(&self) -> bool {
        false
    }

    fn add_source(&mut self, source: Self::Source) -> impl Future<Output = Result<()>> {
        JsonInput::add_source(self, source)
    }

    fn add_source_sync(&mut self, source: Self::Source) -> Result<()> {
        JsonInput::add_source_sync(self, source)
    }

    fn add_types_sync(
        &mut self,
        ctx: &RunContext,
        type_builder: &mut TypeBuilder<'_>,
        infer_maps: bool,
        infer_enums: bool,
        fixed_top_levels: bool,
    ) -> Result<()> {
        JsonInput::add_types_sync(
            self,
            ctx,
            type_builder,
            infer_maps,
            infer_enums,
            fixed_top_levels,
        )
    }

    fn single_string_schema_source(&self) -> Option<String> {
        None
    }
}

/// The error for a [`JsonSample::Reader`] read a second time.
pub(crate) fn already_read() -> QuickTypeError {
    QuickTypeError::internal(
        "This JsonSample::Reader's stream was already read; a SampleReader can be read once",
    )
}

/// `messageParseError(name, description, e)`.
fn message_parse_error(name: &str, description: Option<&str>, e: &ParseError) -> QuickTypeError {
    QuickTypeError::new(
        ErrorKind::MiscJSONParseError,
        vec![
            (
                "description",
                MessageValue::from(description.unwrap_or("input")),
            ),
            ("address", name.into()),
            ("message", e.message().into()),
        ],
    )
}

/// `jsonInputForTargetLanguage(targetLanguage, languages, handleJSONRefs,
/// rendererOptions)` for a language object: a JSON input with the
/// language's date/time recognizer and its integer range for
/// `renderer_options`. Samples given as [`JsonSample::String`] are read with
/// `JSON.parse` semantics, as in TypeScript.
pub fn json_input_for_target_language(
    target_language: &dyn TargetLanguage,
    handle_json_refs: bool,
    renderer_options: &RendererOptions,
) -> JsonInput {
    JsonInput::new(CompressedJson::for_target_language(
        target_language,
        handle_json_refs,
        renderer_options,
    ))
}

/// `jsonInputForTargetLanguage` for a language name, looked up in
/// `languages` (the built-in languages if `None`); an internal error if
/// there is no such language, as in TypeScript.
pub fn json_input_for_target_language_named(
    name: &str,
    languages: Option<&[&'static dyn TargetLanguage]>,
    handle_json_refs: bool,
    renderer_options: &RendererOptions,
) -> Result<JsonInput> {
    let languages = languages.unwrap_or_else(|| default_target_languages());
    let target_language = defined(language_named(name, languages))?;
    Ok(json_input_for_target_language(
        target_language,
        handle_json_refs,
        renderer_options,
    ))
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::date_time::DefaultDateTimeRecognizer;

    fn tallied_input() -> JsonInput {
        let mut input = JsonInput::new(CompressedJson::with_int64_range(
            Box::new(DefaultDateTimeRecognizer),
            false,
        ));
        input.set_tally_inference(true).unwrap();
        input
    }

    fn source(name: &str, samples: &[&str]) -> JsonSourceData {
        JsonSourceData {
            name: name.to_owned(),
            samples: samples
                .iter()
                .map(|s| JsonSample::Stream(s.as_bytes().to_vec()))
                .collect(),
            description: None,
        }
    }

    /// Each top-level's tally, and the number of nodes in use.
    fn state(input: &JsonInput) -> (Vec<(String, String)>, usize) {
        let tallies = input.tallies.as_ref().unwrap();
        let top_levels = input
            .top_levels
            .iter()
            .map(|(name, t)| (name.clone(), tallies.dump(t.tally.unwrap())))
            .collect();
        (top_levels, tallies.tallies.live_nodes())
    }

    /// The type graph `input` infers, or the error, for TypeScript.
    fn graph(input: &mut JsonInput) -> String {
        use crate::inference::InferenceFlags;
        use crate::language::all::language_named;
        let lang = language_named("typescript", default_target_languages()).unwrap();
        let ctx = RunContext::for_target_language(lang, &InferenceFlags::default());
        let mut builder =
            TypeBuilder::new(ctx.string_type_mapping.clone(), false, false, false, false).unwrap();
        match input
            .add_types_sync(&ctx, &mut builder, true, true, false)
            .and_then(|()| builder.finish())
        {
            Ok(graph) => format!("{graph:?}"),
            Err(e) => format!("error {e:?}"),
        }
    }

    /// An input over a compressed form infers from tallies of it, and the
    /// same as from its values one by one; also over tables no reader
    /// makes, where it infers from the values.
    #[test]
    fn inputs_over_a_compressed_form_tally_it() {
        let mut reference = JsonInput::new(CompressedJson::with_int64_range(
            Box::new(DefaultDateTimeRecognizer),
            true,
        ));
        reference.set_tally_inference(false).unwrap();
        assert!(!reference.tally_compressed());
        reference.add_source_sync(source("T", &[A, B])).unwrap();
        reference.add_source_sync(source("U", &[C])).unwrap();
        let (good, top_levels) = reference.to_compressed().unwrap();
        // `{"a": o, "b": o}` with `o = [1]`: an array reached twice.
        let shared = CompressedJsonTables {
            strings: vec!["a".to_owned(), "b".to_owned()],
            objects: vec![6, 9, 6 | 1 << 4, 9],
            object_offsets: vec![0],
            arrays: vec![4],
            array_offsets: vec![0],
        };
        let shared_top_levels = vec![CompressedTopLevel {
            name: "S".to_owned(),
            description: None,
            samples: vec![8],
        }];
        for (tables, top_levels) in [(good, top_levels), (shared, shared_top_levels)] {
            let input = || {
                JsonInput::from_compressed(
                    &tables,
                    true,
                    Box::new(DefaultDateTimeRecognizer),
                    top_levels.clone(),
                )
                .unwrap()
            };
            let mut tallied = input();
            assert_eq!(
                tallied.tally_compressed(),
                !compressed_json_inference_requested()
            );
            tallied.set_tally_compressed(true);
            let mut by_value = input();
            by_value.set_tally_compressed(false);
            let expected = graph(&mut by_value);
            assert_eq!(
                by_value.inferred_from(),
                Some(JsonInference::CompressedValues)
            );
            assert!(!expected.starts_with("error"), "{expected}");
            assert_eq!(graph(&mut tallied), expected);
            // The reader's form is tallied, the shared array declined.
            let declined = top_levels[0].name == "S";
            assert_eq!(
                tallied.inferred_from(),
                Some(if declined {
                    JsonInference::CompressedValues
                } else {
                    JsonInference::CompressedTallies
                })
            );
        }
        assert_eq!(reference.inferred_from(), None);
        reference.set_tally_compressed(true);
        let tallied = graph(&mut reference);
        assert_eq!(
            reference.inferred_from(),
            Some(JsonInference::CompressedTallies)
        );
        reference.set_tally_compressed(false);
        assert_eq!(tallied, graph(&mut reference));
        assert_eq!(
            reference.inferred_from(),
            Some(JsonInference::CompressedValues)
        );
        // Running tallies.
        let mut running = tallied_input();
        running.add_source_sync(source("T", &[A, B])).unwrap();
        graph(&mut running);
        assert_eq!(running.inferred_from(), Some(JsonInference::RunningTallies));
    }

    /// An error tallying a compressed form is raised, not taken for a form
    /// the walk declines (which would infer from the values instead): here
    /// a value that is not there, which the values' inference raises too.
    #[test]
    fn errors_tallying_a_compressed_form_are_raised() {
        let mut input = JsonInput::new(CompressedJson::with_int64_range(
            Box::new(DefaultDateTimeRecognizer),
            false,
        ));
        input.set_tally_inference(false).unwrap();
        input.add_source_sync(source("T", &[A, B])).unwrap();
        let (objects, arrays) = input.compressed_json.counts();
        let strings = input.compressed_json.table_counts().strings as u32;
        for missing in [
            Value::Object(objects as u32),
            Value::Array(arrays as u32),
            Value::InternedString(strings),
            Value::TransformedString(strings),
        ] {
            let samples = &mut input.top_levels[0].samples;
            samples.truncate(2);
            samples.push(missing);
            input.set_tally_compressed(false);
            let expected = graph(&mut input);
            assert!(
                expected.starts_with("error") && expected.contains("undefined"),
                "{expected}"
            );
            input.set_tally_compressed(true);
            assert_eq!(graph(&mut input), expected, "{missing:?}");
            // The walk's own error, not the values' after a decline.
            assert_eq!(
                input.inferred_from(),
                Some(JsonInference::CompressedTallies),
                "{missing:?}"
            );
        }
    }

    const A: &str = r#"{"a":[1,{"b":"x"}],"c":{"d":"2020-01-01"},"__proto__":{"p":1}}"#;
    const B: &str = r#"{"a":[2.5,{"b":"y","e":null}],"c":{"d":"z","f":[true]},"__proto__":[1]}"#;
    const C: &str = r#"[{"a":{"c":{"d":"http://h/x.png"}}},{"a":[[]]}]"#;

    /// A source is added whole or not at all, wherever adding it fails: a
    /// sample that does not parse, merging a sample into the source's
    /// other samples, or merging the source into its top-level.
    #[test]
    fn a_source_is_added_whole_or_not_at_all() {
        let mut expected = tallied_input();
        expected.add_source_sync(source("T", &[A])).unwrap();
        expected.add_source_sync(source("U", &[C])).unwrap();
        let unchanged = state(&expected);
        expected.add_source_sync(source("T", &[B, C])).unwrap();
        expected.add_source_sync(source("T", &[C])).unwrap();
        let expected = state(&expected);

        let failures: [(&[&str], Option<usize>); 6] = [
            // A sample that does not parse, after one that does.
            (&[B, r#"{"a":[1,"#], None),
            (&[B, "[1 2]"], None),
            // Merging the second sample into the first.
            (&[B, A], Some(0)),
            (&[B, A], Some(4)),
            // Merging the source into the top-level.
            (&[B], Some(0)),
            (&[B], Some(3)),
        ];
        for (samples, fail_merge_at) in failures {
            let mut input = tallied_input();
            input.add_source_sync(source("T", &[A])).unwrap();
            input.add_source_sync(source("U", &[C])).unwrap();
            let tallies = input.tallies.as_ref().unwrap();
            tallies.tallies.fail_merge_at.set(fail_merge_at);
            assert!(
                input.add_source_sync(source("T", samples)).is_err(),
                "{samples:?} {fail_merge_at:?}"
            );
            assert_eq!(state(&input), unchanged, "{samples:?} {fail_merge_at:?}");
            // The input takes the next sources as if nothing had happened.
            input.add_source_sync(source("T", &[B, C])).unwrap();
            input.add_source_sync(source("T", &[C])).unwrap();
            assert_eq!(state(&input), expected, "{samples:?} {fail_merge_at:?}");
        }
    }
}
