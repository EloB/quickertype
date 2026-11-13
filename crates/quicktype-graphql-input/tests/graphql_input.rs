//! Differential tests of the GraphQL input against the TypeScript
//! reference.
//!
//! `xtask/graphql-input/run-graphql-inputs.mjs` ran the reference
//! `GraphQLInput` on every case of
//! `tests/fixtures/graphql-input/cases.json` (every query in
//! `tests/inputs/graphql` against the GitHub schema, hand-written queries
//! against small schemas, graphql-js syntax errors, malformed
//! introspection results) and recorded the type graph right after input
//! (`printGraph`, plus class properties, enum cases and top-levels), or the
//! error, in `expected/<id>.txt`. This test does the same with the Rust
//! port and compares byte for byte. Node is not needed.
//!
//! Paths in the cases are relative to the repository root.

use std::path::{Path, PathBuf};

use quicktype_core::internal::capture_console;
use quicktype_core::ty::type_builder::TypeBuilder;
use quicktype_core::ty::type_builder_utils::get_no_string_type_mapping;
use quicktype_core::ty::type_graph::TypeGraph;
use quicktype_core::ty::type_ref::TypeRef;
use quicktype_core::{Input, QuickTypeError, Result, RunContext, parse_json};
use quicktype_graphql_input::graphql::get_introspection_query;
use quicktype_graphql_input::{GraphQlInput, GraphQlSourceData};
use quicktype_js_compat::json::{self, JsonValue};
use serde_json::Value;

fn repo_root() -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("../..")
}

fn fixture_dir() -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/fixtures/graphql-input")
}

fn manifest() -> Value {
    let text = std::fs::read_to_string(fixture_dir().join("cases.json")).expect("cases.json");
    serde_json::from_str(&text).expect("valid JSON")
}

/// The schema of a source, read like `--graphql-schema`.
fn schema_of(source: &Value) -> Result<JsonValue> {
    if let Some(file) = source.get("schemaFile").and_then(Value::as_str) {
        let text = std::fs::read_to_string(repo_root().join(file)).expect("schema file");
        return parse_json(&text, "GraphQL schema", Some(file));
    }
    let text = source["schemaText"].as_str().expect("schema text");
    parse_json(text, "GraphQL schema", None)
}

/// The class of an error as the recorder writes it.
fn error_class(e: &QuickTypeError) -> &'static str {
    match e.as_js_exception() {
        Some(exception) => exception.name().as_str(),
        None => "QuickTypeError",
    }
}

/// Class properties and enum cases, like `propertyLines` in the recorder.
fn property_lines(graph: &TypeGraph) -> Result<Vec<String>> {
    let mut lines = Vec::new();
    for i in 0..graph.len() {
        let t = graph.type_at(TypeRef::new(graph.serial(), i)?)?;
        if t.is_object_type() {
            let props = JsonValue::Array(
                t.properties()?
                    .iter()
                    .map(|(name, p)| {
                        JsonValue::Array(vec![
                            JsonValue::String(name.clone()),
                            JsonValue::Number(p.type_ref.index() as f64),
                            JsonValue::Bool(p.is_optional),
                        ])
                    })
                    .collect(),
            );
            lines.push(format!("{i} properties {}", json::stringify(&props, None)));
        } else if t.is_enum() {
            let cases = JsonValue::Array(
                t.cases()?
                    .iter()
                    .map(|c| JsonValue::String(c.clone()))
                    .collect(),
            );
            lines.push(format!("{i} cases {}", json::stringify(&cases, None)));
        }
    }
    Ok(lines)
}

/// Runs one case like `run-graphql-inputs.mjs` does and returns its output.
fn run_case(case: &Value) -> String {
    let (result, mut lines): (Result<()>, Vec<String>) = capture_console(|| {
        let mut input = GraphQlInput::new();
        for source in case["sources"].as_array().expect("sources") {
            input.add_source_sync(GraphQlSourceData {
                name: source["name"].as_str().expect("a name").to_owned(),
                schema: schema_of(source)?,
                query: source["query"].as_str().expect("a query").to_owned(),
            });
        }
        let stm = get_no_string_type_mapping();
        let mut builder = TypeBuilder::new(stm.clone(), false, false, true, false)?;
        let ctx = RunContext::new(stm);
        Input::add_types_sync(&mut input, &ctx, &mut builder, false, false, false)?;
        quicktype_core::console_log(&format!(
            "# kind {}; needIR {}; needSchemaProcessing {}",
            input.kind(),
            input.need_ir(),
            input.need_schema_processing()
        ));
        quicktype_core::console_log("# graph");
        let graph = builder.finish()?;
        graph.print_graph()?;
        quicktype_core::console_log("# properties");
        for line in property_lines(&graph)? {
            quicktype_core::console_log(&line);
        }
        quicktype_core::console_log("# top-levels");
        for (name, t) in graph.top_levels() {
            quicktype_core::console_log(&format!("{}: {}", json::quote(name), t.index()));
        }
        Ok(())
    });
    if let Err(e) = result {
        lines.push(format!("error: {} {}", error_class(&e), e.user_message()));
    }
    let mut text = lines.join("\n");
    text.push('\n');
    text
}

