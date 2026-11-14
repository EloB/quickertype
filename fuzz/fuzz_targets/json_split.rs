//! Reading a large top-level array on several threads (the CLI's regular
//! files, `input/parallel_read.rs`): arbitrary bytes, split where the
//! parallel scan finds the array's element boundaries, must read exactly
//! as in one go: the same error, or the same type graph right after
//! inference.
//!
//! Header: byte 0 picks the threads (2 to 4), byte 1 the range size (1 to
//! 256 bytes), byte 2 flags: bit 0 `handleRefs`, bit 1 a budget for the
//! parts' trees so small that the rest is read in one go after the first
//! part.

#![no_main]

use libfuzzer_sys::fuzz_target;
use quicktype_core::internal::{ParallelOptions, parallel_sample};
use quicktype_core::language::typescript_flow::language::TypeScriptTargetLanguage;
use quicktype_core::ty::type_builder::TypeBuilder;
use quicktype_core::{
    InferenceFlags, JsonSample, JsonSourceData, RendererOptions, RunContext,
    json_input_for_target_language,
};

fuzz_target!(|data: &[u8]| {
    let [threads, range, flags, sample @ ..] = data else {
        return;
    };
    let options = ParallelOptions {
        threads: 2 + usize::from(threads % 3),
        range: 1 + usize::from(*range),
        min_len: 0,
        budget: if flags & 2 != 0 { 1 << 12 } else { 32 << 20 },
        fault: None,
    };
    let handle_refs = flags & 1 != 0;
    let parallel = read(JsonSample::Reader(parallel_sample(sample.to_vec(), options)), handle_refs);
    let in_one_go = read(JsonSample::Stream(sample.to_vec()), handle_refs);
    assert_eq!(parallel, in_one_go, "read on several threads and in one go differ");
});

/// The source's error, or the type graph inferred from it.
fn read(sample: JsonSample, handle_refs: bool) -> String {
    let lang = &TypeScriptTargetLanguage;
    let mut input = json_input_for_target_language(lang, handle_refs, &RendererOptions::new());
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
