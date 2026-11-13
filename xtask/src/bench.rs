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

use std::collections::BTreeMap;
use std::fmt::Write as _;
use std::fs;
use std::path::{Path, PathBuf};
use std::process::{Command, Stdio};
use std::sync::Mutex;
use std::sync::atomic::{AtomicUsize, Ordering};
use std::time::{Duration, Instant};

use crate::diff::find_reference;
use crate::parity::{Case, build_cli, find_cases, snapshot};

pub const USAGE: &str = "\
cargo xtask bench [options]

Times our quicktype CLI against the TypeScript CLI and prints a Markdown
report (median and min wall time, peak RSS, speedup).

  --ref \"<cmd ...>\"      TypeScript CLI (default: node <checkout>/dist/index.js,
                         found like `cargo xtask diff` does)
  --no-ref               do not run the TypeScript CLI
  --bin \"<cmd ...>\"      our CLI (default: builds target/release/quicktype)
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
";

struct Options {
    reference: Option<Vec<String>>,
    no_ref: bool,
    ours: Option<Vec<String>>,
    baseline: Option<Vec<String>>,
    iterations: usize,
    filters: Vec<String>,
    corpus: bool,
    in_process: bool,
    jobs: usize,
    out: Option<PathBuf>,
}

fn parse_options(args: Vec<String>) -> Result<Options, String> {
    let mut o = Options {
        reference: None,
        no_ref: false,
        ours: None,
        baseline: None,
        iterations: 10,
        filters: vec![],
        corpus: false,
        in_process: false,
        jobs: std::thread::available_parallelism().map_or(4, |n| n.get()),
        out: None,
    };
    let split = |s: String| -> Vec<String> { s.split_whitespace().map(String::from).collect() };
    let mut args = args.into_iter();
    while let Some(a) = args.next() {
        let mut value = || args.next().ok_or_else(|| format!("missing value for {a}"));
        match a.as_str() {
            "--ref" => o.reference = Some(split(value()?)),
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
            _ => return Err(format!("unknown argument {a}\n\n{USAGE}")),
        }
    }
    o.iterations = o.iterations.max(1);
    Ok(o)
}

