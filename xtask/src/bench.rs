//! `cargo xtask bench`: times the Rust CLI against the TypeScript CLI on a
//! fixed set of inputs and prints a Markdown report.
//!
//! Every benchmark is one CLI invocation, run once to warm the file cache
//! (and to check that both CLIs write identical files), then timed
//! `--iterations` times. The report gives the median and the minimum wall
//! time per command and, where `/usr/bin/time` can measure it, the peak
//! resident set size of one more run. `--corpus` also replays every step of
//! every golden case once per command and reports the wall time.
//!
//! The generated inputs (`generated-*.json`) are written to `target/bench`
//! by a seeded generator, so every machine benchmarks the same bytes.
//!
//! `--json <file>` also writes the results as JSON (the playground's
//! `site/data/benchmarks.json`, which `site/build.mjs` validates): the
//! date, the machine, the commits measured, and every number of the report.
//! The commit of a CLI built here is this checkout's HEAD; that of one
//! given with `--bin` or `--baseline` is the HEAD of the work tree whose
//! `target` directory holds it, if it was built after that commit, and
//! otherwise null; `commits.<id>_source` says which.

use std::collections::BTreeMap;
use std::fmt::Write as _;
use std::fs;
use std::path::{Path, PathBuf};
use std::process::{Command, Stdio};
use std::sync::Mutex;
use std::sync::atomic::{AtomicUsize, Ordering};
use std::time::{Duration, Instant, UNIX_EPOCH};

use crate::diff::find_reference;
use crate::parity::{base_command, build_cli, find_cases, prepare_case, snapshot, step_command};

pub const USAGE: &str = "\
cargo xtask bench [options]

Times our quicktype CLI against the TypeScript CLI and prints a Markdown
report (median and min wall time, peak RSS, speedup).

  --ref \"<cmd ...>\"      TypeScript CLI (default: node <checkout>/dist/index.js,
                         found like `cargo xtask diff` does)
  --ref-dir <dir>        the quicktype checkout --in-process benchmarks (default:
                         the checkout of --ref's dist/index.js)
  --no-ref               do not run the TypeScript CLI
  --bin \"<cmd ...>\"      our CLI (default: builds target/release/quickertype)
  --baseline \"<cmd ...>\" an older build of ours to compare with (\"before\")
  -n, --iterations <n>   timed runs per benchmark and command (default 10)
  --filter <substr>      only benchmarks whose name contains <substr> (repeatable)
  --corpus               also replay the whole golden corpus once per command
  --in-process           also run the in-process benchmark: the engine as a
                         library (crates/quicktype-cli/benches/in_process.rs,
                         with mimalloc and with the system allocator)
                         against the reference quicktype-core in a warm Node
                         process (xtask/bench/in-process.mjs)
  -j <n>                 parallel jobs for --corpus (default: number of cores)
  --out <file>           also write the report to <file>
  --json <file>          also write the results as JSON to <file>, with the
                         date, the machine and the commits measured (the
                         playground's site/data/benchmarks.json); a --bin or
                         --baseline CLI's commit is its work tree's HEAD if it
                         is in that work tree's target directory and newer
                         than HEAD, else null, and the JSON says which
";

struct Options {
    reference: Option<Vec<String>>,
    ref_dir: Option<PathBuf>,
    no_ref: bool,
    ours: Option<Vec<String>>,
    baseline: Option<Vec<String>>,
    iterations: usize,
    filters: Vec<String>,
    corpus: bool,
    in_process: bool,
    jobs: usize,
    out: Option<PathBuf>,
    json: Option<PathBuf>,
}

fn parse_options(args: Vec<String>) -> Result<Options, String> {
    let mut o = Options {
        reference: None,
        ref_dir: None,
        no_ref: false,
        ours: None,
        baseline: None,
        iterations: 10,
        filters: vec![],
        corpus: false,
        in_process: false,
        jobs: std::thread::available_parallelism().map_or(4, |n| n.get()),
        out: None,
        json: None,
    };
    let split = |s: String| -> Vec<String> { s.split_whitespace().map(String::from).collect() };
    let mut args = args.into_iter();
    while let Some(a) = args.next() {
        let mut value = || args.next().ok_or_else(|| format!("missing value for {a}"));
        match a.as_str() {
            "--ref" => o.reference = Some(split(value()?)),
            "--ref-dir" => o.ref_dir = Some(PathBuf::from(value()?)),
            "--no-ref" => o.no_ref = true,
            "--bin" => o.ours = Some(split(value()?)),
            "--baseline" => o.baseline = Some(split(value()?)),
            "-n" | "--iterations" => {
                o.iterations = value()?.parse().map_err(|_| "bad --iterations")?;
            }
            "--filter" => o.filters.push(value()?),
            "--corpus" => o.corpus = true,
            "--in-process" => o.in_process = true,
            "-j" | "--jobs" => o.jobs = value()?.parse().map_err(|_| "bad -j")?,
            "--out" => o.out = Some(PathBuf::from(value()?)),
            "--json" => o.json = Some(PathBuf::from(value()?)),
            _ => return Err(format!("unknown argument {a}\n\n{USAGE}")),
        }
    }
    o.iterations = o.iterations.max(1);
    Ok(o)
}

/// A command under test.
struct Tool {
    /// Its key in the JSON results: `typescript`, `baseline` or `rust`.
    id: &'static str,
    label: &'static str,
    cmd: Vec<String>,
}

/// One benchmark: a quicktype invocation. `{INPUTS}` and `{BENCH}` in the
/// arguments are replaced by `tests/inputs` and `target/bench`.
struct Bench {
    group: &'static str,
    name: &'static str,
    args: Vec<&'static str>,
    /// Directories to create in the work directory first.
    dirs: Vec<&'static str>,
}

fn bench(group: &'static str, name: &'static str, args: &[&'static str]) -> Bench {
    Bench {
        group,
        name,
        args: args.to_vec(),
        dirs: vec![],
    }
}

/// The benchmark set. Input sizes: simple-object 77 B, pokedex 82 KB,
/// github-events 82 KB, us-senators 155 KB, 1b409 606 KB (the largest
/// `json/misc` file), generated-small 4 MB, generated-large 40 MB;
/// vega-lite.schema 306 KB, github.gqlschema 1.2 MB.
fn benchmarks() -> Vec<Bench> {
    let mut all = vec![
        bench("startup", "--version", &["--version"]),
        bench(
            "startup",
            "tiny JSON (77 B) → TypeScript",
            &[
                "{INPUTS}/json/samples/simple-object.json",
                "-l",
                "ts",
                "-o",
                "out.ts",
            ],
        ),
        bench(
            "json",
            "pokedex (82 KB) → TypeScript",
            &[
                "{INPUTS}/json/samples/pokedex.json",
                "-l",
                "ts",
                "-o",
                "out.ts",
            ],
        ),
        bench(
            "json",
            "us-senators (155 KB) → TypeScript",
            &[
                "{INPUTS}/json/samples/us-senators.json",
                "-l",
                "ts",
                "-o",
                "out.ts",
            ],
        ),
        bench(
            "json",
            "misc/1b409 (606 KB) → TypeScript",
            &["{INPUTS}/json/misc/1b409.json", "-l", "ts", "-o", "out.ts"],
        ),
        bench(
            "json",
            "all 13 samples as one top-level (multi-source) → TypeScript",
            &["--src", "{INPUTS}/json/samples", "-l", "ts", "-o", "out.ts"],
        ),
        bench(
            "json",
            "generated (4 MB) → TypeScript",
            &["{BENCH}/generated-small.json", "-l", "ts", "-o", "out.ts"],
        ),
        bench(
            "json",
            "generated (40 MB) → TypeScript",
            &["{BENCH}/generated-large.json", "-l", "ts", "-o", "out.ts"],
        ),
        bench(
            "json",
            "generated (40 MB) → Rust",
            &["{BENCH}/generated-large.json", "-l", "rust", "-o", "out.rs"],
        ),
    ];
    for (lang, out) in [
        ("ts", "out.ts"),
        ("rust", "out.rs"),
        ("go", "out.go"),
        ("cs", "out.cs"),
        ("java", "src/TopLevel.java"),
        ("py", "out.py"),
        ("swift", "out.swift"),
        ("c++", "out.hpp"),
    ] {
        let name: &'static str =
            Box::leak(format!("github-events (82 KB) → {lang}").into_boxed_str());
        let mut b = bench(
            "languages",
            name,
            &[
                "{INPUTS}/json/samples/github-events.json",
                "-l",
                lang,
                "-o",
                out,
            ],
        );
        if lang == "java" {
            b.dirs.push("src");
        }
        all.push(b);
    }
    all.extend([
        bench(
            "schema",
            "vega-lite.schema (306 KB) → TypeScript",
            &[
                "--src-lang",
                "schema",
                "{INPUTS}/schema/vega-lite.schema",
                "-l",
                "ts",
                "-o",
                "out.ts",
            ],
        ),
        bench(
            "schema",
            "vega-lite.schema (306 KB) → C#",
            &[
                "--src-lang",
                "schema",
                "{INPUTS}/schema/vega-lite.schema",
                "-l",
                "cs",
                "-o",
                "out.cs",
            ],
        ),
        bench(
            "graphql",
            "github.gqlschema (1.2 MB) + query → TypeScript",
            &[
                "--src-lang",
                "graphql",
                "--graphql-schema",
                "{INPUTS}/graphql/github.gqlschema",
                "{INPUTS}/graphql/github1.graphql",
                "-l",
                "ts",
                "-o",
                "out.ts",
            ],
        ),
        Bench {
            group: "multi-file",
            name: "vega-lite.schema → Java (one file per class)",
            args: vec![
                "--src-lang",
                "schema",
                "{INPUTS}/schema/vega-lite.schema",
                "-l",
                "java",
                "-o",
                "src/TopLevel.java",
            ],
            dirs: vec!["src"],
        },
        bench(
            "multi-file",
            "pokedex → C++ (multi-source)",
            &[
                "{INPUTS}/json/samples/pokedex.json",
                "-l",
                "c++",
                "--source-style",
                "multi-source",
                "-o",
                "quicktype.hpp",
            ],
        ),
    ]);
    all
}

// ---------------------------------------------------------------------------
// The generated inputs.

/// SplitMix64: a tiny, fast, seeded generator.
struct Rng(u64);

impl Rng {
    fn next(&mut self) -> u64 {
        self.0 = self.0.wrapping_add(0x9E37_79B9_7F4A_7C15);
        let mut z = self.0;
        z = (z ^ (z >> 30)).wrapping_mul(0xBF58_476D_1CE4_E5B9);
        z = (z ^ (z >> 27)).wrapping_mul(0x94D0_49BB_1331_11EB);
        z ^ (z >> 31)
    }

    fn below(&mut self, n: u64) -> u64 {
        self.next() % n
    }

    fn chance(&mut self, percent: u64) -> bool {
        self.below(100) < percent
    }

    fn pick<'a>(&mut self, items: &[&'a str]) -> &'a str {
        items[self.below(items.len() as u64) as usize]
    }
}

