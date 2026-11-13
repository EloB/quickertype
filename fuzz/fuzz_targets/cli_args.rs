//! The CLI's option parsing (`command_line_args`, `cli_options`: both
//! passes, with command-line-args' semantics, and the inference of source
//! and target language and top-level name) on arbitrary argv, then
//! `--help`'s usage text or a run of the parsed options on a small sample.
//! The arguments are separated by NUL bytes.
//!
//! The CLI is a binary, so its modules are compiled into this target.

#![no_main]
#![allow(dead_code, unused_imports)]

#[path = "../../crates/quicktype-cli/src/chalk.rs"]
mod chalk;
#[path = "../../crates/quicktype-cli/src/cli_options.rs"]
mod cli_options;
#[path = "../../crates/quicktype-cli/src/command_line_args.rs"]
mod command_line_args;
#[path = "../../crates/quicktype-cli/src/command_line_usage.rs"]
mod command_line_usage;
#[path = "../../crates/quicktype-cli/src/js.rs"]
mod js;
#[path = "../../crates/quicktype-cli/src/messages.rs"]
mod messages;
#[path = "../../crates/quicktype-cli/src/usage.rs"]
mod usage;

use libfuzzer_sys::fuzz_target;
use quicktype_core::{
    InputData, JsonSample, JsonSourceData, Options, default_target_languages,
    json_input_for_target_language, quicktype_multi_file_sync,
};

const SAMPLE: &[u8] = br#"{"id": 1, "name": "x", "tags": ["a", "b"], "child": {"when": "2020-01-01T00:00:00Z", "ok": true, "n": null}, "list": [{"v": 1.5}, {"v": 2, "w": "u"}]}"#;

fuzz_target!(|data: &[u8]| {
    let argv: Vec<String> = quicktype_fuzz::split(data, 0)
        .into_iter()
        .map(quicktype_fuzz::text)
        .collect();
    let argv = if data.is_empty() { Vec::new() } else { argv };
    let Ok(options) = cli_options::parse_cli_options(&argv) else {
        return;
    };
    if options.help {
        let chalk = chalk::Chalk::new(0);
        let _ = usage::usage(&chalk, default_target_languages());
        return;
    }
    if options.src_lang != "json" {
        return;
    }
    quicktype_fuzz::on_cli_stack(move || run(&argv));
});

/// Parses `argv` again (the options are not `Send`) and runs them on
/// [`SAMPLE`].
fn run(argv: &[String]) {
    let Ok(options) = cli_options::parse_cli_options(argv) else {
        return;
    };
    let mut input = json_input_for_target_language(options.lang, false, &options.renderer_options);
    if input
        .add_source_sync(JsonSourceData {
            name: options.top_level.clone(),
            samples: vec![JsonSample::Stream(SAMPLE.to_vec())],
            description: None,
        })
        .is_err()
    {
        return;
    }
    let mut input_data = InputData::new();
    input_data.add_input(input);
    let run = Options::new(options.lang, input_data)
        .with_alphabetize_properties(options.alphabetize_properties)
        .with_all_properties_optional(options.all_properties_optional)
        .with_renderer_options(options.renderer_options.clone());
    let _ = quicktype_multi_file_sync(run);
}
