//! JSON Schema input, as the CLI reads it (`--src-lang schema`): a
//! `FetchingJsonSchemaStore` on an in-memory file system, so `$ref`s
//! resolve between documents, then the rest of the pipeline into any
//! language (see `RunConfig::read` for the header).
//!
//! The body after the header is documents separated by NUL bytes: the
//! first is `main.json`, each later one a file named by its first line
//! (`b.json\n{...}`). Flag bit 2 reads `main.json#/definitions/` (every
//! definition a top-level); bit 3 adds the second document as a source of
//! its own; bit 5 passes it as `--additional-schema` instead.

#![no_main]

use std::collections::HashMap;

use libfuzzer_sys::fuzz_target;
use quicktype_core::input::io::block_on;
use quicktype_core::{
    FetchingJsonSchemaStore, InputData, JsonSchemaInput, JsonSchemaSourceData, Options,
    quicktype_multi_file,
};
use quicktype_fuzz::{MemIo, RunConfig, first_line, on_cli_stack, split, text};

fuzz_target!(|data: &[u8]| {
    let data = data.to_vec();
    on_cli_stack(move || {
        if let Some((config, body)) = RunConfig::read(&data) {
            run(&config, body);
        }
    });
});

fn run(config: &RunConfig, body: &[u8]) {
    let documents = split(body, 0);
    let mut files = HashMap::new();
    files.insert("main.json".to_owned(), text(documents[0]));
    let mut names = Vec::new();
    for document in &documents[1..] {
        let (name, content) = first_line(document);
        let name = text(name);
        names.push(name.clone());
        files.insert(name, text(content));
    }
    let flag = |bit: u8| config.flags & (1 << bit) != 0;
    let explained: Vec<(String, Vec<u8>)> = files
        .iter()
        .map(|(name, content)| (name.clone(), content.clone().into_bytes()))
        .collect();
    let mut args = vec!["--src-lang".to_owned(), "schema".to_owned()];
    args.push(
        if flag(2) {
            "main.json#/definitions/"
        } else {
            "main.json"
        }
        .to_owned(),
    );
    match names.first() {
        Some(second) if flag(5) => args.extend(["--additional-schema".to_owned(), second.clone()]),
        Some(second) if flag(3) => args.push(second.clone()),
        _ => {}
    }
    quicktype_fuzz::explain(config, &args, &explained);

    let main = if flag(2) {
        "main.json#/definitions/"
    } else {
        "main.json"
    };
    let mut sources = vec![main.to_owned()];
    let mut additional = Vec::new();
    if let Some(second) = names.first() {
        if flag(5) {
            additional.push(second.clone());
        } else if flag(3) {
            sources.push(second.clone());
        }
    }

    let mut input = JsonSchemaInput::new(
        Some(Box::new(FetchingJsonSchemaStore::with_io(
            MemIo { files },
            Vec::new(),
        ))),
        Vec::new(),
        additional,
    );
    for uri in sources {
        let added = input.add_source_sync(JsonSchemaSourceData {
            name: "TopLevel".to_owned(),
            uris: Some(vec![uri]),
            schema: None,
            is_converted: false,
        });
        if added.is_err() {
            return;
        }
    }
    let mut input_data = InputData::new();
    input_data.add_input(input);
    let options = config.apply(Options::new(config.lang, input_data));
    let _ = block_on(quicktype_multi_file(options));
}