const WORDS: &[&str] = &[
    "alpha", "bravo", "charlie", "delta", "echo", "foxtrot", "golf", "hotel", "india", "juliet",
    "kilo", "lima", "mike", "november", "oscar", "papa", "quebec", "romeo", "sierra", "tango",
    "uniform", "victor", "whiskey", "xray", "yankee", "zulu", "amber", "birch", "cedar", "dune",
];
const CITIES: &[&str] = &[
    "Stockholm",
    "Lisbon",
    "Osaka",
    "Denver",
    "Nairobi",
    "Lima",
    "Oslo",
    "Perth",
    "Quito",
    "Riga",
];
const STATUSES: &[&str] = &["active", "inactive", "pending", "suspended", "archived"];
const COUNTRIES: &[&str] = &["SE", "PT", "JP", "US", "KE", "PE", "NO", "AU", "EC", "LV"];

fn push_timestamp(out: &mut String, rng: &mut Rng) {
    let _ = write!(
        out,
        "\"20{:02}-{:02}-{:02}T{:02}:{:02}:{:02}Z\"",
        10 + rng.below(15),
        1 + rng.below(12),
        1 + rng.below(28),
        rng.below(24),
        rng.below(60),
        rng.below(60)
    );
}

fn push_uuid(out: &mut String, rng: &mut Rng) {
    let a = rng.next();
    let b = rng.next();
    let _ = write!(
        out,
        "\"{:08x}-{:04x}-4{:03x}-8{:03x}-{:012x}\"",
        a >> 32,
        (a >> 16) & 0xFFFF,
        a & 0xFFF,
        b >> 52,
        b & 0xFFFF_FFFF_FFFF
    );
}

fn push_key(out: &mut String, rng: &mut Rng) {
    const CHARS: &[u8] = b"abcdefghijklmnopqrstuvwxyz0123456789";
    out.push('"');
    for _ in 0..10 {
        out.push(char::from(CHARS[rng.below(CHARS.len() as u64) as usize]));
    }
    out.push('"');
}

/// One record: nested classes, arrays of classes, a map with random keys,
/// enums, dates, UUIDs, URIs, integer strings, nullable and optional
/// properties, and a union of number and string.
fn push_record(out: &mut String, rng: &mut Rng, id: usize) {
    let first = rng.pick(WORDS);
    let last = rng.pick(WORDS);
    let _ = write!(out, "{{\"id\":{id},\"uuid\":",);
    push_uuid(out, rng);
    let _ = write!(
        out,
        ",\"name\":\"{first} {last}\",\"email\":\"{first}.{last}{}@example.com\",\"createdAt\":",
        rng.below(1000)
    );
    push_timestamp(out, rng);
    let _ = write!(
        out,
        ",\"score\":{}.{},\"visits\":{},\"active\":{},\"status\":\"{}\",\"homepage\":\"https://example.com/users/{id}\"",
        rng.below(100),
        rng.below(100),
        rng.below(100_000),
        rng.chance(50),
        rng.pick(STATUSES)
    );
    out.push_str(",\"tags\":[");
    for i in 0..rng.below(5) {
        if i > 0 {
            out.push(',');
        }
        let _ = write!(out, "\"{}\"", rng.pick(WORDS));
    }
    let _ = write!(
        out,
        "],\"address\":{{\"street\":\"{} {} Street\",\"city\":\"{}\",\"zip\":\"{:05}\",\"country\":\"{}\",\"geo\":{{\"lat\":{}.{},\"lng\":{}.{}}}}}",
        rng.below(999) + 1,
        rng.pick(WORDS),
        rng.pick(CITIES),
        rng.below(100_000),
        rng.pick(COUNTRIES),
        rng.below(90),
        rng.below(1_000_000),
        rng.below(180),
        rng.below(1_000_000)
    );
    out.push_str(",\"orders\":[");
    for i in 0..rng.below(4) {
        if i > 0 {
            out.push(',');
        }
        let _ = write!(
            out,
            "{{\"orderId\":{},\"sku\":\"SKU-{}\",\"quantity\":{},\"unitPrice\":{}.{:02},\"shippedAt\":",
            rng.below(1_000_000),
            rng.below(10_000),
            1 + rng.below(9),
            rng.below(500),
            rng.below(100)
        );
        if rng.chance(30) {
            out.push_str("null");
        } else {
            push_timestamp(out, rng);
        }
        if rng.chance(20) {
            let _ = write!(
                out,
                ",\"note\":\"Please leave the parcel with the {} at the {} entrance, thank you very much\"",
                rng.pick(WORDS),
                rng.pick(WORDS)
            );
        }
        out.push('}');
    }
    out.push_str("],\"preferences\":{");
    for i in 0..1 + rng.below(6) {
        if i > 0 {
            out.push(',');
        }
        push_key(out, rng);
        let _ = write!(out, ":{}", rng.below(1000));
    }
    out.push_str("},\"manager\":");
    if rng.chance(40) {
        out.push_str("null");
    } else {
        let _ = write!(
            out,
            "{{\"id\":{},\"name\":\"{} {}\",\"since\":\"20{:02}-{:02}-{:02}\"}}",
            rng.below(1000),
            rng.pick(WORDS),
            rng.pick(WORDS),
            10 + rng.below(15),
            1 + rng.below(12),
            1 + rng.below(28)
        );
    }
    out.push_str(",\"rating\":");
    match rng.below(4) {
        0 => {
            let _ = write!(out, "{}", rng.below(6));
        }
        1 => {
            let _ = write!(out, "{}.5", rng.below(5));
        }
        2 => out.push_str("\"n/a\""),
        _ => out.push_str("null"),
    }
    out.push('}');
}

