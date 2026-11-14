//! Large top-level arrays in files are read on several threads (the CLI's
//! regular files, `input/parallel_read.rs`), at offsets of the file:
//! `pread` on Unix, `seek_read` on Windows (each reading thread with a
//! handle of its own, the file opened again). Files written here, read with
//! forced threads and range sizes, must read as their bytes do in one go:
//! the same type graph, or the same error.

#![cfg(any(unix, windows))]

use std::path::PathBuf;

use quicktype_core::ParallelOptions;
use quicktype_core::internal::{parallel_file_sample, parallel_reads};
use quicktype_core::language::typescript_flow::language::TypeScriptTargetLanguage;
use quicktype_core::ty::type_builder::TypeBuilder;
use quicktype_core::{
    InferenceFlags, JsonSample, JsonSourceData, RendererOptions, RunContext,
    json_input_for_target_language,
};

/// The source's error, or the type graph inferred from it.
fn read(sample: JsonSample) -> String {
    let lang = &TypeScriptTargetLanguage;
    let mut input = json_input_for_target_language(lang, false, &RendererOptions::new());
    let source = JsonSourceData {
        name: "TopLevel".to_owned(),
        samples: vec![sample],
        description: None,
    };
    if let Err(e) = input.add_source_sync(source) {
        return format!("source error: {e:?}");
    }
    let ctx = RunContext::for_target_language(lang, &InferenceFlags::default());
    let graph = TypeBuilder::new(ctx.string_type_mapping.clone(), false, false, false, false)
        .and_then(|mut builder| {
            input.add_types_sync(&ctx, &mut builder, true, true, false)?;
            builder.finish()
        });
    match graph {
        Ok(graph) => format!("{graph:?}"),
        Err(e) => format!("inference error: {e:?}"),
    }
}

#[test]
fn files_read_on_several_threads_read_as_in_one_go() {
    let dir = PathBuf::from(env!("CARGO_TARGET_TMPDIR")).join("parallel-files");
    std::fs::create_dir_all(&dir).unwrap();
    let records: Vec<String> = (0..3_000)
        .map(|i| {
            format!(
                r#"{{"id":{i},"kind":"{}","name":"n{}","tags":["t{}","x,]"],"when":"2020-01-{:02}T00:00:00Z","ok":{}}}"#,
                ["a", "b", "c"][i % 3],
                i % 40,
                i % 7,
                1 + i % 28,
                i % 2 == 0
            )
        })
        .collect();
    let good = format!("[{}]\n", records.join(",\n"));
    let broken = good.replacen(r#""id":2000,"#, r#""id":2000,,"#, 1);
    let trailing = format!("{good} x");
    for (name, text, whole) in [
        ("good", &good, true),
        ("broken", &broken, false),
        ("trailing", &trailing, false),
    ] {
        let path = dir.join(format!("{name}.json"));
        std::fs::write(&path, text).unwrap();
        let expected = read(JsonSample::Stream(text.clone().into_bytes()));
        for threads in [2, 4] {
            for range in [64, 4_096, 65_536] {
                let options = ParallelOptions::default()
                    .with_threads(threads)
                    .with_small_ranges(range)
                    .with_min_len(0);
                let before = parallel_reads();
                let sample = parallel_file_sample(&path, options).unwrap();
                let got = read(JsonSample::Reader(sample));
                let after = parallel_reads();
                assert_eq!(
                    got, expected,
                    "{name}, {threads} threads, ranges of {range}"
                );
                if whole {
                    assert_eq!(after.whole - before.whole, 1, "{name}, {threads}, {range}");
                } else {
                    // Read in part on several threads, then in one go.
                    assert_eq!(
                        (after.in_part - before.in_part) + (after.again - before.again),
                        1,
                        "{name}, {threads}, {range}"
                    );
                }
            }
        }
    }
}
