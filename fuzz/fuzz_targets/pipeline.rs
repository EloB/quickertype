//! The whole pipeline through the library API: arbitrary JSON samples to
//! any output language with arbitrary run and renderer options (see
//! `RunConfig::read` for the header), on a thread with the CLI's stack.
//!
//! The body after the header is one or more samples separated by NUL
//! bytes. Flag bit 2 reads them with `JSON.parse` semantics (the
//! JavaScript API) instead of stream-json's (the CLI); bit 3 makes each
//! sample a source of its own (a top-level each) instead of samples of one
//! top-level; bit 5 picks unusual top-level names.

#![no_main]

use libfuzzer_sys::fuzz_target;
use quicktype_core::{
    InputData, JsonSample, JsonSourceData, Options, json_input_for_target_language,
    quicktype_multi_file_sync,
};
use quicktype_fuzz::{RunConfig, on_cli_stack, split, text};

const NAMES: &[&str] = &["TopLevel", "Other", "TopLevel", "top_level"];
const ODD_NAMES: &[&str] = &["class", "a b", "日本語", "1", "", "$&", "😀", "Top-Level"];

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
    let pieces = split(body, 0);
    let samples: Vec<JsonSample> = pieces
        .iter()
        .map(|sample| {
            if flag(2) {
                JsonSample::String(text(sample))
            } else {
                JsonSample::Stream(sample.to_vec())
            }
        })
        .collect();
    let names = if flag(5) { ODD_NAMES } else { NAMES };

    let files: Vec<(String, Vec<u8>)> = pieces
        .iter()
        .enumerate()
        .map(|(i, sample)| (format!("sample{i}.json"), sample.to_vec()))
        .collect();
    let mut args = Vec::new();
    for (i, (file, _)) in files.iter().enumerate() {
        if flag(3) || i == 0 {
            args.extend(["--top-level".to_owned(), names[i % names.len()].to_owned()]);
        }
        args.extend(["--src".to_owned(), file.clone()]);
    }
    if flag(2) {
        args.push("# API only: JSON.parse semantics".to_owned());
    }
    if flag(3) {
        args.push("# API only: one source per sample".to_owned());
    }
    quicktype_fuzz::explain(config, &args, &files);

    let mut input = json_input_for_target_language(
        config.lang,
        !config.inference_flags.ignore_json_refs,
        &config.renderer_options,
    );
    let added = if flag(3) {
        samples.into_iter().enumerate().try_for_each(|(i, sample)| {
            input.add_source_sync(JsonSourceData {
                name: names[i % names.len()].to_owned(),
                samples: vec![sample],
                description: None,
            })
        })
    } else {
        input.add_source_sync(JsonSourceData {
            name: names[0].to_owned(),
            samples,
            description: None,
        })
    };
    if added.is_err() {
        return;
    }
    let mut input_data = InputData::new();
    input_data.add_input(input);
    let _ = quicktype_multi_file_sync(config.apply(Options::new(config.lang, input_data)));
}