/// A JSON document with `records` records, about 650 bytes each.
fn generate_json(records: usize, seed: u64) -> String {
    let mut rng = Rng(seed);
    let mut out = String::with_capacity(records * 700);
    out.push_str("{\"generatedAt\":\"2024-01-01T00:00:00Z\",\"records\":[\n");
    for id in 0..records {
        if id > 0 {
            out.push_str(",\n");
        }
        push_record(&mut out, &mut rng, id);
    }
    out.push_str("\n]}\n");
    out
}

/// Writes the generated inputs that `benches` use (an argument names them
/// as `{BENCH}/<name>`), unless they are already up to date.
fn write_generated_inputs(dir: &Path, benches: &[Bench]) -> Result<(), String> {
    for (name, records) in [
        ("generated-small.json", 6_000),
        ("generated-large.json", 60_000),
    ] {
        let reference = format!("{{BENCH}}/{name}");
        if !benches.iter().any(|b| b.args.contains(&reference.as_str())) {
            continue;
        }
        fs::create_dir_all(dir).map_err(|e| e.to_string())?;
        let text = generate_json(records, 0x5EED_0000 + records as u64);
        let path = dir.join(name);
        if fs::read(&path).ok().as_deref() != Some(text.as_bytes()) {
            fs::write(&path, text).map_err(|e| format!("{}: {e}", path.display()))?;
        }
    }
    Ok(())
}

// ---------------------------------------------------------------------------
// Measuring.

#[derive(Default, Clone)]
struct Stats {
    median: f64,
    min: f64,
    /// Peak resident set size in bytes, if measured.
    rss: Option<u64>,
}

