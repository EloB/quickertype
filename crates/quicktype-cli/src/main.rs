//! The `quicktype` CLI. Port of `quicktype/src/index.ts`.
//!
//! Contract: for any argv, stdin and input files, this binary must produce
//! byte-identical stdout, stderr, exit code and output files to the
//! TypeScript `quicktype` it replaces. `cargo xtask parity` checks that.
//!
//! The flow is TypeScript's `main`: parse the options (both passes, with
//! command-line-args' semantics), handle `--help`, `--version`,
//! `--telemetry` and `--build-markov-chain`, collect the sources, build
//! quicktype-core's [`Options`] (`makeQuicktypeOptions`), run
//! [`quicktype_multi_file`] and write the files (`writeOutput`). The CLI
//! uses only quicktype-core's public API.

mod chalk;
mod cli_options;
mod command_line_args;
mod command_line_usage;
mod compressed_json_from_stream;
mod graphql_introspection;
mod js;
mod messages;
mod node_fs;
mod sources;
mod type_source;
mod url_grammar;
mod usage;

use std::cell::RefCell;
use std::io::{self, BufWriter, ErrorKind as IoErrorKind, Write};
use std::process::ExitCode;
use std::rc::Rc;
use std::thread;

use quicktype_core::internal::{block_on, train_markov_chain};
use quicktype_core::{
    Comment, DebugOptions, ErrorKind, FetchingJsonSchemaStore, INFERENCE_FLAGS, InferenceFlags,
    InputData, JsonSample, JsonSchemaInput, JsonSchemaSourceData, JsonSourceData,
    MultiFileRenderResult, Options, QuickTypeError, Readable, RendererOptions, SampleReader, StdIo,
    TargetLanguage, default_target_languages, json_input_for_target_language, parse_json,
    quicktype_multi_file, set_console_sink, sources_from_postman_collection,
};
use quicktype_graphql_input::{GraphQlInput, GraphQlSourceData};
use quicktype_js_compat::wordwrap::WordWrap;

use crate::chalk::Chalk;
use crate::cli_options::{CliOptions, parse_cli_options};
use crate::messages::{CliError, message_error};
use crate::type_source::{JsonTypeSource, TypeSource};

#[cfg(feature = "mimalloc")]
#[global_allocator]
static GLOBAL: mimalloc::MiMalloc = mimalloc::MiMalloc;

/// `packageJSON.version`.
const VERSION: &str = env!("CARGO_PKG_VERSION");

/// The stack of the thread that runs quicktype. Type inference and the
/// rewrites recurse once per nesting level of the input, as in TypeScript;
/// a large stack lets deep inputs through like Node does.
const STACK_SIZE: usize = 256 << 20;

/// `console.log`, `console.error` and `process.stdout.write`, with
/// quicktype's EPIPE handling: a closed stdout or stderr ends the process
/// with exit code 0.
///
/// Any other write error makes Node throw an uncaught exception (a stack
/// trace on stderr, exit code 1). That trace cannot be reproduced; we print a
/// one-line error instead and exit 1 (a known gap, see docs/PARITY.md).
struct Console {
    stdout: RefCell<BufWriter<io::Stdout>>,
}

impl Console {
    fn new() -> Self {
        Self {
            stdout: RefCell::new(BufWriter::new(io::stdout())),
        }
    }

    fn check(result: io::Result<()>, stream: &str) {
        let Err(e) = result else {
            return;
        };
        if e.kind() == IoErrorKind::BrokenPipe {
            std::process::exit(0);
        }
        // Best effort: stderr itself may be the stream that failed.
        let _ = writeln!(io::stderr(), "Error: cannot write to {stream}: {e}.");
        std::process::exit(1);
    }

    /// `process.stdout.write(text)`.
    fn write(&self, text: &str) {
        Self::check(
            self.stdout.borrow_mut().write_all(text.as_bytes()),
            "stdout",
        );
    }

    /// `console.log(text)`.
    fn log(&self, text: &str) {
        Self::check(writeln!(self.stdout.borrow_mut(), "{text}"), "stdout");
    }

