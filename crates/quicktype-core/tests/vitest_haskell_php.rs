//! Ports of quicktype's Vitest tests for the Haskell and PHP renderers
//! (`test/unit/haskell-enum-case-naming.test.ts`, `php-unions.test.ts` and
//! `php-validation.test.ts`).
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

/// The output of the first render of scenario `name`.
fn render_scenario(name: &str) -> String {
    let path = Path::new(env!("CARGO_MANIFEST_DIR"))
        .join("tests/fixtures/core-rendering/scenarios")
        .join(format!("{name}.json"));
    let fixture: Value = serde_json::from_str(&fs::read_to_string(path).unwrap()).unwrap();
    let mut graph = build_graph(&fixture["graph"]).unwrap();
    let result = gather_and_render(&mut graph, &fixture["gather"], &fixture["renders"][0]).unwrap();
    assert_eq!(result.len(), 1, "{name}: one file expected");
    result
        .values()
        .next()
        .map(|file| file.lines.join("\n"))
        .unwrap()
}

fn is_word_char(c: char) -> bool {
    c.is_ascii_alphanumeric() || c == '_'
}

/// Whether `text` contains `needle` followed by a word character (`/needle\w/`).
fn contains_followed_by_word(text: &str, needle: &str) -> bool {
    text.match_indices(needle)
        .any(|(i, _)| text[i + needle.len()..].starts_with(is_word_char))
}

/// Whether `text` contains the word `needle` (`/needle\b/` for a needle
/// ending in a word character).
fn contains_word(text: &str, needle: &str) -> bool {
    text.match_indices(needle)
        .any(|(i, _)| !text[i + needle.len()..].starts_with(is_word_char))
}

#[test]
fn haskell_enum_case_naming_suffixes_the_enum_name_without_over_renaming() {
    let output = render_scenario("vitest-haskell-enum-case-naming");
    let lines: Vec<&str> = output.split('\n').collect();
    let start = lines
        .iter()
        .position(|line| line.starts_with("data Health"))
        .expect("data Health");
    let constructors: Vec<&str> = lines[start + 1..]
        .iter()
        .map_while(|line| {
            let rest = line.trim_start().strip_prefix(['=', '|'])?;
            let rest = rest.strip_prefix(char::is_whitespace)?.trim_start();
            rest.split_whitespace().next()
        })
        .collect();
    assert_eq!(constructors, ["OkHealth", "ErrorHealth"]);
    assert!(!output.contains("HealthErrorHealth"));
}

#[test]
fn php_heterogeneous_arrays_render_with_runtime_dispatch() {
    let php = render_scenario("vitest-php-unions-dispatch");
    for check in [
        "is_int($value)",
        "is_string($value)",
        "is_bool($value)",
        "is_null($value)",
    ] {
        assert!(php.contains(check), "missing {check}");
    }
    assert!(contains_followed_by_word(&php, "$value instanceof "));
    assert!(php.contains("Cannot deserialize union value"));
}

#[test]
fn php_union_property_gets_a_union_type_declaration() {
    let php = render_scenario("vitest-php-unions-declaration");
    assert!(php.contains("private V|int|string $v;"));
    assert!(php.contains("stdClass|int|string $value"));
}

#[test]
fn php_nullable_unions_keep_the_question_mark_hint() {
    let php = render_scenario("vitest-php-unions-nullable");
    assert!(php.contains("private ?string $a;"));
}

#[test]
fn php_double_member_accepts_integers() {
    let php = render_scenario("vitest-php-unions-double");
    assert!(php.contains("is_float($value) || is_int($value)"));
}

#[test]
fn php_reserved_words_are_not_class_names() {
    let php = render_scenario("vitest-php-unions-reserved");
    assert!(!contains_word(&php, "class Mixed"));
    assert!(contains_word(&php, "class MixedClass"));
}

/// `validationMethod(php, propertyName)`: the text of `validate<Name>` up
/// to the next doc comment.
fn validation_method<'p>(php: &'p str, property_name: &str) -> &'p str {
    let start = php
        .find(&format!("public static function validate{property_name}("))
        .unwrap_or_else(|| panic!("No validate{property_name} method found in generated PHP"));
    match php[start..].find("\n    /**") {
        Some(end) => &php[start..start + end],
        None => &php[start..],
    }
}

#[test]
fn php_validation_does_not_recheck_scalar_parameter_types() {
    let php = render_scenario("vitest-php-validation");
    for property in ["Boolean", "Integer", "Number", "NullableNumber", "String"] {
        let method = validation_method(&php, property);
        for check in ["bool", "float", "int", "integer", "string"] {
            assert!(
                !method.contains(&format!("is_{check}(")),
                "validate{property} rechecks is_{check}"
            );
        }
    }

    assert!(validation_method(&php, "Integers").contains("if (!is_integer($value_v))"));
    assert!(validation_method(&php, "ScalarUnion").contains("if (is_int($value))"));
    assert!(validation_method(&php, "ScalarUnion").contains("elseif (is_string($value))"));
}