fn median(sorted: &[f64]) -> f64 {
    let n = sorted.len();
    if n % 2 == 1 {
        sorted[n / 2]
    } else {
        (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0
    }
}

fn command(cmd: &[String], args: &[String], work: &Path) -> Command {
    let mut command = base_command(cmd, work);
    command.args(args);
    command
}

fn run_once(cmd: &[String], args: &[String], work: &Path) -> Result<Duration, String> {
    let start = Instant::now();
    let out = command(cmd, args, work)
        .stdout(Stdio::null())
        .stderr(Stdio::piped())
        .output()
        .map_err(|e| format!("cannot spawn {}: {e}", cmd[0]))?;
    let elapsed = start.elapsed();
    if !out.status.success() {
        return Err(format!(
            "{} exited with {}: {}",
            cmd.join(" "),
            out.status,
            String::from_utf8_lossy(&out.stderr)
                .lines()
                .next()
                .unwrap_or("")
        ));
    }
    Ok(elapsed)
}

/// The peak RSS of one run, measured with `/usr/bin/time` (`-l` on macOS,
/// `-v` with GNU time elsewhere).
fn peak_rss(cmd: &[String], args: &[String], work: &Path) -> Option<u64> {
    let time = Path::new("/usr/bin/time");
    if !time.is_file() {
        return None;
    }
    let flag = if cfg!(target_os = "macos") {
        "-l"
    } else {
        "-v"
    };
    let mut wrapped = vec![time.to_string_lossy().into_owned(), flag.to_owned()];
    wrapped.extend(cmd.iter().cloned());
    let out = command(&wrapped, args, work)
        .stdout(Stdio::null())
        .stderr(Stdio::piped())
        .output()
        .ok()?;
    let stderr = String::from_utf8_lossy(&out.stderr);
    stderr.lines().rev().find_map(|line| {
        let line = line.trim();
        if let Some(bytes) = line.strip_suffix("maximum resident set size") {
            bytes.trim().parse().ok()
        } else {
            let kb = line.strip_prefix("Maximum resident set size (kbytes):")?;
            kb.trim().parse::<u64>().ok().map(|k| k * 1024)
        }
    })
}

fn measure(
    tool: &Tool,
    b: &Bench,
    args: &[String],
    work: &Path,
    iterations: usize,
) -> Result<(Stats, BTreeMap<String, Vec<u8>>), String> {
    let _ = fs::remove_dir_all(work);
    fs::create_dir_all(work).map_err(|e| e.to_string())?;
    for dir in &b.dirs {
        fs::create_dir_all(work.join(dir)).map_err(|e| e.to_string())?;
    }
    // Warm-up, and the files to compare between tools.
    run_once(&tool.cmd, args, work)?;
    let files = snapshot(work);
    let mut times: Vec<f64> = Vec::with_capacity(iterations);
    for _ in 0..iterations {
        times.push(run_once(&tool.cmd, args, work)?.as_secs_f64() * 1000.0);
    }
    times.sort_by(f64::total_cmp);
    let stats = Stats {
        median: median(&times),
        min: times[0],
        rss: peak_rss(&tool.cmd, args, work),
    };
    Ok((stats, files))
}

// ---------------------------------------------------------------------------
// The corpus.

struct CorpusStats {
    wall: Duration,
    process: Duration,
    steps: usize,
    failed_steps: usize,
}

/// Runs every step of every golden case once with `jobs` parallel jobs,
/// without checking the outputs (that is `cargo xtask parity`).
fn run_corpus(root: &Path, cmd: &[String], jobs: usize) -> Result<CorpusStats, String> {
    let golden = root.join("tests/golden");
    let inputs = root.join("tests/inputs").to_string_lossy().into_owned();
    let mut dirs = vec![];
    find_cases(&golden, &mut dirs);
    dirs.sort();
    let work_root = root.join("target/bench/corpus");
    let next = AtomicUsize::new(0);
    let totals = Mutex::new((Duration::ZERO, 0usize, 0usize));
    let start = Instant::now();
    std::thread::scope(|s| {
        for _ in 0..jobs.max(1) {
            s.spawn(|| {
                loop {
                    let i = next.fetch_add(1, Ordering::Relaxed);
                    let Some(dir) = dirs.get(i) else { break };
                    let work = work_root.join(format!("w{i}"));
                    let (busy, steps, failed) = corpus_case(cmd, &inputs, dir, &work);
                    let _ = fs::remove_dir_all(&work);
                    let mut t = totals.lock().expect("lock");
                    t.0 += busy;
                    t.1 += steps;
                    t.2 += failed;
                }
            });
        }
    });
    let wall = start.elapsed();
    let (process, steps, failed_steps) = totals.into_inner().expect("lock");
    Ok(CorpusStats {
        wall,
        process,
        steps,
        failed_steps,
    })
}

/// Runs one case's steps; returns the time spent in the CLI, the number of
/// steps and how many of them could not even be started or exited
/// unexpectedly.
fn corpus_case(
    cmd: &[String],
    inputs: &str,
    case_dir: &Path,
    work: &Path,
) -> (Duration, usize, usize) {
    let Ok(case) = prepare_case(case_dir, work) else {
        return (Duration::ZERO, 0, 1);
    };
    let mut busy = Duration::ZERO;
    let mut failed = 0;
    for step in &case.steps {
        let Ok(mut command) = step_command(cmd, inputs, &case, step, work) else {
            failed += 1;
            continue;
        };
        command.stdout(Stdio::null()).stderr(Stdio::null());
        let start = Instant::now();
        let status = command.status();
        busy += start.elapsed();
        let expected_ok = step.exit.map_or(!step.expect_failure, |code| code == 0);
        match status {
            Ok(s) if s.success() == expected_ok => {}
            _ => failed += 1,
        }
    }
    (busy, case.steps.len(), failed)
}

// ---------------------------------------------------------------------------
// The report.

fn shell_output(program: &str, args: &[&str]) -> Option<String> {
    let out = Command::new(program).args(args).output().ok()?;
    out.status
        .success()
        .then(|| String::from_utf8_lossy(&out.stdout).trim().to_owned())
        .filter(|s| !s.is_empty())
}

/// One line of the machine's description: its JSON key, its label in the
/// report, its value.
struct MachineFact {
    key: &'static str,
    label: &'static str,
    value: String,
}

/// The machine's description, for the report and the JSON: on macOS and
/// Linux, always the CPU, the cores, the memory and the OS, each with a
/// fallback where the system does not say (the CPU's architecture for its
/// name, the threads the process may use for the cores).
fn machine_info(tools: &[Tool]) -> Vec<MachineFact> {
    let mut info = vec![];
    let mut fact = |key, label, value| info.push(MachineFact { key, label, value });
    let arch = shell_output("uname", &["-m"]).unwrap_or_else(|| std::env::consts::ARCH.to_owned());
    let parallelism = || {
        std::thread::available_parallelism()
            .ok()
            .map(|n| n.get().to_string())
    };
    let kernel = || shell_output("uname", &["-sr"]);
    if cfg!(target_os = "macos") {
        let cpu = shell_output("sysctl", &["-n", "machdep.cpu.brand_string"]);
        fact("cpu", "CPU", cpu.unwrap_or(arch));
        if let Some(n) = shell_output("sysctl", &["-n", "hw.ncpu"]).or_else(parallelism) {
            fact("cores", "Cores", n);
        }
        if let Some(bytes) =
            shell_output("sysctl", &["-n", "hw.memsize"]).and_then(|s| s.parse::<u64>().ok())
        {
            fact("memory", "Memory", gib(bytes));
        }
        let os = shell_output("sw_vers", &["-productVersion"]).map(|v| format!("macOS {v}"));
        fact(
            "os",
            "OS",
            os.or_else(kernel).unwrap_or_else(|| "macOS".to_owned()),
        );
        // "{ 1.23 4.56 7.89 }"
        if let Some(load) = shell_output("sysctl", &["-n", "vm.loadavg"]).and_then(|l| {
            l.trim_matches(['{', '}', ' '])
                .split_whitespace()
                .next()
                .map(String::from)
        }) {
            fact("load_average", "Load average (1 min, at the start)", load);
        }
    } else {
        let cpu = fs::read_to_string("/proc/cpuinfo")
            .ok()
            .and_then(|cpuinfo| cpu_from_cpuinfo(&cpuinfo, &arch));
        fact("cpu", "CPU", cpu.unwrap_or(arch));
        if let Some(n) = shell_output("nproc", &[]).or_else(parallelism) {
            fact("cores", "Cores", n);
        }
        if let Some(memory) = fs::read_to_string("/proc/meminfo")
            .ok()
            .and_then(|meminfo| memory_from_meminfo(&meminfo))
        {
            fact("memory", "Memory", memory);
        }
        fact(
            "os",
            "OS",
            kernel().unwrap_or_else(|| std::env::consts::OS.to_owned()),
        );
        if let Some(load) = fs::read_to_string("/proc/loadavg")
            .ok()
            .and_then(|l| l.split_whitespace().next().map(String::from))
        {
            fact("load_average", "Load average (1 min, at the start)", load);
        }
    }
    if let Some(v) = shell_output("rustc", &["--version"]) {
        fact("rustc", "rustc", v);
    }
    if tools
        .iter()
        .any(|t| t.cmd.first().is_some_and(|c| c == "node"))
    {
        if let Some(v) = shell_output("node", &["--version"]) {
            fact("node", "Node.js", v);
        }
    }
    info
}

/// Bytes in GiB, as the report shows memory: "64 GiB", "3.7 GiB".
fn gib(bytes: u64) -> String {
    let g = bytes as f64 / f64::from(1u32 << 30);
    if g >= 10.0 || (g - g.round()).abs() < 0.05 {
        format!("{g:.0} GiB")
    } else {
        format!("{g:.1} GiB")
    }
}

/// The value of the first `key : value` line of /proc/cpuinfo whose key is
/// `key`, if it is not empty.
fn cpuinfo_value<'a>(cpuinfo: &'a str, key: &str) -> Option<&'a str> {
    cpuinfo.lines().find_map(|line| {
        let (k, v) = line.split_once(':')?;
        Some(v.trim()).filter(|v| k.trim() == key && !v.is_empty())
    })
}

/// The CPU's name from /proc/cpuinfo: its "model name" (x86, 32-bit ARM),
/// else its "Hardware" (ARM boards and phones), else its "CPU part" with
/// the architecture `arch` (64-bit ARM servers, which name nothing else).
fn cpu_from_cpuinfo(cpuinfo: &str, arch: &str) -> Option<String> {
    cpuinfo_value(cpuinfo, "model name")
        .or_else(|| cpuinfo_value(cpuinfo, "Hardware"))
        .map(String::from)
        .or_else(|| {
            cpuinfo_value(cpuinfo, "CPU part").map(|part| format!("{arch}, CPU part {part}"))
        })
}

/// The memory from /proc/meminfo (`MemTotal:  65843876 kB`), in GiB.
fn memory_from_meminfo(meminfo: &str) -> Option<String> {
    let total = meminfo.lines().find_map(|l| l.strip_prefix("MemTotal:"))?;
    let kib: u64 = total.trim().strip_suffix("kB")?.trim().parse().ok()?;
    Some(gib(kib * 1024))
}

/// Where a CLI under test comes from, for the JSON results: the commit it
/// was built from, as far as can be told.
struct Provenance {
    commit: Option<String>,
    /// Whether its work tree had changes to tracked files; `None` if not known.
    modified: Option<bool>,
    /// How `commit` was found, or why it is not known.
    source: String,
}

impl Provenance {
    /// This checkout, which `build_cli` (or `cargo bench`) has just built.
    fn built(root: &Path) -> Self {
        Self {
            commit: git_head(root),
            modified: git_modified(root),
            source: "this checkout, built by cargo xtask bench".to_owned(),
        }
    }

