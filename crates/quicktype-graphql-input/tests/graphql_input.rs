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
use quicktype_core::{
    Input, InputData, Options, QuickTypeError, Result, RunContext, get_target_language, parse_json,
    quicktype_multi_file_sync,
};
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

/// Deeper than Node's stack allows (see "Stack depth" in
/// `docs/PARITY.md`), the input fails with V8's `RangeError` where
/// TypeScript does, on a test thread's small stack: nested selection sets
/// in the parser, `ofType` chains in `makeType` (7,459 wrappers still
/// build) and, in the run, the graph rewriting that TypeScript overflows in
/// at about 400 nested lists. Before, a chain of 100,000 list
/// types aborted the CLI, 3,000 nested selection sets took it minutes.
#[test]
fn deep_queries_and_schemas_fail_like_node() {
    let overflow = ("RangeError", "Maximum call stack size exceeded");
    let schema_text = std::fs::read_to_string(fixture_dir().join("schemas/basic.gqlschema"))
        .expect("the basic schema");
    let depth = 50_000;
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
    let e = input.add_types_sync(&mut builder).unwrap_err();
    assert_eq!((error_class(&e), e.user_message()), overflow);

    // `[[[...Int...]]]` as `depth` nested `ofType`s.
    let source = |depth: usize| {
        let mut wrapped = String::from(r#"{"kind": "SCALAR", "name": "Int"}"#);
        for _ in 0..depth {
            wrapped = format!(r#"{{"kind": "LIST", "ofType": {wrapped}}}"#);
        }
        let schema = format!(
            r#"{{"data": {{"__schema": {{"queryType": {{"name": "Q"}}, "mutationType": null, "types": [
                {{"kind": "OBJECT", "name": "Q", "fields": [{{"name": "a", "args": [], "type": {wrapped}}}]}},
                {{"kind": "SCALAR", "name": "Int"}}]}}}}}}"#
        );
        GraphQlSourceData {
            name: "Lists".to_owned(),
            schema: parse_json(&schema, "GraphQL schema", None).unwrap(),
            query: "{ a }".to_owned(),
        }
    };
    let add_types = |depth| {
        let mut input = GraphQlInput::new();
        input.add_source_sync(source(depth));
        let mut builder =
            TypeBuilder::new(get_no_string_type_mapping(), false, false, false, false).unwrap();
        input.add_types_sync(&mut builder).map(|()| builder.len())
    };
    assert!(add_types(7_459).unwrap() > 2 * 7_459);
    for depth in [7_460, 100_000] {
        let e = add_types(depth).unwrap_err();
        assert_eq!((error_class(&e), e.user_message()), overflow);
    }

    let mut input = GraphQlInput::new();
    input.add_source_sync(source(7_459));
    let mut input_data = InputData::new();
    input_data.add_input(input);
    let lang = get_target_language("go").unwrap();
    let e = quicktype_multi_file_sync(Options::new(lang, input_data)).unwrap_err();
    assert_eq!((error_class(&e), e.user_message()), overflow);
}

/// A chain of 40,000 fragments, each spreading the next, is expanded in
/// linear time (cycle detection once looked through every enclosing
/// expansion at each spread). The reference takes about 0.5 s; the bound
/// is generous for debug builds.
#[test]
fn long_fragment_chains_are_linear() {
    let length = 40_000;
    let mut query = String::from("{ viewer { ...F0 } }\n");
    for i in 0..length {
        let next = if i + 1 < length {
            format!("...F{}", i + 1)
        } else {
            "name".to_owned()
        };
        query.push_str(&format!("fragment F{i} on User {{ age {next} }}\n"));
    }
    let schema_text = std::fs::read_to_string(fixture_dir().join("schemas/basic.gqlschema"))
        .expect("the basic schema");
    let mut input = GraphQlInput::new();
    input.add_source_sync(GraphQlSourceData {
        name: "Chain".to_owned(),
        schema: parse_json(&schema_text, "GraphQL schema", None).unwrap(),
        query,
    });
    let mut builder =
        TypeBuilder::new(get_no_string_type_mapping(), false, false, false, false).unwrap();
    let start = std::time::Instant::now();
    input.add_types_sync(&mut builder).unwrap();
    let elapsed = start.elapsed();
    assert!(
        elapsed < std::time::Duration::from_secs(5),
        "expanding the chain took {elapsed:?}"
    );
}
