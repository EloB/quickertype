//! The run-level public API (`Run.ts`): `quicktype`,
//! `quicktypeMultiFile(Sync)`, `combineRenderResults` and the options.
//!
//! Includes ports of quicktype's Vitest tests that drive the API end to
//! end: `pipeline-timing.test.ts`, `typescript-output-filename.test.ts`
//! and `just-types-option.test.ts`. Those that need a renderer other
//! languages' work packages are still porting skip themselves (printing
//! why) until it lands. Expected values not taken from the Vitest tests
//! were checked against quicktype-core's JavaScript API.

use std::cell::RefCell;
use std::rc::Rc;

use quicktype_core::{
    Annotation, AnnotationData, Comment, DebugOptions, InputData, JsErrorName, JsonSchemaInput,
    JsonSchemaSourceData, JsonSourceData, Location, MultiFileRenderResult, OptionValue, Options,
    QuickTypeError, RendererOptions, Result, SerializedRenderResult, Span, block_on,
    capture_console, combine_render_results, get_target_language, json_input_for_target_language,
    quicktype, quicktype_multi_file, quicktype_multi_file_sync,
};

/// A JSON input for `lang` with one top-level, `name`, and its samples.
fn json_input_data(lang: &str, name: &str, samples: &[&str]) -> InputData {
    let lang = get_target_language(lang).unwrap();
    let mut input = json_input_for_target_language(lang, false, &RendererOptions::new());
    input
        .add_source_sync(JsonSourceData {
            name: name.to_owned(),
            samples: samples.iter().map(|s| (*s).into()).collect(),
            description: None,
        })
        .unwrap();
    let mut input_data = InputData::new();
    input_data.add_input(input);
    input_data
}

/// A JSON Schema input with one source given as text.
fn schema_input_data(name: &str, schema: &str, is_converted: bool) -> InputData {
    let mut input = JsonSchemaInput::new(None, Vec::new(), Vec::new());
    input
        .add_source_sync(JsonSchemaSourceData {
            name: name.to_owned(),
            uris: None,
            schema: Some(schema.to_owned()),
            is_converted,
        })
        .unwrap();
    let mut input_data = InputData::new();
    input_data.add_input(input);
    input_data
}

fn renderer_options(options: &[(&str, OptionValue)]) -> RendererOptions {
    let mut result = RendererOptions::new();
    for (name, value) in options {
        result.set(*name, value.clone());
    }
    result
}

/// `quicktype({inputData, lang, rendererOptions, outputFilename})` on the
/// "Person" sample of `just-types-option.test.ts`, joined; `None` (with a
/// note) while the language's renderer is not ported yet.
fn lines_for(lang: &str, options: &[(&str, OptionValue)]) -> Option<Result<String>> {
    generate(
        lang,
        "Person",
        r#"{"name": "Alice", "age": 37}"#,
        options,
        None,
    )
}

fn generate(
    lang: &str,
    name: &str,
    sample: &str,
    options: &[(&str, OptionValue)],
    output_filename: Option<&str>,
) -> Option<Result<String>> {
    let target = get_target_language(lang).unwrap();
    let mut quicktype_options = Options {
        renderer_options: renderer_options(options),
        ..Options::new(target, json_input_data(lang, name, &[sample]))
    };
    if let Some(output_filename) = output_filename {
        quicktype_options.output_filename = output_filename.to_owned();
    }
    match block_on(quicktype(quicktype_options)) {
        Err(e) if e.user_message().ends_with("renderer is not ported yet") => {
            eprintln!("skipped: {e}");
            None
        }
        result => Some(result.map(|r| r.lines.join("\n"))),
    }
}

fn flag(on: bool) -> OptionValue {
    OptionValue::Bool(on)
}

fn text(s: &str) -> OptionValue {
    OptionValue::String(s.to_owned())
}

// ---- Run ----------------------------------------------------------------