    /// A CLI given with `flag` (`--bin`, `--baseline`) whose first word is
    /// `program`: the HEAD of the git work tree whose `target` directory
    /// holds the binary, if the binary is newer than that commit; otherwise
    /// not known (it may have been built from anything).
    fn given(program: &str, flag: &str) -> Self {
        let unknown = |why: String| Self {
            commit: None,
            modified: None,
            source: why,
        };
        let Some(binary) = find_program(program) else {
            return unknown(format!("{flag} runs {program}, which was not found"));
        };
        let tree = binary
            .parent()
            .and_then(|dir| git_output(dir, &["rev-parse", "--show-toplevel"]))
            .and_then(|top| fs::canonicalize(top).ok())
            .filter(|top| binary.starts_with(top.join("target")));
        let Some((tree, commit)) = tree.and_then(|t| git_head(&t).map(|c| (t, c))) else {
            return unknown(format!(
                "{flag} runs {}, which is not in the target directory of a git work tree",
                binary.display()
            ));
        };
        let built = fs::metadata(&binary).and_then(|m| m.modified()).ok();
        let committed = git_output(&tree, &["log", "-1", "--format=%ct"])
            .and_then(|s| s.parse().ok())
            .map(|secs| UNIX_EPOCH + Duration::from_secs(secs));
        if matches!((built, committed), (Some(built), Some(committed)) if built < committed) {
            return unknown(format!(
                "{flag} runs {}, which is older than the HEAD of {} ({commit}), so it was built from something else",
                binary.display(),
                tree.display()
            ));
        }
        Self {
            commit: Some(commit),
            modified: git_modified(&tree),
            source: format!(
                "the HEAD of {}, whose target directory holds {flag}'s binary (built after that commit)",
                tree.display()
            ),
        }
    }
}

/// The file `program` runs: a path, or a name found on `PATH`.
fn find_program(program: &str) -> Option<PathBuf> {
    let path = Path::new(program);
    let found = if path.components().count() > 1 {
        Some(path.to_path_buf())
    } else {
        let paths = std::env::var_os("PATH")?;
        std::env::split_paths(&paths)
            .map(|dir| dir.join(program))
            .find(|p| p.is_file())
    };
    found.and_then(|p| fs::canonicalize(p).ok())
}

fn ms(v: f64) -> String {
    if v >= 100.0 {
        format!("{v:.0}")
    } else if v >= 10.0 {
        format!("{v:.1}")
    } else {
        format!("{v:.2}")
    }
}

fn mib(bytes: Option<u64>) -> String {
    bytes.map_or_else(
        || "n/a".into(),
        |b| format!("{:.1}", b as f64 / 1_048_576.0),
    )
}

fn ratio(slow: f64, fast: f64) -> String {
    if fast > 0.0 {
        format!("{:.1}×", slow / fast)
    } else {
        "–".into()
    }
}

pub fn run(root: &Path, args: Vec<String>) -> Result<bool, String> {
    let invocation = std::iter::once("cargo xtask bench".to_owned())
        .chain(args.iter().map(|a| shell_quote(a)))
        .collect::<Vec<_>>()
        .join(" ");
    let o = parse_options(args)?;
    // Found (or refused) up front, before minutes of other benchmarks.
    let in_process_checkout = if o.in_process && !o.no_ref {
        Some(reference_checkout(root, &o)?)
    } else {
        None
    };
    let mut tools = vec![];
    if !o.no_ref {
        let cmd = match &o.reference {
            Some(cmd) => cmd.clone(),
            None => {
                let script = find_reference(root)?.ok_or(
                    "TypeScript CLI not found: set QUICKTYPE_REFERENCE, pass --ref, or use --no-ref",
                )?;
                vec!["node".into(), script.to_string_lossy().into_owned()]
            }
        };
        tools.push(Tool {
            id: "typescript",
            label: "TypeScript",
            cmd,
        });
    }
    if let Some(cmd) = &o.baseline {
        tools.push(Tool {
            id: "baseline",
            label: "Rust (before)",
            cmd: cmd.clone(),
        });
    }
    let ours = match &o.ours {
        Some(cmd) => cmd.clone(),
        None => build_cli(root)?,
    };
    // The commits measured, before anything runs: our CLI's (built here, or
    // --bin's), the baseline's, and this checkout's for --in-process, which
    // builds it with cargo bench.
    let program = |cmd: &[String]| cmd.first().map_or(String::new(), Clone::clone);
    let mut provenance = vec![(
        "quickertype",
        if o.ours.is_some() {
            Provenance::given(&program(&ours), "--bin")
        } else {
            Provenance::built(root)
        },
    )];
    if let Some(cmd) = &o.baseline {
        provenance.push(("baseline", Provenance::given(&program(cmd), "--baseline")));
    }
    let in_process_provenance = o.in_process.then(|| Provenance::built(root));
    tools.push(Tool {
        id: "rust",
        label: if o.baseline.is_some() {
            "Rust (after)"
        } else {
            "Rust"
        },
        cmd: ours,
    });

    // Before anything runs: the load average says how quiet the machine was.
    let machine = machine_info(&tools);
    let date = utc_date();

    let bench_dir = root.join("target/bench");
    let inputs = root.join("tests/inputs").to_string_lossy().into_owned();
    let bench_dir_str = bench_dir.to_string_lossy().into_owned();

    let selected: Vec<Bench> = benchmarks()
        .into_iter()
        .filter(|b| {
            o.filters.is_empty()
                || o.filters
                    .iter()
                    .any(|f| b.name.contains(f.as_str()) || b.group.contains(f.as_str()))
        })
        .collect();
    write_generated_inputs(&bench_dir, &selected)?;

    let mut rows: Vec<(&Bench, Vec<Stats>, bool)> = vec![];
    for b in &selected {
        let args: Vec<String> = b
            .args
            .iter()
            .map(|a| {
                a.replace("{INPUTS}", &inputs)
                    .replace("{BENCH}", &bench_dir_str)
            })
            .collect();
        eprintln!("bench: {} / {}", b.group, b.name);
        let mut stats = vec![];
        let mut first_files: Option<BTreeMap<String, Vec<u8>>> = None;
        let mut identical = true;
        for (i, tool) in tools.iter().enumerate() {
            let work = bench_dir.join(format!("work{i}"));
            let (s, files) = measure(tool, b, &args, &work, o.iterations)?;
            eprintln!(
                "  {:<14} median {:>9} ms   min {:>9} ms",
                tool.label,
                ms(s.median),
                ms(s.min)
            );
            match &first_files {
                None => first_files = Some(files),
                Some(first) => identical &= *first == files,
            }
            stats.push(s);
        }
        rows.push((b, stats, identical));
    }

    let mut corpus = vec![];
    if o.corpus {
        for tool in &tools {
            eprintln!("bench: corpus with {} ({} jobs)", tool.label, o.jobs);
            let c = run_corpus(root, &tool.cmd, o.jobs)?;
            eprintln!(
                "  wall {:.1} s, CLI time {:.1} s, {} steps",
                c.wall.as_secs_f64(),
                c.process.as_secs_f64(),
                c.steps
            );
            corpus.push(c);
        }
    }

    let mut in_process = vec![];
    if o.in_process {
        in_process = run_in_process(root, o.iterations, in_process_checkout.as_deref())?;
    }

    let report = render_report(&o, &machine, &tools, &rows, &corpus, &in_process);
    print!("{report}");
    if let Some(path) = &o.out {
        fs::write(path, &report).map_err(|e| format!("{}: {e}", path.display()))?;
    }
    if let Some(path) = &o.json {
        let results = Results {
            date,
            command: invocation,
            machine: &machine,
            iterations: o.iterations,
            jobs: o.jobs,
            tools: &tools,
            provenance: &provenance,
            rows: &rows,
            corpus: &corpus,
            in_process: &in_process,
            in_process_provenance: in_process_provenance.as_ref(),
        };
        let json = json_results(root, &results);
        let text = serde_json::to_string_pretty(&json).map_err(|e| e.to_string())?;
        fs::write(path, text + "\n").map_err(|e| format!("{}: {e}", path.display()))?;
        eprintln!("bench: wrote {}", path.display());
    }
    Ok(rows.iter().all(|(_, _, identical)| *identical))
}