#[test]
fn graphql_input_matches_the_reference() {
    let manifest = manifest();
    let cases = manifest["cases"].as_array().expect("cases");
    assert!(cases.len() > 200, "the manifest lists every case");
    let mut failures = Vec::new();
    for case in cases {
        let id = case["id"].as_str().expect("an id");
        let expected =
            std::fs::read_to_string(fixture_dir().join("expected").join(format!("{id}.txt")))
                .expect("expected output");
        let actual = run_case(case);
        if actual != expected {
            failures.push(format!("--- {id}\nexpected:\n{expected}actual:\n{actual}"));
        }
    }
    assert!(
        failures.is_empty(),
        "{} of {} cases differ:\n{}",
        failures.len(),
        cases.len(),
        failures.join("\n")
    );
}

/// Where the TypeScript loops forever (a fragment that spreads itself
/// without a field in between), the port fails instead.
#[test]
fn self_spreading_fragments_fail() {
    let manifest = manifest();
    for case in manifest["nonTerminating"]
        .as_array()
        .expect("nonTerminating")
    {
        let output = run_case(case);
        assert!(
            output.ends_with("spreads itself, which never terminates.\n"),
            "{}: {output}",
            case["id"]
        );
    }
}

#[test]
fn introspection_query_is_graphql_js_s() {
    let manifest = manifest();
    assert_eq!(
        get_introspection_query(),
        manifest["introspectionQuery"].as_str().expect("the query")
    );
}

/// A recorded syntax error: its message and position.
type SyntaxError = (String, Option<usize>);

/// graphql-js's `parse` on seeded mutations of valid documents
/// (`parse-vectors.json`): the port accepts the same documents and rejects
/// the others with the same message at the same position.
#[test]
fn parser_matches_graphql_js() {
    let text = std::fs::read_to_string(fixture_dir().join("parse-vectors.json")).expect("vectors");
    let vectors: Vec<(String, Option<SyntaxError>)> =
        serde_json::from_str(&text).expect("valid JSON");
    assert!(vectors.len() > 2000);
    let mut failures = Vec::new();
    for (source, expected) in &vectors {
        let actual = quicktype_graphql_input::graphql::parse(source)
            .err()
            .map(|e| (e.message().to_owned(), Some(e.position())));
        if &actual != expected {
            failures.push(format!(
                "{source:?}\n  expected {expected:?}\n  actual   {actual:?}"
            ));
        }
    }
    assert!(
        failures.is_empty(),
        "{} of {} vectors differ:\n{}",
        failures.len(),
        vectors.len(),
        failures
            .iter()
            .take(20)
            .cloned()
            .collect::<Vec<_>>()
            .join("\n")
    );
}

/// Far deeper than Node's stack allows (see `docs/PARITY.md`, Known gaps):
/// nested selection sets and `ofType` chains build without overflowing the
/// native stack, on a test thread's small stack.
#[test]
fn deep_queries_and_schemas_do_not_overflow() {
    let depth = 50_000;
    let schema_text = std::fs::read_to_string(fixture_dir().join("schemas/basic.gqlschema"))
        .expect("the basic schema");
    let query = format!(
        "{{ viewer {}{{ name }}{} }}",
        "{ best ".repeat(depth),
        " }".repeat(depth)
    );
    let mut input = GraphQlInput::new();
    input.add_source_sync(GraphQlSourceData {
        name: "Deep".to_owned(),
        schema: parse_json(&schema_text, "GraphQL schema", None).unwrap(),
        query,
    });
    let mut builder =
        TypeBuilder::new(get_no_string_type_mapping(), false, false, false, false).unwrap();
    input.add_types_sync(&mut builder).unwrap();
    assert!(builder.len() > 2 * depth);

    // `[[[...Int...]]]` as nested `ofType`s.
    let mut wrapped = String::from(r#"{"kind": "SCALAR", "name": "Int"}"#);
    for _ in 0..depth {
        wrapped = format!(r#"{{"kind": "LIST", "ofType": {wrapped}}}"#);
    }
    let schema = format!(
        r#"{{"data": {{"__schema": {{"queryType": {{"name": "Q"}}, "mutationType": null, "types": [
            {{"kind": "OBJECT", "name": "Q", "fields": [{{"name": "a", "args": [], "type": {wrapped}}}]}},
            {{"kind": "SCALAR", "name": "Int"}}]}}}}}}"#
    );
    let mut input = GraphQlInput::new();
    input.add_source_sync(GraphQlSourceData {
        name: "Lists".to_owned(),
        schema: parse_json(&schema, "GraphQL schema", None).unwrap(),
        query: "{ a }".to_owned(),
    });
    let mut builder =
        TypeBuilder::new(get_no_string_type_mapping(), false, false, false, false).unwrap();
    input.add_types_sync(&mut builder).unwrap();
    assert!(builder.len() > 2 * depth);
}
