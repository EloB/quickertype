//! Differential test: every case in `tests/corpus` must produce exactly the
//! schema (or error) the reference recorded in its `expected.json`
//! (`xtask/typescript-input/record.mjs`: quicktype-typescript-input on
//! TypeScript 5.9.3 and typescript-json-schema 0.67.4).
//!
//! The corpus: `golden-*` are TypeScript outputs from `tests/golden` (every
//! schema, GraphQL and comment-injection one; the JSON fixture's priority
//! and sample inputs, every tenth misc input, and `--readonly` and
//! `--prefer-types` variants of the union-heavy `combinations*` inputs);
//! `json-ts-*` are the `--just-types` TypeScript files that step 0 of
//! quicktype's `json-ts-csharp` fixture feeds back in; `unit-*` come from
//! quicktype's `test/unit/typescript-input.test.ts`; `feature-*` and
//! `error-*` are hand-written cases for typescript-json-schema features and
//! compiler errors; `order-*` exercise the TypeScript 5.9 union-order
//! emulation (`tjs::order`).
//!
//! Needs the TypeScript 7.0.2 compiler: `$QUICKTYPE_TSC`, the usual lookup
//! from this crate's directory, or `node_modules` of a sibling `quicktype`
//! checkout (the layout `cargo xtask golden` uses). Without one the test is
//! skipped with a message.
//!
//! Cases listed in `tests/known-differences.txt` are expected to differ; the
//! test fails if one of them starts to match, so the list stays exact.
//!
//! `TS_INPUT_FILTER=<substring>` runs only matching cases;
//! `TS_INPUT_CORPUS=<dir>` runs another corpus recorded the same way;
//! `TS_INPUT_DUMP=<dir>` writes `<case>.expected`/`<case>.actual` for every
//! differing case there.

use std::path::{Path, PathBuf};
use std::sync::Mutex;

use quicktype_typescript_input::schema_for_typescript_sources_in;
use quicktype_typescript_input::tsc::locate;
use serde_json::Value;

fn find_tsc(crate_dir: &Path) -> Option<PathBuf> {
    if std::env::var_os(locate::TSC_ENV).is_some() {
        return locate::locate(crate_dir).ok();
    }
    if let Ok(exe) = locate::locate(crate_dir) {
        return Some(exe);
    }
    crate_dir.ancestors().find_map(|dir| {
        let exe = locate::platform_package_exe(&dir.join("quicktype").join("node_modules"));
        (exe.is_file() && locate::has_pinned_version(&exe)).then_some(exe)
    })
}

/// The reference's result for a case, as one comparable string.
fn expected(dir: &Path) -> String {
    let text = std::fs::read_to_string(dir.join("expected.json")).expect("expected.json");
    let v: Value = serde_json::from_str(&text).expect("valid expected.json");
    let warnings = v["warnings"].as_array().cloned().unwrap_or_default();
    let warnings: Vec<String> = warnings
        .iter()
        .filter_map(|w| w.as_str().map(str::to_owned))
        .collect();
    match v["error"].as_str() {
        Some(e) => format!("error: {e}\nwarnings: {warnings:?}"),
        None => format!(
            "schema: {}\nname: {}\nuris: {:?}\nwarnings: {warnings:?}",
            v["schema"].as_str().unwrap_or_default(),
            v["name"].as_str().unwrap_or_default(),
            v["uris"]
                .as_array()
                .map(|a| a.iter().filter_map(Value::as_str).collect::<Vec<_>>())
                .unwrap_or_default(),
        ),
    }
}

fn actual(dir: &Path, tsc: &Path) -> String {
    let mut files: Vec<String> = std::fs::read_dir(dir)
        .expect("case directory")
        .filter_map(|e| e.ok()?.file_name().into_string().ok())
        .filter(|f| f.ends_with(".ts"))
        .collect();
    files.sort();
    match schema_for_typescript_sources_in(&files, dir, tsc) {
        Ok(out) => format!(
            "schema: {}\nname: {}\nuris: {:?}\nwarnings: {:?}",
            out.source.schema, out.source.name, out.source.uris, out.warnings
        ),
        Err(e) => format!(
            "error: {}\nwarnings: {:?}",
            e.message(),
            Vec::<String>::new()
        ),
    }
}

