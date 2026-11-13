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
//! Set `RENDER_CASES_FILTER=<substring>` to run a subset, and
//! `RENDER_CASES_LANG=<lang>[,<lang>...]` to run only the cases rendered
//! with those languages (any of a language's names: `ts` selects the
//! `typescript` cases). With `RENDER_CASES_DUMP=<dir>`, the actual output
//! of every differing file is written to `<dir>/<case id>.<file name>`.

mod render_support;

use std::fs;
use std::path::Path;

use quicktype_core::language::all::{ALL, language_named};
use render_support::{build_graph, first_difference, gather_and_render};
use serde_json::Value;

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
    for file in files {
        let name = file["name"].as_str().unwrap_or_default();
        let expected = match file["golden"].as_str() {
            Some(golden) => fs::read_to_string(golden_dir.join(golden))
                .map_err(|e| format!("cannot read golden {golden}: {e}"))?,
            None => file["text"].as_str().unwrap_or_default().to_owned(),
        };
        let serialized = &result[name];
        let actual = serialized.lines.join("\n");
        if actual != expected {
            let mut message = format!("{name} differs at {}", first_difference(&expected, &actual));
            if let Ok(dir) = std::env::var("RENDER_CASES_DUMP") {
                let id = fixture["id"]
                    .as_str()
                    .unwrap_or_default()
                    .replace('/', "__");
                let path = Path::new(&dir).join(format!("{id}.{name}"));
                if let Err(e) = fs::create_dir_all(&dir).and_then(|()| fs::write(&path, &actual)) {
                    message.push_str(&format!("\n    cannot dump to {}: {e}", path.display()));
                }
            }
            return Err(message);
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
    // The canonical names (what the recorder stores) of the requested
    // languages, resolved through every name of each language.
    let langs: Vec<&str> = std::env::var("RENDER_CASES_LANG")
        .unwrap_or_default()
        .split(',')
        .filter(|l| !l.is_empty())
        .map(|l| match language_named(l, &ALL) {
            Some(language) => language.name(),
            None => panic!("RENDER_CASES_LANG: unknown language {l:?}"),
        })
        .collect();
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
        let lang = fixture["render"]["lang"].as_str().unwrap_or_default();
        if !langs.is_empty() && !langs.contains(&lang) {
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
