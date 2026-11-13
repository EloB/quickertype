//! Postman collections (`--src-lang postman`): the collection (JSON or
//! YAML) read into one JSON source per request, as the CLI reads it, then
//! the samples through the pipeline into any language (see
//! `RunConfig::read` for the header), on a thread with the CLI's stack.

#![no_main]

use libfuzzer_sys::fuzz_target;
use quicktype_core::{
    Comment, InputData, JsonSample, JsonSourceData, Options, json_input_for_target_language,
    quicktype_multi_file_sync, sources_from_postman_collection,
};
use quicktype_fuzz::{RunConfig, on_cli_stack, text};
use quicktype_js_compat::wordwrap::WordWrap;

fuzz_target!(|data: &[u8]| {
    let data = data.to_vec();
    on_cli_stack(move || {
        if let Some((config, body)) = RunConfig::read(&data) {
            run(&config, body);
        }
    });
});

fn run(config: &RunConfig, body: &[u8]) {
    let Ok(postman) = sources_from_postman_collection(&text(body), Some("collection.json")) else {
        return;
    };
    let fixed_top_levels = postman.sources.len() > 1;
    let mut input = json_input_for_target_language(
        config.lang,
        !config.inference_flags.ignore_json_refs,
        &config.renderer_options,
    );
    for source in postman.sources {
        let added = input.add_source_sync(JsonSourceData {
            name: source.name,
            samples: source
                .samples
                .into_iter()
                .map(|sample| JsonSample::Stream(sample.into_bytes()))
                .collect(),
            description: source.description,
        });
        if added.is_err() {
            return;
        }
    }
    let mut input_data = InputData::new();
    input_data.add_input(input);
    let mut options = config.apply(Options::new(config.lang, input_data));
    if fixed_top_levels {
        options = options.with_fixed_top_levels(true);
    }
    if let Some(description) = postman.description {
        let comments = WordWrap::new(90)
            .wrap(&description)
            .split('\n')
            .map(Comment::from)
            .collect();
        options = options.with_leading_comments(Some(comments));
    }
    let _ = quicktype_multi_file_sync(options);
}