#[test]
fn corpus_matches_reference() {
    let crate_dir = Path::new(env!("CARGO_MANIFEST_DIR"));
    let Some(tsc) = find_tsc(crate_dir) else {
        eprintln!(
            "SKIPPED: TypeScript 7.0.2 compiler not found; set {} to run the TypeScript-input differential test",
            locate::TSC_ENV
        );
        return;
    };
    let custom_corpus = std::env::var_os("TS_INPUT_CORPUS").map(PathBuf::from);
    let corpus = custom_corpus
        .clone()
        .unwrap_or_else(|| crate_dir.join("tests/corpus"));
    let known: Vec<String> = std::fs::read_to_string(crate_dir.join("tests/known-differences.txt"))
        .unwrap_or_default()
        .lines()
        .map(str::trim)
        .filter(|l| !l.is_empty() && !l.starts_with('#'))
        .map(str::to_owned)
        .collect();
    let filter = std::env::var("TS_INPUT_FILTER").ok();
    let mut cases: Vec<String> = std::fs::read_dir(&corpus)
        .expect("tests/corpus")
        .filter_map(|e| e.ok())
        .filter(|e| e.path().is_dir())
        .filter_map(|e| e.file_name().into_string().ok())
        .filter(|c| filter.as_ref().is_none_or(|f| c.contains(f.as_str())))
        .collect();
    cases.sort();
    let queue = Mutex::new(cases.clone());
    let differing = Mutex::new(Vec::new());
    let threads = std::thread::available_parallelism()
        .map_or(4, |n| n.get())
        .min(8);
    std::thread::scope(|scope| {
        for _ in 0..threads {
            scope.spawn(|| {
                loop {
                    let Some(case) = queue.lock().unwrap().pop() else {
                        break;
                    };
                    let dir = corpus.join(&case);
                    let (want, got) = (expected(&dir), actual(&dir, &tsc));
                    if want != got {
                        differing.lock().unwrap().push((case, want, got));
                    }
                }
            });
        }
    });
    let mut differing = differing.into_inner().unwrap();
    differing.sort();
    if let Some(dump) = std::env::var_os("TS_INPUT_DUMP") {
        let dump = PathBuf::from(dump);
        std::fs::create_dir_all(&dump).expect("dump directory");
        for (case, want, got) in &differing {
            std::fs::write(dump.join(format!("{case}.expected")), want).expect("write");
            std::fs::write(dump.join(format!("{case}.actual")), got).expect("write");
        }
    }
    let same = cases.len() - differing.len();
    eprintln!(
        "TypeScript input: {same}/{} cases identical to the reference",
        cases.len()
    );
    let mut problems = Vec::new();
    for (case, want, got) in &differing {
        if !known.contains(case) {
            let first = want
                .lines()
                .zip(got.lines())
                .position(|(a, b)| a != b)
                .unwrap_or(0);
            let w: String = want
                .lines()
                .nth(first)
                .unwrap_or_default()
                .chars()
                .take(400)
                .collect();
            let g: String = got
                .lines()
                .nth(first)
                .unwrap_or_default()
                .chars()
                .take(400)
                .collect();
            problems.push(format!("{case}:\n  expected {w}\n  actual   {g}"));
        }
    }
    if filter.is_none() && custom_corpus.is_none() {
        for k in &known {
            if !differing.iter().any(|(c, _, _)| c == k) {
                problems.push(format!(
                    "{k}: listed in known-differences.txt but now matches; remove it"
                ));
            }
        }
    }
    assert!(
        problems.is_empty(),
        "{} unexpected results:\n{}",
        problems.len(),
        problems.join("\n")
    );
}
