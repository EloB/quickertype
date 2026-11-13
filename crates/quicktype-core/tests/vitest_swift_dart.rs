//! Ports of quicktype's Vitest tests for the Swift and Dart renderers
//! (`test/unit/swift-acronym-names.test.ts`,
//! `swift-coding-keys-protocol.test.ts`, `swift-final-classes.test.ts`,
//! `swift-json-null-hashable.test.ts` and `dart-method-names.test.ts`).
//!
//! Each test's input is a render scenario (`fixtures/core-rendering/
//! scenarios/vitest-*.txt`), recorded from the reference by
//! `xtask/core-rendering/run-render-scenarios.mjs`; `render_scenarios.rs`
//! compares the Rust output with the reference byte for byte. This file
//! renders the same graphs and checks what the Vitest tests assert.

mod render_support;

use std::fs;
use std::path::Path;

use render_support::{build_graph, gather_and_render};
use serde_json::Value;

/// The lines of render `index` of scenario `name` (one file expected).
fn render_scenario(name: &str, index: usize) -> Vec<String> {
    let path = Path::new(env!("CARGO_MANIFEST_DIR"))
        .join("tests/fixtures/core-rendering/scenarios")
        .join(format!("{name}.json"));
    let fixture: Value = serde_json::from_str(&fs::read_to_string(path).unwrap()).unwrap();
    let mut graph = build_graph(&fixture["graph"]).unwrap();
    let result =
        gather_and_render(&mut graph, &fixture["gather"], &fixture["renders"][index]).unwrap();
    assert_eq!(result.len(), 1, "{name}: one file expected");
    result.into_values().next().unwrap().lines
}

/// The name in a line `struct <name>: Codable {` (`/^struct (\w+): Codable \{$/m`).
fn swift_struct_name(lines: &[String]) -> Option<&str> {
    lines.iter().find_map(|line| {
        let name = line.strip_prefix("struct ")?.strip_suffix(": Codable {")?;
        (!name.is_empty() && name.chars().all(|c| c.is_ascii_alphanumeric() || c == '_'))
            .then_some(name)
    })
}

/// The class declarations
/// (`/^\s*(?:(?:public|internal)\s+)?(?:final\s+)?class\s+/`).
fn class_declarations(lines: &[String]) -> Vec<&str> {
    lines
        .iter()
        .map(String::as_str)
        .filter(|line| {
            let mut rest = line.trim_start();
            for modifier in [["public", "internal"].as_slice(), ["final"].as_slice()] {
                for m in modifier {
                    if let Some(after) = rest.strip_prefix(m)
                        && after.starts_with(char::is_whitespace)
                    {
                        rest = after.trim_start();
                        break;
                    }
                }
            }
            rest.strip_prefix("class")
                .is_some_and(|after| after.starts_with(char::is_whitespace))
        })
        .collect()
}

#[test]
fn swift_struct_names_honor_the_acronym_style() {
    for (index, (style, expected)) in [
        ("original", "FaqCoordinate"),
        ("pascal", "FAQCoordinate"),
        ("camel", "FaqCoordinate"),
        ("lowerCase", "faqCoordinate"),
    ]
    .into_iter()
    .enumerate()
    {
        let lines = render_scenario("vitest-swift-acronym-names", index);
        assert_eq!(
            swift_struct_name(&lines),
            Some(expected),
            "acronym-style={style}:\n{}",
            lines.join("\n")
        );
    }
}

#[test]
fn swift_emits_redundant_coding_keys_when_a_protocol_is_requested() {
    let output = render_scenario("vitest-swift-coding-keys-protocol", 0).join("\n");
    assert!(output.contains("enum CodingKeys: String, CodingKey, CaseIterable"));
}

#[test]
fn swift_keeps_classes_open_by_default() {
    let model = render_scenario("vitest-swift-final-classes-model", 0);
    let recursive = render_scenario("vitest-swift-final-classes-recursive", 0);
    let lines: Vec<String> = model.into_iter().chain(recursive).collect();
    let declarations = class_declarations(&lines);
    assert!(!declarations.is_empty());
    assert!(
        declarations
            .iter()
            .all(|line| !line.contains("final class"))
    );
}

#[test]
fn swift_marks_requested_model_classes_as_final() {
    let lines = render_scenario("vitest-swift-final-classes-model", 1);
    let declarations = class_declarations(&lines);
    assert_eq!(declarations.len(), 2, "{declarations:?}");
    for expected in ["final class TopLevel", "final class Child"] {
        assert!(
            declarations.iter().any(|line| line.contains(expected)),
            "{expected}: {declarations:?}"
        );
    }
}

#[test]
fn swift_marks_cycle_breakers_and_codable_helpers_as_final() {
    let lines = render_scenario("vitest-swift-final-classes-recursive", 1);
    let declarations = class_declarations(&lines);
    for expected in [
        "final class TopLevel",
        "final class JSONNull",
        "final class JSONCodingKey",
        "final class JSONAny",
    ] {
        assert!(
            declarations.iter().any(|line| line.contains(expected)),
            "{expected}: {declarations:?}"
        );
    }
    assert!(declarations.iter().all(|line| line.contains("final class")));
}

#[test]
fn swift_json_null_implements_modern_hashable() {
    let output = render_scenario("vitest-swift-json-null-hashable", 0).join("\n");
    assert!(output.contains("public func hash(into hasher: inout Hasher)"));
    assert!(output.contains("hasher.combine(0)"));
    assert!(!output.contains("public var hashValue: Int"));
}
