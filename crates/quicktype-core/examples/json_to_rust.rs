//! The Rust API example from the repository's README.md: Rust types from a
//! JSON sample. Run it with
//! `cargo run -p quickertype-core --example json_to_rust`.

use quicktype_core::{
    InputData, JsonSourceData, Options, QuickTypeError, combine_render_results,
    get_target_language, json_input_for_target_language, quicktype_multi_file_sync,
};

fn main() -> Result<(), QuickTypeError> {
    let lang = get_target_language("rust")?;

    let mut input = json_input_for_target_language(lang, false, &Default::default());
    input.add_source_sync(JsonSourceData {
        name: "Person".to_owned(),
        samples: vec![r#"{"name": "Ann", "age": 7}"#.into()],
        description: None,
    })?;
    let mut input_data = InputData::new();
    input_data.add_input(input);

    let files = quicktype_multi_file_sync(Options::new(lang, input_data))?;
    print!("{}", combine_render_results(files).lines.join("\n"));
    Ok(())
}
