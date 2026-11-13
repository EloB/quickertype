//! Ports of quicktype's Vitest tests of JSON input:
//!
//! - `test/unit/integer-range-inference.test.ts` (the parts beyond
//!   `integerStringInRange`, which `support/integer_range.rs` ports).
//! - `test/unit/empty-json-samples.test.ts`.
//!
//! Where the TypeScript renders code and searches it (`int64` vs `float64`,
//! the top-level's name), these check the type graph the input builds
//! instead (an `integer` or `double` property, a top-level class), which is
//! what decides the rendered code; so they test the input on its own.
//!
//! `test/unit/parse-json.test.ts` is ported next to `parseJSON`, in
//! `support/parse_json.rs` (its strict-JSON case also in
//! `quicktype_js_compat::json::parse`'s tests); `url-input.test.ts` is in
//! `json_schema_vitest.rs` and, through the CLI, in quicktype-cli's
//! `tests/url_input.rs`.

use std::future::Future;
use std::pin::pin;
use std::task::{Context, Poll, Waker};

use indexmap::IndexMap;
use quicktype_core::date_time::DefaultDateTimeRecognizer;
use quicktype_core::inference::InferenceFlags;
use quicktype_core::input::compressed_json::{CompressedJson, JsonSample};
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
    let mut input = JsonInput::new(cjson);
    block_on(input.add_source(JsonSourceData {
        name: "Edge".to_owned(),
        samples: vec![JsonSample::Stream(json.as_bytes().to_vec())],
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
        samples: vec![json.into()],
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

fn empty_source() -> JsonSourceData {
    JsonSourceData {
        name: "X".to_owned(),
        samples: Vec::new(),
        description: None,
    }
}

fn typescript_input() -> JsonInput {
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
        samples: vec![r#"{"name":"Alice","age":30}"#.into()],
        description: None,
    }))
    .expect("valid sample");
    let mut input_data = InputData::new();
    input_data.add_input(input);
    let graph = graph_of(language("typescript"), &mut input_data).expect("graph");
    let person = graph.top_levels()["Person"];
    assert_eq!(graph.kind(person).expect("kind"), TypeKind::Class);
}

/// TS adds every JSON source to the one `"json"` input, whichever way it
/// was created; here sources read either way share it.
#[test]
fn input_data_keeps_one_input_per_kind() {
    let mut input_data = InputData::new();
    let samples = [
        ("A", JsonSample::from("{}")),
        ("B", JsonSample::Stream(b"[1.0]".to_vec())),
        ("A", JsonSample::from(r#"{"x":1}"#)),
    ];
    for (name, sample) in samples {
        input_data
            .add_source_sync(
                "json",
                JsonSourceData {
                    name: name.to_owned(),
                    samples: vec![sample],
                    description: None,
                },
                typescript_input,
            )
            .expect("added");
    }
    assert!(input_data.need_ir());
    assert!(!input_data.need_schema_processing());
    assert_eq!(input_data.single_string_schema_source().expect("ok"), None);
    let graph = graph_of(language("typescript"), &mut input_data).expect("graph");
    let names: Vec<&String> = graph.top_levels().keys().collect();
    assert_eq!(names, ["A", "B"]);
    // `1.0` was read with stream-json semantics: a double.
    let b = graph.type_at(graph.top_levels()["B"]).expect("B");
    assert_eq!(
        graph.kind(b.items().expect("array")).expect("kind"),
        TypeKind::Double
    );
}

/// The JavaScript facade's path: tables and encoded top-levels exported
/// from one input and imported into another give the same graph.
#[test]
fn compressed_tables_round_trip() {
    let mut input = typescript_input();
    let samples = [
        r#"{"d":"2020-01-01","u":"http://h/p.png","e":["x","y","x"],"n":{"k":[1,2.5,null]}}"#,
        r#""2021-02-03""#,
    ];
    input
        .add_source_sync(JsonSourceData {
            name: "First".to_owned(),
            samples: samples.iter().map(|&s| s.into()).collect(),
            description: Some("described".to_owned()),
        })
        .expect("valid");
    input
        .add_source_sync(JsonSourceData {
            name: "Second".to_owned(),
            samples: vec!["[true]".into()],
            description: None,
        })
        .expect("valid");
    let (tables, top_levels) = input.to_compressed();
    let imported = JsonInput::from_compressed(
        &tables,
        false,
        language("typescript").date_time_recognizer(),
        top_levels,
    )
    .expect("valid tables");

    let print = |input: JsonInput| {
        let mut input_data = InputData::new();
        input_data.add_input(input);
        graph_of(language("typescript"), &mut input_data)
            .expect("graph")
            .graph_text()
            .expect("print")
    };
    assert_eq!(print(imported), print(input));
}
