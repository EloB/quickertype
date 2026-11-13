//! Ports of quicktype's Vitest tests `test/unit/golang-enum-type-name-suffix.test.ts`
//! and `test/unit/json-schema-definitions.test.ts` (the render-level parts).
//!
//! Each test's input is a render scenario (`fixtures/core-rendering/
//! scenarios/vitest-*.txt`), recorded from the reference by
//! `xtask/core-rendering/run-render-scenarios.mjs`; `render_scenarios.rs`
//! compares the Rust output with the reference byte for byte. This file
//! renders the same graphs and checks what the Vitest tests assert.

mod render_support;

use std::fs;
use std::path::Path;

use regex::Regex;
use render_support::{build_graph, gather_and_render};
use serde_json::Value;

/// The output of render `index` of scenario `name` (a single file).
fn render_scenario(name: &str, index: usize) -> String {
    let path = Path::new(env!("CARGO_MANIFEST_DIR"))
        .join("tests/fixtures/core-rendering/scenarios")
        .join(format!("{name}.json"));
    let fixture: Value = serde_json::from_str(&fs::read_to_string(path).unwrap()).unwrap();
    let mut graph = build_graph(&fixture["graph"]).unwrap();
    let result =
        gather_and_render(&mut graph, &fixture["gather"], &fixture["renders"][index]).unwrap();
    assert_eq!(result.len(), 1, "{name}: one file expected");
    result
        .values()
        .next()
        .map(|file| file.lines.join("\n"))
        .unwrap()
}

/// `expect(text).toMatch(pattern)`.
fn assert_matches(text: &str, pattern: &str) {
    let regex = Regex::new(pattern).unwrap();
    assert!(regex.is_match(text), "expected /{pattern}/ in:\n{text}");
}

#[test]
fn golang_enum_type_name_suffix_is_off_by_default_and_qualifies_constants_when_enabled() {
    let default_output = render_scenario("vitest-golang-enum-type-name-suffix", 0);
    let qualified_output = render_scenario("vitest-golang-enum-type-name-suffix", 1);
    let independently_qualified_output =
        render_scenario("vitest-golang-enum-type-name-suffix-tree-part", 0);

    assert_matches(&default_output, r#"Bark\s+DogNoise = "BARK""#);
    assert_matches(&qualified_output, r#"BarkDogNoise\s+DogNoise = "BARK""#);
    assert_matches(&qualified_output, r#"GrowlDogNoise\s+DogNoise = "GROWL""#);
    assert_matches(&qualified_output, r#"HowlDogNoise\s+DogNoise = "HOWL""#);
    assert_matches(
        &independently_qualified_output,
        r#"BarkTreePart\s+TreePart = "BARK""#,
    );
}

#[test]
fn golang_enum_type_name_suffix_resolves_collisions_using_the_complete_qualified_name() {
    let output = render_scenario("vitest-golang-enum-type-name-suffix-collision", 0);

    assert!(output.contains("type BarkDogNoise struct"));
    let unqualified = Regex::new(r#"(?m)^\s*BarkDogNoise\s+DogNoise = "BARK""#).unwrap();
    assert!(!unqualified.is_match(&output), "{output}");
    assert_matches(&output, r#"(?m)^\s*\w*BarkDogNoise\s+DogNoise = "BARK""#);
}

#[test]
fn json_schema_type_under_defs_keeps_its_definition_name() {
    // Issue #2778.
    let output = render_scenario("vitest-json-schema-definitions", 0);

    assert!(output.contains("LightParams: LightParams;"), "{output}");
    assert!(
        output.contains("export interface LightParams {"),
        "{output}"
    );
}