/// A command under test.
struct Tool {
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

fn write_generated_inputs(dir: &Path) -> Result<(), String> {
    fs::create_dir_all(dir).map_err(|e| e.to_string())?;
    for (name, records) in [
        ("generated-small.json", 6_000),
        ("generated-large.json", 60_000),
    ] {
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
    let mut c = Command::new(&cmd[0]);
    c.args(&cmd[1..])
        .args(args)
        .current_dir(work)
        .stdin(Stdio::null())
        .env("TZ", "UTC")
        .env("NODE_NO_WARNINGS", "1")
        .env_remove("NODE_OPTIONS")
        .env_remove("FORCE_COLOR")
        .env_remove("NO_COLOR");
    c
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
    let Ok(bytes) = fs::read(case_dir.join("case.json")) else {
        return (Duration::ZERO, 0, 1);
    };
    let Ok(case) = serde_json::from_slice::<Case>(&bytes) else {
        return (Duration::ZERO, 0, 1);
    };
    let _ = fs::remove_dir_all(work);
    if fs::create_dir_all(work).is_err() {
        return (Duration::ZERO, 0, 1);
    }
    for dir in &case.dirs {
        let _ = fs::create_dir_all(work.join(dir));
    }
    let mut busy = Duration::ZERO;
    let mut failed = 0;
    for step in &case.steps {
        let args: Vec<String> = step
            .args
            .iter()
            .map(|a| a.replace("{INPUTS}", inputs))
            .collect();
        let stdin = match &step.stdin {
            Some(path) => match fs::File::open(path.replace("{INPUTS}", inputs)) {
                Ok(f) => Stdio::from(f),
                Err(_) => {
                    failed += 1;
                    continue;
                }
            },
            None => Stdio::null(),
        };
        let mut c = command(cmd, &args, work);
        c.stdin(stdin)
            .envs(&case.env)
            .stdout(Stdio::null())
            .stderr(Stdio::null());
        let start = Instant::now();
        let status = c.status();
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

fn machine_info(tools: &[Tool]) -> Vec<(String, String)> {
    let mut info = vec![];
    if cfg!(target_os = "macos") {
        if let Some(cpu) = shell_output("sysctl", &["-n", "machdep.cpu.brand_string"]) {
            info.push(("CPU".into(), cpu));
        }
        if let Some(n) = shell_output("sysctl", &["-n", "hw.ncpu"]) {
            info.push(("Cores".into(), n));
        }
        if let Some(bytes) =
            shell_output("sysctl", &["-n", "hw.memsize"]).and_then(|s| s.parse::<u64>().ok())
        {
            info.push(("Memory".into(), format!("{} GiB", bytes >> 30)));
        }
        if let Some(v) = shell_output("sw_vers", &["-productVersion"]) {
            info.push(("OS".into(), format!("macOS {v}")));
        }
    } else {
        if let Ok(cpuinfo) = fs::read_to_string("/proc/cpuinfo") {
            if let Some(model) = cpuinfo.lines().find_map(|l| {
                l.strip_prefix("model name")
                    .and_then(|r| r.split(':').nth(1))
            }) {
                info.push(("CPU".into(), model.trim().to_owned()));
            }
        }
        if let Some(n) = shell_output("nproc", &[]) {
            info.push(("Cores".into(), n));
        }
        if let Some(os) = shell_output("uname", &["-sr"]) {
            info.push(("OS".into(), os));
        }
    }
    if let Some(v) = shell_output("rustc", &["--version"]) {
        info.push(("rustc".into(), v));
    }
    if tools
        .iter()
        .any(|t| t.cmd.first().is_some_and(|c| c == "node"))
    {
        if let Some(v) = shell_output("node", &["--version"]) {
            info.push(("Node.js".into(), v));
        }
    }
    info
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
    let o = parse_options(args)?;
    let mut tools = vec![];
    if !o.no_ref {
        let cmd = match &o.reference {
            Some(cmd) => cmd.clone(),
            None => {
                let script = find_reference(root).ok_or(
                    "TypeScript CLI not found: set QUICKTYPE_REF, pass --ref, or use --no-ref",
                )?;
                vec!["node".into(), script.to_string_lossy().into_owned()]
            }
        };
        tools.push(Tool {
            label: "TypeScript",
            cmd,
        });
    }
    if let Some(cmd) = &o.baseline {
        tools.push(Tool {
            label: "Rust (before)",
            cmd: cmd.clone(),
        });
    }
    let ours = match &o.ours {
        Some(cmd) => cmd.clone(),
        None => build_cli(root)?,
    };
    tools.push(Tool {
        label: if o.baseline.is_some() {
            "Rust (after)"
        } else {
            "Rust"
        },
        cmd: ours,
    });

    let bench_dir = root.join("target/bench");
    write_generated_inputs(&bench_dir)?;
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
        let checkout = if o.no_ref {
            None
        } else {
            match &o.reference {
                Some(cmd) => cmd
                    .last()
                    .map(PathBuf::from)
                    .filter(|p| p.ends_with("dist/index.js"))
                    .and_then(|p| p.parent()?.parent().map(Path::to_path_buf)),
                None => {
                    find_reference(root).and_then(|p| p.parent()?.parent().map(Path::to_path_buf))
                }
            }
        };
        in_process = run_in_process(root, o.iterations, checkout.as_deref())?;
    }

    let report = render_report(&o, &tools, &rows, &corpus, &in_process);
    print!("{report}");
    if let Some(path) = &o.out {
        fs::write(path, &report).map_err(|e| format!("{}: {e}", path.display()))?;
    }
    Ok(rows.iter().all(|(_, _, identical)| *identical))
}

fn render_report(
    o: &Options,
    tools: &[Tool],
    rows: &[(&Bench, Vec<Stats>, bool)],
    corpus: &[CorpusStats],
    in_process: &[InProcess],
) -> String {
    let mut r = String::new();
    let _ = writeln!(r, "Machine:\n");
    for (k, v) in machine_info(tools) {
        let _ = writeln!(r, "- {k}: {v}");
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
// In process.

struct InProcess {
    label: &'static str,
    runs: u64,
    total: f64,
    total_min: f64,
    parse: f64,
    engine: f64,
}

/// Reads the `--json` line the two in-process benchmarks print.
fn parse_in_process(label: &'static str, stdout: &[u8]) -> Result<InProcess, String> {
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
        results.push(parse_in_process("TypeScript (warm Node)", &out.stdout)?);
    }
    for (label, features) in [
        (
            "Rust (native, system allocator)",
            Some("--no-default-features"),
        ),
        ("Rust (native, mimalloc)", None),
    ] {
        eprintln!("bench: in process, {label}");
        let mut command = Command::new(std::env::var("CARGO").unwrap_or_else(|_| "cargo".into()));
        command.args(["bench", "-p", "quicktype-cli", "--bench", "in_process"]);
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
        results.push(parse_in_process(label, &out.stdout)?);
    }
    Ok(results)
}
