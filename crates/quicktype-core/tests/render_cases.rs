//! Differential renderer tests on real inputs.
//!
//! `xtask/core-rendering/record-render-cases.mjs` ran the reference CLI on
//! every golden case of the ported languages and dumped the type graph that
//! reached name gathering, plus the arguments and results of
//! `renderGraphAndSerialize`. This test rebuilds each graph, runs the Rust
//! `gather_names` and renderer on it and compares every file byte for byte
//! with the golden recording (and, for cases without `--quiet`, the issue
//! annotations that the CLI prints to stderr). Node is not needed.
//!
//! Set `RENDER_CASES_FILTER=<substring>` to run a subset.

mod render_support;

use std::fs;
use std::path::Path;

use render_support::{build_graph, first_difference, gather_and_render};
use serde_json::Value;

/// The CLI's stdout for a multi-file result (`writeOutput` without `--out`):
/// every file under a `// <name>` header, separated by a blank line.
fn join_stdout(result: &quicktype_core::target_language::MultiFileRenderResult) -> String {
    let several = result.len() > 1;
    result
        .iter()
        .map(|(name, serialized)| {
            let text = serialized.lines.join("\n");
            if several {
                format!("// {name}\n\n{text}")
            } else {
                text
            }
        })
        .collect::<Vec<_>>()
        .join("\n")
}

fn run_case(fixture: &Value, golden_dir: &Path) -> Result<(), String> {
    let mut graph = build_graph(&fixture["graph"]).map_err(|e| format!("graph: {e}"))?;
    let result = gather_and_render(&mut graph, &fixture["gather"], &fixture["render"])
        .map_err(|e| format!("render: {e}"))?;
    let files = fixture["files"].as_array().ok_or("no files")?;
    let names: Vec<&String> = result.keys().collect();
    let expected_names: Vec<&str> = files.iter().filter_map(|f| f["name"].as_str()).collect();
    if names != expected_names {
        return Err(format!("files {names:?}, expected {expected_names:?}"));
    }
    // Several files printed to stdout (no `--out`): compare them joined the
    // way the CLI's `writeOutput` prints them.
    if let Some(stdout) = fixture["stdout"].as_str() {
        let expected = fs::read_to_string(golden_dir.join(stdout))
            .map_err(|e| format!("cannot read golden {stdout}: {e}"))?;
        let actual = join_stdout(&result);
        if actual != expected {
            return Err(format!(
                "stdout differs at {}",
                first_difference(&expected, &actual)
            ));
        }
    }
    for file in files {
        let name = file["name"].as_str().unwrap_or_default();
        let serialized = &result[name];
        let expected = match (file["golden"].as_str(), file["text"].as_str()) {
            (Some(golden), _) => Some(
                fs::read_to_string(golden_dir.join(golden))
                    .map_err(|e| format!("cannot read golden {golden}: {e}"))?,
            ),
            (None, Some(text)) => Some(text.to_owned()),
            (None, None) if fixture["stdout"].is_string() => None,
            (None, None) => return Err(format!("{name}: no golden or text")),
        };
        let actual = serialized.lines.join("\n");
        if let Some(expected) = expected
            && actual != expected
        {
            return Err(format!(
                "{name} differs at {}",
                first_difference(&expected, &actual)
            ));
        }
        if let Some(annotations) = file["annotations"].as_array() {
            let actual: Vec<Value> = serialized
                .annotations
                .iter()
                .map(|a| {
                    serde_json::json!([
                        a.annotation.message(),
                        a.span.start.line,
                        a.span.start.column,
                        a.span.end.line,
                        a.span.end.column
                    ])
                })
                .collect();
            if &actual != annotations {
                return Err(format!(
                    "{name}: annotations differ\n    expected: {annotations:?}\n    actual:   {actual:?}"
                ));
            }
        }
    }
    Ok(())
}

#[test]
fn render_cases_match_reference() {
    let manifest = Path::new(env!("CARGO_MANIFEST_DIR"));
    let dir = manifest.join("tests/fixtures/core-rendering/cases");
    let golden_dir = manifest.join("../../tests/golden");
    let filter = std::env::var("RENDER_CASES_FILTER").unwrap_or_default();
    let mut entries: Vec<_> = fs::read_dir(&dir)
        .unwrap()
        .map(|e| e.unwrap().path())
        .collect();
    entries.sort();

    let mut total = 0;
    let mut failures = Vec::new();
    for path in entries {
        let text = fs::read_to_string(&path).unwrap();
        let fixture: Value = serde_json::from_str(&text).unwrap();
        let id = fixture["id"].as_str().unwrap_or_default().to_owned();
        if !id.contains(&filter) {
            continue;
        }
        total += 1;
        if let Err(message) = run_case(&fixture, &golden_dir) {
            failures.push(format!("{id}: {message}"));
        }
    }
    println!(
        "render cases: {} of {total} match the reference",
        total - failures.len()
    );
    assert!(total > 0, "no render cases found");
    assert!(
        failures.is_empty(),
        "{} of {total} render case(s) differ:\n{}",
        failures.len(),
        failures.join("\n")
    );
}