    /// `console.error(text)`; flushes stdout first to keep the order.
    fn error(&self, text: &str) {
        self.flush();
        Self::check(writeln!(io::stderr(), "{text}"), "stderr");
    }

    fn flush(&self) {
        Self::check(self.stdout.borrow_mut().flush(), "stdout");
    }
}

/// `makeInputData(sources, targetLanguage, additionalSchemaAddresses,
/// handleJSONRefs, rendererOptions, httpHeaders)`: adds every source to the
/// input of its kind, reading (and parsing) the JSON samples.
async fn make_input_data(
    sources: Vec<TypeSource>,
    target_language: &'static dyn TargetLanguage,
    additional_schema_addresses: &[String],
    handle_json_refs: bool,
    renderer_options: &RendererOptions,
    http_headers: Option<&[String]>,
) -> Result<InputData, CliError> {
    let mut input_data = InputData::new();
    for source in sources {
        match source {
            TypeSource::GraphQl(source) => {
                input_data
                    .add_source("graphql", source, GraphQlInput::new)
                    .await?;
            }
            TypeSource::Json(source) => {
                add_json_source(
                    &mut input_data,
                    source,
                    target_language,
                    handle_json_refs,
                    renderer_options,
                )
                .await?;
            }
            TypeSource::Schema(source) => {
                input_data
                    .add_source("schema", source, || {
                        JsonSchemaInput::new(
                            Some(Box::new(FetchingJsonSchemaStore::new(
                                http_headers.unwrap_or_default().to_vec(),
                            ))),
                            Vec::new(),
                            additional_schema_addresses.to_vec(),
                        )
                    })
                    .await?;
            }
        }
    }
    Ok(input_data)
}

/// `inputData.addSource("json", source, () =>
/// jsonInputForTargetLanguage(...))`: reads and parses the samples with
/// stream-json's semantics.
///
/// TypeScript reads each sample's stream as it parses it, one sample after
/// the other, and stops at the first error: a sample that fails to parse
/// is reported before a later one is even read (`bad.json -` never touches
/// standard input). So each sample is read and added on its own; a failure
/// aborts the run, so the samples added before it do not matter.
async fn add_json_source(
    input_data: &mut InputData,
    source: JsonTypeSource,
    target_language: &'static dyn TargetLanguage,
    handle_json_refs: bool,
    renderer_options: &RendererOptions,
) -> Result<(), CliError> {
    let JsonTypeSource {
        name,
        samples,
        description,
    } = source;
    let make_input =
        || json_input_for_target_language(target_language, handle_json_refs, renderer_options);
    if samples.is_empty() {
        // `DriverNoSamplesForTopLevel`.
        let empty = JsonSourceData {
            name,
            samples: Vec::new(),
            description,
        };
        return Ok(input_data.add_source("json", empty, make_input).await?);
    }
    for sample in samples {
        // Read chunk by chunk as it is parsed, like TypeScript's stream:
        // a large file is never held whole.
        let reader = sample.open_std().map_err(CliError::Io)?;
        let one = JsonSourceData {
            name: name.clone(),
            samples: vec![JsonSample::Reader(SampleReader::new(reader))],
            description: description.clone(),
        };
        input_data.add_source("json", one, make_input).await?;
    }
    Ok(())
}

/// The `--debug` components: comma-separated, each trimmed; `all` turns
/// on everything. Returns the switches and `checkProvenance`.
fn parse_debug_options(debug: Option<&str>) -> Result<(DebugOptions, bool), CliError> {
    let Some(debug) = debug else {
        return Ok((DebugOptions::default(), false));
    };
    let components: Vec<&str> = debug.split(',').collect();
    // `components.includes("all")` looks at the untrimmed components.
    let all = components.contains(&"all");
    let mut options = if all {
        DebugOptions::all()
    } else {
        DebugOptions::default()
    };
    let mut check_provenance = all;
    for component in components {
        match js::trim(component) {
            "print-graph" => options.print_graph = true,
            "print-reconstitution" => options.print_reconstitution = true,
            "print-gather-names" => options.print_gather_names = true,
            "print-transformations" => options.print_transformations = true,
            "print-times" => options.print_times = true,
            "print-schema-resolving" => options.print_schema_resolving = true,
            "provenance" => check_provenance = true,
            "all" => {}
            other => {
                return Err(message_error(
                    ErrorKind::DriverUnknownDebugOption,
                    vec![("option", other.into())],
                ));
            }
        }
    }
    Ok((options, check_provenance))
}

