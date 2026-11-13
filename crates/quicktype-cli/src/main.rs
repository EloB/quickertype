//! The `quicktype` CLI. Port of `quicktype/src/index.ts`.
//!
//! Contract: for any argv, stdin and input files, this binary must produce
//! byte-identical stdout, stderr, exit code and output files to the
//! TypeScript `quicktype` it replaces. `cargo xtask parity` checks that.
//!
//! Ported so far: option parsing (both passes, with command-line-args'
//! semantics), `--help` (plain and coloured), `--version`, `--telemetry`
//! validation and the CLI-level errors. Reading sources and generating code
//! need the engine and exit with an internal "not implemented" error.

mod chalk;
mod cli_options;
mod command_line_args;
mod command_line_usage;
mod compressed_json_from_stream;
mod graphql_introspection;
mod js;
mod messages;
mod type_source;
mod url_grammar;
mod usage;

use std::io::{self, BufWriter, ErrorKind, Write};
use std::process::ExitCode;

use quicktype_core::language::all::default_target_languages;

use crate::chalk::Chalk;
use crate::cli_options::{CliOptions, parse_cli_options};
use crate::messages::{CliError, DriverError};

/// `packageJSON.version`.
const VERSION: &str = env!("CARGO_PKG_VERSION");

/// The source languages `makeQuicktypeOptions` knows.
const SOURCE_LANGUAGES: [&str; 5] = ["graphql", "json", "schema", "typescript", "postman"];

/// `console.log` / `console.error` with quicktype's EPIPE handling: a closed
/// stdout or stderr ends the process with exit code 0.
///
/// Any other write error makes Node throw an uncaught exception (a stack
/// trace on stderr, exit code 1). That trace cannot be reproduced; we print a
/// one-line error instead and exit 1 (a known gap, see docs/PARITY.md).
struct Console {
    stdout: BufWriter<io::Stdout>,
}

impl Console {
    fn new() -> Self {
        Self {
            stdout: BufWriter::new(io::stdout()),
        }
    }

    fn check(result: io::Result<()>, stream: &str) {
        let Err(e) = result else {
            return;
        };
        if e.kind() == ErrorKind::BrokenPipe {
            std::process::exit(0);
        }
        // Best effort: stderr itself may be the stream that failed.
        let _ = writeln!(io::stderr(), "Error: cannot write to {stream}: {e}.");
        std::process::exit(1);
    }

    /// `console.log(text)`.
    fn log(&mut self, text: &str) {
        Self::check(writeln!(self.stdout, "{text}"), "stdout");
    }

    /// `console.error(text)`; flushes stdout first to keep the order.
    fn error(&mut self, text: &str) {
        self.flush();
        Self::check(writeln!(io::stderr(), "{text}"), "stderr");
    }

    fn flush(&mut self) {
        Self::check(self.stdout.flush(), "stdout");
    }
}

/// TS `makeQuicktypeOptions`, up to the point where the engine takes over:
/// handles `--help` and `--version` and validates the source language.
fn make_quicktype_options(
    options: &CliOptions,
    chalk: &Chalk,
    console: &mut Console,
) -> Result<(), CliError> {
    if options.help {
        console.log(&usage::usage(chalk, default_target_languages())?);
        return Ok(());
    }
    if options.version {
        console.log(&format!("quicktype version {VERSION}"));
        console.log("Visit quicktype.io for more info.");
        return Ok(());
    }
    if options.build_markov_chain.is_some() {
        // TODO(engine): trainMarkovChain + JSON.stringify.
        return Err(CliError::NotImplemented("--build-markov-chain".to_owned()));
    }
    if !SOURCE_LANGUAGES.contains(&options.src_lang.as_str()) {
        // The `default` branch of the source-language switch, which runs
        // before any source is read.
        return Err(DriverError::UnknownSourceLanguage {
            lang: options.src_lang.clone(),
        }
        .into());
    }
    // TODO(engine): read the sources (getSources, samplesFromDirectory,
    // GraphQL introspection, TypeScript, Postman), parse --debug, build the
    // InputData and run quicktypeMultiFile with `options`, then writeOutput.
    Err(CliError::NotImplemented(
        "reading sources and generating code".to_owned(),
    ))
}

/// TS `main(argv)`.
fn run(args: &[String], chalk: &Chalk, console: &mut Console) -> Result<(), CliError> {
    let options = parse_cli_options(args)?;

    if let Some(telemetry) = &options.telemetry {
        if telemetry != "enable" && telemetry != "disable" {
            console.error(&chalk.red("telemetry must be 'enable' or 'disable'"));
            return Ok(());
        }
        if args.len() == 2 {
            // Merely a run to set telemetry; there is nothing else to do.
            return Ok(());
        }
    }

    make_quicktype_options(&options, chalk, console)
}

fn main() -> ExitCode {
    // Node decodes argv as UTF-8, replacing invalid sequences.
    let args: Vec<String> = std::env::args_os()
        .skip(1)
        .map(|arg| arg.to_string_lossy().into_owned())
        .collect();
    let chalk = Chalk::for_stdout(&args);
    let mut console = Console::new();
    let code = match run(&args, &chalk, &mut console) {
        Ok(()) => 0,
        Err(e) => {
            console.error(&format!("Error: {e}."));
            e.exit_code()
        }
    };
    console.flush();
    ExitCode::from(code)
}