fn render_report(
    o: &Options,
    machine: &[MachineFact],
    tools: &[Tool],
    rows: &[(&Bench, Vec<Stats>, bool)],
    corpus: &[CorpusStats],
    in_process: &[InProcess],
) -> String {
    let mut r = String::new();
    let _ = writeln!(r, "Machine:\n");
    for fact in machine {
        let _ = writeln!(r, "- {}: {}", fact.label, fact.value);
    }
    let _ = writeln!(
        r,
        "- Iterations: {} timed runs per benchmark after one warm-up run; wall time in ms, median (min)",
        o.iterations
    );
    let _ = writeln!(r);

    let last = tools.len() - 1;
    // Header.
    let _ = write!(r, "| Benchmark |");
    for t in tools {
        let _ = write!(r, " {} |", t.label);
    }
    let has_ref = tools.first().is_some_and(|t| t.label == "TypeScript");
    let has_baseline = tools.iter().any(|t| t.label == "Rust (before)");
    if has_ref {
        let _ = write!(r, " vs TS |");
    }
    if has_baseline {
        let _ = write!(r, " vs before |");
    }
    let _ = write!(
        r,
        " Peak RSS MiB ({}) |",
        tools
            .iter()
            .map(|t| t.label)
            .collect::<Vec<_>>()
            .join(" / ")
    );
    let _ = writeln!(r);
    let _ = write!(r, "|---|");
    for _ in tools {
        let _ = write!(r, "---:|");
    }
    if has_ref {
        let _ = write!(r, "---:|");
    }
    if has_baseline {
        let _ = write!(r, "---:|");
    }
    let _ = writeln!(r, "---:|");

    let mut group = "";
    for (b, stats, identical) in rows {
        if b.group != group {
            group = b.group;
            let _ = writeln!(
                r,
                "| **{group}** |{}",
                " |".repeat(tools.len() + 1 + usize::from(has_ref) + usize::from(has_baseline))
            );
        }
        let mark = if *identical {
            ""
        } else {
            " ⚠ outputs differ"
        };
        let _ = write!(r, "| {}{mark} |", b.name);
        for s in stats {
            let _ = write!(r, " {} ({}) |", ms(s.median), ms(s.min));
        }
        if has_ref {
            let _ = write!(r, " {} |", ratio(stats[0].median, stats[last].median));
        }
        if has_baseline {
            let _ = write!(
                r,
                " {} |",
                ratio(stats[last - 1].median, stats[last].median)
            );
        }
        let _ = writeln!(
            r,
            " {} |",
            stats
                .iter()
                .map(|s| mib(s.rss))
                .collect::<Vec<_>>()
                .join(" / ")
        );
    }

    if !corpus.is_empty() {
        let _ = writeln!(
            r,
            "\nGolden corpus: every step of every case in `tests/golden`, {} parallel jobs, outputs not checked.\n",
            o.jobs
        );
        let _ = writeln!(
            r,
            "| Command | Steps | Wall time (s) | CLI time, summed (s) | Mean per step (ms) | Unexpected exits |"
        );
        let _ = writeln!(r, "|---|---:|---:|---:|---:|---:|");
        for (t, c) in tools.iter().zip(corpus) {
            let _ = writeln!(
                r,
                "| {} | {} | {:.1} | {:.1} | {:.1} | {} |",
                t.label,
                c.steps,
                c.wall.as_secs_f64(),
                c.process.as_secs_f64(),
                c.process.as_secs_f64() * 1000.0 / c.steps.max(1) as f64,
                c.failed_steps
            );
        }
        if corpus.len() > 1 {
            let last = &corpus[corpus.len() - 1];
            let _ = writeln!(
                r,
                "\nCorpus speedup ({} vs {}): {:.1}× wall time.",
                tools[tools.len() - 1].label,
                tools[0].label,
                corpus[0].wall.as_secs_f64() / last.wall.as_secs_f64()
            );
        }
    }

    if let Some(first) = in_process.first() {
        let _ = writeln!(
            r,
            "\nIn process: {} runs per iteration (every `json/samples` file and `json/misc/1b409.json` × 8 languages) through the library API, `JSON.parse` semantics, after warm-up; ms, median of {} iterations.\n",
            first.runs, o.iterations
        );
        let _ = writeln!(
            r,
            "| Engine | Total (min) | Parse to CompressedJSON | Inference to rendering | Per run |"
        );
        let _ = writeln!(r, "|---|---:|---:|---:|---:|");
        for p in in_process {
            let _ = writeln!(
                r,
                "| {} | {} ({}) | {} | {} | {} |",
                p.label,
                ms(p.total),
                ms(p.total_min),
                ms(p.parse),
                ms(p.engine),
                ms(p.total / p.runs.max(1) as f64)
            );
        }
    }
    r
}

// ---------------------------------------------------------------------------
// The JSON results (`--json`).

/// Everything one run measured, for `json_results`.
struct Results<'a> {
    date: String,
    command: String,
    machine: &'a [MachineFact],
    iterations: usize,
    jobs: usize,
    tools: &'a [Tool],
    /// Where the Rust CLIs come from, by their key in `commits`
    /// (`quickertype`, `baseline`).
    provenance: &'a [(&'static str, Provenance)],
    rows: &'a [(&'a Bench, Vec<Stats>, bool)],
    corpus: &'a [CorpusStats],
    in_process: &'a [InProcess],
    /// The checkout the in-process benchmark built.
    in_process_provenance: Option<&'a Provenance>,
}

/// A number as JSON, rounded to `digits` decimals (the measurements are not
/// more precise than that, and the file stays readable).
fn number(v: f64, digits: i32) -> serde_json::Value {
    let scale = 10f64.powi(digits);
    serde_json::Number::from_f64((v * scale).round() / scale)
        .map_or(serde_json::Value::Null, serde_json::Value::Number)
}

/// Today's date in UTC, `YYYY-MM-DD` (Howard Hinnant's `civil_from_days`).
fn utc_date() -> String {
    let secs = std::time::SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .map_or(0, |d| d.as_secs());
    let z = i64::try_from(secs / 86_400).unwrap_or(0) + 719_468;
    let era = z.div_euclid(146_097);
    let doe = z.rem_euclid(146_097);
    let yoe = (doe - doe / 1460 + doe / 36_524 - doe / 146_096) / 365;
    let doy = doe - (365 * yoe + yoe / 4 - yoe / 100);
    let mp = (5 * doy + 2) / 153;
    let day = doy - (153 * mp + 2) / 5 + 1;
    let month = if mp < 10 { mp + 3 } else { mp - 9 };
    let year = yoe + era * 400 + i64::from(month <= 2);
    format!("{year:04}-{month:02}-{day:02}")
}

/// An argument as a shell would need it.
fn shell_quote(arg: &str) -> String {
    if !arg.is_empty()
        && arg
            .chars()
            .all(|c| c.is_ascii_alphanumeric() || "-_./=:,+@%".contains(c))
    {
        arg.to_owned()
    } else {
        format!("'{}'", arg.replace('\'', r"'\''"))
    }
}

/// What `git -C <dir> <args>` prints (trimmed, possibly empty), if it succeeds.
fn git_output(dir: &Path, args: &[&str]) -> Option<String> {
    let out = Command::new("git")
        .arg("-C")
        .arg(dir)
        .args(args)
        .stderr(Stdio::null())
        .output()
        .ok()?;
    out.status
        .success()
        .then(|| String::from_utf8_lossy(&out.stdout).trim().to_owned())
}

