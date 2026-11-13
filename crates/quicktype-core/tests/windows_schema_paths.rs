//! Port of quicktype's `test/unit/windows-schema-paths.test.ts` (issue
//! #2869): schema inputs given as Windows absolute paths must work.
//!
//! On POSIX, a drive-letter path such as `C:/Users/quicktype/top.schema.json`
//! is read relative to the working directory, so the test creates a literal
//! `C:/Users/quicktype` tree in a temporary directory and changes into it.
//! Because it changes the working directory it is its own test binary, and
//! its cases run one after the other in a single test.

use quicktype_core::input::fetching_json_schema_store::FetchingJsonSchemaStore;
use quicktype_core::input::io::block_on;
use quicktype_core::input::json_schema_input::{JsonSchemaInput, JsonSchemaSourceData};
use quicktype_core::ty::transformed_string_type::TypeKind;
use quicktype_core::ty::type_builder::TypeBuilder;
use quicktype_core::ty::type_builder_utils::get_no_string_type_mapping;
use quicktype_core::ty::type_graph::TypeGraph;

const TOP_LEVEL_SCHEMA: &str = r#"{"$schema":"http://json-schema.org/draft-07/schema#","type":"array","items":{"$ref":"item.schema.json"}}"#;
const ITEM_SCHEMA: &str = r#"{"$schema":"http://json-schema.org/draft-07/schema#","type":"object","properties":{"name":{"type":"string"}},"required":["name"]}"#;

/// The same setup the CLI uses for `-s schema <path>`.
fn graph_of(schema_uri: &str) -> TypeGraph {
    block_on(async {
        let mut input = JsonSchemaInput::new(
            Some(Box::new(FetchingJsonSchemaStore::new(Vec::new()))),
            Vec::new(),
            Vec::new(),
        );
        input
            .add_source(JsonSchemaSourceData {
                name: "TopLevel".to_owned(),
                uris: Some(vec![schema_uri.to_owned()]),
                ..JsonSchemaSourceData::default()
            })
            .await?;
        let mut builder =
            TypeBuilder::new(get_no_string_type_mapping(), false, false, false, false)?;
        input.add_types(&mut builder, false, None).await?;
        builder.finish()
    })
    .unwrap_or_else(|e| panic!("{schema_uri}: {e}"))
}

/// Whether some object has a `name` property: the item schema, which is only
/// reachable through the relative `$ref`.
fn has_name_property(graph: &TypeGraph) -> bool {
    graph.types().iter().any(|t| {
        t.is_object_type()
            && t.properties().is_ok_and(|p| {
                p.get("name").is_some_and(|name| {
                    graph
                        .type_at(name.type_ref)
                        .is_ok_and(|t| matches!(t.kind(), TypeKind::Intersection))
                })
            })
    })
}

/// The path passed to quicktype for the temporary directory, as a user
/// would type it.
type SchemaArg = Box<dyn Fn(&std::path::Path) -> String>;

#[test]
fn schema_inputs_given_as_absolute_paths() {
    let is_windows = cfg!(windows);
    let temp = std::env::temp_dir().join(format!("quicktype-windows-paths-{}", std::process::id()));
    let cases: [(&str, &str, SchemaArg); 3] = [
        (
            "Windows absolute path with backslashes",
            if is_windows {
                "backslashes"
            } else {
                "C:/Users/quicktype"
            },
            Box::new(move |temp| {
                if is_windows {
                    temp.join("backslashes")
                        .join("top.schema.json")
                        .display()
                        .to_string()
                } else {
                    "C:\\Users\\quicktype\\top.schema.json".to_owned()
                }
            }),
        ),
        (
            "Windows absolute path with forward slashes",
            if is_windows {
                "forward-slashes"
            } else {
                "C:/Users/quicktype"
            },
            Box::new(move |temp| {
                if is_windows {
                    temp.join("forward-slashes")
                        .join("top.schema.json")
                        .display()
                        .to_string()
                        .replace('\\', "/")
                } else {
                    "C:/Users/quicktype/top.schema.json".to_owned()
                }
            }),
        ),
        (
            "POSIX absolute path",
            "posix",
            Box::new(|temp| {
                temp.join("posix")
                    .join("top.schema.json")
                    .display()
                    .to_string()
            }),
        ),
    ];
    let previous = std::env::current_dir().unwrap();
    for (description, schema_dir, schema_arg) in &cases {
        let dir = temp.join(schema_dir);
        std::fs::create_dir_all(&dir).unwrap();
        std::fs::write(dir.join("top.schema.json"), TOP_LEVEL_SCHEMA).unwrap();
        std::fs::write(dir.join("item.schema.json"), ITEM_SCHEMA).unwrap();
        std::env::set_current_dir(&temp).unwrap();
        let graph = graph_of(&schema_arg(&temp));
        std::env::set_current_dir(&previous).unwrap();
        assert!(
            has_name_property(&graph),
            "{description}: no type from the $ref'd schema"
        );
    }
    let _ = std::fs::remove_dir_all(&temp);
}
