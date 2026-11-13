//! Development tasks for the quicktype Rust port (the `cargo xtask` pattern).
//!
//! ```text
//! cargo xtask parity [options]     replay the golden corpus (see `parity --help`)
//! cargo xtask diff [opts] -- <args> run the TypeScript CLI and ours side by side and compare
//! cargo xtask bench [options]      time ours against the TypeScript CLI (see `bench --help`)
//! cargo xtask golden [ref-dir]     re-record tests/golden from the TypeScript reference
//! ```

mod bench;
mod diff;
mod parity;

use std::path::{Path, PathBuf};
use std::process::{Command, ExitCode};

const USAGE: &str = "\
usage: cargo xtask <task> [args]

tasks:
  parity [options]   replay tests/golden against a quicktype binary (--help for options)
  diff [options] -- <quicktype args>
                     run the TypeScript CLI and ours side by side and compare (--help)
  bench [options]    time ours against the TypeScript CLI, Markdown report (--help)
  golden [ref-dir]   re-record tests/golden from a built TypeScript quicktype checkout
                     (default ref-dir: $QUICKTYPE_REFERENCE, else ../quicktype)
";

fn workspace_root() -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR"))
        .parent()
        .expect("xtask lives in the workspace")
        .to_path_buf()
}

fn main() -> ExitCode {
    let mut args = std::env::args().skip(1);
    let root = workspace_root();
    let result = match args.next().as_deref() {
        Some("parity") => {
            let rest: Vec<String> = args.collect();
            if rest.iter().any(|a| a == "-h" || a == "--help") {
                print!("{}", parity::USAGE);
                return ExitCode::SUCCESS;
            }
            parity::run(&root, rest)
        }
        Some("diff") => {
            let rest: Vec<String> = args.collect();
            let before_separator = rest.iter().take_while(|a| *a != "--");
            if before_separator
                .into_iter()
                .any(|a| a == "-h" || a == "--help")
            {
                print!("{}", diff::USAGE);
                return ExitCode::SUCCESS;
            }
            diff::run(&root, rest)
        }
        Some("bench") => {
            let rest: Vec<String> = args.collect();
            if rest.iter().any(|a| a == "-h" || a == "--help") {
                print!("{}", bench::USAGE);
                return ExitCode::SUCCESS;
            }
            bench::run(&root, rest)
        }
        Some("golden") => Command::new(root.join("xtask/golden/record.sh"))
            .args(args)
            .status()
            .map(|s| s.success())
            .map_err(|e| e.to_string()),
        _ => {
            eprint!("{USAGE}");
            return ExitCode::from(2);
        }
    };
    match result {
        Ok(true) => ExitCode::SUCCESS,
        Ok(false) => ExitCode::FAILURE,
        Err(e) => {
            eprintln!("xtask: {e}");
            ExitCode::from(2)
        }
    }
}
