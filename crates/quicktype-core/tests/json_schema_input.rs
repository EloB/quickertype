//! Differential tests of the JSON Schema input against the TypeScript
//! reference.
//!
//! `xtask/core-json-schema-input/run-schema-inputs.mjs` ran the reference
//! `JSONSchemaInput` on every case of
//! `tests/fixtures/core-json-schema-input/cases.json` (every schema in
//! `tests/inputs/schema`, the golden corpus's schema error cases, and
//! hand-written edge cases) and recorded the `--debug
//! print-schema-resolving` trace, the type graph right after input, or the
//! error, in `expected/<id>.txt`. This test does the same with the Rust
//! port and compares byte for byte. Node is not needed.
//!
//! Paths in the cases are relative to the repository root, which is this
//! test's working directory. Cases that fetch over the network are skipped,
//! with a message, when the network is unavailable (or the `http` feature
//! is off).

use std::path::{Path, PathBuf};

use quicktype_core::attributes::accessor_names::{
    AccessorEntry, AccessorNames, AccessorNamesTypeAttributeKind, UnionMemberNamesTypeAttributeKind,
};
use quicktype_core::attributes::constraints::PatternTypeAttributeKind;
use quicktype_core::attributes::enum_values::EnumValuesTypeAttributeKind;
use quicktype_core::attributes::type_attributes::AttributeKind;
use quicktype_core::attributes::type_names::init_type_names;
use quicktype_core::attributes::uri_attributes::UriTypeAttributeKind;
use quicktype_core::input::fetching_json_schema_store::FetchingJsonSchemaStore;
use quicktype_core::input::io::block_on;
use quicktype_core::input::json_schema_input::{JsonSchemaInput, JsonSchemaSourceData};
use quicktype_core::input::json_schema_store::JsonSchemaStore;
use quicktype_core::messages::Result;
use quicktype_core::support::support::{capture_console, console_log};
use quicktype_core::ty::type_builder::TypeBuilder;
use quicktype_core::ty::type_builder_utils::{StringTypeMapping, get_no_string_type_mapping};
use quicktype_core::ty::type_graph::TypeGraph;
use quicktype_core::ty::type_ref::TypeRef;
use quicktype_js_compat::json::{self, JsonValue};
use serde_json::Value;

fn repo_root() -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("../..")
}

fn fixture_dir() -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/fixtures/core-json-schema-input")
}

fn strings(v: Option<&Value>) -> Option<Vec<String>> {
    v.and_then(Value::as_array).map(|items| {
        items
            .iter()
            .map(|s| s.as_str().expect("a string").to_owned())
            .collect()
    })
}

fn source(v: &Value) -> JsonSchemaSourceData {
    JsonSchemaSourceData {
        name: v["name"].as_str().expect("a name").to_owned(),
        uris: strings(v.get("uris")),
        schema: v.get("schema").and_then(Value::as_str).map(str::to_owned),
        is_converted: v.get("isConverted").and_then(Value::as_bool) == Some(true),
    }
}

fn entry_json(e: &AccessorEntry) -> JsonValue {
    match e {
        AccessorEntry::Name(n) => JsonValue::String(n.clone()),
        AccessorEntry::ByLanguage(m) => JsonValue::Array(
            m.iter()
                .map(|(k, v)| {
                    JsonValue::Array(vec![
                        JsonValue::String(k.clone()),
                        JsonValue::String(v.clone()),
                    ])
                })
                .collect(),
        ),
    }
}

fn names_json(names: &AccessorNames) -> JsonValue {
    JsonValue::Array(
        names
            .iter()
            .map(|(k, e)| JsonValue::Array(vec![JsonValue::String(k.clone()), entry_json(e)]))
            .collect(),
    )
}

fn strings_json<'a>(items: impl IntoIterator<Item = &'a String>) -> JsonValue {
    JsonValue::Array(
        items
            .into_iter()
            .map(|s| JsonValue::String(s.clone()))
            .collect(),
    )
}

/// The attributes the graph printer does not show, like
/// `attributeLines` in `run-schema-inputs.mjs`.
fn attribute_lines(graph: &TypeGraph) -> Result<Vec<String>> {
    let mut lines = Vec::new();
    for i in 0..graph.len() {
        let attributes = graph.attributes(TypeRef::new(graph.serial(), i)?)?;
        let mut line = |name: &str, v: JsonValue| {
            lines.push(format!("{i} {name} {}", json::stringify(&v, None)))
        };
        if let Some(v) = AccessorNamesTypeAttributeKind.try_get_in_attributes(attributes) {
            line("accessorNames", names_json(v));
        }
        if let Some(v) = EnumValuesTypeAttributeKind.try_get_in_attributes(attributes) {
            line("enumValues", names_json(v));
        }
        if let Some(v) = UnionMemberNamesTypeAttributeKind.try_get_in_attributes(attributes) {
            line(
                "unionMemberNames",
                JsonValue::Array(v.values().map(entry_json).collect()),
            );
        }
        if let Some((protocols, extensions)) =
            UriTypeAttributeKind.try_get_in_attributes(attributes)
        {
            line(
                "uriAttributes",
                JsonValue::Array(vec![strings_json(protocols), strings_json(extensions)]),
            );
        }
        if let Some(v) = PatternTypeAttributeKind.try_get_in_attributes(attributes) {
            line("pattern", JsonValue::String(v.clone()));
        }
    }
    Ok(lines)
}

