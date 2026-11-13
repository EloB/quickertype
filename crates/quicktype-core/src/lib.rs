//! Port of `packages/quicktype-core/src/index.ts`.
//!
//! quicktype infers types from JSON samples, JSON Schema, GraphQL queries
//! and Postman collections, and generates code for them in about 25 target
//! languages. This crate is the engine: it reproduces the TypeScript
//! `quicktype-core` byte for byte.
//!
//! # The public API
//!
//! The items re-exported at the crate root are the API. They mirror the
//! exports of TypeScript's `index.ts`, with Rust names:
//!
//! - **Running:** [`quicktype`], [`quicktype_multi_file`] and
//!   [`quicktype_multi_file_sync`] take [`Options`] and return
//!   [`SerializedRenderResult`]s (the lines of each generated file and
//!   their [`Annotation`]s); [`combine_render_results`] squashes several
//!   files into one.
//! - **Inputs:** an [`InputData`] holds one [`Input`] per source language.
//!   [`JsonInput`] reads JSON samples ([`JsonSourceData`], each sample a
//!   [`JsonSample`] read with `JSON.parse` semantics as the JavaScript API
//!   does, or with stream-json semantics as the CLI does);
//!   [`json_input_for_target_language`] makes one that suits a language.
//!   [`JsonSchemaInput`] reads JSON Schema ([`JsonSchemaSourceData`]),
//!   fetching documents through a [`JsonSchemaStore`] such as
//!   [`FetchingJsonSchemaStore`]. [`sources_from_postman_collection`] turns
//!   a Postman collection into JSON sources.
//! - **I/O:** files, URLs and standard input are read through the [`Io`]
//!   trait, with Node's semantics and error texts
//!   ([`read_from_file_or_url`], [`readable_from_file_or_url`]); [`StdIo`]
//!   implements it on `std` (cargo feature `fs`, on by default; `http` adds
//!   URLs). Inputs that fetch are asynchronous; [`block_on`] runs them
//!   natively.
//! - **Languages and their options:** [`TargetLanguage`],
//!   [`default_target_languages`], [`language_named`],
//!   [`get_target_language`], and the untyped [`RendererOptions`] the
//!   renderers read (with the [`OptionDefinition`]s a front end needs to
//!   parse them).
//! - **Inference flags:** [`InferenceFlags`] and their descriptions,
//!   [`INFERENCE_FLAGS`].
//! - **Errors:** every failure is a [`QuickTypeError`], whose
//!   [`user_message`](QuickTypeError::user_message) is the message the
//!   TypeScript implementation reports: one of quicktype's messages
//!   ([`ErrorKind`]) or a JavaScript exception that escapes it
//!   ([`JsException`]). Nothing panics on user input.
//! - **Diagnostics:** `--debug` output is written with [`console_log`];
//!   [`set_console_sink`] redirects it.
//!
//! ```
//! use quicktype_core::{
//!     InputData, JsonSourceData, Options, get_target_language, json_input_for_target_language,
//!     quicktype_multi_file_sync,
//! };
//!
//! let lang = get_target_language("rust")?;
//! let mut input = json_input_for_target_language(lang, false, &Default::default());
//! input.add_source_sync(JsonSourceData {
//!     name: "Coordinate".to_owned(),
//!     samples: vec![r#"{"lat": 51.5, "lng": -0.12}"#.into()],
//!     description: None,
//! })?;
//! let mut input_data = InputData::new();
//! input_data.add_input(input);
//!
//! let files = quicktype_multi_file_sync(Options {
//!     output_filename: "coordinate.rs".to_owned(),
//!     ..Options::new(lang, input_data)
//! })?;
//! assert!(files["coordinate.rs"].lines.join("\n").contains("pub lat: f64,"));
//! # Ok::<(), quicktype_core::QuickTypeError>(())
//! ```
//!
//! # Modules
//!
//! The modules mirror `packages/quicktype-core/src` file for file
//! (snake_case, `Type/` as `ty/`), so each has one obvious TypeScript
//! counterpart. They are public for the renderers, the WebAssembly bindings
//! and tests; front ends use the root re-exports.

pub mod annotation;
pub mod attributes;
pub mod convenience_renderer;
pub mod cycle_breaker;
pub mod date_time;
pub mod declaration_ir;
pub mod gather_names;
pub mod graph;
pub mod graph_rewriting;
pub mod inference;
pub mod input;
pub mod language;
pub mod make_transformations;
pub mod markov_chain;
pub mod messages;
pub mod naming;
pub mod renderer;
pub mod renderer_options;
pub mod rewrites;
pub mod run;
pub mod source;
pub mod support;
pub mod target_language;
pub mod transformers;
pub mod ty;
pub mod types;
pub mod unify_classes;
pub mod union_builder;

// ---- Running (`Run.ts`) -------------------------------------------------

pub use crate::annotation::AnnotationData;
pub use crate::run::{
    Clock, DebugOptions, Options, QuicktypeTiming, RunContext, Timer, TimingCallback,
    combine_render_results, get_target_language, quicktype, quicktype_multi_file,
    quicktype_multi_file_sync,
};
pub use crate::source::{Annotation, Location, SerializedRenderResult, Span};
pub use crate::target_language::MultiFileRenderResult;

// ---- Inference flags (`Inference.ts`) -----------------------------------

pub use crate::inference::{INFERENCE_FLAGS, InferenceFlag, InferenceFlagName, InferenceFlags};

// ---- Inputs (`input/`) ---------------------------------------------------

pub use crate::input::compressed_json::{CompressedJsonTables, JsonSample};
pub use crate::input::fetching_json_schema_store::FetchingJsonSchemaStore;
pub use crate::input::inputs::{
    CompressedTopLevel, Input, InputData, JsonInput, JsonSourceData, LocalBoxFuture,
    json_input_for_target_language, json_input_for_target_language_named,
};
pub use crate::input::json_schema_input::{
    JsonSchemaAttributeProducer, JsonSchemaAttributes, JsonSchemaInput, JsonSchemaSourceData,
    JsonSchemaType, Ref,
};
pub use crate::input::json_schema_store::{JsonSchema, JsonSchemaStore, SchemaCache};
pub use crate::input::postman_collection::{PostmanSources, sources_from_postman_collection};

// ---- I/O (`input/io/`) ---------------------------------------------------

pub use crate::input::io::block_on;
#[cfg(feature = "fs")]
pub use crate::input::io::node_io::StdIo;
pub use crate::input::io::node_io::{
    HttpResponse, Io, IoError, Readable, is_url, read_from_file_or_url, readable_from_file_or_url,
};

// ---- Languages and renderer options --------------------------------------

pub use crate::language::all::{
    default_target_languages, is_language_display_name, is_language_name, language_named,
};
pub use crate::renderer_options::{
    CliOptionDefinitions, OptionDefinition, OptionKind, OptionType, OptionValue, RendererOptions,
};
pub use crate::target_language::{LanguageConfig, TargetLanguage};

// ---- Errors (`Messages.ts`) ----------------------------------------------

pub use crate::messages::{
    ErrorKind, JsErrorName, JsException, MessageValue, QuickTypeError, Result,
};

// ---- Support -------------------------------------------------------------

pub use crate::markov_chain::{TrainingMarkovChain, train as train_markov_chain};
pub use crate::support::comments::{Comment, CommentOptions};
pub use crate::support::parse_json::parse_json;
pub use crate::support::support::{ConsoleSink, capture_console, console_log, set_console_sink};
