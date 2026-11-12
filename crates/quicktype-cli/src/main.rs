//! The `quicktype` CLI. Port of `quicktype/src/index.ts`.
//!
//! Contract: for any argv, stdin and input files, this binary must produce
//! byte-identical stdout, stderr, exit code and output files to the
//! TypeScript `quicktype` it replaces. `cargo xtask parity` checks that.

mod compressed_json_from_stream;
mod graphql_introspection;
mod type_source;
mod url_grammar;

use std::process::ExitCode;

const VERSION: &str = env!("CARGO_PKG_VERSION");

fn main() -> ExitCode {
    let args: Vec<String> = std::env::args().skip(1).collect();
    if args.iter().any(|a| a == "--version" || a == "-v") {
        println!("quicktype version {VERSION}");
        println!("Visit quicktype.io for more info.");
        return ExitCode::SUCCESS;
    }
    eprintln!("quicktype (rust): not implemented yet");
    ExitCode::from(2)
}
