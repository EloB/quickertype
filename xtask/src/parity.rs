//! `cargo xtask parity`: replays the golden corpus against a quicktype binary
//! and checks that it writes byte-identical files.
//!
//! Every golden case is a recorded run of the TypeScript quicktype CLI
//! (`tests/golden/<fixture>/<input>/<hash>/case.json` + expected files).
//!
//! The run is a *ratchet*: `tests/parity-baseline.txt` lists the case ids
//! that are known to pass. A run fails if any of those regress; newly passing
//! cases are reported and recorded with `--update-baseline`.
//!
//! Two kinds of steps exist:
//!
//! - **File steps** (the fixture corpus): the step must exit 0 (or fail, with
//!   `expect_failure`) and write exactly `files`.
//! - **CLI-behavior steps** (the `cli-*` fixtures, recorded by
//!   `xtask/golden/record-cli.mjs`): the step has an `exit` code, and its
//!   stdout and stderr must equal `step<N>.stdout` / `step<N>.stderr` in the
//!   case directory (a missing file means empty output). An optional `stdin`
//!   names a file that is piped to the process. Before comparing, the
//!   absolute inputs directory in the actual output is replaced by `{INPUTS}`
//!   and the work directory by `{CWD}`, exactly as the recorder did.
//!
//! A case may set extra environment variables with `env`. Every step runs
//! with `TZ=UTC` and `NODE_NO_WARNINGS=1`, and without `FORCE_COLOR`,
//! `NO_COLOR` and `NODE_OPTIONS`, so the developer's shell cannot change the
//! result.

use std::collections::{BTreeMap, BTreeSet};
use std::fs;
use std::path::{Path, PathBuf};
use std::process::{Command, Stdio};
use std::sync::Mutex;
use std::sync::atomic::{AtomicUsize, Ordering};
use std::time::{Duration, Instant};

use serde::Deserialize;

pub const USAGE: &str = "\
cargo xtask parity [options]

  --bin \"<cmd ...>\"    quicktype command to test (default: builds and uses
                       target/release/quicktype). The TypeScript reference:
                       --bin \"node ../quicktype/dist/index.js\"
  --filter <substr>    only cases whose id contains <substr> (repeatable, OR)
  -j <n>               parallel jobs (default: number of cores)
  --show <n>           print details for the first n failures (default 10)
  --keep               keep work dirs of failing cases in target/parity
  --report <file>      write a JSON report with every case's result
  --strict             fail on any failing case, not only on regressions
  --update-baseline    record the passing cases in tests/parity-baseline.txt
";

#[derive(Deserialize)]
pub(crate) struct Case {
    /// Directories that must exist before the first step (quicktype does not
    /// create output directories itself).
    #[serde(default)]
    dirs: Vec<String>,
    /// Extra environment variables for every step.
    #[serde(default)]
    env: BTreeMap<String, String>,
    pub(crate) steps: Vec<Step>,
}

#[derive(Deserialize)]
pub(crate) struct Step {
    args: Vec<String>,
    files: Vec<String>,
    #[serde(default)]
    pub(crate) expect_failure: bool,
    /// File (usually below `{INPUTS}`) piped to stdin; stdin is empty otherwise.
    #[serde(default)]
    stdin: Option<String>,
    /// Expected exit code. Its presence makes this a CLI-behavior step whose
    /// stdout and stderr are compared as well.
    #[serde(default)]
    pub(crate) exit: Option<i32>,
}

/// Environment variables removed from every step: they would let the
/// developer's shell change colors or inject Node flags.
const SCRUBBED_ENV: &[&str] = &["FORCE_COLOR", "NO_COLOR", "NODE_OPTIONS"];

struct Options {
    bin: Option<Vec<String>>,
    filters: Vec<String>,
    jobs: usize,
    show: usize,
    keep: bool,
    strict: bool,
    update_baseline: bool,
    report: Option<PathBuf>,
}

struct Outcome {
    id: String,
    failure: Option<String>,
    elapsed: Duration,
}

