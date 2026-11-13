//! Ports of quicktype's Vitest tests of JSON input:
//!
//! - `test/unit/integer-range-inference.test.ts` (the parts beyond
//!   `integerStringInRange`, which `support/integer_range.rs` ports). The
//!   TypeScript checks the rendered code (`int64` vs `float64`, ...); there
//!   is no renderer yet, so these check the inferred `integer` or `double`
//!   in the type graph, which is what decides the rendered type.
//! - `test/unit/empty-json-samples.test.ts`; its last test renders code, so
//!   it checks the top-level in the graph instead.
//! - `test/unit/parse-json.test.ts`: `parseJSON`'s YAML and BOM handling
//!   belongs to the JSON Schema input's port; its strict-JSON case is in
//!   `quicktype_js_compat::json::parse`'s tests.
//!
//! `url-input.test.ts` needs the I/O layer and the CLI (Phase 3).

use std::future::Future;
use std::pin::pin;
use std::task::{Context, Poll, Waker};

use indexmap::IndexMap;
use quicktype_core::date_time::DefaultDateTimeRecognizer;
use quicktype_core::inference::InferenceFlags;
use quicktype_core::input::compressed_json::{CompressedJson, CompressedJsonFromString};
use quicktype_core::input::compressed_json_from_stream::CompressedJsonFromStream;
use quicktype_core::input::inputs::{
    InputData, JsonInput, JsonSourceData, json_input_for_target_language_named,
};
use quicktype_core::language::all::{default_target_languages, language_named};
use quicktype_core::messages::Result;
use quicktype_core::renderer_options::RendererOptions;
use quicktype_core::run::RunContext;
use quicktype_core::support::integer_range::{
    INT16_RANGE, INT64_RANGE, IntegerRange, JS_SAFE_INTEGER_RANGE,
};
use quicktype_core::target_language::TargetLanguage;
use quicktype_core::ty::transformed_string_type::TypeKind;
use quicktype_core::ty::type_builder::TypeBuilder;
use quicktype_core::ty::type_graph::TypeGraph;

fn block_on<F: Future>(future: F) -> F::Output {
    let mut cx = Context::from_waker(Waker::noop());
    let mut future = pin!(future);
    loop {
        if let Poll::Ready(output) = future.as_mut().poll(&mut cx) {
            return output;
        }
    }
}

fn language(name: &str) -> &'static dyn TargetLanguage {
    language_named(name, default_target_languages()).expect("known language")
}

fn graph_of(language: &dyn TargetLanguage, input_data: &mut InputData) -> Result<TypeGraph> {
    let ctx = RunContext::for_target_language(language, &InferenceFlags::default());
    let mut builder =
        TypeBuilder::new(ctx.string_type_mapping.clone(), false, false, false, false)?;
    block_on(input_data.add_types(&ctx, &mut builder, true, true, false))?;
    builder.finish()
}

/// The kind of each property of the `Edge` top-level class.
fn property_kinds(graph: &TypeGraph) -> IndexMap<String, TypeKind> {
    let top = graph.top_levels()["Edge"];
    graph
        .type_at(top)
        .expect("top-level")
        .properties()
        .expect("a class")
        .iter()
        .map(|(name, p)| (name.clone(), graph.kind(p.type_ref).expect("kind")))
        .collect()
}

/// `streamedLinesForJSON`: the CLI's streaming reader with `range`.
fn streamed_kinds(
    lang: &str,
    json: &str,
    range: Option<IntegerRange>,
) -> IndexMap<String, TypeKind> {
    let cjson = CompressedJson::new(Box::new(DefaultDateTimeRecognizer), false, range);
    let mut input = JsonInput::new(CompressedJsonFromStream::new(cjson));
    block_on(input.add_source(JsonSourceData {
        name: "Edge".to_owned(),
        samples: vec![json.as_bytes().to_vec()],
        description: None,
    }))
    .expect("valid JSON");
    let mut input_data = InputData::new();
    input_data.add_input(input);
    property_kinds(&graph_of(language(lang), &mut input_data).expect("graph"))
}

