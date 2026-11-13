//! Ports of quicktype's Vitest tests for JSON Schema input
//! (`test/unit/json-schema-definitions.test.ts`,
//! `prefix-items-schema.test.ts`, `missing-schema-path.test.ts` and
//! `url-input.test.ts`; `windows-schema-paths.test.ts` is in its own test
//! binary because it changes the working directory).
//!
//! The originals render TypeScript and look for names in the output.
//! Rendering is not part of this crate yet, so these assert the same facts
//! one step earlier, on the type graph the input builds: which named types
//! and properties exist.

use quicktype_core::input::fetching_json_schema_store::FetchingJsonSchemaStore;
use quicktype_core::input::io::block_on;
use quicktype_core::input::json_schema_input::{JsonSchemaInput, JsonSchemaSourceData};
use quicktype_core::messages::Result;
use quicktype_core::ty::type_builder::TypeBuilder;
use quicktype_core::ty::type_builder_utils::get_no_string_type_mapping;
use quicktype_core::ty::type_graph::TypeGraph;

/// Builds the input graph of the given sources, the way `quicktype()` does
/// with a `FetchingJSONSchemaStore`.
fn graph_of(sources: Vec<JsonSchemaSourceData>) -> Result<TypeGraph> {
    block_on(async {
        let mut input = JsonSchemaInput::new(
            Some(Box::new(FetchingJsonSchemaStore::new(Vec::new()))),
            Vec::new(),
            Vec::new(),
        );
        for source in sources {
            input.add_source(source).await?;
        }
        let mut builder =
            TypeBuilder::new(get_no_string_type_mapping(), false, false, false, false)?;
        input.add_types(&mut builder, false, None).await?;
        builder.finish()
    })
}

fn text_source(name: &str, schema: &str) -> JsonSchemaSourceData {
    JsonSchemaSourceData {
        name: name.to_owned(),
        schema: Some(schema.to_owned()),
        ..JsonSchemaSourceData::default()
    }
}

/// The names of all properties of all object types.
fn property_names(graph: &TypeGraph) -> Vec<String> {
    graph
        .types()
        .iter()
        .filter(|t| t.is_object_type())
        .flat_map(|t| {
            t.properties()
                .map(|p| p.keys().cloned().collect::<Vec<_>>())
                .unwrap_or_default()
        })
        .collect()
}

/// The combined names of all object types.
fn object_names(graph: &TypeGraph) -> Vec<String> {
    graph
        .types()
        .iter()
        .filter(|t| t.is_object_type())
        .filter_map(|t| graph.combined_name(t.type_ref()).ok())
        .collect()
}

const LIGHT_SCHEMA: &str = r##"{
    "$schema": "https://json-schema.org/draft/2020-12/schema",
    "$defs": {
        "LightParams": {
            "type": "object",
            "properties": {
                "outlet_id": { "type": "string" },
                "app_id": { "type": "string" },
                "rgba": { "type": "string" }
            },
            "additionalProperties": false,
            "required": ["outlet_id", "app_id", "rgba"]
        }
    },
    "type": "object",
    "properties": { "LightParams": { "$ref": "#/$defs/LightParams" } },
    "additionalProperties": false,
    "required": ["LightParams"]
}"##;

/// json-schema-definitions.test.ts: "a type under $defs keeps its
/// definition name (issue #2778)".
#[test]
fn a_type_under_defs_keeps_its_definition_name() {
    let graph = graph_of(vec![text_source("LightSchema", LIGHT_SCHEMA)]).unwrap();
    let names = object_names(&graph);
    assert!(names.iter().any(|n| n == "LightParams"), "{names:?}");
    assert!(names.iter().any(|n| n == "LightSchema"), "{names:?}");
    assert!(property_names(&graph).iter().any(|p| p == "LightParams"));
}

const DEFS: &str = r#"{
    "Bar": { "type": "object", "properties": { "barField": { "type": "integer" } }, "required": ["barField"] },
    "Baz": { "type": "object", "properties": { "bazField": { "type": "string" } }, "required": ["bazField"] }
}"#;

fn assert_bar_and_baz(schema: &str) {
    let graph = graph_of(vec![text_source("Foo", schema)]).unwrap();
    let properties = property_names(&graph);
    assert!(properties.iter().any(|p| p == "barField"), "{properties:?}");
    assert!(properties.iter().any(|p| p == "bazField"), "{properties:?}");
}

/// prefix-items-schema.test.ts: "a 2020-12 prefixItems tuple keeps its
/// member types".
#[test]
fn a_2020_12_prefix_items_tuple_keeps_its_member_types() {
    assert_bar_and_baz(&format!(
        r##"{{ "$schema": "https://json-schema.org/draft/2020-12/schema", "type": "array",
              "prefixItems": [{{ "$ref": "#/$defs/Bar" }}, {{ "$ref": "#/$defs/Baz" }}], "$defs": {DEFS} }}"##
    ));
}

/// prefix-items-schema.test.ts: "an object-form `items` next to
/// `prefixItems` joins the union".
#[test]
fn an_object_form_items_next_to_prefix_items_joins_the_union() {
    assert_bar_and_baz(&format!(
        r##"{{ "$schema": "https://json-schema.org/draft/2020-12/schema", "type": "array",
              "prefixItems": [{{ "$ref": "#/$defs/Bar" }}], "items": {{ "$ref": "#/$defs/Baz" }}, "$defs": {DEFS} }}"##
    ));
}

