//! Ports of quicktype's Java and Kotlin unit tests:
//!
//! - `test/unit/java-acronym-names.test.ts`
//! - `test/unit/kotlin-klaxon-empty-object-map.test.ts`
//! - `test/unit/kotlinx-datetime-serializers.test.ts`
//!
//! The TypeScript tests run the whole pipeline on a schema or JSON sample
//! and assert on the generated code. Here the graphs come from the render
//! scenarios of the same names
//! (`tests/fixtures/core-rendering/scenarios/<id>.txt`, recorded by
//! `xtask/core-rendering/run-render-scenarios.mjs`), which
//! `render_scenarios.rs` also compares byte for byte with the reference;
//! these tests render them with the Rust renderers and check what the
//! TypeScript tests check.

mod render_support;

use std::fs;
use std::path::Path;

use render_support::{build_graph, gather_and_render};
use serde_json::Value;

/// The output of every render of scenario `id`: all files, joined.
fn render_scenario(id: &str) -> Vec<String> {
    let path = Path::new(env!("CARGO_MANIFEST_DIR"))
        .join("tests/fixtures/core-rendering/scenarios")
        .join(format!("{id}.json"));
    let text = fs::read_to_string(&path).expect("scenario fixture");
    let fixture: Value = serde_json::from_str(&text).expect("scenario JSON");
    fixture["renders"]
        .as_array()
        .expect("renders")
        .iter()
        .map(|render| {
            let mut graph = build_graph(&fixture["graph"]).expect("graph");
            let result = gather_and_render(&mut graph, &fixture["gather"], render).expect("render");
            result
                .values()
                .map(|file| file.lines.join("\n"))
                .collect::<Vec<_>>()
                .join("\n")
        })
        .collect()
}

/// The single render of scenario `id`.
fn render_single(id: &str) -> String {
    let mut outputs = render_scenario(id);
    assert_eq!(outputs.len(), 1, "{id} has one render");
    outputs.remove(0)
}

// ---- java-acronym-names.test.ts -------------------------------------------------

// Java enum constants must keep acronyms uppercase for every --acronym-style
// setting. They are rendered in UPPER_UNDERSCORE style, but before the fix in
// https://github.com/glideapps/quicktype/pull/2851 (issue #2850) the
// acronym-style option was still applied to words recognized as acronyms
// (e.g. "SPA"), so with --acronym-style=camel the JSON enum value
// "MULTI_SPA_IN_GROUP_REJECTED" produced the constant
// "MULTI_Spa_IN_GROUP_REJECTED".
//
// The raw JSON name always appears in the string literals of
// toValue()/forValue(), so the test checks the *identifier* of
// `case <identifier>: return "MULTI_SPA_IN_GROUP_REJECTED";`.

const ENUM_VALUE: &str = "MULTI_SPA_IN_GROUP_REJECTED";

/// The capture of `/case (\w+): return "MULTI_SPA_IN_GROUP_REJECTED";/`.
fn java_enum_constant_identifier(output: &str) -> Option<&str> {
    let suffix = format!(": return \"{ENUM_VALUE}\";");
    output.lines().find_map(|line| {
        let start = line.find("case ")? + "case ".len();
        let rest = &line[start..];
        let end = rest.find(&suffix)?;
        let identifier = &rest[..end];
        identifier
            .chars()
            .all(|c| c.is_ascii_alphanumeric() || c == '_')
            .then_some(identifier)
    })
}

#[test]
fn java_enum_constants_keep_acronyms_uppercase_for_every_acronym_style() {
    // Renders with acronym-style original, pascal, camel and lowerCase.
    let outputs = render_scenario("java-acronym-names");
    assert_eq!(outputs.len(), 4);
    for output in &outputs {
        assert_eq!(
            java_enum_constant_identifier(output),
            Some(ENUM_VALUE),
            "generated Java output:\n{output}"
        );
    }
}

// ---- kotlin-klaxon-empty-object-map.test.ts ---------------------------------------

// Maps of empty objects render as `Map<String, X>` with `typealias X =
// JsonObject` in Kotlin/Klaxon. Klaxon's reflective deserializer never
// consults custom converters for map values, so fields holding such maps must
// be handled by a field-level converter, which Klaxon does consult
// (https://github.com/glideapps/quicktype/issues/2881).

