//! `cargo xtask streaming-fuzz`: runs generated inputs through both ways of
//! inferring JSON types, running tallies and quicktype's compressed form,
//! and requires identical results (docs/STREAMING-INFERENCE.md).
//!
//! The generator and the comparison are quicktype-core's
//! `tests/streaming_inference.rs` (its ignored `fuzz` and `dump_documents`
//! tests); this runs them in release mode with the counts given here.

use std::path::Path;
use std::process::Command;

pub const USAGE: &str = "\
cargo xtask streaming-fuzz [options]

Generates JSON inputs from consecutive seeds and checks, for each, that
inference from running tallies and from the compressed form give the same
add_source results, the same type graphs (every inference flag
combination) and the same output of a whole run (a language and an option
set picked by the seed). Runs in release mode, in process.

  --seeds <n>    how many seeds (default 1000000; `_` separators allowed)
  --start <n>    the first seed (default 0)
  -j <n>         threads (default: number of cores)
  --runs <n>     whole runs per seed (default 1)
  --dump <dir>   instead, write <n> generated documents (default 2000) to
                 <dir> as <seed>.json, for `cargo xtask diff --each <dir>`

examples:
  cargo xtask streaming-fuzz --seeds 1_000_000 -j 8
  cargo xtask streaming-fuzz --start 5000000 --seeds 100000 --runs 3
  cargo xtask streaming-fuzz --dump target/streaming-docs --seeds 2000
";

pub fn run(root: &Path, args: Vec<String>) -> Result<bool, String> {
    let mut seeds: Option<String> = None;
    let mut start = "0".to_owned();
    let mut jobs: Option<String> = None;
    let mut runs = "1".to_owned();
    let mut dump: Option<String> = None;
    let mut iter = args.into_iter();
    while let Some(arg) = iter.next() {
        let mut value = || iter.next().ok_or(format!("{arg} needs a value"));
        match arg.as_str() {
            "--seeds" => seeds = Some(value()?),
            "--start" => start = value()?,
            "-j" | "--jobs" => jobs = Some(value()?),
            "--runs" => runs = value()?,
            "--dump" => dump = Some(value()?),
            other => return Err(format!("unknown option {other}\n\n{USAGE}")),
        }
    }
    let test = if dump.is_some() {
        "dump_documents"
    } else {
        "fuzz"
    };
    let default_seeds = if dump.is_some() { "2000" } else { "1000000" };
    let mut command = Command::new(std::env::var("CARGO").unwrap_or_else(|_| "cargo".to_owned()));
    command
        .current_dir(root)
        .args([
            "test",
            "--release",
            "-p",
            "quicktype-core",
            "--test",
            "streaming_inference",
            "--",
            "--ignored",
            "--exact",
            test,
            "--nocapture",
        ])
        .env(
            "QUICKTYPE_STREAMING_SEEDS",
            seeds.as_deref().unwrap_or(default_seeds),
        )
        .env("QUICKTYPE_STREAMING_START", &start)
        .env("QUICKTYPE_STREAMING_RUNS", &runs);
    if let Some(jobs) = jobs {
        command.env("QUICKTYPE_STREAMING_JOBS", jobs);
    }
    if let Some(dir) = dump {
        let dir = std::env::current_dir()
            .map_err(|e| e.to_string())?
            .join(dir);
        command.env("QUICKTYPE_STREAMING_DUMP", dir);
    }
    let status = command
        .status()
        .map_err(|e| format!("cannot run cargo: {e}"))?;
    Ok(status.success())
}