fn parse_options(args: Vec<String>) -> Result<Options, String> {
    let mut o = Options {
        bin: None,
        filters: vec![],
        jobs: std::thread::available_parallelism().map_or(4, |n| n.get()),
        show: 10,
        keep: false,
        strict: false,
        update_baseline: false,
        report: None,
    };
    let mut args = args.into_iter();
    while let Some(a) = args.next() {
        let mut value = || args.next().ok_or_else(|| format!("missing value for {a}"));
        match a.as_str() {
            "--bin" => o.bin = Some(value()?.split_whitespace().map(String::from).collect()),
            "--filter" => o.filters.push(value()?),
            "-j" | "--jobs" => o.jobs = value()?.parse().map_err(|_| "bad -j")?,
            "--show" => o.show = value()?.parse().map_err(|_| "bad --show")?,
            "--keep" => o.keep = true,
            "--strict" => o.strict = true,
            "--update-baseline" => o.update_baseline = true,
            "--report" => o.report = Some(PathBuf::from(value()?)),
            _ => return Err(format!("unknown argument {a}\n\n{USAGE}")),
        }
    }
    Ok(o)
}

pub(crate) fn find_cases(dir: &Path, out: &mut Vec<PathBuf>) {
    let Ok(entries) = fs::read_dir(dir) else {
        return;
    };
    for entry in entries.flatten() {
        let path = entry.path();
        if path.is_dir() {
            if path.join("case.json").is_file() {
                out.push(path);
            } else {
                find_cases(&path, out);
            }
        }
    }
}

pub(crate) fn snapshot(dir: &Path) -> BTreeMap<String, Vec<u8>> {
    fn walk(base: &Path, dir: &Path, acc: &mut BTreeMap<String, Vec<u8>>) {
        let Ok(entries) = fs::read_dir(dir) else {
            return;
        };
        for entry in entries.flatten() {
            let path = entry.path();
            if path.is_dir() {
                walk(base, &path, acc);
            } else if let Ok(bytes) = fs::read(&path) {
                let rel = path.strip_prefix(base).expect("walked path is below base");
                acc.insert(rel.to_string_lossy().into_owned(), bytes);
            }
        }
    }
    let mut acc = BTreeMap::new();
    walk(dir, dir, &mut acc);
    acc
}

/// Replaces every occurrence of `from` in `haystack` with `to`.
fn replace_bytes(haystack: &[u8], from: &[u8], to: &[u8]) -> Vec<u8> {
    if from.is_empty() {
        return haystack.to_vec();
    }
    let mut out = Vec::with_capacity(haystack.len());
    let mut i = 0;
    while i < haystack.len() {
        if haystack[i..].starts_with(from) {
            out.extend_from_slice(to);
            i += from.len();
        } else {
            out.push(haystack[i]);
            i += 1;
        }
    }
    out
}

/// Replaces absolute paths in captured output by their placeholders, longest
/// path first (both the given and the canonical form of each directory).
fn normalize_output(output: &[u8], placeholders: &[(String, &str)]) -> Vec<u8> {
    let mut pairs: Vec<&(String, &str)> = placeholders.iter().collect();
    pairs.sort_by_key(|(path, _)| std::cmp::Reverse(path.len()));
    let mut out = output.to_vec();
    for (path, placeholder) in pairs {
        out = replace_bytes(&out, path.as_bytes(), placeholder.as_bytes());
    }
    out
}

/// The given and the canonical form of `dir`, for output normalization.
fn path_forms(dir: &Path, placeholder: &'static str) -> Vec<(String, &'static str)> {
    let mut forms = vec![(dir.to_string_lossy().into_owned(), placeholder)];
    if let Ok(canonical) = dir.canonicalize() {
        let canonical = canonical.to_string_lossy().into_owned();
        if canonical != forms[0].0 {
            forms.push((canonical, placeholder));
        }
    }
    forms
}

/// Compares one captured stream of a CLI-behavior step with its golden file.
fn check_stream(
    case_dir: &Path,
    step: usize,
    stream: &str,
    actual: &[u8],
    placeholders: &[(String, &str)],
) -> Result<(), String> {
    let path = case_dir.join(format!("step{step}.{stream}"));
    let expected = match fs::read(&path) {
        Ok(bytes) => bytes,
        Err(e) if e.kind() == std::io::ErrorKind::NotFound => vec![],
        Err(e) => return Err(format!("golden {}: {e}", path.display())),
    };
    let actual = normalize_output(actual, placeholders);
    if expected == actual {
        Ok(())
    } else {
        Err(format!(
            "step {step}: {stream} differs at {}",
            first_difference(&expected, &actual)
        ))
    }
}

