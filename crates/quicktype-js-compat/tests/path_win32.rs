//! Replays the vectors `xtask/js-compat/gen-path-win32-vectors.mjs` records
//! from Node's `path.win32`.

use std::path::Path;

use quicktype_js_compat::path_win32;
use serde_json::Value;

#[test]
fn matches_nodes_path_win32() {
    let path = Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/vectors/path_win32.json");
    let vectors: Value = serde_json::from_str(&std::fs::read_to_string(&path).unwrap()).unwrap();
    let mut failures = Vec::new();
    for case in vectors["paths"].as_array().unwrap() {
        let p = case["path"].as_str().unwrap();
        let got = [
            ("isAbsolute", Value::Bool(path_win32::is_absolute(p))),
            ("dirname", Value::from(path_win32::dirname(p))),
            ("basename", Value::from(path_win32::basename(p))),
            ("extname", Value::from(path_win32::extname(p))),
            ("normalize", Value::from(path_win32::normalize(p))),
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
        let got = path_win32::join(&args);
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
