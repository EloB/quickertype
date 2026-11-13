//! Ports of quicktype's Vitest tests for the C (cJSON) renderer
//! (`test/unit/cjson-enum-default.test.ts` and
//! `cjson-split-sources.test.ts`).
//!
//! Each test's input is a render scenario (`fixtures/core-rendering/
//! scenarios/vitest-cjson-*.txt`), recorded from the reference by
//! `xtask/core-rendering/run-render-scenarios.mjs`; `render_scenarios.rs`
//! compares the Rust output with the reference byte for byte. This file
//! renders the same graphs and checks what the Vitest tests assert.

mod render_support;

use std::fs;
use std::path::Path;

use indexmap::IndexMap;
use render_support::{build_graph, gather_and_render};
use serde_json::Value;

/// The files of render `index` of scenario `name`, in output order.
fn render_scenario(name: &str, index: usize) -> IndexMap<String, String> {
    let path = Path::new(env!("CARGO_MANIFEST_DIR"))
        .join("tests/fixtures/core-rendering/scenarios")
        .join(format!("{name}.json"));
    let fixture: Value = serde_json::from_str(&fs::read_to_string(path).unwrap()).unwrap();
    let mut graph = build_graph(&fixture["graph"]).unwrap();
    let result =
        gather_and_render(&mut graph, &fixture["gather"], &fixture["renders"][index]).unwrap();
    result
        .into_iter()
        .map(|(name, file)| (name, file.lines.join("\n")))
        .collect()
}

/// `includesIn(source)`: every `#include <...>` and `#include "..."`
/// (`/#include [<"][^>"]+[>"]/g`).
fn includes_in(source: &str) -> Vec<&str> {
    let mut includes = Vec::new();
    let mut rest = source;
    while let Some(start) = rest.find("#include ") {
        let candidate = &rest[start..];
        let after = &candidate["#include ".len()..];
        let matched = after.starts_with(['<', '"']).then(|| {
            let body = &after[1..];
            let len = body.find(['>', '"']).unwrap_or(0);
            (len > 0).then(|| &candidate[.."#include ".len() + 1 + len + 1])
        });
        match matched.flatten() {
            Some(include) => {
                includes.push(include);
                rest = &candidate[include.len()..];
            }
            None => rest = &candidate["#include ".len()..],
        }
    }
    includes
}

/// The `<file>` of an `#include <file>`.
fn angle_include(include: &str) -> Option<&str> {
    include.strip_prefix("#include <")?.strip_suffix('>')
}

#[test]
fn cjson_enum_invalid_value_does_not_collide_with_a_real_enumerator() {
    let files = render_scenario("vitest-cjson-enum-default", 0);
    let output = &files["stdout"];
    assert!(output.contains(
        "enum Subscription {
    SUBSCRIPTION_STATE = 1,
    SUBSCRIPTION_CONFIG,
    SUBSCRIPTION_HEARTBEAT,
};"
    ));
    assert!(output.contains("enum Subscription x = 0;"));
}

/// The multi-source header/source pairs (`source-style` multi-source,
/// `header-only` false).
fn multi_source_pairs() -> IndexMap<String, String> {
    render_scenario("vitest-cjson-split-sources", 0)
}

#[test]
fn cjson_multi_source_every_header_gets_a_source_file() {
    let files = multi_source_pairs();
    let names: Vec<&String> = files.keys().collect();
    let headers: Vec<&&String> = names.iter().filter(|name| name.ends_with(".h")).collect();
    assert!(headers.len() > 2);
    for header in headers {
        let source = format!("{}.c", header.strip_suffix(".h").unwrap());
        assert!(names.contains(&&source), "{source} missing");
    }
}

#[test]
fn cjson_multi_source_no_generated_file_includes_itself() {
    for (filename, source) in &multi_source_pairs() {
        let includes = includes_in(source);
        assert!(!includes.contains(&format!("#include \"{filename}\"").as_str()));
        assert!(!includes.contains(&format!("#include <{filename}>").as_str()));
    }
}

#[test]
fn cjson_multi_source_generated_files_are_included_with_quotes() {
    let files = multi_source_pairs();
    for source in files.values() {
        for include in includes_in(source) {
            // Angle brackets are reserved for system and vendored headers;
            // a generated file must never appear in them.
            if let Some(file) = angle_include(include) {
                assert!(!files.contains_key(file), "{include}");
            }
        }
    }
}

#[test]
fn cjson_multi_source_each_source_file_includes_its_own_header_first() {
    for (filename, source) in &multi_source_pairs() {
        let Some(base) = filename.strip_suffix(".c") else {
            continue;
        };
        assert_eq!(
            includes_in(source).first().copied(),
            Some(format!("#include \"{base}.h\"").as_str())
        );
    }
}

#[test]
fn cjson_multi_source_header_only_emits_no_source_files() {
    let files = render_scenario("vitest-cjson-split-sources", 1);
    assert!(files.len() > 2);
    for (filename, source) in &files {
        assert!(filename.ends_with(".h"), "{filename}");
        let includes = includes_in(source);
        assert!(!includes.contains(&format!("#include \"{filename}\"").as_str()));
        assert!(!includes.contains(&format!("#include <{filename}>").as_str()));
    }
}

#[test]
fn cjson_source_filename_swaps_only_a_trailing_h() {
    // `.replace(".h", ".c")` would have produced "my.couse.h".
    let files = render_scenario("vitest-cjson-split-sources", 2);
    let mut names: Vec<&String> = files.keys().collect();
    names.sort();
    assert_eq!(names, ["my.house.c", "my.house.h"]);
}

#[test]
fn includes_in_matches_like_the_regular_expression() {
    assert_eq!(
        includes_in("#include <a.h>\n#include \"b.h\"\n#include x\n#include <>"),
        ["#include <a.h>", "#include \"b.h\""]
    );
    assert_eq!(angle_include("#include <a.h>"), Some("a.h"));
    assert_eq!(angle_include("#include \"a.h\""), None);
}