/// The sources of `--src-lang typescript`: one schema made from all the
/// TypeScript files (TS `makeTypeScriptSource`). typescript-json-schema's
/// warnings go to stderr as it writes them.
fn make_typescript_source(
    file_names: &[String],
    console: &Console,
) -> Result<JsonSchemaSourceData, CliError> {
    match quicktype_typescript_input::schema_for_typescript_sources(file_names) {
        Ok(output) => {
            for warning in &output.warnings {
                console.error(warning);
            }
            let source = output.source;
            Ok(JsonSchemaSourceData {
                name: source.name,
                uris: Some(source.uris),
                schema: Some(source.schema),
                is_converted: source.is_converted,
            })
        }
        Err(failure) => {
            for warning in &failure.warnings {
                console.error(warning);
            }
            Err(match failure.error {
                quicktype_typescript_input::Error::TypeScript { message } => message_error(
                    ErrorKind::TypeScriptCompilerError,
                    vec![("message", message.into())],
                ),
                other => CliError::Thrown(other.message()),
            })
        }
    }
}

/// What `--src-lang postman` contributes to a run.
#[derive(Default)]
struct PostmanInputs {
    /// One JSON source per request.
    sources: Vec<TypeSource>,
    /// The (last) collection's description, wrapped at 90 columns.
    leading_comments: Option<Vec<Comment>>,
    /// Whether a collection has several requests, whose top-levels must
    /// then stay separate.
    fixed_top_levels: bool,
}

/// The sources of `--src-lang postman`: every request of every collection
/// (TS reads them with `fs.readFileSync`), with the collection description
/// as leading comments.
fn postman_sources(collection_files: &[String]) -> Result<PostmanInputs, CliError> {
    let mut inputs = PostmanInputs::default();
    for collection_file in collection_files {
        let collection_json = node_fs::read_file_sync_utf8(collection_file)?;
        let postman = sources_from_postman_collection(&collection_json, Some(collection_file))?;
        if postman.sources.len() > 1 {
            inputs.fixed_top_levels = true;
        }
        for source in postman.sources {
            inputs.sources.push(TypeSource::Json(JsonTypeSource {
                name: source.name,
                samples: source.samples.into_iter().map(Readable::Text).collect(),
                description: source.description,
            }));
        }
        if let Some(description) = postman.description {
            inputs.leading_comments = Some(
                WordWrap::new(90)
                    .wrap(&description)
                    .split('\n')
                    .map(Comment::from)
                    .collect(),
            );
        }
    }
    Ok(inputs)
}

