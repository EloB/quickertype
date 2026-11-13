//! Inference from running tallies gives what quicktype infers from the
//! compressed form of the samples (docs/STREAMING-INFERENCE.md): generated
//! inputs go through both, and everything must be identical (each source's
//! error, the type graph right after inference for every combination of
//! the inference flags, and a whole run for a language and option set).
//!
//! `tallies_infer_what_the_compressed_form_infers` checks a few thousand
//! seeds; `cargo xtask streaming-fuzz` runs the ignored `fuzz` test over
//! millions (`QUICKTYPE_STREAMING_SEEDS`, `QUICKTYPE_STREAMING_START`,
//! `QUICKTYPE_STREAMING_JOBS`, `QUICKTYPE_STREAMING_RUNS`), and the
//! ignored `dump_documents` writes generated documents for comparing both
//! CLIs with the TypeScript one (`QUICKTYPE_STREAMING_DUMP`).

mod streaming_support;

use std::path::PathBuf;

use streaming_support::check_many;
use streaming_support::generator::{self, Case, Encoding, Limits, Sample, Source};

const LIMITS: Limits = Limits {
    lone_surrogates: true,
    max_depth: 10,
    big_maps: true,
    max_bytes: 16_000,
    deep_permille: 3,
};

fn env_u64(name: &str, default: u64) -> u64 {
    std::env::var(name)
        .ok()
        .and_then(|v| v.replace('_', "").parse().ok())
        .unwrap_or(default)
}

fn jobs() -> usize {
    env_u64(
        "QUICKTYPE_STREAMING_JOBS",
        std::thread::available_parallelism().map_or(4, |n| n.get()) as u64,
    ) as usize
}

fn check_seeds(default_count: u64, progress: bool) {
    let start = env_u64("QUICKTYPE_STREAMING_START", 0);
    let count = env_u64("QUICKTYPE_STREAMING_SEEDS", default_count);
    let runs = env_u64("QUICKTYPE_STREAMING_RUNS", 1) as usize;
    let begun = std::time::Instant::now();
    match check_many(start, count, jobs(), LIMITS, runs, progress) {
        Ok(stats) => eprintln!(
            "{count} seeds from {start}: 0 differences ({} graphs, {} runs of which {} failed alike, {} source errors alike) in {:.1?}",
            stats.graphs,
            stats.runs,
            stats.failed_runs,
            stats.source_errors,
            begun.elapsed()
        ),
        Err(failures) => panic!("{}", failures.join("\n\n")),
    }
}

#[test]
fn tallies_infer_what_the_compressed_form_infers() {
    check_seeds(3_000, false);
}

/// The long run (`cargo xtask streaming-fuzz`).
#[test]
#[ignore]
fn fuzz() {
    std::panic::set_hook(Box::new(|_| {}));
    check_seeds(100_000, true);
}

/// Writes `QUICKTYPE_STREAMING_SEEDS` generated documents to the
/// directory `QUICKTYPE_STREAMING_DUMP`, as `<seed>.json`.
#[test]
#[ignore]
fn dump_documents() {
    let Some(dir) = std::env::var_os("QUICKTYPE_STREAMING_DUMP").map(PathBuf::from) else {
        return;
    };
    std::fs::create_dir_all(&dir).expect("dump directory");
    let start = env_u64("QUICKTYPE_STREAMING_START", 0);
    let count = env_u64("QUICKTYPE_STREAMING_SEEDS", 2_000);
    for seed in start..start + count {
        std::fs::write(dir.join(format!("{seed}.json")), generator::document(seed)).expect("write");
    }
}

/// A case of the given sources, each a list of samples read as `encoding`.
fn case(handle_refs: bool, sources: &[(&str, &[&str])], encoding: Encoding) -> Case {
    Case {
        handle_refs,
        sources: sources
            .iter()
            .map(|(name, samples)| Source {
                name: (*name).to_owned(),
                description: None,
                samples: samples
                    .iter()
                    .map(|text| Sample {
                        text: (*text).to_owned(),
                        encoding,
                    })
                    .collect(),
            })
            .collect(),
    }
}

/// Every language and option set on hand-written cases.
fn check_case(case: &Case) {
    for encoding in [Encoding::Stream, Encoding::Reader(3), Encoding::Text] {
        let mut case = case.clone();
        for source in &mut case.sources {
            for sample in &mut source.samples {
                sample.encoding = encoding;
            }
        }
        streaming_support::on_cli_stack(|| streaming_support::check_all(&case))
            .unwrap_or_else(|e| panic!("{encoding:?}: {e}"));
    }
}

#[test]
fn proto_keys() {
    check_case(&case(
        false,
        &[(
            "Proto",
            &[
                r#"[{"a":1,"__proto__":{"x":1}},{"__proto__":"s","b":2,"__proto__":[1]},{"c":{"__proto__":null}},{"__proto__":2}]"#,
            ],
        )],
        Encoding::Stream,
    ));
}

