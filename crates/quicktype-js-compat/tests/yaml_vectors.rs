//! Replays the `YAML.parse` vectors recorded from Node (yaml 2.9.0) by
//! `xtask/core-json-schema-input/gen-yaml-vectors.mjs`. Values must be
//! identical, including object key order, `-0`, `NaN` and `Infinity`;
//! for errors only the fact that one is thrown is compared (the messages
//! are a documented difference).

use std::path::Path;

use quicktype_js_compat::json::JsonValue;
use quicktype_js_compat::{number, yaml};
use serde_json::{Value, json};

/// The encoding of `gen-yaml-vectors.mjs`.
fn encode(v: &JsonValue) -> Value {
    match v {
        JsonValue::Null => Value::Null,
        JsonValue::Bool(b) => Value::Bool(*b),
        JsonValue::String(s) => Value::String(s.clone()),
        JsonValue::Number(n) => {
            let repr = if *n == 0.0 && n.is_sign_negative() {
                "-0".to_owned()
            } else {
                number::to_string(*n)
            };
            json!({ "n": repr })
        }
        JsonValue::Array(items) => json!({ "a": items.iter().map(encode).collect::<Vec<_>>() }),
        JsonValue::Object(map) => json!({
            "o": map.iter().map(|(k, v)| json!([k, encode(v)])).collect::<Vec<_>>()
        }),
    }
}

#[test]
fn yaml_parse_matches_yaml_2_9() {
    let root = Path::new(env!("CARGO_MANIFEST_DIR"));
    let text = std::fs::read_to_string(root.join("tests/vectors/yaml.json")).expect("vectors");
    let cases: Vec<Value> = serde_json::from_str(&text).expect("valid JSON");
    let mut failures = Vec::new();
    for case in &cases {
        let input = match (case.get("text"), case.get("path")) {
            (Some(Value::String(t)), _) => t.clone(),
            (_, Some(Value::String(p))) => {
                let text = std::fs::read_to_string(root.join("../..").join(p)).expect("input file");
                text.strip_prefix('\u{feff}')
                    .map(str::to_owned)
                    .unwrap_or(text)
            }
            _ => panic!("bad case {case}"),
        };
        let got = yaml::parse(&input);
        let ok = match (&got, case.get("ok"), case.get("err")) {
            (Ok(v), Some(want), _) => &encode(v) == want,
            (Err(_), None, Some(_)) => true,
            _ => false,
        };
        if !ok {
            let label = case
                .get("path")
                .map_or_else(|| format!("{input:?}"), |p| p.to_string());
            failures.push(format!(
                "{label}: got {:?}, want {}",
                got.map(|v| encode(&v)).map_err(|e| e.to_string()),
                case.get("ok")
                    .map_or_else(|| format!("error {}", case["message"]), |v| v.to_string())
            ));
        }
    }
    assert!(
        failures.is_empty(),
        "{} of {} cases differ:\n{}",
        failures.len(),
        cases.len(),
        failures
            .iter()
            .take(60)
            .cloned()
            .collect::<Vec<_>>()
            .join("\n")
    );
}