/// The commit checked out in `dir`, if it is a git work tree.
fn git_head(dir: &Path) -> Option<String> {
    git_output(dir, &["rev-parse", "HEAD"]).filter(|s| !s.is_empty())
}

/// Whether the work tree `dir` has changes to tracked files; `None` if it is not one.
fn git_modified(dir: &Path) -> Option<bool> {
    git_output(dir, &["status", "--porcelain", "--untracked-files=no"]).map(|s| !s.is_empty())
}

/// The quicktype commit the TypeScript CLI was built from: its checkout's
/// HEAD if `node <checkout>/dist/index.js` is a git work tree, else the one
/// `tests/golden/REFERENCE` names.
fn quicktype_commit(root: &Path, tools: &[Tool]) -> Option<String> {
    let checkout = tools
        .iter()
        .find(|t| t.id == "typescript")?
        .cmd
        .iter()
        .map(PathBuf::from)
        .find(|p| p.ends_with("dist/index.js"))
        .and_then(|p| p.parent()?.parent().map(Path::to_path_buf));
    checkout.as_deref().and_then(git_head).or_else(|| {
        let reference = fs::read_to_string(root.join("tests/golden/REFERENCE")).ok()?;
        reference
            .lines()
            .find_map(|l| l.trim().strip_prefix("quicktype_commit="))
            .map(String::from)
    })
}

fn json_results(root: &Path, r: &Results<'_>) -> serde_json::Value {
    use serde_json::{Map, Value, json};

    let machine: Map<String, Value> = r
        .machine
        .iter()
        .map(|f| (f.key.to_owned(), Value::String(f.value.clone())))
        .collect();
    // `<id>`: the commit (null if not known), `<id>_modified`: whether its
    // work tree had local changes (null if not known), `<id>_source`: how
    // the commit was found, or why it is not known.
    let mut commits = Map::new();
    commits.insert(
        "quicktype".to_owned(),
        json!(quicktype_commit(root, r.tools)),
    );
    for (id, p) in r.provenance {
        commits.insert((*id).to_owned(), json!(p.commit));
        commits.insert(format!("{id}_modified"), json!(p.modified));
        commits.insert(format!("{id}_source"), json!(p.source));
    }
    let tools: Map<String, Value> = r
        .tools
        .iter()
        .map(|t| (t.id.to_owned(), json!({ "label": t.label })))
        .collect();
    let cli: Vec<Value> = r
        .rows
        .iter()
        .map(|(b, stats, identical)| {
            let results: Map<String, Value> = r
                .tools
                .iter()
                .zip(stats)
                .map(|(t, s)| {
                    let rss = s
                        .rss
                        .map_or(Value::Null, |b| number(b as f64 / 1_048_576.0, 1));
                    (
                        t.id.to_owned(),
                        json!({
                            "median_ms": number(s.median, 3),
                            "min_ms": number(s.min, 3),
                            "peak_rss_mib": rss,
                        }),
                    )
                })
                .collect();
            json!({
                "group": b.group,
                "name": b.name,
                "identical": identical,
                "results": results,
            })
        })
        .collect();
    let corpus = if r.corpus.is_empty() {
        Value::Null
    } else {
        let results: Map<String, Value> = r
            .tools
            .iter()
            .zip(r.corpus)
            .map(|(t, c)| {
                (
                    t.id.to_owned(),
                    json!({
                        "steps": c.steps,
                        "wall_s": number(c.wall.as_secs_f64(), 2),
                        "cli_time_s": number(c.process.as_secs_f64(), 2),
                        "unexpected_exits": c.failed_steps,
                    }),
                )
            })
            .collect();
        json!({ "jobs": r.jobs, "results": results })
    };
    let in_process = r.in_process.first().map_or(Value::Null, |first| {
        let results: Map<String, Value> = r
            .in_process
            .iter()
            .map(|p| {
                (
                    p.id.to_owned(),
                    json!({
                        "label": p.label,
                        "total_ms": number(p.total, 2),
                        "total_min_ms": number(p.total_min, 2),
                        "parse_ms": number(p.parse, 2),
                        "engine_ms": number(p.engine, 2),
                    }),
                )
            })
            .collect();
        // The Rust engine measured here is this checkout's, whatever --bin is.
        let engine_commits = r.in_process_provenance.map_or(Value::Null, |p| {
            json!({ "quickertype": p.commit, "quickertype_modified": p.modified })
        });
        json!({ "runs": first.runs, "iterations": r.iterations, "commits": engine_commits, "results": results })
    });
    json!({
        "format": 1,
        "date": r.date,
        "command": r.command,
        "machine": machine,
        "commits": commits,
        "iterations": r.iterations,
        "tools": tools,
        "cli": cli,
        "corpus": corpus,
        "in_process": in_process,
    })
}

// ---------------------------------------------------------------------------
// In process.

/// The TypeScript checkout for the in-process benchmark: `--ref-dir`, else
/// the checkout of `--ref`'s `dist/index.js`, else the one `cargo xtask diff`
/// finds. An error, never a silent skip, if there is none.
fn reference_checkout(root: &Path, o: &Options) -> Result<PathBuf, String> {
    let checkout = match (&o.ref_dir, &o.reference) {
        (Some(dir), _) => Some(dir.clone()),
        (None, Some(cmd)) => cmd
            .iter()
            .map(PathBuf::from)
            .find(|p| p.ends_with("dist/index.js"))
            .and_then(|p| p.parent()?.parent().map(Path::to_path_buf)),
        (None, None) => {
            find_reference(root)?.and_then(|p| p.parent()?.parent().map(Path::to_path_buf))
        }
    };
    let checkout = checkout.ok_or(
        "--in-process: cannot tell which quicktype checkout --ref runs; \
         pass --ref-dir <checkout> (or --no-ref to skip TypeScript)",
    )?;
    let core = checkout.join("packages/quicktype-core/dist/index.js");
    if !core.is_file() {
        return Err(format!(
            "--in-process: {} not found; build the quicktype checkout, or pass --ref-dir",
            core.display()
        ));
    }
    Ok(checkout)
}

struct InProcess {
    /// Its key in the JSON results.
    id: &'static str,
    label: &'static str,
    runs: u64,
    total: f64,
    total_min: f64,
    parse: f64,
    engine: f64,
}

/// Reads the `--json` line the two in-process benchmarks print.
fn parse_in_process(
    id: &'static str,
    label: &'static str,
    stdout: &[u8],
) -> Result<InProcess, String> {
    let text = String::from_utf8_lossy(stdout);
    let line = text
        .lines()
        .rev()
        .find(|l| l.starts_with('{'))
        .ok_or_else(|| format!("{label}: no result in the output:\n{text}"))?;
    let v: serde_json::Value = serde_json::from_str(line).map_err(|e| format!("{label}: {e}"))?;
    let f = |k: &str| {
        v.get(k)
            .and_then(serde_json::Value::as_f64)
            .unwrap_or(f64::NAN)
    };
    Ok(InProcess {
        id,
        label,
        runs: v
            .get("runs")
            .and_then(serde_json::Value::as_u64)
            .unwrap_or(0),
        total: f("total_ms"),
        total_min: f("total_min_ms"),
        parse: f("parse_ms"),
        engine: f("engine_ms"),
    })
}

