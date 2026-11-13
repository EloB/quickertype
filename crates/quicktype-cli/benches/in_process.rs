//! In-process throughput of the engine: the JavaScript API's workload
//! (`JSON.parse` semantics, no process start, no file I/O), natively.
//!
//! ```text
//! cargo bench -p quickertype --bench in_process [-- [--iterations N] [--json]]
//! cargo bench -p quickertype --bench in_process --no-default-features   # system allocator
//! QUICKTYPE_INFERENCE=compressed-json cargo bench -p quickertype --bench in_process
//!     # inference from the compressed form instead of from running tallies
//!     # (JsonInput::new reads the variable)
//! ```
//!
//! It lives in the CLI crate to run with the CLI's global allocator
//! (mimalloc, the `mimalloc` feature); the engine is quicktype-core's public
//! API.
//!
//! One iteration runs every JSON file in `tests/inputs/json/samples` (and
//! `json/misc/1b409.json`, the largest misc file) through eight target
//! languages: 14 inputs × 8 languages = 112 runs. Each run builds a
//! `JsonInput` from the text (the "parse" phase: `JSON.parse` plus the
//! running tallies, or `CompressedJSON`) and calls `quicktype_multi_file_sync` (the "engine"
//! phase: inference, rewrites, naming, rendering). The timing of the
//! reference TypeScript for the same workload comes from
//! `xtask/bench/in-process.mjs`; `cargo xtask bench --in-process` runs both.

#[cfg(feature = "mimalloc")]
#[global_allocator]
static GLOBAL: mimalloc::MiMalloc = mimalloc::MiMalloc;

use std::path::{Path, PathBuf};
use std::time::{Duration, Instant};

use quicktype_core::{
    InputData, JsonSourceData, Options, RendererOptions, get_target_language,
    json_input_for_target_language, quicktype_multi_file_sync,
};

/// The global allocator.
const ALLOCATOR: &str = if cfg!(feature = "mimalloc") {
    "mimalloc"
} else {
    "system"
};

/// The languages, by CLI name.
const LANGUAGES: [&str; 8] = ["ts", "rust", "go", "cs", "java", "py", "swift", "c++"];

fn inputs_dir() -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("../../tests/inputs/json")
}

/// The input files, sorted by name, with their text.
fn inputs() -> Vec<(String, String)> {
    let dir = inputs_dir();
    let mut paths: Vec<PathBuf> = std::fs::read_dir(dir.join("samples"))
        .expect("tests/inputs/json/samples")
        .flatten()
        .map(|e| e.path())
        .filter(|p| p.extension().is_some_and(|e| e == "json"))
        .collect();
    paths.sort();
    paths.push(dir.join("misc/1b409.json"));
    paths
        .into_iter()
        .map(|p| {
            let text = std::fs::read_to_string(&p).expect("readable input");
            let name = p.file_name().unwrap().to_string_lossy().into_owned();
            (name, text)
        })
        .collect()
}

/// One run; returns (parse time, engine time, output bytes).
fn run(lang: &str, text: &str) -> (Duration, Duration, usize) {
    let lang = get_target_language(lang).expect("built-in language");
    let start = Instant::now();
    let mut input = json_input_for_target_language(lang, false, &RendererOptions::new());
    input
        .add_source_sync(JsonSourceData {
            name: "TopLevel".to_owned(),
            samples: vec![text.into()],
            description: None,
        })
        .expect("valid sample");
    let mut input_data = InputData::new();
    input_data.add_input(input);
    let parsed = Instant::now();
    let files = quicktype_multi_file_sync(Options::new(lang, input_data)).expect("run succeeds");
    let done = Instant::now();
    let bytes = files
        .values()
        .map(|f| f.lines.iter().map(|l| l.len() + 1).sum::<usize>())
        .sum();
    (parsed - start, done - parsed, bytes)
}

/// Reports a bad argument and exits.
fn usage_error(message: &str) -> ! {
    eprintln!("in_process: {message}");
    std::process::exit(2);
}

