//! GraphQL input (`--src-lang graphql`): a query against a schema's
//! introspection result, then the rest of the pipeline into any language
//! (see `RunConfig::read` for the header), on a thread with the CLI's
//! stack.
//!
//! With flag bit 2 the body is the schema (JSON or YAML, as `parseJSON`
//! reads `--graphql-schema`), a NUL byte and the query; without it the
//! body is the query, against a fixed schema picked by bits 3 and 5 (the
//! two test schemas and GitHub's).

#![no_main]

use std::sync::OnceLock;

use libfuzzer_sys::fuzz_target;
use quicktype_core::{InputData, Options, parse_json, quicktype_multi_file_sync};
use quicktype_fuzz::{RunConfig, on_cli_stack, text};
use quicktype_graphql_input::{GraphQlInput, GraphQlSourceData};
use quicktype_js_compat::json::JsonValue;

const SCHEMAS: [&str; 3] = [
    include_str!(
        "../../crates/quicktype-graphql-input/tests/fixtures/graphql-input/schemas/basic.gqlschema"
    ),
    include_str!(
        "../../crates/quicktype-graphql-input/tests/fixtures/graphql-input/schemas/query-only.gqlschema"
    ),
    include_str!("../../tests/inputs/graphql/github.gqlschema"),
];

fn fixed_schema(i: usize) -> &'static JsonValue {
    static PARSED: [OnceLock<JsonValue>; 3] = [OnceLock::new(), OnceLock::new(), OnceLock::new()];
    PARSED[i].get_or_init(|| parse_json(SCHEMAS[i], "GraphQL schema", None).expect("schema parses"))
}

fuzz_target!(|data: &[u8]| {
    let data = data.to_vec();
    on_cli_stack(move || {
        if let Some((config, body)) = RunConfig::read(&data) {
            run(&config, body);
        }
    });
});

fn run(config: &RunConfig, body: &[u8]) {
    let flag = |bit: u8| config.flags & (1 << bit) != 0;
    let (schema, query) = if flag(2) {
        let (schema, query) = match body.iter().position(|&b| b == 0) {
            Some(i) => (&body[..i], &body[i + 1..]),
            None => (body, &[][..]),
        };
        let Ok(schema) = parse_json(&text(schema), "GraphQL schema", Some("schema.gqlschema"))
        else {
            return;
        };
        (schema, text(query))
    } else {
        let i = match (flag(3), flag(5)) {
            (false, false) | (true, true) => 0,
            (true, false) => 1,
            (false, true) => 2,
        };
        (fixed_schema(i).clone(), text(body))
    };

    quicktype_fuzz::explain(
        config,
        &[
            "--src-lang".to_owned(),
            "graphql".to_owned(),
            "--graphql-schema".to_owned(),
            "schema.gqlschema".to_owned(),
            "query.graphql".to_owned(),
        ],
        &[
            (
                "schema.gqlschema".to_owned(),
                quicktype_js_compat::json::stringify(&schema, None).into_bytes(),
            ),
            ("query.graphql".to_owned(), query.clone().into_bytes()),
        ],
    );

    let mut input = GraphQlInput::new();
    input.add_source_sync(GraphQlSourceData {
        name: "TopLevel".to_owned(),
        query,
        schema,
    });
    let mut input_data = InputData::new();
    input_data.add_input(input);
    let _ = quicktype_multi_file_sync(config.apply(Options::new(config.lang, input_data)));
}