/// prefix-items-schema.test.ts: "draft-07 array-valued items still works
/// (no regression)".
#[test]
fn draft_07_array_valued_items_still_works() {
    assert_bar_and_baz(&format!(
        r##"{{ "$schema": "http://json-schema.org/draft-07/schema#", "type": "array",
              "items": [{{ "$ref": "#/definitions/Bar" }}, {{ "$ref": "#/definitions/Baz" }}], "definitions": {DEFS} }}"##
    ));
}

/// missing-schema-path.test.ts: "missing JSON Schema paths report the
/// fetch error" (issue #2812).
#[test]
fn missing_json_schema_paths_report_the_fetch_error() {
    let dir = std::env::temp_dir().join(format!("quicktype-missing-schema-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let missing = dir.join("*.json");
    let missing = missing.to_str().unwrap();
    let error = graph_of(vec![JsonSchemaSourceData {
        name: "TopLevel".to_owned(),
        uris: Some(vec![missing.to_owned()]),
        ..JsonSchemaSourceData::default()
    }])
    .unwrap_err();
    let reported = quicktype_core::support::windows_paths::fix_windows_path(missing);
    assert_eq!(
        error.user_message(),
        format!("Could not fetch schema #, referred to from {reported}#")
    );
    let _ = std::fs::remove_dir_all(&dir);
}

/// url-input.test.ts: URL inputs served by a local HTTP server.
#[cfg(feature = "http")]
mod url_input {
    use std::io::{BufRead, BufReader, Write};
    use std::net::TcpListener;

    use super::*;
    use quicktype_core::input::io::node_io::{StdIo, read_from_file_or_url};

    const MAIN_SCHEMA: &str = r#"{"$schema":"http://json-schema.org/draft-07/schema#","type":"object","properties":{"referenced":{"$ref":"referenced.schema"}},"required":["referenced"]}"#;
    const REFERENCED_SCHEMA: &str = r#"{"$schema":"http://json-schema.org/draft-07/schema#","type":"object","properties":{"veryUniqueReferencedProperty":{"type":"string"}},"required":["veryUniqueReferencedProperty"]}"#;
    const SAMPLE: &str = r#"{"veryUniquePropertyName":"quicktype","count":3}"#;

    /// Serves the test's files over HTTP on a free port; returns the base
    /// URL. The server thread lives as long as the test process.
    fn serve() -> String {
        let listener = TcpListener::bind("127.0.0.1:0").unwrap();
        let port = listener.local_addr().unwrap().port();
        std::thread::spawn(move || {
            for stream in listener.incoming() {
                let Ok(mut stream) = stream else { continue };
                let mut reader = BufReader::new(stream.try_clone().unwrap());
                let mut request_line = String::new();
                if reader.read_line(&mut request_line).is_err() {
                    continue;
                }
                // Skip the headers.
                let mut line = String::new();
                while reader.read_line(&mut line).is_ok_and(|n| n > 2) {
                    line.clear();
                }
                let path = request_line.split_whitespace().nth(1).unwrap_or("/");
                let name = path.rsplit('/').next().unwrap_or("");
                let (status, body) = match name {
                    "unauthorized.json" => ("401 Unauthorized", r#"{"message":"Bad credentials"}"#),
                    "sample.json" => ("200 OK", SAMPLE),
                    "main.schema" => ("200 OK", MAIN_SCHEMA),
                    "referenced.schema" => ("200 OK", REFERENCED_SCHEMA),
                    _ => ("404 Not Found", ""),
                };
                let _ = write!(
                    stream,
                    "HTTP/1.1 {status}\r\nContent-Type: application/json\r\nContent-Length: {}\r\nConnection: close\r\n\r\n{body}",
                    body.len()
                );
            }
        });
        format!("http://127.0.0.1:{port}")
    }

    /// "generates types from a JSON URL": the URL's body is read.
    #[test]
    fn reads_a_json_url() {
        let base = serve();
        let text = block_on(read_from_file_or_url(
            &StdIo,
            &format!("{base}/sample.json"),
            &[],
        ))
        .unwrap();
        assert!(text.contains("veryUniquePropertyName"));
    }

    /// "rejects an HTTP error response".
    #[test]
    fn rejects_an_http_error_response() {
        let base = serve();
        let url = format!("{base}/unauthorized.json");
        let error = block_on(read_from_file_or_url(&StdIo, &url, &[])).unwrap_err();
        assert_eq!(
            error.user_message(),
            format!("Cannot read from file or URL {url}: Error: HTTP 401 Unauthorized")
        );
    }

    /// "resolves a relative remote JSON Schema reference".
    #[test]
    fn resolves_a_relative_remote_json_schema_reference() {
        let base = serve();
        let graph = graph_of(vec![JsonSchemaSourceData {
            name: "TopLevel".to_owned(),
            uris: Some(vec![format!("{base}/main.schema")]),
            ..JsonSchemaSourceData::default()
        }])
        .unwrap();
        let properties = property_names(&graph);
        assert!(
            properties
                .iter()
                .any(|p| p == "veryUniqueReferencedProperty"),
            "{properties:?}"
        );
    }
}