/// The first non-blank stderr line, shortened, for failure summaries.
fn first_stderr_line(stderr: &[u8]) -> String {
    String::from_utf8_lossy(stderr)
        .lines()
        .find(|l| !l.trim().is_empty())
        .unwrap_or("")
        .chars()
        .take(200)
        .collect()
}

/// Describes the first differing line between two outputs.
pub(crate) fn first_difference(expected: &[u8], actual: &[u8]) -> String {
    let expected = String::from_utf8_lossy(expected);
    let actual = String::from_utf8_lossy(actual);
    let (el, al): (Vec<&str>, Vec<&str>) =
        (expected.split('\n').collect(), actual.split('\n').collect());
    let show = |l: Option<&&str>| l.map_or_else(|| "<eof>".to_owned(), |s| format!("{s:?}"));
    for i in 0..el.len().max(al.len()) {
        if el.get(i) != al.get(i) {
            return format!(
                "line {}:\n      expected: {}\n      actual:   {}",
                i + 1,
                show(el.get(i)),
                show(al.get(i))
            );
        }
    }
    "identical text, different bytes".into()
}

/// A quicktype command (`bin`, plus its leading arguments) run in `work`
/// with the environment every recorded run had: `TZ=UTC`,
/// `NODE_NO_WARNINGS=1`, and none of [`SCRUBBED_ENV`]. Stdin is empty.
pub(crate) fn base_command(bin: &[String], work: &Path) -> Command {
    let mut command = Command::new(&bin[0]);
    command
        .args(&bin[1..])
        .current_dir(work)
        .stdin(Stdio::null())
        .env("TZ", "UTC")
        .env("NODE_NO_WARNINGS", "1");
    for name in SCRUBBED_ENV {
        command.env_remove(name);
    }
    command
}

/// Reads a golden case and prepares a fresh work directory for it, with
/// the directories it needs.
pub(crate) fn prepare_case(case_dir: &Path, work: &Path) -> Result<Case, String> {
    let bytes = fs::read(case_dir.join("case.json")).map_err(|e| e.to_string())?;
    let case: Case = serde_json::from_slice(&bytes).map_err(|e| format!("bad case.json: {e}"))?;
    let _ = fs::remove_dir_all(work);
    fs::create_dir_all(work).map_err(|e| e.to_string())?;
    for dir in &case.dirs {
        fs::create_dir_all(work.join(dir)).map_err(|e| e.to_string())?;
    }
    Ok(case)
}

/// The command for one step of a golden case, as the recorder ran it: the
/// step's arguments with `{INPUTS}` replaced, its stdin file (if any), and
/// the case's environment, which overrides [`base_command`]'s.
pub(crate) fn step_command(
    bin: &[String],
    inputs: &str,
    case: &Case,
    step: &Step,
    work: &Path,
) -> Result<Command, String> {
    let mut command = base_command(bin, work);
    command.args(step.args.iter().map(|a| a.replace("{INPUTS}", inputs)));
    if let Some(path) = &step.stdin {
        let path = path.replace("{INPUTS}", inputs);
        let file = fs::File::open(&path).map_err(|e| format!("stdin {path}: {e}"))?;
        command.stdin(Stdio::from(file));
    }
    command.envs(&case.env);
    Ok(command)
}

