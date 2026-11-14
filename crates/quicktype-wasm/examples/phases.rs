//! Where the engine's time goes natively, phase by phase, for comparing
//! with the WebAssembly engine in a browser
//! (`npm/quicktype-core/test/bench/phases.mjs`; docs/BENCHMARKS.md, "Where
//! the WebAssembly engine's time goes"). The same entry points as the
//! facade's, called in process: `jsonCreate` and `jsonRead` read the sample
//! into a compressed form, and a run over it takes a lease on it, as
//! `assemble` does, then runs quicktype to TypeScript. The spans are those
//! of `quicktype_core::trace`, so it needs the `trace` feature:
//!
//! ```sh
//! cargo run --release -p quicktype-wasm --features trace --example phases -- FILE [ROUNDS] [--json]
//! ```
//!
//! Prints the median of each phase over the rounds (after three warm-up
//! rounds), in milliseconds. The allocator is mimalloc, as in the CLI.

use std::collections::BTreeMap;
use std::time::Instant;

use quicktype_core::input::inputs::{CompressedTopLevel, JsonInput};
use quicktype_core::{InputData, Options, get_target_language, quicktype_multi_file_sync, trace};
use quicktype_wasm::samples::{json_acquire, json_create, json_drop, json_read, take_lease};

/// The CLI's allocator.
#[global_allocator]
static GLOBAL: mimalloc::MiMalloc = mimalloc::MiMalloc;

fn median(values: &mut [f64]) -> f64 {
    values.sort_by(f64::total_cmp);
    let middle = values.len() / 2;
    if values.len() % 2 == 1 {
        values[middle]
    } else {
        (values[middle - 1] + values[middle]) / 2.0
    }
}

fn main() {
    let args: Vec<String> = std::env::args().skip(1).collect();
    let positional: Vec<&String> = args.iter().filter(|a| !a.starts_with("--")).collect();
    let Some(file) = positional.first() else {
        eprintln!("usage: phases FILE [ROUNDS] [--json]");
        std::process::exit(2);
    };
    let rounds: usize = positional.get(1).map_or(21, |r| r.parse().expect("ROUNDS"));
    let text = std::fs::read_to_string(file).expect("the input file");
    if !trace::ENABLED {
        eprintln!("phases: build it with --features trace");
        std::process::exit(2);
    }
    let lang = get_target_language("typescript").expect("typescript");
    let mut phases: BTreeMap<String, Vec<f64>> = BTreeMap::new();
    let mut output_length = 0;
    for round in 0..rounds + 3 {
        let _ = trace::take();
        let start = Instant::now();
        let id = json_create("default", false, None, None)
            .expect("jsonCreate")
            .expect("room for an input");
        let root = json_read(id, &text);
        assert!(root > 0, "jsonRead returned {root}");
        let read = Instant::now();
        let (_, form) = take_lease(json_acquire(id).expect("a lease")).expect("the lease");
        let input = JsonInput::from_shared(
            form,
            vec![CompressedTopLevel {
                name: "TopLevel".to_owned(),
                description: None,
                samples: vec![root],
            }],
        )
        .expect("an input over the form");
        let mut input_data = InputData::new();
        input_data.add_input(input);
        let files = quicktype_multi_file_sync(Options::new(lang, input_data)).expect("the run");
        let ran = Instant::now();
        output_length = files.values().map(|f| f.lines.join("\n").len()).sum();
        drop(files);
        json_drop(id);
        let (spans, dropped) = trace::take();
        assert_eq!(dropped, 0);
        if round < 3 {
            continue;
        }
        let mut sums: BTreeMap<String, f64> = BTreeMap::new();
        for (name, start, end) in spans {
            *sums.entry(name).or_default() += end - start;
        }
        sums.insert("(read)".to_owned(), (read - start).as_secs_f64() * 1000.0);
        sums.insert("(run)".to_owned(), (ran - read).as_secs_f64() * 1000.0);
        for (name, ms) in sums {
            phases.entry(name).or_default().push(ms);
        }
    }
    let name = std::path::Path::new(file.as_str())
        .file_name()
        .map_or_else(|| file.to_string(), |n| n.to_string_lossy().into_owned());
    if args.iter().any(|a| a == "--json") {
        let medians: Vec<String> = phases
            .iter_mut()
            .map(|(phase, ms)| format!("{phase:?}: {}", median(ms)))
            .collect();
        println!(
            "{{\"input\": {name:?}, \"outputLength\": {output_length}, \"medians\": {{{}}}}}",
            medians.join(", ")
        );
    } else {
        println!("{name}: {output_length} bytes of TypeScript; medians of {rounds} rounds, ms");
        for (phase, ms) in &mut phases {
            println!("  {phase:<40} {:>10.3}", median(ms));
        }
    }
}