#[test]
fn klaxon_map_of_empty_object_fields_get_a_field_converter() {
    let output = render_single("kotlin-klaxon-empty-object-map-2881");

    // Empty objects still render as a JsonObject typealias.
    assert!(output.contains("typealias Reward = JsonObject"), "{output}");

    // The field-level converter must be declared and registered...
    assert!(
        output.contains("@Target(AnnotationTarget.FIELD)"),
        "{output}"
    );
    assert!(
        output.contains("private annotation class KlaxonJsonObjectMap"),
        "{output}"
    );
    assert!(
        output.contains(".fieldConverter(KlaxonJsonObjectMap::class, jsonObjectMapConverter)"),
        "{output}"
    );

    // ...and the map-of-empty-object property must be annotated with it.
    assert!(
        output.contains("@KlaxonJsonObjectMap\n    val rewards: Map<String, Reward>"),
        "{output}"
    );
}

#[test]
fn klaxon_maps_nested_inside_maps_of_empty_objects_are_annotated() {
    let output = render_single("kotlin-klaxon-empty-object-map-nested");

    assert!(
        output.contains("@KlaxonJsonObjectMap\n    val outer: Map<String, Map<String, Outer>>"),
        "{output}"
    );
}

#[test]
fn klaxon_plain_classes_and_maps_of_non_empty_objects_are_not_annotated() {
    let output = render_single("kotlin-klaxon-empty-object-map-plain");

    // `widgets` renders as `Map<String, Plain>`, which Klaxon deserializes
    // fine on its own, so none of the workaround machinery should appear.
    assert!(
        output.contains("val widgets: Map<String, Plain>"),
        "{output}"
    );
    assert!(!output.contains("KlaxonJsonObjectMap"), "{output}");
    assert!(!output.contains("fieldConverter"), "{output}");
}

// ---- kotlinx-datetime-serializers.test.ts -------------------------------------------

// Kotlin's language-wide stringTypeMapping maps JSON Schema "date", "time",
// and "date-time" formats to java.time types for all frameworks.
// kotlinx.serialization has no built-in serializers for java.time, so the
// kotlinx renderer must emit custom KSerializer objects and register them
// with a `@file:UseSerializers(...)` annotation.

#[test]
fn kotlinx_emits_serializers_and_use_serializers_for_date_time_types() {
    let output = render_single("kotlinx-datetime-serializers-all");

    assert!(
        output.contains(
            "@file:UseSerializers(OffsetDateTimeSerializer::class, LocalDateSerializer::class, OffsetTimeSerializer::class)"
        ),
        "{output}"
    );
    for (serializer, java_type) in [
        ("OffsetDateTimeSerializer", "OffsetDateTime"),
        ("LocalDateSerializer", "LocalDate"),
        ("OffsetTimeSerializer", "OffsetTime"),
    ] {
        assert!(
            output.contains(&format!("object {serializer} : KSerializer<{java_type}>")),
            "{output}"
        );
        assert!(
            output.contains(&format!("import java.time.{java_type}")),
            "{output}"
        );
    }

    // The file annotation must precede the package declaration.
    let annotation = output.find("@file:UseSerializers").expect("annotation");
    let package = output.find("package ").expect("package");
    assert!(annotation < package, "{output}");
}

#[test]
fn kotlinx_emits_only_the_serializers_that_are_used() {
    let output = render_single("kotlinx-datetime-serializers-date");

    assert!(
        output.contains("@file:UseSerializers(LocalDateSerializer::class)"),
        "{output}"
    );
    assert!(output.contains("object LocalDateSerializer"), "{output}");
    assert!(!output.contains("OffsetDateTimeSerializer"), "{output}");
    assert!(!output.contains("OffsetTimeSerializer"), "{output}");
}

#[test]
fn kotlinx_emits_no_serializer_machinery_without_date_time_types() {
    let output = render_single("kotlinx-datetime-serializers-none");

    assert!(!output.contains("@file:UseSerializers"), "{output}");
    assert!(!output.contains("KSerializer"), "{output}");
    assert!(!output.contains("java.time"), "{output}");
}