/// The sources of `--src-lang graphql`: each query file with the
/// introspection schema of `--graphql-schema`, or of
/// `--graphql-introspect` (which is also written to the `--graphql-schema`
/// file if given). `None` when there is nothing more to do: the schema was
/// written to its file, or printed, for lack of a query.
async fn graphql_sources(
    options: &CliOptions,
    console: &Console,
) -> Result<Option<Vec<TypeSource>>, CliError> {
    let mut schema_string: Option<String> = None;
    let mut wrote_schema_to_file = false;
    if let Some(url) = &options.graphql_introspect {
        let introspected = graphql_introspection::introspect_server(
            &StdIo,
            url,
            options.http_method.as_deref().unwrap_or("POST"),
            options.http_header.as_deref().unwrap_or_default(),
        )
        .await?;
        if let Some(file) = &options.graphql_schema {
            node_fs::write_file_sync(file, &introspected)?;
            wrote_schema_to_file = true;
        }
        schema_string = Some(introspected);
    }

    let num_sources = options.src.len();
    if num_sources != 1 {
        if wrote_schema_to_file {
            // We're done.
            return Ok(None);
        }
        if num_sources == 0 {
            if let Some(schema) = &schema_string {
                console.log(schema);
                return Ok(None);
            }
            return Err(message_error(ErrorKind::DriverNoGraphQLQueryGiven, vec![]));
        }
    }

    let http_headers = options.http_header.as_deref().unwrap_or_default();
    let mut sources = Vec::with_capacity(num_sources);
    for query_file in &options.src {
        let mut schema_file_name = None;
        let schema_text = match &schema_string {
            Some(text) => text,
            None => {
                let file_name = options.graphql_schema.as_deref().ok_or_else(|| {
                    QuickTypeError::internal("Defined value expected, but got undefined")
                })?;
                schema_file_name = Some(file_name);
                schema_string.insert(node_fs::read_file_sync_utf8(file_name)?)
            }
        };
        let schema = parse_json(schema_text, "GraphQL schema", schema_file_name)?;
        let query =
            node_fs::read(node_fs::readable_from_file_or_url(query_file, http_headers).await?)
                .await?;
        let name = if num_sources == 1 {
            options.top_level.clone()
        } else {
            sources::type_name_from_filename(query_file)
        };
        sources.push(TypeSource::GraphQl(GraphQlSourceData {
            name,
            schema,
            query,
        }));
    }
    Ok(Some(sources))
}

/// TS `makeQuicktypeOptions(options)`: handles `--help`, `--version` and
/// `--build-markov-chain` (returning `None`, as there is nothing to
/// generate), collects the sources and builds the engine's options.
async fn make_quicktype_options(
    options: &CliOptions,
    chalk: &Chalk,
    console: &Console,
) -> Result<Option<Options<'static>>, CliError> {
    if options.help {
        console.log(&usage::usage(chalk, default_target_languages())?);
        return Ok(None);
    }
    if options.version {
        console.log(&format!("quicktype version {VERSION}"));
        console.log("Visit quicktype.io for more info.");
        return Ok(None);
    }
    if let Some(corpus) = &options.build_markov_chain {
        let contents = node_fs::read_file_sync(corpus)?;
        let contents = String::from_utf8_lossy(&contents);
        let lines: Vec<&str> = contents.split('\n').collect();
        console.log(&train_markov_chain(&lines, 3).to_json());
        return Ok(None);
    }

    let mut leading_comments = None;
    let mut fixed_top_levels = false;
    let sources = match options.src_lang.as_str() {
        "graphql" => match graphql_sources(options, console).await? {
            Some(sources) => sources,
            None => return Ok(None),
        },
        "json" | "schema" => sources::get_sources(options).await?,
        "typescript" => vec![TypeSource::Schema(make_typescript_source(
            &options.src,
            console,
        )?)],
        "postman" => {
            let postman = postman_sources(&options.src)?;
            leading_comments = postman.leading_comments;
            fixed_top_levels = postman.fixed_top_levels;
            postman.sources
        }
        other => {
            return Err(message_error(
                ErrorKind::DriverUnknownSourceLanguage,
                vec![("lang", other.into())],
            ));
        }
    };

    let (debug, check_provenance) = parse_debug_options(options.debug.as_deref())?;

    // `quicktypeOptions[flagName] = !cliOptions[noFlagName]`, in
    // `inferenceFlagNames` order.
    let mut inference_flags = InferenceFlags::default();
    for (flag, negated) in INFERENCE_FLAGS.iter().zip(options.negated_inference_flags) {
        inference_flags.set(flag.name, !negated);
    }

    let lang = options.lang;
    let input_data = make_input_data(
        sources,
        lang,
        &options.additional_schema,
        !inference_flags.ignore_json_refs,
        &options.renderer_options,
        options.http_header.as_deref(),
    )
    .await?;

    let mut quicktype_options = Options::new(lang, input_data);
    quicktype_options.inference_flags = inference_flags;
    quicktype_options.alphabetize_properties = options.alphabetize_properties;
    quicktype_options.all_properties_optional = options.all_properties_optional;
    quicktype_options.fixed_top_levels = fixed_top_levels;
    quicktype_options.no_render = options.no_render;
    quicktype_options.renderer_options = options.renderer_options.clone();
    quicktype_options.leading_comments = leading_comments;
    if let Some(out) = &options.out {
        quicktype_options.output_filename = js::basename(out).to_owned();
    }
    quicktype_options.debug = debug;
    quicktype_options.check_provenance = check_provenance;
    Ok(Some(quicktype_options))
}