/// `coreLinesForJSON`: `jsonInputForTargetLanguage` (`JSON.parse`).
fn core_kinds(
    lang: &str,
    json: &str,
    renderer_options: &RendererOptions,
) -> IndexMap<String, TypeKind> {
    let mut input = json_input_for_target_language_named(lang, None, false, renderer_options)
        .expect("known language");
    block_on(input.add_source(JsonSourceData {
        name: "Edge".to_owned(),
        samples: vec![json.to_owned()],
        description: None,
    }))
    .expect("valid JSON");
    let mut input_data = InputData::new();
    input_data.add_input(input);
    property_kinds(&graph_of(language(lang), &mut input_data).expect("graph"))
}

fn range_for_language(lang: &str) -> Option<IntegerRange> {
    language(lang).get_supported_integer_range(&RendererOptions::new())
}

// describe("language-declared integer ranges")

#[test]
fn crystal_renders_integers_as_int64_so_its_range_is_int64() {
    assert_eq!(range_for_language("crystal"), Some(INT64_RANGE.clone()));
}

#[test]
fn elms_int_is_a_javascript_number_at_runtime() {
    assert_eq!(
        range_for_language("elm"),
        Some(JS_SAFE_INTEGER_RANGE.clone())
    );
}

#[test]
fn cjsons_range_follows_the_integer_size_renderer_option() {
    let cjson = language("cjson");
    assert_eq!(
        cjson.get_supported_integer_range(&RendererOptions::new()),
        Some(INT64_RANGE.clone())
    );
    let mut options = RendererOptions::new();
    options.set("integer-size", "int16_t");
    assert_eq!(
        cjson.get_supported_integer_range(&options),
        Some(INT16_RANGE.clone())
    );
}

// describe("streaming inference of numbers at the integer-range boundary")

#[test]
fn go_out_of_range_whole_numbers_become_float64_int64_max_stays_int64() {
    let kinds = streamed_kinds(
        "go",
        r#"{"big": 9223372036854775807, "bigger": 123456789012345678901234567890}"#,
        range_for_language("go"),
    );
    assert_eq!(kinds["big"], TypeKind::Integer);
    assert_eq!(kinds["bigger"], TypeKind::Double);
}

#[test]
fn go_int64_min_stays_int64_one_below_becomes_float64() {
    let kinds = streamed_kinds(
        "go",
        r#"{"min": -9223372036854775808, "smaller": -9223372036854775809}"#,
        range_for_language("go"),
    );
    assert_eq!(kinds["min"], TypeKind::Integer);
    assert_eq!(kinds["smaller"], TypeKind::Double);
}

#[test]
fn crystal_whole_numbers_inside_int64_remain_integers() {
    let kinds = streamed_kinds(
        "crystal",
        r#"{"fits": 2147483647, "overflows": 2147483648}"#,
        range_for_language("crystal"),
    );
    assert_eq!(kinds["fits"], TypeKind::Integer);
    assert_eq!(kinds["overflows"], TypeKind::Integer);
}

#[test]
fn python_arbitrary_precision_integers_never_overflow_to_float() {
    let kinds = streamed_kinds(
        "python",
        r#"{"huge": 123456789012345678901234567890}"#,
        range_for_language("python"),
    );
    assert_eq!(kinds["huge"], TypeKind::Integer);
}

#[test]
fn the_range_is_what_decides_not_the_languages_renderer() {
    let literal = r#"{"n": 9007199254740993}"#;
    let as_int64 = streamed_kinds("python", literal, Some(INT64_RANGE.clone()));
    assert_eq!(as_int64["n"], TypeKind::Integer);
    let as_js_safe = streamed_kinds("python", literal, Some(JS_SAFE_INTEGER_RANGE.clone()));
    assert_eq!(as_js_safe["n"], TypeKind::Double);
}

// describe("core (JSON.parse-based) inference at the integer-range boundary")