#[test]
fn maps_around_500_keys_with_proto() {
    for n in [499, 500, 501] {
        let mut object = String::from("{");
        for i in 0..n {
            if i == 250 {
                object.push_str(r#""__proto__":{"p":"2020-01-01"},"#);
            }
            object.push_str(&format!(
                r#""k{i}":{},"#,
                if i % 3 == 0 { "1" } else { "\"x\"" }
            ));
        }
        object.push_str(r#""__proto__":[true]}"#);
        let second = r#"{"k1":2.5,"k2":null,"new":{"a":"b"}}"#;
        check_case(&case(
            false,
            &[("Map", &[object.as_str(), second])],
            Encoding::Stream,
        ));
    }
}

#[test]
fn refs() {
    let doc = r##"{"a":{"b":[1,2]},"c":{"$ref":"#/a"},"d":[{"$ref":"#/a/b"},{"$ref":"#/a"},{"$ref":"#/a/b"}],"e":{"$ref":"#/a/b/0"}}"##;
    check_case(&case(true, &[("Refs", &[doc])], Encoding::Stream));
    check_case(&case(false, &[("Refs", &[doc])], Encoding::Stream));
    let bad = r##"{"a":1,"c":{"$ref":"#/x"},"d":{"$ref":"nope"}}"##;
    check_case(&case(true, &[("Bad", &[bad])], Encoding::Stream));
    let mixed = r##"[{"$ref":"#/0"},{"$ref":3},{"$ref":"2020-01-01"}]"##;
    check_case(&case(true, &[("Mixed", &[mixed])], Encoding::Stream));
}

#[test]
fn duplicate_keys_samples_and_sources() {
    check_case(&case(
        false,
        &[
            (
                "A",
                &[r#"{"x":1,"x":"s","y":[]}"#, r#"{"y":[{"z":1}],"x":null}"#],
            ),
            ("B", &[r#"[[],[[1]],[[1.5,"2020-01-01T00:00:00Z"]]]"#]),
            ("A", &[r#"{"w":true,"x":"https://a.b/c.PNG"}"#]),
            ("A", &[r#"{"x":"#]),
            ("A", &[r#"{"x":"red","x":"red","x":"blue"}"#]),
        ],
        Encoding::Stream,
    ));
}

#[test]
fn enum_thresholds() {
    for (values, cases) in [
        (9, 2),
        (10, 3),
        (10, 4),
        (16, 3),
        (16, 4),
        (17, 4),
        (25, 4),
        (25, 5),
        (26, 5),
    ] {
        let items: Vec<String> = (0..values)
            .map(|i| format!(r#"{{"e":"case{}","n":"{}"}}"#, i % cases, i % 2))
            .collect();
        let doc = format!("[{}]", items.join(","));
        check_case(&case(
            false,
            &[("Enums", &[doc.as_str()])],
            Encoding::Stream,
        ));
    }
}

/// Nesting around inference's depth limit and far beyond it: both paths
/// fail with TypeScript's `RangeError` at the same depth, and neither
/// overflows the native stack.
#[test]
fn deep_nesting() {
    streaming_support::on_cli_stack(deep_nesting_on_cli_stack);
}

fn deep_nesting_on_cli_stack() {
    use generator::{MAX_DEPTH, nested};
    for style in 0..3 {
        for depth in [MAX_DEPTH - 2, MAX_DEPTH - 1, MAX_DEPTH, MAX_DEPTH + 1] {
            let doc = nested(depth, style, "1");
            let deep = case(false, &[("Deep", &[doc.as_str()])], Encoding::Stream);
            streaming_support::check_light(&deep)
                .unwrap_or_else(|e| panic!("style {style}, depth {depth}: {e}"));
            // `1` nested `depth` levels: one `inferType` for the
            // top-level, one per level below it.
            let fails = depth + 1 > MAX_DEPTH;
            assert_eq!(
                streaming_support::graph_text(&deep).contains("Maximum call stack size exceeded"),
                fails,
                "style {style}, depth {depth}"
            );
        }
    }
    for depth in [20_000, 1_000_000] {
        let doc = nested(depth, 0, "");
        for encoding in [Encoding::Stream, Encoding::Reader(4096), Encoding::Text] {
            let deep = case(false, &[("Deep", &[doc.as_str()])], encoding);
            streaming_support::check_light(&deep)
                .unwrap_or_else(|e| panic!("depth {depth}, {encoding:?}: {e}"));
            assert!(
                streaming_support::graph_text(&deep).contains("Maximum call stack size exceeded"),
                "depth {depth}, {encoding:?}"
            );
        }
    }
}