fn run_in_process(
    root: &Path,
    iterations: usize,
    checkout: Option<&Path>,
) -> Result<Vec<InProcess>, String> {
    let n = iterations.to_string();
    let mut results = vec![];
    if let Some(checkout) = checkout {
        eprintln!("bench: in process, TypeScript");
        let out = Command::new("node")
            .arg(root.join("xtask/bench/in-process.mjs"))
            .arg(checkout)
            .args(["--json", "-n", &n])
            .stderr(Stdio::inherit())
            .output()
            .map_err(|e| format!("cannot run node: {e}"))?;
        if !out.status.success() {
            return Err("xtask/bench/in-process.mjs failed".into());
        }
        results.push(parse_in_process(
            "typescript",
            "TypeScript (warm Node)",
            &out.stdout,
        )?);
    }
    for (id, label, features) in [
        (
            "rust-system-allocator",
            "Rust (native, system allocator)",
            Some("--no-default-features"),
        ),
        ("rust", "Rust (native, mimalloc)", None),
    ] {
        eprintln!("bench: in process, {label}");
        let mut command = Command::new(std::env::var("CARGO").unwrap_or_else(|_| "cargo".into()));
        command.args(["bench", "-p", "quickertype", "--bench", "in_process"]);
        command.args(features);
        let out = command
            .args(["--", "--json", "-n", &n])
            .current_dir(root)
            .stderr(Stdio::inherit())
            .output()
            .map_err(|e| format!("cannot run cargo bench: {e}"))?;
        if !out.status.success() {
            return Err("cargo bench --bench in_process failed".into());
        }
        results.push(parse_in_process(id, label, &out.stdout)?);
    }
    Ok(results)
}

#[cfg(test)]
mod tests {
    use super::*;

    /// /proc/cpuinfo of an x86 cloud machine (two of its processors).
    const XEON: &str = "processor\t: 0\nvendor_id\t: GenuineIntel\ncpu family\t: 6\nmodel\t\t: 85\n\
        model name\t: Intel(R) Xeon(R) Platinum 8259CL CPU @ 2.50GHz\nstepping\t: 7\ncpu MHz\t\t: 2499.998\n\n\
        processor\t: 1\nvendor_id\t: GenuineIntel\nmodel name\t: Intel(R) Xeon(R) Platinum 8259CL CPU @ 2.50GHz\n";

    /// /proc/cpuinfo of a 64-bit ARM server (AWS Graviton2): no model name, no Hardware.
    const GRAVITON: &str = "processor\t: 0\nBogoMIPS\t: 243.75\nFeatures\t: fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid\n\
        CPU implementer\t: 0x41\nCPU architecture: 8\nCPU variant\t: 0x3\nCPU part\t: 0xd0c\nCPU revision\t: 1\n";

    /// /proc/cpuinfo of a Raspberry Pi 4 on a 64-bit kernel: Hardware, no model name.
    const PI: &str = "processor\t: 0\nBogoMIPS\t: 108.00\nFeatures\t: fp asimd evtstrm crc32 cpuid\n\
        CPU implementer\t: 0x41\nCPU architecture: 8\nCPU variant\t: 0x0\nCPU part\t: 0xd08\nCPU revision\t: 3\n\n\
        Hardware\t: BCM2835\nRevision\t: c03114\nSerial\t\t: 10000000abcdef01\nModel\t\t: Raspberry Pi 4 Model B Rev 1.4\n";

    #[test]
    fn the_cpu_is_named_from_proc_cpuinfo() {
        assert_eq!(
            cpu_from_cpuinfo(XEON, "x86_64").as_deref(),
            Some("Intel(R) Xeon(R) Platinum 8259CL CPU @ 2.50GHz")
        );
        assert_eq!(cpu_from_cpuinfo(PI, "aarch64").as_deref(), Some("BCM2835"));
        assert_eq!(
            cpu_from_cpuinfo(GRAVITON, "aarch64").as_deref(),
            Some("aarch64, CPU part 0xd0c")
        );
        // Nothing to name it by: the caller falls back to the architecture.
        assert_eq!(cpu_from_cpuinfo("", "x86_64"), None);
        assert_eq!(
            cpu_from_cpuinfo("processor\t: 0\nmodel name\t:\n", "x86_64"),
            None
        );
    }

    #[test]
    fn the_memory_is_read_from_proc_meminfo() {
        let meminfo = "MemTotal:       65843876 kB\nMemFree:        12345678 kB\nMemAvailable:   40000000 kB\n";
        assert_eq!(memory_from_meminfo(meminfo).as_deref(), Some("63 GiB"));
        assert_eq!(
            memory_from_meminfo("MemTotal:        3884152 kB\n").as_deref(),
            Some("3.7 GiB")
        );
        assert_eq!(memory_from_meminfo("MemFree: 12 kB\n"), None);
        assert_eq!(memory_from_meminfo("MemTotal: lots\n"), None);
        // macOS's hw.memsize, in bytes.
        assert_eq!(gib(64 << 30), "64 GiB");
        assert_eq!(gib(8 << 30), "8 GiB");
    }

    fn git(dir: &Path, args: &[&str]) {
        let status = Command::new("git")
            .arg("-C")
            .arg(dir)
            .args([
                "-c",
                "user.name=xtask",
                "-c",
                "user.email=xtask@example.com",
            ])
            .args([
                "-c",
                "commit.gpgsign=false",
                "-c",
                "core.hooksPath=/dev/null",
            ])
            .args(args)
            .stdout(Stdio::null())
            .stderr(Stdio::null())
            .status()
            .unwrap();
        assert!(status.success(), "git {args:?}");
    }

    #[test]
    fn a_given_cli_is_its_work_trees_head_only_if_built_after_it() {
        let tree = std::env::temp_dir().join(format!("xtask-bench-test-{}", std::process::id()));
        let _ = fs::remove_dir_all(&tree);
        fs::create_dir_all(tree.join("target/release")).unwrap();
        fs::write(tree.join("README"), "x").unwrap();
        fs::write(tree.join(".gitignore"), "target/\n").unwrap();
        git(&tree, &["init", "-q"]);
        git(&tree, &["add", "."]);
        git(&tree, &["commit", "-q", "-m", "x"]);
        let head = git_head(&tree).unwrap();
        let binary = tree.join("target/release/quickertype");
        fs::write(&binary, "").unwrap();
        let program = binary.to_string_lossy().into_owned();

        let given = Provenance::given(&program, "--bin");
        assert_eq!(
            given.commit.as_deref(),
            Some(head.as_str()),
            "{}",
            given.source
        );
        assert_eq!(given.modified, Some(false));
        assert!(given.source.starts_with("the HEAD of "), "{}", given.source);
        fs::write(tree.join("README"), "changed").unwrap();
        assert_eq!(Provenance::given(&program, "--bin").modified, Some(true));

        // Built before HEAD: from something else.
        fs::File::options()
            .write(true)
            .open(&binary)
            .unwrap()
            .set_modified(std::time::SystemTime::now() - Duration::from_secs(86_400))
            .unwrap();
        let stale = Provenance::given(&program, "--baseline");
        assert_eq!((stale.commit, stale.modified), (None, None));
        assert!(
            stale.source.starts_with("--baseline runs "),
            "{}",
            stale.source
        );
        assert!(
            stale.source.contains("older than the HEAD"),
            "{}",
            stale.source
        );

        // In the work tree, but not in its target directory.
        let elsewhere = tree.join("quickertype");
        fs::write(&elsewhere, "").unwrap();
        let outside = Provenance::given(&elsewhere.to_string_lossy(), "--bin");
        assert_eq!(outside.commit, None);
        assert!(
            outside.source.contains("not in the target directory"),
            "{}",
            outside.source
        );

        let missing = Provenance::given(&tree.join("nowhere").to_string_lossy(), "--bin");
        assert_eq!(missing.commit, None);
        assert!(
            missing.source.ends_with("which was not found"),
            "{}",
            missing.source
        );

        // Built here: this checkout's HEAD.
        let built = Provenance::built(&tree);
        assert_eq!(
            (built.commit.as_deref(), built.modified),
            (Some(head.as_str()), Some(true))
        );
        let _ = fs::remove_dir_all(&tree);
    }
}
