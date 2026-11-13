//! Ports of quicktype's Vitest tests for the C++ renderer:
//! `test/unit/cplusplus-multi-source.test.ts` and the C++ case of
//! `test/unit/enum-order.test.ts`.
//!
//! Both drive the public API end to end, as the TypeScript tests do. The
//! byte-for-byte comparison with the reference is the render scenario
//! `vitest-cplusplus-multi-source` (`render_scenarios.rs`).

use quicktype_core::internal::block_on;
use quicktype_core::{
    InputData, JsonSchemaInput, JsonSchemaSourceData, JsonSourceData, Options, RendererOptions,
    get_target_language, json_input_for_target_language, quicktype, quicktype_multi_file,
};

/// `cPlusPlusMultiSourceFiles()`: every file of the multi-source render of
/// two JSON top-levels, as `(filename, text)`.
fn c_plus_plus_multi_source_files() -> Vec<(String, String)> {
    let lang = get_target_language("cplusplus").unwrap();
    let mut json_input = json_input_for_target_language(lang, false, &RendererOptions::new());
    for (name, sample) in [
        ("ChunkCache", r#"{"chunks":["one"],"size":1}"#),
        ("BufferPath", r#"{"path":"somewhere","maxSize":2}"#),
    ] {
        json_input
            .add_source_sync(JsonSourceData {
                name: name.to_owned(),
                samples: vec![sample.into()],
                description: None,
            })
            .unwrap();
    }

    let mut input_data = InputData::new();
    input_data.add_input(json_input);
    let mut renderer_options = RendererOptions::new();
    renderer_options.set("source-style", "multi-source");
    let result = block_on(quicktype_multi_file(
        Options::new(lang, input_data)
            .with_output_filename("quicktype.hpp")
            .with_renderer_options(renderer_options),
    ))
    .unwrap();

    result
        .iter()
        .map(|(filename, serialized)| (filename.clone(), serialized.lines.join("\n")))
        .collect()
}

#[test]
fn the_umbrella_header_includes_the_json_generators() {
    let files = c_plus_plus_multi_source_files();
    let umbrella = files
        .iter()
        .find(|(name, _)| name == "quicktype.hpp")
        .map(|(_, text)| text)
        .expect("quicktype.hpp");
    assert!(umbrella.contains("#include \"Generators.hpp\""));
}

#[test]
fn usage_comments_name_top_level_types_not_generated_files() {
    let files = c_plus_plus_multi_source_files();
    assert!(files.len() > 1);
    for (filename, source) in &files {
        assert!(
            source.contains("//     ChunkCache data = nlohmann::json::parse(jsonString);"),
            "{filename}"
        );
        assert!(
            source.contains("//     BufferPath data = nlohmann::json::parse(jsonString);"),
            "{filename}"
        );
        assert!(
            !source.contains(&format!(
                "//     {filename} data = nlohmann::json::parse(jsonString);"
            )),
            "{filename}"
        );
    }
}

#[test]
fn preserves_json_schema_enum_case_order() {
    let schema = r#"{"$schema":"http://json-schema.org/draft-04/schema#","title":"Test","type":"object","properties":{"errorCode":{"type":"string","enum":["B","A","E"]}}}"#;
    let mut schema_input = JsonSchemaInput::new(None, Vec::new(), Vec::new());
    schema_input
        .add_source_sync(JsonSchemaSourceData {
            name: "Test".to_owned(),
            uris: None,
            schema: Some(schema.to_owned()),
            is_converted: false,
        })
        .unwrap();
    let mut input_data = InputData::new();
    input_data.add_input(schema_input);

    let lang = get_target_language("c++").unwrap();
    let result = block_on(quicktype(Options::new(lang, input_data))).unwrap();

    assert!(
        result
            .lines
            .iter()
            .any(|line| line == "    enum class ErrorCode : int { B, A, E };")
    );
}
