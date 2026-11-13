//! Deeply nested schemas: the JSON Schema input must fail where Node's stack
//! overflows, with V8's `RangeError: Maximum call stack size exceeded`, and
//! must never overflow the native stack itself, whatever the nesting.
//!
//! The thresholds are Node 24's, measured with
//! `xtask/core-json-schema-input/measure-stack-depth.mjs` (the last depth
//! that still succeeds, in a fresh process). These tests run on the default
//! test-thread stack (2 MB), smaller than the CLI's.

use quicktype_core::input::io::block_on;
use quicktype_core::input::json_schema_input::{JsonSchemaInput, JsonSchemaSourceData};
use quicktype_core::messages::{JsErrorName, Result};
use quicktype_core::ty::type_builder::TypeBuilder;
use quicktype_core::ty::type_builder_utils::get_no_string_type_mapping;

/// Runs the input stage on schema text; `Ok(())` or the error's CLI line.
fn run(schema: &str) -> std::result::Result<(), String> {
    let result: Result<()> = block_on(async {
        let mut input = JsonSchemaInput::new(None, Vec::new(), Vec::new());
        input
            .add_source(JsonSchemaSourceData {
                name: "T".to_owned(),
                schema: Some(schema.to_owned()),
                ..JsonSchemaSourceData::default()
            })
            .await?;
        let mut builder =
            TypeBuilder::new(get_no_string_type_mapping(), false, false, true, false)?;
        input.add_types(&mut builder, false, None).await?;
        builder.finish().map(|_| ())
    });
    result.map_err(|e| {
        if let Some(js) = e.as_js_exception() {
            assert_eq!(js.name(), JsErrorName::RangeError, "{e}");
        }
        format!("Error: {e}.")
    })
}

fn nested(open: &str, close: &str, n: usize) -> String {
    format!(
        "{}{{\"type\":\"string\"}}{}",
        open.repeat(n),
        close.repeat(n)
    )
}

const OVERFLOW: &str = "Error: Maximum call stack size exceeded.";

/// The last depth Node handles, and the first it overflows at.
fn assert_threshold(open: &str, close: &str, last_ok: usize) {
    assert_eq!(
        run(&nested(open, close, last_ok)),
        Ok(()),
        "{open} x {last_ok}"
    );
    assert_eq!(
        run(&nested(open, close, last_ok + 1)),
        Err(OVERFLOW.to_owned()),
        "{open} x {}",
        last_ok + 1
    );
}

#[test]
fn items_overflow_like_node() {
    assert_threshold(r#"{"type":"array","items":"#, "}", 322);
}

#[test]
fn tuples_overflow_like_node() {
    assert_threshold(r#"{"type":"array","items":["#, "]}", 198);
}

#[test]
fn properties_overflow_like_node() {
    assert_threshold(r#"{"type":"object","properties":{"a":"#, "}}", 161);
}

#[test]
fn all_of_overflows_like_node() {
    assert_threshold(r#"{"allOf":["#, "]}", 200);
}

#[test]
fn one_of_and_any_of_overflow_like_node() {
    assert_threshold(r#"{"oneOf":["#, "]}", 170);
    assert_threshold(r#"{"anyOf":["#, "]}", 170);
}

#[test]
fn mixed_paths_add_up_like_node() {
    assert_threshold(
        r#"{"type":"object","properties":{"a":{"type":"array","items":"#,
        "}}}",
        107,
    );
}

/// TypeScript recurses into `additionalProperties`, `$ref` targets and
/// untyped objects after an `await`, on a fresh stack: such chains never
/// overflow there, and must not crash here.
#[test]
fn chains_after_awaits_do_not_overflow() {
    assert_eq!(
        run(&nested(
            r#"{"type":"object","additionalProperties":"#,
            "}",
            3000
        )),
        Ok(())
    );
    assert_eq!(run(&nested(r#"{"properties":{"a":"#, "}}", 1000)), Ok(()));
    let n = 3000;
    let definitions: Vec<String> = (0..n)
        .map(|i| format!(r##""d{i}":{{"$ref":"#/definitions/d{}"}}"##, i + 1))
        .chain(std::iter::once(format!(r#""d{n}":{{"type":"string"}}"#)))
        .collect();
    let refs = format!(
        r##"{{"definitions":{{{}}},"$ref":"#/definitions/d0"}}"##,
        definitions.join(",")
    );
    assert_eq!(run(&refs), Ok(()));
}

/// `Canonizer.addIDs` walks the whole document recursively: Node overflows
/// on a document nested 4,152 levels deep.
#[test]
fn deep_documents_overflow_in_add_ids_like_node() {
    assert_eq!(run(&nested(r#"{"x":"#, "}", 4150)), Ok(()));
    assert_eq!(
        run(&nested(r#"{"x":"#, "}", 4151)),
        Err(OVERFLOW.to_owned())
    );
    let arrays = format!("{{\"a\":{}1{}}}", "[".repeat(50_000), "]".repeat(50_000));
    assert_eq!(run(&arrays), Err(OVERFLOW.to_owned()));
}

/// YAML aliases can make a value nest far deeper than the document; that
/// fails (the schema cannot be read) instead of crashing.
#[test]
fn yaml_alias_nesting_is_bounded() {
    let mut yaml = String::from("a0: &a0 [[[[[[[[[[1]]]]]]]]]]\n");
    for i in 1..200 {
        yaml.push_str(&format!("a{i}: &a{i} [[[[[[[[[[*a{}]]]]]]]]]]\n", i - 1));
    }
    assert!(run(&yaml).is_err());
    assert!(run(&format!("{}1{}", "[".repeat(300), "]".repeat(300))).is_err());
}