/// TS `writeOutput(cliOptions, resultsByFilename)`: writes each file next to
/// `--out`, or all of them to stdout (with a `// <file>` header each when
/// there are several), and prints the issues to stderr unless `--quiet`.
fn write_output(
    options: &CliOptions,
    results_by_filename: &MultiFileRenderResult,
    console: &Console,
) -> Result<(), CliError> {
    let mut on_first = true;
    for (filename, result) in results_by_filename {
        let output = result.lines.join("\n");

        if let Some(out) = &options.out {
            let path = js::path_join(&[js::dirname(out), filename]);
            node_fs::write_file_sync(&path, &output)?;
        } else {
            if !on_first {
                console.write("\n");
            }
            if results_by_filename.len() > 1 {
                console.write(&format!("// {filename}\n\n"));
            }
            console.write(&output);
        }

        if options.quiet {
            continue;
        }

        for annotation in &result.annotations {
            let line_number = annotation.span.start.line;
            let human_line_number = line_number + 1;
            console.error(&format!(
                "\nIssue in line {human_line_number}: {}",
                annotation.annotation.message()
            ));
            let line = result
                .lines
                .get(line_number)
                .map_or("undefined", String::as_str);
            console.error(&format!("{human_line_number}: {line}"));
        }

        on_first = false;
    }
    Ok(())
}

/// TS `main(argv)`.
async fn run(args: &[String], chalk: &Chalk, console: &Console) -> Result<(), CliError> {
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

    let Some(quicktype_options) = make_quicktype_options(&options, chalk, console).await? else {
        return Ok(());
    };

    let results_by_filename = quicktype_multi_file(quicktype_options)
        .await
        .map_err(CliError::from)?;

    write_output(&options, &results_by_filename, console)
}

/// The process: `main(process.argv.slice(2)).catch(...)`, on a thread with
/// a large stack.
fn cli_main(args: Vec<String>) -> u8 {
    let chalk = Chalk::for_stdout(&args);
    let console = Rc::new(Console::new());
    // quicktype-core's debug output (`--debug print-graph`, ...) is
    // `console.log` too.
    let sink = Rc::clone(&console);
    set_console_sink(Some(Box::new(move |line| sink.log(line))));
    let code = match block_on(run(&args, &chalk, &console)) {
        Ok(()) => 0,
        Err(e) => {
            console.error(&format!("Error: {e}."));
            e.exit_code()
        }
    };
    console.flush();
    set_console_sink(None);
    code
}

fn main() -> ExitCode {
    // Node decodes argv as UTF-8, replacing invalid sequences.
    let args: Vec<String> = std::env::args_os()
        .skip(1)
        .map(|arg| arg.to_string_lossy().into_owned())
        .collect();
    let generation = thread::Builder::new()
        .name("quicktype".to_owned())
        .stack_size(STACK_SIZE)
        .spawn(move || cli_main(args));
    let code = match generation.map(thread::JoinHandle::join) {
        Ok(Ok(code)) => code,
        Ok(Err(_)) | Err(_) => {
            let _ = writeln!(
                io::stderr(),
                "Error: {}.",
                QuickTypeError::internal("the quicktype thread failed").user_message()
            );
            1
        }
    };
    ExitCode::from(code)
}