fn run_case(
    bin: &[String],
    inputs: &str,
    case_dir: &Path,
    work: &Path,
) -> Result<Duration, String> {
    let case = prepare_case(case_dir, work)?;

    let mut placeholders = path_forms(Path::new(inputs), "{INPUTS}");
    placeholders.extend(path_forms(work, "{CWD}"));

    let mut elapsed = Duration::ZERO;
    for (i, step) in case.steps.iter().enumerate() {
        let before = snapshot(work);
        let mut command = step_command(bin, inputs, &case, step, work)?;
        let start = Instant::now();
        let out = command
            .output()
            .map_err(|e| format!("step {i}: cannot spawn {}: {e}", bin[0]))?;
        elapsed += start.elapsed();

        if let Some(expected_exit) = step.exit {
            let actual_exit = out.status.code();
            if actual_exit != Some(expected_exit) {
                return Err(format!(
                    "step {i}: exit {} (expected {expected_exit}): {}",
                    actual_exit.map_or_else(|| "signal".to_owned(), |c| c.to_string()),
                    first_stderr_line(&out.stderr)
                ));
            }
            check_stream(case_dir, i, "stdout", &out.stdout, &placeholders)?;
            check_stream(case_dir, i, "stderr", &out.stderr, &placeholders)?;
        } else if step.expect_failure {
            if out.status.success() {
                return Err(format!("step {i}: expected failure, but exited 0"));
            }
            continue;
        } else if !out.status.success() {
            return Err(format!(
                "step {i}: exit {}: {}",
                out.status.code().unwrap_or(-1),
                first_stderr_line(&out.stderr)
            ));
        }

        let after = snapshot(work);
        let changed: Vec<&String> = after
            .iter()
            .filter(|(p, b)| before.get(*p) != Some(b))
            .map(|(p, _)| p)
            .collect();
        let missing: Vec<&String> = step
            .files
            .iter()
            .filter(|f| !after.contains_key(*f))
            .collect();
        let extra: Vec<&&String> = changed.iter().filter(|p| !step.files.contains(p)).collect();
        if !missing.is_empty() || !extra.is_empty() {
            return Err(format!(
                "step {i}: file set differs; missing {missing:?}, unexpected {extra:?}"
            ));
        }
        for file in &step.files {
            let expected = fs::read(case_dir.join(format!("step{i}")).join(file))
                .map_err(|e| format!("golden {file}: {e}"))?;
            if expected != after[file] {
                return Err(format!(
                    "step {i}: {file} differs at {}",
                    first_difference(&expected, &after[file])
                ));
            }
        }
    }
    Ok(elapsed)
}

pub(crate) fn build_cli(root: &Path) -> Result<Vec<String>, String> {
    let status = Command::new(std::env::var("CARGO").unwrap_or_else(|_| "cargo".into()))
        .args(["build", "--release", "--package", "quicktype-cli"])
        .current_dir(root)
        .status()
        .map_err(|e| e.to_string())?;
    if !status.success() {
        return Err("building quicktype-cli failed".into());
    }
    Ok(vec![
        root.join("target/release/quicktype")
            .to_string_lossy()
            .into_owned(),
    ])
}

