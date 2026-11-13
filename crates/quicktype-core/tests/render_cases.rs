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

use quicktype_core::target_language::MultiFileRenderResult;
use render_support::{build_graph, first_difference, gather_and_render};
use serde_json::Value;

/// What the CLI's `writeOutput` prints for a render without `--out`,
/// modeled exactly: each file under a `// <name>` header when there are
/// several, separated by `"\n"` -- except with `--quiet`, where
/// `writeOutput` `continue`s before clearing its `onFirst` flag, so no
/// separator is ever printed.
fn join_stdout(result: &MultiFileRenderResult, quiet: bool) -> String {
    let mut out = String::new();
    let mut on_first = true;
    for (name, serialized) in result {
        if !on_first {
            out.push('\n');
        }
        if result.len() > 1 {
            out.push_str(&format!("// {name}\n\n"));
        }
        out.push_str(&serialized.lines.join("\n"));
        if quiet {
            continue;
        }
        on_first = false;
    }
    out
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
    // way the CLI's `writeOutput` prints them, with the stdout golden
    // (`stdout`) or the recorded stdout (`stdoutText`).
    let stdout = match (fixture["stdout"].as_str(), fixture["stdoutText"].as_str()) {
        (Some(path), _) => Some(
            fs::read_to_string(golden_dir.join(path))
                .map_err(|e| format!("cannot read golden {path}: {e}"))?,
        ),
        (None, Some(text)) => Some(text.to_owned()),
        (None, None) => None,
    };
    let has_stdout = stdout.is_some();
    if let Some(expected) = stdout {
        let quiet = fixture["quiet"].as_bool().unwrap_or(false);
        let actual = join_stdout(&result, quiet);
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
            (None, None) if has_stdout => None,
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

#[test]
fn join_stdout_models_write_output() {
    let file = |lines: &[&str]| quicktype_core::source::SerializedRenderResult {
        lines: lines.iter().map(|&l| l.to_owned()).collect(),
        annotations: Vec::new(),
    };
    let mut result = MultiFileRenderResult::new();
    result.insert("A.java".to_owned(), file(&["a", ""]));
    result.insert("B.java".to_owned(), file(&["b", ""]));
    assert_eq!(
        join_stdout(&result, false),
        "// A.java\n\na\n\n// B.java\n\nb\n"
    );
    // `--quiet` skips `onFirst = false`, so no separator is printed.
    assert_eq!(
        join_stdout(&result, true),
        "// A.java\n\na\n// B.java\n\nb\n"
    );
    result.shift_remove("B.java");
    assert_eq!(join_stdout(&result, false), "a\n");
    assert_eq!(join_stdout(&result, true), "a\n");
}
