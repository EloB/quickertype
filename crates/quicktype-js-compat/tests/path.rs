//! Replays the vectors `xtask/js-compat/gen-path-vectors.mjs` records from
//! Node's `path.win32` and `path.posix`, on every platform.

use std::path::Path;

use quicktype_js_compat::{path_posix, path_win32};
use serde_json::Value;

/// One flavor of Node's `path`.
struct PathModule {
    is_absolute: fn(&str) -> bool,
    dirname: fn(&str) -> &str,
    basename: fn(&str) -> &str,
    extname: fn(&str) -> &str,
    normalize: fn(&str) -> String,
    join: fn(&[&str]) -> String,
}

fn replay(vectors: &str, module: &PathModule) {
    let path = Path::new(env!("CARGO_MANIFEST_DIR"))
        .join("tests/vectors")
        .join(vectors);
    let vectors: Value = serde_json::from_str(&std::fs::read_to_string(&path).unwrap()).unwrap();
    let mut failures = Vec::new();
    for case in vectors["paths"].as_array().unwrap() {
        let p = case["path"].as_str().unwrap();
        let got = [
            ("isAbsolute", Value::Bool((module.is_absolute)(p))),
            ("dirname", Value::from((module.dirname)(p))),
            ("basename", Value::from((module.basename)(p))),
            ("extname", Value::from((module.extname)(p))),
            ("normalize", Value::from((module.normalize)(p))),
        ];
        for (name, value) in got {
            if case[name] != value {
                failures.push(format!("{name}({p:?}) = {value}, Node: {}", case[name]));
            }
        }
    }
    for case in vectors["joins"].as_array().unwrap() {
        let args: Vec<&str> = case["args"]
            .as_array()
            .unwrap()
            .iter()
            .map(|a| a.as_str().unwrap())
            .collect();
        let got = (module.join)(&args);
        if case["join"] != got.as_str() {
            failures.push(format!("join({args:?}) = {got:?}, Node: {}", case["join"]));
        }
    }
    assert!(
        failures.is_empty(),
        "{} differences:\n{}",
        failures.len(),
        failures.join("\n")
    );
}

#[test]
fn matches_nodes_path_win32() {
    replay(
        "path_win32.json",
        &PathModule {
            is_absolute: path_win32::is_absolute,
            dirname: path_win32::dirname,
            basename: path_win32::basename,
            extname: path_win32::extname,
            normalize: path_win32::normalize,
            join: path_win32::join,
        },
    );
}

#[test]
fn matches_nodes_path_posix() {
    replay(
        "path_posix.json",
        &PathModule {
            is_absolute: path_posix::is_absolute,
            dirname: path_posix::dirname,
            basename: path_posix::basename,
            extname: path_posix::extname,
            normalize: path_posix::normalize,
            join: path_posix::join,
        },
    );
}