pub fn run(root: &Path, args: Vec<String>) -> Result<bool, String> {
    let o = parse_options(args)?;
    let bin = match &o.bin {
        Some(bin) if !bin.is_empty() => bin.clone(),
        _ => build_cli(root)?,
    };
    let golden = root.join("tests/golden");
    let baseline_path = root.join("tests/parity-baseline.txt");
    let inputs = root.join("tests/inputs").to_string_lossy().into_owned();

    let matches =
        |id: &str| o.filters.is_empty() || o.filters.iter().any(|f| id.contains(f.as_str()));
    let mut dirs = vec![];
    find_cases(&golden, &mut dirs);
    let mut cases: Vec<(String, PathBuf)> = dirs
        .into_iter()
        .map(|d| {
            (
                d.strip_prefix(&golden)
                    .expect("case below golden")
                    .to_string_lossy()
                    .into_owned(),
                d,
            )
        })
        .filter(|(id, _)| matches(id))
        .collect();
    cases.sort();
    if cases.is_empty() {
        return Err(format!(
            "no cases found in {} (filters: {:?})",
            golden.display(),
            o.filters
        ));
    }

    let work_root = root.join("target/parity");
    let next = AtomicUsize::new(0);
    let done = AtomicUsize::new(0);
    let outcomes = Mutex::new(Vec::with_capacity(cases.len()));
    let start = Instant::now();

    std::thread::scope(|s| {
        for _ in 0..o.jobs.max(1) {
            s.spawn(|| {
                loop {
                    let i = next.fetch_add(1, Ordering::Relaxed);
                    let Some((id, dir)) = cases.get(i) else { break };
                    let work = work_root.join(format!("w{i}"));
                    let (failure, elapsed) = match run_case(&bin, &inputs, dir, &work) {
                        Ok(t) => (None, t),
                        Err(e) => (Some(e), Duration::ZERO),
                    };
                    if failure.is_none() || !o.keep {
                        let _ = fs::remove_dir_all(&work);
                    }
                    outcomes.lock().expect("lock").push(Outcome {
                        id: id.clone(),
                        failure,
                        elapsed,
                    });
                    let n = done.fetch_add(1, Ordering::Relaxed) + 1;
                    if n % 1000 == 0 {
                        eprintln!("  {n}/{} ...", cases.len());
                    }
                }
            });
        }
    });

    let wall = start.elapsed();
    let mut outcomes = outcomes.into_inner().expect("lock");
    outcomes.sort_by(|a, b| a.id.cmp(&b.id));

    let mut per_fixture: BTreeMap<&str, (usize, usize)> = BTreeMap::new();
    for oc in &outcomes {
        let entry = per_fixture
            .entry(oc.id.split('/').next().unwrap_or(""))
            .or_default();
        entry.1 += 1;
        entry.0 += usize::from(oc.failure.is_none());
    }
    println!("  {:<44} {:>6} {:>6}", "fixture", "pass", "total");
    for (fixture, (pass, total)) in &per_fixture {
        let mark = if pass == total { ' ' } else { '✗' };
        println!("{mark} {fixture:<44} {pass:>6} {total:>6}");
    }

    let failures: Vec<&Outcome> = outcomes.iter().filter(|o| o.failure.is_some()).collect();
    for f in failures.iter().take(o.show) {
        println!(
            "\nFAIL {}\n    {}",
            f.id,
            f.failure.as_deref().unwrap_or("")
        );
    }
    if failures.len() > o.show {
        println!("\n... and {} more failures", failures.len() - o.show);
    }

    let passing: BTreeSet<&str> = outcomes
        .iter()
        .filter(|o| o.failure.is_none())
        .map(|o| o.id.as_str())
        .collect();
    let busy: Duration = outcomes.iter().map(|o| o.elapsed).sum();
    println!(
        "\nparity: {}/{} cases pass ({:.1}%) | wall {:.1}s | quicktype time in passing cases {:.1}s",
        passing.len(),
        outcomes.len(),
        100.0 * passing.len() as f64 / outcomes.len() as f64,
        wall.as_secs_f64(),
        busy.as_secs_f64(),
    );

    // Ratchet against the baseline (restricted to the cases this run covered).
    let baseline_text = fs::read_to_string(&baseline_path).unwrap_or_default();
    let baseline: BTreeSet<&str> = baseline_text
        .lines()
        .map(str::trim)
        .filter(|l| !l.is_empty() && matches(l))
        .collect();
    let regressions: Vec<&&str> = baseline
        .iter()
        .filter(|id| !passing.contains(**id))
        .collect();
    let new_passes = passing.iter().filter(|id| !baseline.contains(**id)).count();
    println!(
        "baseline: {} cases, {} regressions, {new_passes} new passes",
        baseline.len(),
        regressions.len()
    );
    for id in regressions.iter().take(o.show) {
        println!("  REGRESSION {id}");
    }

    if o.update_baseline {
        if !o.filters.is_empty() {
            return Err("--update-baseline must be run without --filter".into());
        }
        let mut text: String = passing.iter().map(|id| format!("{id}\n")).collect();
        if text.is_empty() {
            text.push('\n');
        }
        fs::write(&baseline_path, text).map_err(|e| e.to_string())?;
        println!("baseline updated: {} passing cases", passing.len());
    } else if new_passes > 0 {
        println!("(run with --update-baseline to lock in the new passes)");
    }

    if let Some(path) = &o.report {
        let report: Vec<serde_json::Value> = outcomes
            .iter()
            .map(|o| {
                serde_json::json!({
                    "id": o.id,
                    "pass": o.failure.is_none(),
                    "failure": o.failure,
                    "ms": u64::try_from(o.elapsed.as_millis()).unwrap_or(u64::MAX),
                })
            })
            .collect();
        let json = serde_json::to_string_pretty(&report).map_err(|e| e.to_string())?;
        fs::write(path, json).map_err(|e| e.to_string())?;
    }

    Ok(regressions.is_empty() && (!o.strict || failures.is_empty()))
}
