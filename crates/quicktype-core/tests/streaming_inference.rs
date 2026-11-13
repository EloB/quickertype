//! Inference from running tallies, and from tallies of the compressed form,
//! gives what quicktype infers from the compressed form of the samples
//! value by value (docs/STREAMING-INFERENCE.md): generated inputs go
//! through each, and everything must be identical (each source's error,
//! the type graph right after inference for every combination of the
//! inference flags, and a whole run for a language and option set).
//!
//! `tallies_infer_what_the_compressed_form_infers` and
//! `compressed_tallies_infer_what_the_compressed_form_infers` check a few
//! thousand seeds; `cargo xtask streaming-fuzz` runs the ignored `fuzz`
//! test over millions (`QUICKTYPE_STREAMING_SEEDS`,
//! `QUICKTYPE_STREAMING_START`, `QUICKTYPE_STREAMING_JOBS`; per seed
//! `QUICKTYPE_STREAMING_GRAPHS` graphs and `QUICKTYPE_STREAMING_RUNS` whole
//! runs on every `QUICKTYPE_STREAMING_RUNS_EVERY`th seed;
//! `QUICKTYPE_STREAMING_PATH` the ways of inferring compared with the
//! reference, `running` (the CLI's, the default), `compressed` (the
//! WebAssembly engine's) or `all`; `QUICKTYPE_STREAMING_TRACE` prints each
//! seed as it starts), and the
//! ignored `dump_documents` writes generated documents for comparing both
//! CLIs with the TypeScript one (`QUICKTYPE_STREAMING_DUMP`).

mod streaming_support;

use std::path::PathBuf;

use streaming_support::generator::{self, Case, Encoding, Limits, Sample, Source};
use streaming_support::{Effort, Path, check_many};

const LIMITS: Limits = Limits {
    lone_surrogates: true,
    max_depth: 10,
    big_maps: true,
    max_bytes: 16_000,
    deep_permille: 3,
};

/// For the few thousand seeds of `cargo test` (unoptimized): fewer samples
/// nested near the depth limit, whose rewrites after inference are slow on
/// both paths; `deep_nesting` covers those depths on its own.
const CI_LIMITS: Limits = Limits {
    deep_permille: 1,
    ..LIMITS
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

fn check_seeds(
    default_count: u64,
    limits: Limits,
    default_effort: Effort,
    progress: bool,
    path: Path,
) {
    let start = env_u64("QUICKTYPE_STREAMING_START", 0);
    let count = env_u64("QUICKTYPE_STREAMING_SEEDS", default_count);
    let effort = Effort {
        graphs: env_u64("QUICKTYPE_STREAMING_GRAPHS", default_effort.graphs as u64) as usize,
        runs: env_u64("QUICKTYPE_STREAMING_RUNS", default_effort.runs as u64) as usize,
        runs_every: env_u64("QUICKTYPE_STREAMING_RUNS_EVERY", default_effort.runs_every),
    };
    let begun = std::time::Instant::now();
    match check_many(start, count, jobs(), limits, effort, progress, path) {
        Ok(stats) => eprintln!(
            "{count} seeds from {start}, {path:?}: 0 differences ({} graphs, {} runs of which {} failed alike, {} runs skipped for a $ref cycle through a union, {} source errors alike) in {:.1?}",
            stats.graphs,
            stats.runs,
            stats.failed_runs,
            stats.skipped_runs,
            stats.source_errors,
            begun.elapsed()
        ),
        Err(failures) => panic!("{}", failures.join("\n\n")),
    }
}

#[test]
fn tallies_infer_what_the_compressed_form_infers() {
    let effort = Effort {
        graphs: 5,
        runs: 1,
        runs_every: 1,
    };
    check_seeds(3_000, CI_LIMITS, effort, false, Path::RunningTallies);
}

/// The WebAssembly engine's path: tallies of the compressed form, as the
/// readers made it and as tables imported from JavaScript.
#[test]
fn compressed_tallies_infer_what_the_compressed_form_infers() {
    let effort = Effort {
        graphs: 5,
        runs: 1,
        runs_every: 1,
    };
    check_seeds(3_000, CI_LIMITS, effort, false, Path::CompressedTallies);
}

/// The long run (`cargo xtask streaming-fuzz`).
#[test]
#[ignore]
fn fuzz() {
    std::panic::set_hook(Box::new(|_| {}));
    let effort = Effort {
        graphs: 2,
        runs: 1,
        runs_every: 10,
    };
    let path = std::env::var("QUICKTYPE_STREAMING_PATH").map_or(Path::RunningTallies, |name| {
        Path::named(&name).unwrap_or_else(|| panic!("unknown QUICKTYPE_STREAMING_PATH {name}"))
    });
    check_seeds(100_000, LIMITS, effort, true, path);
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
        deep: false,
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
/// overflows the native stack. (Past 4,578 levels, a sample read with
/// `JSON.parse` semantics fails while it is read, as in TypeScript; see
/// "Very deeply nested JSON" in `docs/PARITY.md`.)
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
    for (depth, style) in [(20_000, 0), (1_000_000, 0), (100_000, 1), (100_000, 2)] {
        let doc = nested(depth, style, if style == 0 { "" } else { "1" });
        for encoding in [Encoding::Stream, Encoding::Reader(4096), Encoding::Text] {
            eprintln!("depth {depth}, style {style}, {encoding:?}");
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

/// Lists the seeds from `QUICKTYPE_STREAMING_START` whose cases are nested
/// around the depth limit or beyond, or handle references (to look into a
/// seed without running it); with `QUICKTYPE_STREAMING_SHOW`, prints each
/// case whole.
#[test]
#[ignore]
fn list_cases() {
    let start = env_u64("QUICKTYPE_STREAMING_START", 0);
    let count = env_u64("QUICKTYPE_STREAMING_SEEDS", 1_000);
    for seed in start..start + count {
        let case = generator::case(seed, LIMITS);
        let bytes: usize = case
            .sources
            .iter()
            .flat_map(|s| &s.samples)
            .map(|s| s.text.len())
            .sum();
        if std::env::var_os("QUICKTYPE_STREAMING_SHOW").is_some() {
            eprintln!("seed {seed}: {case:#?}");
        } else if case.deep || case.handle_refs {
            eprintln!(
                "seed {seed}: deep {}, refs {}, {} sources, {bytes} bytes",
                case.deep,
                case.handle_refs,
                case.sources.len()
            );
        }
    }
}

/// One whole run of the case of seed `QUICKTYPE_STREAMING_START` with
/// `QUICKTYPE_STREAMING_LANG` and the CLI flags `QUICKTYPE_STREAMING_OPTIONS`,
/// from tallies unless `QUICKTYPE_INFERENCE=compressed-json` (which
/// `JsonInput::new` reads; to look into a seed).
#[test]
#[ignore]
fn one_run() {
    let seed = env_u64("QUICKTYPE_STREAMING_START", 0);
    let lang = std::env::var("QUICKTYPE_STREAMING_LANG").unwrap_or_else(|_| "typescript".into());
    let options = std::env::var("QUICKTYPE_STREAMING_OPTIONS").unwrap_or_default();
    let case = generator::case(seed, LIMITS);
    let (sources, result) = streaming_support::on_cli_stack(|| {
        streaming_support::run(&case, streaming_support::language(&lang), &options, None)
    });
    eprintln!("sources: {sources:?}");
    match result {
        Ok(files) => {
            for (name, file) in files {
                eprintln!("== {name}\n{}", file.lines.join("\n"));
            }
        }
        Err(e) => eprintln!("error: {e}"),
    }
}