fn main() {
    let mut iterations = 10usize;
    let mut json = false;
    let mut filters: Vec<String> = Vec::new();
    let mut per_input = false;
    let mut languages: Vec<&'static str> = Vec::new();
    let mut args = std::env::args().skip(1);
    while let Some(a) = args.next() {
        match a.as_str() {
            "--iterations" | "-n" => {
                iterations = match args.next().map(|n| n.parse::<usize>()) {
                    Some(Ok(n)) if n >= 1 => n,
                    _ => usage_error("--iterations takes a whole number of at least 1"),
                };
            }
            "--json" => json = true,
            // Only inputs whose file name contains one of the filters.
            "--filter" => filters.extend(args.next()),
            // Also print the median time of each input and language.
            "--per-input" => per_input = true,
            // Only these languages (repeatable).
            "--lang" => {
                let name = args.next().unwrap_or_default();
                match LANGUAGES.iter().copied().find(|l| *l == name) {
                    Some(lang) => languages.push(lang),
                    None => usage_error(&format!(
                        "--lang takes one of {}, got {name:?}",
                        LANGUAGES.join(", ")
                    )),
                }
            }
            // `cargo bench` passes `--bench`.
            _ => {}
        }
    }
    let inputs: Vec<(String, String)> = inputs()
        .into_iter()
        .filter(|(name, _)| filters.is_empty() || filters.iter().any(|f| name.contains(f.as_str())))
        .collect();
    if inputs.is_empty() {
        usage_error("no input matches --filter");
    }
    if languages.is_empty() {
        languages = LANGUAGES.to_vec();
    }
    let runs = inputs.len() * languages.len();

    // Warm-up: first-use initialization (the Markov chain, pluralize's
    // rules) happens once per process, as in a long-lived JS process.
    let mut output_bytes = 0;
    for (_, text) in &inputs {
        for lang in &languages {
            output_bytes += run(lang, text).2;
        }
    }

    let mut totals = Vec::with_capacity(iterations);
    let mut parse_totals = Vec::with_capacity(iterations);
    let mut engine_totals = Vec::with_capacity(iterations);
    // Per input and language, every iteration's time.
    let mut cells: Vec<Vec<f64>> = vec![Vec::new(); runs];
    for _ in 0..iterations {
        let (mut parse, mut engine) = (Duration::ZERO, Duration::ZERO);
        for (i, (_, text)) in inputs.iter().enumerate() {
            for (j, lang) in languages.iter().enumerate() {
                let (p, e, _) = run(lang, text);
                parse += p;
                engine += e;
                cells[i * languages.len() + j].push((p + e).as_secs_f64() * 1000.0);
            }
        }
        totals.push((parse + engine).as_secs_f64() * 1000.0);
        parse_totals.push(parse.as_secs_f64() * 1000.0);
        engine_totals.push(engine.as_secs_f64() * 1000.0);
    }
    let summarize = |v: &mut Vec<f64>| {
        v.sort_by(f64::total_cmp);
        let n = v.len();
        let median = if n % 2 == 1 {
            v[n / 2]
        } else {
            (v[n / 2 - 1] + v[n / 2]) / 2.0
        };
        (median, v[0])
    };
    if per_input {
        print!("{:<32}", "input (ms per run, median)");
        for lang in &languages {
            print!("{lang:>8}");
        }
        println!();
        for (i, (name, _)) in inputs.iter().enumerate() {
            print!("{name:<32}");
            for j in 0..languages.len() {
                print!("{:>8.3}", summarize(&mut cells[i * languages.len() + j]).0);
            }
            println!();
        }
    }
    let (total, total_min) = summarize(&mut totals);
    let (parse, _) = summarize(&mut parse_totals);
    let (engine, _) = summarize(&mut engine_totals);
    if json {
        println!(
            "{{\"allocator\":\"{ALLOCATOR}\",\"runs\":{runs},\"iterations\":{iterations},\"total_ms\":{total},\"total_min_ms\":{total_min},\"parse_ms\":{parse},\"engine_ms\":{engine},\"output_bytes\":{output_bytes}}}"
        );
    } else {
        println!(
            "in-process: {} inputs × {} languages = {runs} runs per iteration, {iterations} iterations, {ALLOCATOR} allocator",
            inputs.len(),
            languages.len()
        );
        println!("  total   median {total:.1} ms  (min {total_min:.1} ms)");
        println!("  parse   median {parse:.1} ms");
        println!("  engine  median {engine:.1} ms");
        println!("  per run {:.3} ms", total / runs as f64);
    }
}
