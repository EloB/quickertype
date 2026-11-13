//! Ports of quicktype's C# Vitest tests:
//!
//! - `test/unit/csharp-dateonly-timeonly-converters.test.ts`
//! - `test/unit/csharp-partial-helpers.test.ts`
//! - `test/unit/csharp-records.test.ts`
//! - `test/unit/csharp-superfluous-usings.test.ts`
//! - `test/unit/csharp-system-text-json-exceptions.test.ts`
//!
//! Each TypeScript test runs `quicktype()` on a JSON sample or JSON Schema.
//! `xtask/core-rendering/record-render-cases.mjs` recorded the type graph
//! those calls render (the `unit/csharp-*` render cases); these tests
//! render it with the Rust C# renderers and make the TypeScript tests'
//! assertions on the output. (`render_cases.rs` also compares the output
//! byte for byte.)

mod render_support;

use std::fs;
use std::path::Path;

use render_support::{build_graph, gather_and_render};
use serde_json::Value;

/// The C# rendered from the recorded render case `unit/<id>`.
fn render(id: &str) -> String {
    let manifest = Path::new(env!("CARGO_MANIFEST_DIR"));
    let path = manifest
        .join("tests/fixtures/core-rendering/cases")
        .join(format!("unit__{}.json", id.replace('/', "__")));
    let text =
        fs::read_to_string(&path).unwrap_or_else(|e| panic!("cannot read {}: {e}", path.display()));
    let fixture: Value = serde_json::from_str(&text).expect("render case JSON");
    let mut graph = build_graph(&fixture["graph"]).expect("graph");
    let result =
        gather_and_render(&mut graph, &fixture["gather"], &fixture["render"]).expect("render");
    assert_eq!(result.len(), 1, "one file");
    let (_, file) = result.first().expect("one file");
    file.lines.join("\n")
}

fn assert_contains(output: &str, needle: &str) {
    assert!(output.contains(needle), "expected {needle:?} in:\n{output}");
}

fn assert_not_contains(output: &str, needle: &str) {
    assert!(
        !output.contains(needle),
        "unexpected {needle:?} in:\n{output}"
    );
}

/// Whether `output` matches `/<word>\b/`: `word` not followed by a word
/// character.
fn contains_word(output: &str, word: &str) -> bool {
    output.match_indices(word).any(|(i, _)| {
        !output[i + word.len()..]
            .chars()
            .next()
            .is_some_and(|c| c.is_ascii_alphanumeric() || c == '_')
    })
}

// ---- csharp-dateonly-timeonly-converters.test.ts ---------------------------

#[test]
fn date_time_only_converters_are_emitted_by_default() {
    let output = render("csharp-dateonly-timeonly-converters/default");

    assert_contains(&output, "class DateOnlyConverter");
    assert_contains(&output, "class TimeOnlyConverter");
    assert_contains(&output, "new DateOnlyConverter(),");
    assert_contains(&output, "new TimeOnlyConverter(),");
}

#[test]
fn date_time_only_converters_are_omitted_when_disabled() {
    let output = render("csharp-dateonly-timeonly-converters/disabled");

    assert_not_contains(&output, "DateOnlyConverter");
    assert_not_contains(&output, "TimeOnlyConverter");
    // The DateTimeOffset converter is unaffected.
    assert_contains(&output, "class IsoDateTimeOffsetConverter");
    assert_contains(&output, "IsoDateTimeOffsetConverter.Singleton");
}

// ---- csharp-partial-helpers.test.ts -----------------------------------------

#[test]
fn helpers_are_partial() {
    for framework in ["NewtonSoft", "SystemTextJson"] {
        let output = render(&format!("csharp-partial-helpers/{framework}"));
        assert_contains(&output, "public static partial class Serialize");
        assert_contains(&output, "internal static partial class Converter");
    }
}

// ---- csharp-records.test.ts -------------------------------------------------

#[test]
fn use_records_emits_partial_records() {
    for framework in ["NewtonSoft", "SystemTextJson"] {
        let output = render(&format!("csharp-records/{framework}"));
        assert_contains(&output, "public partial record Person");
        // `not.toMatch(/public partial class Person\b/)`
        assert!(
            !contains_word(&output, "public partial class Person"),
            "{framework}: {output}"
        );
        // Helpers stay classes; only data types become records.
        assert_contains(&output, "public static partial class Serialize");
        assert_contains(&output, "internal static partial class Converter");
    }
}

#[test]
fn default_remains_partial_class() {
    let output = render("csharp-records/default");
    assert_contains(&output, "public partial class Person");
    assert_not_contains(&output, "public partial record Person");
}

#[test]
fn records_avoid_compiler_generated_member_names() {
    let output = render("csharp-records/record-member-names");
    // `not.toMatch(/public string (Clone|EqualityContract|PrintMembers) \{/)`
    for member in ["Clone", "EqualityContract", "PrintMembers"] {
        assert_not_contains(&output, &format!("public string {member} {{"));
    }
}

#[test]
fn just_types_with_use_records_still_emits_records() {
    let output = render("csharp-records/just-types");
    assert_contains(&output, "public partial record Person");
    assert_not_contains(&output, "JsonConverter");
    assert_not_contains(&output, "FromJson");
}

// ---- csharp-superfluous-usings.test.ts --------------------------------------

#[test]
fn newtonsoft_attributes_only_omits_converter_usings() {
    let output = render("csharp-superfluous-usings/NewtonSoft-attributes-only");

    assert_contains(&output, "using Newtonsoft.Json;");
    assert_not_contains(&output, "using System.Globalization;");
    assert_not_contains(&output, "using Newtonsoft.Json.Converters;");
}

#[test]
fn system_text_json_attributes_only_omits_globalization() {
    let output = render("csharp-superfluous-usings/SystemTextJson-attributes-only");

    assert_contains(&output, "using System.Text.Json.Serialization;");
    assert_not_contains(&output, "using System.Globalization;");
}

#[test]
fn complete_output_keeps_converter_usings() {
    for (framework, expected_using) in [
        ("NewtonSoft", "using Newtonsoft.Json.Converters;"),
        ("SystemTextJson", "using System.Globalization;"),
    ] {
        let output = render(&format!("csharp-superfluous-usings/{framework}-complete"));

        assert_contains(&output, "using System.Globalization;");
        assert_contains(&output, expected_using);
        assert_contains(&output, "IsoDateTime");
    }
}

// ---- csharp-system-text-json-exceptions.test.ts -----------------------------

#[test]
fn union_converters_throw_serializer_supported_exceptions() {
    let output = render("csharp-system-text-json-exceptions/union");

    assert_contains(
        &output,
        "throw new JsonException(\"Cannot unmarshal type Mixed\");",
    );
    assert_contains(
        &output,
        "throw new NotSupportedException(\"Cannot marshal type Mixed\");",
    );
    assert_not_contains(&output, "throw new Exception(");
}