#[test]
fn quicktype_squashes_what_quicktype_multi_file_returns() {
    let rust = get_target_language("rust").unwrap();
    let samples = [r#"{"id": 1, "tags": ["a"]}"#];
    let files = quicktype_multi_file_sync(Options::new(
        rust,
        json_input_data("rust", "Item", &samples),
    ))
    .unwrap();
    assert_eq!(files.keys().collect::<Vec<_>>(), ["stdout"]);
    let single = block_on(quicktype(Options::new(
        rust,
        json_input_data("rust", "Item", &samples),
    )))
    .unwrap();
    assert_eq!(single, files["stdout"]);
    let async_files = block_on(quicktype_multi_file(Options::new(
        rust,
        json_input_data("rust", "Item", &samples),
    )))
    .unwrap();
    assert_eq!(async_files, files);
    assert!(single.lines.join("\n").contains("pub struct Item {"));
}

#[test]
fn no_render_returns_done_under_the_output_filename() {
    let kotlin = get_target_language("kotlin").unwrap();
    let files = quicktype_multi_file_sync(Options {
        no_render: true,
        output_filename: "Out.kt".to_owned(),
        ..Options::new(kotlin, json_input_data("kotlin", "A", &["[1, 2]"]))
    })
    .unwrap();
    assert_eq!(files["Out.kt"].lines, ["Done.", ""]);
}

#[test]
fn leading_comments_start_the_output() {
    let rust = get_target_language("rust").unwrap();
    let result = block_on(quicktype(Options {
        leading_comments: Some(vec![Comment::from("Hello"), Comment::from("World")]),
        renderer_options: renderer_options(&[("density", text("dense"))]),
        ..Options::new(
            rust,
            json_input_data("rust", "Person", &[r#"{"name": "Ann"}"#]),
        )
    }))
    .unwrap();
    assert_eq!(
        result.lines[..6],
        [
            "/// Hello",
            "",
            "/// World",
            "",
            "use serde::{Serialize, Deserialize};",
            ""
        ]
    );
}

#[test]
fn unknown_option_values_are_reported() {
    let error = lines_for("rust", &[("density", text("sparse"))])
        .unwrap()
        .unwrap_err();
    assert_eq!(
        error.user_message(),
        "Unknown value sparse for option density"
    );
}

#[test]
fn a_converted_schema_passes_through_to_json_schema() {
    let schema = get_target_language("schema").unwrap();
    let files = block_on(quicktype_multi_file(Options::new(
        schema,
        schema_input_data("X", r#"{"b": 1, "1": [1.50, 2e3]}"#, true),
    )))
    .unwrap();
    assert_eq!(
        files["stdout"].lines,
        [
            "{",
            "    \"1\": [",
            "        1.5,",
            "        2000",
            "    ],",
            "    \"b\": 1",
            "}",
            ""
        ]
    );

    let error = block_on(quicktype_multi_file(Options::new(
        schema,
        schema_input_data("X", r#"{"b": 1,}"#, true),
    )))
    .unwrap_err();
    let exception = error.as_js_exception().unwrap();
    assert_eq!(exception.name(), JsErrorName::SyntaxError);
    assert_eq!(
        exception.message(),
        "Expected double-quoted property name in JSON at position 8 (line 1 column 9)"
    );
}

#[test]
fn schema_input_needs_the_async_run() {
    let rust = get_target_language("rust").unwrap();
    let schema = r#"{"type": "object", "properties": {"a": {"type": "string"}}}"#;
    let error =
        quicktype_multi_file_sync(Options::new(rust, schema_input_data("X", schema, false)))
            .unwrap_err();
    assert_eq!(
        error.user_message(),
        "Internal error: addTypesSync not supported in JSONSchemaInput"
    );
    let result = block_on(quicktype(Options::new(
        rust,
        schema_input_data("X", schema, false),
    )))
    .unwrap();
    assert!(result.lines.join("\n").contains("pub struct X {"));
}

#[test]
fn languages_are_looked_up_by_any_of_their_names() {
    assert_eq!(get_target_language("csharp").unwrap().name(), "cs");
    let error = get_target_language("python3").unwrap_err();
    assert_eq!(error.user_message(), "Unknown language name: python3");
    assert_eq!(
        error.as_js_exception().map(|e| e.name()),
        Some(JsErrorName::Error)
    );
}

#[test]
fn the_default_options_are_quicktypes() {
    let options = Options::default();
    assert_eq!(options.lang.name(), "typescript");
    assert_eq!(options.output_filename, "stdout");
    assert!(options.inference_flags.infer_maps && options.inference_flags.ignore_json_refs);
    assert!(!options.alphabetize_properties && !options.no_render && !options.check_provenance);
}

#[test]
fn debug_output_goes_to_the_console() {
    let rust = get_target_language("rust").unwrap();
    let (result, lines) = capture_console(|| {
        quicktype_multi_file_sync(Options {
            debug: DebugOptions {
                print_graph: true,
                ..DebugOptions::default()
            },
            check_provenance: true,
            ..Options::new(rust, json_input_data("rust", "A", &[r#"{"x": 1}"#]))
        })
    });
    result.unwrap();
    assert_eq!(
        lines[..2],
        ["0: integer | 0", "1: class A | children 0 | 1 | given A ()"]
    );
    assert!(lines.iter().any(|l| l == "\n# gather names"), "{lines:?}");
}

fn span(start: usize, end: usize) -> Span {
    Span {
        start: Location {
            line: start,
            column: 0,
        },
        end: Location {
            line: end,
            column: 4,
        },
    }
}

#[test]
fn combine_render_results_prefixes_each_file() {
    let mut files = MultiFileRenderResult::new();
    assert_eq!(
        combine_render_results(files.clone()),
        SerializedRenderResult::default()
    );
    let issue = |line| Annotation {
        annotation: AnnotationData::issue("check"),
        span: span(line, line),
    };
    files.insert(
        "a.h".to_owned(),
        SerializedRenderResult {
            lines: vec!["int a;".to_owned(), String::new()],
            annotations: vec![issue(0)],
        },
    );
    assert_eq!(combine_render_results(files.clone()), files["a.h"]);
    files.insert(
        "b.c".to_owned(),
        SerializedRenderResult {
            lines: vec!["int b;".to_owned()],
            annotations: vec![issue(0)],
        },
    );
    let combined = combine_render_results(files);
    assert_eq!(
        combined.lines,
        ["// a.h", "", "int a;", "", "// b.c", "", "int b;"]
    );
    assert_eq!(
        combined
            .annotations
            .iter()
            .map(|a| a.span)
            .collect::<Vec<_>>(),
        [span(2, 2), span(6, 6)]
    );
}

// ---- pipeline-timing.test.ts ---------------------------------------------
// The TypeScript tests render TypeScript; the passes are the same for
// every language.

fn timed_names(input_data: InputData) -> Vec<String> {
    let names = Rc::new(RefCell::new(Vec::new()));
    let sink = Rc::clone(&names);
    let rust = get_target_language("rust").unwrap();
    block_on(quicktype(Options {
        on_timing: Some(Rc::new(move |timing| {
            assert!(timing.milliseconds >= 0.0);
            sink.borrow_mut().push(timing.name.clone());
        })),
        ..Options::new(rust, input_data)
    }))
    .unwrap();
    names.take()
}

#[test]
fn reports_input_processing_and_rendering() {
    let names = timed_names(json_input_data(
        "rust",
        "Example",
        &[r#"{"id": 1, "name": "quicktype"}"#],
    ));
    assert!(names.iter().any(|n| n == "read input"), "{names:?}");
    assert!(names.iter().any(|n| n == "render"), "{names:?}");
}

#[test]
fn reports_json_schema_parsing_separately() {
    let names = timed_names(schema_input_data(
        "Example",
        r#"{"properties":{"id":{"type":"integer"}},"type":"object"}"#,
        false,
    ));
    for name in ["parse JSON Schema", "read input", "render"] {
        assert!(names.iter().any(|n| n == name), "{name}: {names:?}");
    }
}

// ---- typescript-output-filename.test.ts ----------------------------------

fn experiment_counts(lang: &str, output_filename: Option<&str>) -> Option<String> {
    generate(
        lang,
        "ExperimentCounts",
        r#"{"experiments": 3}"#,
        &[],
        output_filename,
    )
    .map(Result::unwrap)
}

#[test]
fn uses_output_filename_in_typescript_usage_imports() {
    if let Some(output) = experiment_counts("typescript", Some("src/cli/ExperimentCounts.ts")) {
        assert!(
            output.contains(
                r#"//   import { Convert, ExperimentCounts } from "./ExperimentCounts";"#
            )
        );
        assert!(!output.contains(r#"from "./file""#));
    }
}

#[test]
fn uses_output_filename_in_javascript_usage_require() {
    if let Some(output) = experiment_counts("javascript", Some("src/cli/ExperimentCounts.js")) {
        assert!(output.contains(r#"//   const Convert = require("./ExperimentCounts");"#));
        assert!(!output.contains(r#"require("./file")"#));
    }
}

#[test]
fn uses_output_filename_in_flow_usage_require() {
    if let Some(output) = experiment_counts("flow", Some("ExperimentCounts.js")) {
        assert!(output.contains(r#"//   const Convert = require("./ExperimentCounts");"#));
        assert!(!output.contains(r#"require("./file")"#));
    }
}

#[test]
fn falls_back_to_file_when_writing_to_stdout() {
    if let Some(output) = experiment_counts("typescript", None) {
        assert!(output.contains(r#" } from "./file";"#));
    }
    if let Some(output) = experiment_counts("javascript", None) {
        assert!(output.contains(r#"//   const Convert = require("./file");"#));
    }
}

// ---- just-types-option.test.ts -------------------------------------------
// ("Kotlin: enum cases retain their TypeScript string values" needs the
// TypeScript input, so it is in the CLI's tests.)

fn ok(lang: &str, options: &[(&str, OptionValue)]) -> Option<String> {
    lines_for(lang, options).map(Result::unwrap)
}

fn rejected(lang: &str, options: &[(&str, OptionValue)]) -> Option<QuickTypeError> {
    lines_for(lang, options).map(Result::unwrap_err)
}

#[test]
fn csharp_just_types_has_no_attributes_or_helpers_but_a_namespace() {
    if let Some(output) = ok("csharp", &[("just-types", flag(true))]) {
        assert!(output.contains("namespace QuickType"));
        assert!(output.contains("public partial class Person"));
        assert!(!output.contains("JsonConverter"));
        assert!(!output.contains("JsonProperty"));
    }
}

#[test]
fn csharp_just_types_with_use_records_emits_records_without_helpers() {
    if let Some(output) = ok(
        "csharp",
        &[("just-types", flag(true)), ("use-records", flag(true))],
    ) {
        assert!(output.contains("namespace QuickType"));
        assert!(output.contains("public partial record Person"));
        assert!(!output.contains("JsonConverter"));
        assert!(!output.contains("FromJson"));
    }
}

#[test]
fn kotlin_just_types_has_plain_data_classes() {
    if let Some(output) = ok("kotlin", &[("just-types", flag(true))]) {
        assert!(output.contains("data class Person"));
        assert!(!output.contains("Klaxon"));
    }
}

#[test]
fn scala3_just_types_has_plain_case_classes() {
    if let Some(output) = ok("scala3", &[("just-types", flag(true))]) {
        assert!(output.contains("case class Person"));
        assert!(!output.contains("circe"));
    }
}

#[test]
fn smithy_accepts_just_types() {
    if let Some(via_boolean) = ok("smithy4a", &[("just-types", flag(true))]) {
        assert!(via_boolean.contains("structure Person"));
        assert_eq!(Some(via_boolean), ok("smithy4a", &[]));
    }
}

#[test]
fn csharp_generated_file_marker() {
    for options in [
        vec![("features", text("attributes-only"))],
        vec![
            ("framework", text("NewtonSoft")),
            ("features", text("attributes-only")),
        ],
        vec![("just-types", flag(true))],
        vec![("features", text("complete"))],
    ] {
        if let Some(output) = ok("csharp", &options) {
            assert!(
                output.starts_with("// <auto-generated />\n//\n"),
                "{options:?}"
            );
        }
    }
}

#[test]
fn the_removed_enum_spellings_are_errors() {
    let cases = [
        ("csharp", "features", "just-types"),
        ("csharp", "features", "just-types-and-namespace"),
        ("kotlin", "framework", "just-types"),
        ("scala3", "framework", "just-types"),
    ];
    for (lang, option, value) in cases {
        if let Some(error) = rejected(lang, &[(option, text(value))]) {
            assert_eq!(
                error.user_message(),
                format!("Unknown value {value} for option {option}")
            );
        }
    }
}

#[test]
fn just_types_wins_over_a_conflicting_enum_option() {
    let cases = [
        ("csharp", "features", "attributes-only", "JsonProperty"),
        ("kotlin", "framework", "jackson", "jackson"),
        ("scala3", "framework", "upickle", "upickle"),
    ];
    for (lang, option, value, absent) in cases {
        if let Some(output) = ok(lang, &[("just-types", flag(true)), (option, text(value))]) {
            assert_eq!(
                Some(output.clone()),
                ok(lang, &[("just-types", flag(true))])
            );
            assert!(!output.contains(absent), "{lang}");
        }
    }
}

#[test]
fn framework_defaults() {
    if let Some(output) = ok("scala3", &[]) {
        assert!(output.contains("io.circe"));
    }
    if let Some(output) = ok("kotlin", &[]) {
        assert!(output.contains("com.fasterxml.jackson"));
    }
}