/// Runs one case like `run-schema-inputs.mjs` does and returns its output.
fn run_case(case: &Value) -> String {
    init_type_names();
    let (result, mut lines): (Result<()>, Vec<String>) = capture_console(|| {
        block_on(async {
            let store: Option<Box<dyn JsonSchemaStore>> =
                if case.get("store").and_then(Value::as_bool) == Some(false) {
                    None
                } else {
                    Some(Box::new(FetchingJsonSchemaStore::new(Vec::new())))
                };
            let additional = strings(case.get("additional")).unwrap_or_default();
            let mut input = JsonSchemaInput::new(store, Vec::new(), additional);
            for s in case["sources"].as_array().expect("sources") {
                input.add_source(source(s)).await?;
            }
            let stm = if case.get("stm").and_then(Value::as_str) == Some("string") {
                StringTypeMapping::new()
            } else {
                get_no_string_type_mapping()
            };
            let alphabetize = case.get("alphabetize").and_then(Value::as_bool) == Some(true);
            let mut builder = TypeBuilder::new(stm, alphabetize, false, true, false)?;
            input.add_types(&mut builder, true, None).await?;
            let single = input.single_string_schema_source().map_or_else(
                || "null".to_owned(),
                |s| quicktype_js_compat::json::quote(&s),
            );
            console_log(&format!(
                "# needIR {}; single string source {single}",
                input.need_ir()
            ));
            console_log("# graph");
            let graph = builder.finish()?;
            graph.print_graph()?;
            console_log("# attributes");
            for line in attribute_lines(&graph)? {
                console_log(&line);
            }
            Result::Ok(())
        })
    });
    if let Err(e) = result {
        lines.push(format!("error: {}", e.user_message()));
    }
    let mut text = lines.join("\n");
    text.push('\n');
    text
}

/// Whether the network cases can run: the `http` feature is on and the
/// remote schema they fetch is reachable.
fn network_available() -> bool {
    if !cfg!(feature = "http") {
        return false;
    }
    let url = "https://raw.githubusercontent.com/quicktype/quicktype/master/test/inputs/schema/list.schema";
    block_on(quicktype_core::input::io::node_io::read_from_file_or_url(
        &quicktype_core::input::io::node_io::StdIo,
        url,
        &[],
    ))
    .is_ok()
}

/// The first line where `got` and `want` differ, for the failure report.
fn first_difference(got: &str, want: &str) -> String {
    for (i, (g, w)) in got.lines().zip(want.lines()).enumerate() {
        if g != w {
            return format!("line {}:\n    got:  {g}\n    want: {w}", i + 1);
        }
    }
    format!(
        "lengths differ: got {} lines, want {}",
        got.lines().count(),
        want.lines().count()
    )
}

#[test]
fn json_schema_input_matches_reference() {
    // Deep schemas recurse deeply; give the run a large stack, and run it
    // in the repository root, where the cases' paths are relative to.
    let handle = std::thread::Builder::new()
        .stack_size(256 * 1024 * 1024)
        .spawn(|| {
            std::env::set_current_dir(repo_root()).expect("repository root");
            let manifest =
                std::fs::read_to_string(fixture_dir().join("cases.json")).expect("cases.json");
            let cases: Vec<Value> = serde_json::from_str(&manifest).expect("valid manifest");
            let network = network_available();
            let mut failures = Vec::new();
            let mut skipped = Vec::new();
            let mut matched = 0;
            for case in &cases {
                let id = case["id"].as_str().expect("an id");
                if case.get("network").and_then(Value::as_bool) == Some(true) && !network {
                    skipped.push(id.to_owned());
                    continue;
                }
                let want =
                    std::fs::read_to_string(fixture_dir().join(format!("expected/{id}.txt")))
                        .unwrap_or_else(|e| panic!("expected/{id}.txt: {e}"));
                let got = run_case(case);
                if got == want {
                    matched += 1;
                } else {
                    failures.push(format!("{id}: {}", first_difference(&got, &want)));
                }
            }
            if !skipped.is_empty() {
                eprintln!(
                    "skipped {} network case(s) (offline or no `http` feature): {}",
                    skipped.len(),
                    skipped.join(", ")
                );
            }
            eprintln!(
                "JSON Schema input: {matched} of {} cases match the reference byte for byte",
                cases.len() - skipped.len()
            );
            failures
        })
        .expect("spawn test thread");
    let failures = handle.join().expect("test thread");
    assert!(
        failures.is_empty(),
        "{} case(s) differ:\n{}",
        failures.len(),
        failures.join("\n")
    );
}
