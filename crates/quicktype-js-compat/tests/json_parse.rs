//! Replays the `JSON.parse` vectors recorded from Node by
//! `xtask/core-json-input/gen-json-parse-vectors.mjs`: for every input,
//! either the parsed value (serialized in own-property order) or V8's
//! `SyntaxError` message must match.

use std::path::Path;

use quicktype_js_compat::json;
use serde_json::Value;

#[test]
fn json_parse_matches_v8() {
    // The parser and dropping a value are iterative, but `stringify` recurses,
    // and some vectors nest 5,000 levels deep.
    std::thread::Builder::new()
        .stack_size(256 << 20)
        .spawn(replay)
        .expect("spawn")
        .join()
        .expect("replay");
}

fn replay() {
    let path = Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/vectors/json_parse.json");
    let text = std::fs::read_to_string(&path).expect("vectors");
    let vectors: Vec<Value> = serde_json::from_str(&text).expect("vectors are JSON");
    let mut mismatches = Vec::new();
    for vector in &vectors {
        let input = vector["input"].as_str().expect("input");
        let expected = match (&vector["ok"], &vector["error"]) {
            (Value::String(ok), _) => Ok(ok.as_str()),
            (_, Value::String(error)) => Err(error.as_str()),
            _ => panic!("malformed vector {vector}"),
        };
        let actual = json::parse(input).map(|v| json::stringify(&v, None));
        let matches = match (&actual, expected) {
            (Ok(a), Ok(e)) => a == e,
            (Err(a), Err(e)) => a.message() == e,
            _ => false,
        };
        if !matches {
            mismatches.push(format!(
                "input {input:?}\n  expected {expected:?}\n  actual   {:?}",
                actual.as_ref().map_err(|e| e.message())
            ));
        }
    }
    assert!(
        mismatches.is_empty(),
        "{} of {} vectors differ:\n{}",
        mismatches.len(),
        vectors.len(),
        mismatches
            .iter()
            .take(20)
            .cloned()
            .collect::<Vec<_>>()
            .join("\n")
    );
}
