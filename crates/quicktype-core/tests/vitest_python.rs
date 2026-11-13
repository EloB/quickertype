//! Ports of quicktype's Vitest tests for the Python renderer
//! (`test/unit/python-typing-type.test.ts` and
//! `python-union-order.test.ts`).
//!
//! Each test's input is a render scenario (`fixtures/core-rendering/
//! scenarios/vitest-python-*.txt`), recorded from the reference by
//! `xtask/core-rendering/run-render-scenarios.mjs`; `render_scenarios.rs`
//! compares the Rust output with the reference byte for byte. This file
//! renders the same graphs and checks what the Vitest tests assert.

mod render_support;

use std::fs;
use std::path::Path;

use render_support::{build_graph, gather_and_render};
use serde_json::Value;

/// The output of render `index` of scenario `name`.
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

/// `pythonFor(version)`: the schema output, then the JSON output (render
/// 0 is Python 3.6, render 1 Python 3.7).
fn python_for(index: usize) -> String {
    [
        render_scenario("vitest-python-typing-type-schema", index),
        render_scenario("vitest-python-typing-type-json", index),
    ]
    .join("\n")
}

fn is_word_char(c: char) -> bool {
    c.is_ascii_alphanumeric() || c == '_'
}

/// Whether `text` contains the word `word` (`/\bword\b/`).
fn contains_word(text: &str, word: &str) -> bool {
    text.match_indices(word).any(|(i, _)| {
        !text[..i].ends_with(is_word_char) && !text[i + word.len()..].starts_with(is_word_char)
    })
}

/// Whether a line of `text` matches `/from typing import [^\n]*\bType\b/`.
fn imports_typing_type(text: &str) -> bool {
    text.lines().any(|line| {
        line.match_indices("from typing import ")
            .any(|(i, m)| contains_word(&line[i + m.len()..], "Type"))
    })
}

/// Whether `text` matches `/\bType\[/`.
fn uses_typing_type(text: &str) -> bool {
    text.match_indices("Type[")
        .any(|(i, _)| !text[..i].ends_with(is_word_char))
}

#[test]
fn python_3_6_does_not_import_or_use_typing_type() {
    let output = python_for(0);

    assert!(output.contains("T = TypeVar(\"T\")"));
    assert!(!imports_typing_type(&output));
    assert!(!uses_typing_type(&output));
    assert!(output.contains("def to_class(c, x: Any) -> dict:"));
    assert!(output.contains("def to_enum(c, x: Any) -> EnumT:"));
    assert!(output.contains("def is_type(t, x: Any) -> T:"));
}

#[test]
fn python_3_7_keeps_typing_type_annotations() {
    let output = python_for(1);

    assert!(imports_typing_type(&output));
    assert!(output.contains("def to_class(c: Type[T], x: Any) -> dict:"));
    assert!(output.contains("def to_enum(c: Type[EnumT], x: Any) -> EnumT:"));
    assert!(output.contains("def is_type(t: Type[T], x: Any) -> T:"));
}

#[test]
fn python_tries_integer_before_number_in_unions() {
    let output = render_scenario("vitest-python-union-order", 0);

    assert!(output.contains("from_union([from_int, from_float]"));
    assert!(output.contains("from_union([from_int, to_float]"));
}
