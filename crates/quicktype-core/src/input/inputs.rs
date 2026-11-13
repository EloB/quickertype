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

use indexmap::{IndexMap, IndexSet};

use super::compressed_json::{CompressedJson, CompressedJsonTables, JsonSample, ParseError, Value};
use super::inference::TypeInference;
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
    samples: Vec<Value>,
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
#[derive(Debug)]
pub struct JsonInput {
    compressed_json: CompressedJson,
    top_levels: IndexMap<String, JsonTopLevel>,
}

impl JsonInput {
    /// `new JSONInput(compressedJSON)`.
    pub fn new(compressed_json: CompressedJson) -> Self {
        JsonInput {
            compressed_json,
            top_levels: IndexMap::new(),
        }
    }

    /// A JSON input from the tables and top-levels a JavaScript
    /// `CompressedJSON` and `JSONInput` built: the JavaScript facade reads
    /// the samples (with `JSON.parse` and its error messages) and sends the
    /// result this way (research 05, §4.2).
    pub fn from_compressed(
        tables: &CompressedJsonTables,
        handle_refs: bool,
        date_time_recognizer: Box<dyn DateTimeRecognizer>,
        top_levels: Vec<CompressedTopLevel>,
    ) -> Result<Self> {
        let compressed_json =
            CompressedJson::from_tables(date_time_recognizer, handle_refs, tables)?;
        let (objects, arrays) = compressed_json.counts();
        let mut input = JsonInput::new(compressed_json);
        for top_level in top_levels {
            let values = top_level
                .samples
                .iter()
                .map(|&v| input.compressed_json.decode_value(v, objects, arrays))
                .collect::<Result<Vec<Value>>>()?;
            input.add_samples(&top_level.name, values, top_level.description.as_deref());
        }
        Ok(input)
    }

    /// The inverse of [`from_compressed`](Self::from_compressed): the
    /// compressed samples as tables and encoded top-levels.
    pub fn to_compressed(&self) -> (CompressedJsonTables, Vec<CompressedTopLevel>) {
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
        (tables, top_levels)
    }

    /// The compressed samples.
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
        let mut values = Vec::with_capacity(samples.len());
        for sample in samples {
            match self.compressed_json.parse_sample(sample) {
                Ok(value) => values.push(value),
                Err(ParseError::Read(e)) => return Err(e),
                Err(e) => return Err(message_parse_error(&name, description.as_deref(), &e)),
            }
        }
        self.add_samples(&name, values, description.as_deref());
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
        let inference = TypeInference::new(&self.compressed_json, infer_maps, infer_enums);
        for (name, top_level) in &self.top_levels {
            let tref = inference.infer_top_level_type(
                type_builder,
                make_names_type_attributes(name, false),
                &top_level.samples,
                fixed_top_levels,
            )?;
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