#[test]
fn go_whole_numbers_between_2_53_and_int64_max_stay_int64() {
    let kinds = core_kinds(
        "go",
        r#"{"big": 9223372036854774784, "bigger": 123456789012345678901234567890}"#,
        &RendererOptions::new(),
    );
    assert_eq!(kinds["big"], TypeKind::Integer);
    assert_eq!(kinds["bigger"], TypeKind::Double);
}

#[test]
fn python_huge_whole_numbers_stay_int() {
    let kinds = core_kinds(
        "python",
        r#"{"huge": 123456789012345678901234567890}"#,
        &RendererOptions::new(),
    );
    assert_eq!(kinds["huge"], TypeKind::Integer);
}

#[test]
fn cjson_the_integer_size_option_narrows_the_inferred_range() {
    let json = r#"{"n": 32768}"#;
    let as_default = core_kinds("cjson", json, &RendererOptions::new());
    assert_eq!(as_default["n"], TypeKind::Integer);
    let mut options = RendererOptions::new();
    options.set("integer-size", "int16_t");
    let as_int16 = core_kinds("cjson", json, &options);
    assert_eq!(as_int16["n"], TypeKind::Double);
}

// describe("JSON input with empty samples") — empty-json-samples.test.ts

fn empty_source() -> JsonSourceData<String> {
    JsonSourceData {
        name: "X".to_owned(),
        samples: Vec::new(),
        description: None,
    }
}

fn typescript_input() -> JsonInput<CompressedJsonFromString> {
    json_input_for_target_language_named("typescript", None, false, &RendererOptions::new())
        .expect("typescript")
}

#[test]
fn add_source_throws_a_clear_error() {
    let error = block_on(typescript_input().add_source(empty_source())).unwrap_err();
    assert_eq!(
        error.user_message(),
        "No JSON samples given for top-level X"
    );
}

#[test]
fn add_source_sync_throws_a_clear_error() {
    let error = typescript_input()
        .add_source_sync(empty_source())
        .unwrap_err();
    assert_eq!(
        error.user_message(),
        "No JSON samples given for top-level X"
    );
}

#[test]
fn non_empty_samples_still_generate_code() {
    let mut input = typescript_input();
    block_on(input.add_source(JsonSourceData {
        name: "Person".to_owned(),
        samples: vec![r#"{"name":"Alice","age":30}"#.to_owned()],
        description: None,
    }))
    .expect("valid sample");
    let mut input_data = InputData::new();
    input_data.add_input(input);
    let graph = graph_of(language("typescript"), &mut input_data).expect("graph");
    let person = graph.top_levels()["Person"];
    assert_eq!(graph.kind(person).expect("kind"), TypeKind::Class);
}

#[test]
fn input_data_keeps_one_input_per_kind() {
    let mut input_data = InputData::new();
    let make = || typescript_input();
    for name in ["A", "B", "A"] {
        input_data
            .add_source_sync(
                "json",
                JsonSourceData {
                    name: name.to_owned(),
                    samples: vec!["{}".to_owned()],
                    description: None,
                },
                make,
            )
            .expect("added");
    }
    assert!(input_data.need_ir());
    assert!(!input_data.need_schema_processing());
    assert_eq!(input_data.single_string_schema_source().expect("ok"), None);
    let graph = graph_of(language("typescript"), &mut input_data).expect("graph");
    let names: Vec<&String> = graph.top_levels().keys().collect();
    assert_eq!(names, ["A", "B"]);
    // A different input type under the same kind is an internal error.
    let error = input_data
        .add_source_sync(
            "json",
            JsonSourceData {
                name: "C".to_owned(),
                samples: vec![b"{}".to_vec()],
                description: None,
            },
            || {
                JsonInput::new(CompressedJsonFromStream::new(CompressedJson::new(
                    Box::new(DefaultDateTimeRecognizer),
                    false,
                    None,
                )))
            },
        )
        .unwrap_err();
    assert_eq!(
        error.user_message(),
        "Internal error: The input of kind json doesn't take this kind of source"
    );
}
