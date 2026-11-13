//! The CLI's options: definitions, the two-pass parse and the inference of
//! source language, target language and top-level name. Port of the option
//! handling in `src/index.ts` (`CLIOptions`, `makeOptionDefinitions`,
//! `parseCLIOptions`, `parseOptions`, `inferCLIOptions`, `inferLang`,
//! `inferTopLevel`).

use quicktype_core::language::all::{default_target_languages, language_named};
use quicktype_core::renderer_options::{
    OptionDefinition, OptionKind, OptionType, OptionValue, RendererOptions,
};
use quicktype_core::target_language::TargetLanguage;

use crate::command_line_args::{self, ArgValue};
use crate::js;
use crate::messages::DriverError;

/// `defaultDefaultTargetLanguageName`.
const DEFAULT_TARGET_LANGUAGE_NAME: &str = "go";

/// The CLI switches that turn off an inference flag, in
/// `inferenceFlagNames` order, with the flag's `negationDescription`.
// TODO(core): derive from quicktype_core::inference once Inference.ts is
// ported (the CLI name is `no` + the flag name without `infer`, dashed).
pub const NEGATED_INFERENCE_FLAGS: [(&str, &str); 8] = [
    ("no-maps", "Don't infer maps, always use classes"),
    ("no-enums", "Don't infer enums, always use strings"),
    ("no-uuids", "Don't convert UUIDs to UUID objects"),
    ("no-date-times", "Don't infer dates or times"),
    (
        "no-integer-strings",
        "Don't convert stringified integers to integers",
    ),
    (
        "no-boolean-strings",
        "Don't convert stringified booleans to booleans",
    ),
    ("no-combine-classes", "Don't combine similar classes"),
    ("no-ignore-json-refs", "Treat $ref as a reference in JSON"),
];

/// The fully parsed command line (TS `CLIOptions`): what the engine
/// consumes. Renderer options keep every value the parser produced,
/// including the defaults of all of the language's options (both `x` and
/// `no-x` for booleans), in definition order, exactly like the TS object.
// TODO(engine): most fields are read only once makeQuicktypeOptions can
// build the engine's options from them.
#[allow(dead_code)]
#[derive(Clone, Debug)]
pub struct CliOptions {
    /// Input files, URLs or directories (`--src` and bare arguments).
    pub src: Vec<String>,
    /// `--src-urls`: a URL grammar file.
    pub src_urls: Option<String>,
    /// The source language: `json` unless given or inferred.
    pub src_lang: String,
    /// The target language.
    pub lang: &'static dyn TargetLanguage,
    /// The top-level type name.
    pub top_level: String,
    /// `--no-render`.
    pub no_render: bool,
    /// `--alphabetize-properties`.
    pub alphabetize_properties: bool,
    /// `--all-properties-optional`.
    pub all_properties_optional: bool,
    /// The target language's options (untyped, keyed by option name).
    pub renderer_options: RendererOptions,
    /// `--help`.
    pub help: bool,
    /// `--quiet`.
    pub quiet: bool,
    /// `--version`.
    pub version: bool,
    /// `--out`: the output file.
    pub out: Option<String>,
    /// `--build-markov-chain`.
    pub build_markov_chain: Option<String>,
    /// `--additional-schema` (`-S`).
    pub additional_schema: Vec<String>,
    /// `--graphql-schema`.
    pub graphql_schema: Option<String>,
    /// `--graphql-introspect`.
    pub graphql_introspect: Option<String>,
    /// `--http-method`.
    pub http_method: Option<String>,
    /// `--http-header`.
    pub http_header: Option<Vec<String>>,
    /// `--debug`.
    pub debug: Option<String>,
    /// `--telemetry`.
    pub telemetry: Option<String>,
    /// Whether each of [`NEGATED_INFERENCE_FLAGS`] was given (`noMaps`, …).
    pub negated_inference_flags: [bool; 8],
}

/// The result of one parse (TS `Partial<CLIOptions>`).
#[derive(Clone, Debug, Default)]
struct PartialCliOptions {
    out: Option<String>,
    top_level: Option<String>,
    lang: Option<String>,
    src_lang: Option<String>,
    src: Option<Vec<String>>,
    src_urls: Option<String>,
    negated_inference_flags: [Option<bool>; 8],
    graphql_schema: Option<String>,
    graphql_introspect: Option<String>,
    http_method: Option<String>,
    http_header: Option<Vec<String>>,
    additional_schema: Option<Vec<String>>,
    no_render: Option<bool>,
    alphabetize_properties: Option<bool>,
    all_properties_optional: Option<bool>,
    build_markov_chain: Option<String>,
    quiet: Option<bool>,
    debug: Option<String>,
    telemetry: Option<String>,
    help: Option<bool>,
    version: Option<bool>,
    renderer_options: RendererOptions,
}

fn cli(name: &'static str, option_type: OptionType, description: &'static str) -> OptionDefinition {
    OptionDefinition::new(name, option_type, description, OptionKind::Cli)
}

/// The global options (TS `makeOptionDefinitions`), in help order. `lang`
/// only exists when there is more than one target language.
pub fn make_option_definitions(
    target_languages: &[&'static dyn TargetLanguage],
) -> Vec<OptionDefinition> {
    use OptionType::{Boolean, String};

    let mut definitions = vec![
        cli(
            "out",
            String,
            "The output file. Determines --lang and --top-level.",
        )
        .with_alias('o')
        .with_type_label("FILE"),
        cli("top-level", String, "The name for the top level type.")
            .with_alias('t')
            .with_type_label("NAME"),
    ];
    if target_languages.len() >= 2 {
        definitions.push(
            cli("lang", String, "The target language.")
                .with_alias('l')
                .with_type_label("LANG"),
        );
    }
    definitions.extend([
        cli("src-lang", String, "The source language (default is json).")
            .with_alias('s')
            .with_type_label("SRC_LANG"),
        cli("src", String, "The file, url, or data directory to type.")
            .multiple()
            .default_option()
            .with_type_label("FILE|URL|DIRECTORY"),
        cli(
            "src-urls",
            String,
            "Tracery grammar describing URLs to crawl.",
        )
        .with_type_label("FILE"),
    ]);
    for (name, negation) in NEGATED_INFERENCE_FLAGS {
        definitions.push(OptionDefinition {
            description: format!("{negation}.").into(),
            ..cli(name, Boolean, "")
        });
    }
    definitions.extend([
        cli("graphql-schema", String, "GraphQL introspection file.").with_type_label("FILE"),
        cli("graphql-introspect", String, "Introspect GraphQL schema from a server.")
            .with_type_label("URL"),
        cli(
            "http-method",
            String,
            "HTTP method to use for the GraphQL introspection query.",
        )
        .with_type_label("METHOD"),
        cli(
            "http-header",
            String,
            "Header(s) to attach to all HTTP requests, including the GraphQL introspection query.",
        )
        .multiple()
        .with_type_label("HEADER"),
        cli(
            "additional-schema",
            String,
            "Register the $id's of additional JSON Schema files.",
        )
        .with_alias('S')
        .multiple()
        .with_type_label("FILE"),
        cli("no-render", Boolean, "Don't render output."),
        cli("alphabetize-properties", Boolean, "Alphabetize order of class properties."),
        cli("all-properties-optional", Boolean, "Make all class properties optional."),
        cli("build-markov-chain", String, "Markov chain corpus filename.").with_type_label("FILE"),
        cli("quiet", Boolean, "Don't show issues in the generated code."),
        cli(
            "debug",
            String,
            "Comma separated debug options: print-graph, print-reconstitution, print-gather-names, print-transformations, print-schema-resolving, print-times, provenance",
        )
        .with_type_label("OPTIONS or all"),
        cli(
            "telemetry",
            String,
            "Enable anonymous telemetry to help improve quicktype",
        )
        .with_type_label("enable|disable"),
        cli("help", Boolean, "Get some help.").with_alias('h'),
        cli("version", Boolean, "Display the version of quicktype").with_alias('v'),
    ]);
    definitions
}

fn as_string(value: ArgValue) -> String {
    match value {
        ArgValue::String(s) => s,
        ArgValue::Bool(b) => b.to_string(),
        ArgValue::Null => "null".to_owned(),
        ArgValue::List(items) => items.join(","),
    }
}

fn as_list(value: ArgValue) -> Vec<String> {
    match value {
        ArgValue::List(items) => items,
        other => vec![as_string(other)],
    }
}

fn as_bool(value: &ArgValue) -> bool {
    match value {
        ArgValue::Bool(b) => *b,
        ArgValue::Null => false,
        ArgValue::String(s) => !s.is_empty(),
        ArgValue::List(_) => true,
    }
}

/// Parses `argv` against `definitions` and splits the result into global and
/// renderer options (TS `parseOptions`). In strict mode (`partial == false`)
/// unknown options are errors.
fn parse_options(
    definitions: &[OptionDefinition],
    argv: &[String],
    partial: bool,
) -> Result<PartialCliOptions, DriverError> {
    let parsed = command_line_args::parse(definitions, argv, partial).map_err(|e| {
        DriverError::CliOptionParsingFailed {
            message: e.to_string(),
        }
    })?;

    if let Some((name, _)) = parsed.values.iter().find(|(_, v)| *v == ArgValue::Null) {
        return Err(DriverError::CliOptionParsingFailed {
            message: format!("Missing value for command line option \"{name}\""),
        });
    }

    let mut options = PartialCliOptions::default();
    for definition in definitions {
        let Some(value) = parsed.get(&definition.name).cloned() else {
            continue;
        };
        if definition.kind != OptionKind::Cli {
            let value = match value {
                ArgValue::Bool(b) => OptionValue::Bool(b),
                other => OptionValue::String(as_string(other)),
            };
            options
                .renderer_options
                .set(definition.name.to_string(), value);
            continue;
        }
        if let Some(i) = NEGATED_INFERENCE_FLAGS
            .iter()
            .position(|(name, _)| *name == definition.name)
        {
            options.negated_inference_flags[i] = Some(as_bool(&value));
            continue;
        }
        match definition.name.as_ref() {
            "out" => options.out = Some(as_string(value)),
            "top-level" => options.top_level = Some(as_string(value)),
            "lang" => options.lang = Some(as_string(value)),
            "src-lang" => options.src_lang = Some(as_string(value)),
            "src" => options.src = Some(as_list(value)),
            "src-urls" => options.src_urls = Some(as_string(value)),
            "graphql-schema" => options.graphql_schema = Some(as_string(value)),
            "graphql-introspect" => options.graphql_introspect = Some(as_string(value)),
            "http-method" => options.http_method = Some(as_string(value)),
            "http-header" => options.http_header = Some(as_list(value)),
            "additional-schema" => options.additional_schema = Some(as_list(value)),
            "no-render" => options.no_render = Some(as_bool(&value)),
            "alphabetize-properties" => options.alphabetize_properties = Some(as_bool(&value)),
            "all-properties-optional" => options.all_properties_optional = Some(as_bool(&value)),
            "build-markov-chain" => options.build_markov_chain = Some(as_string(value)),
            "quiet" => options.quiet = Some(as_bool(&value)),
            "debug" => options.debug = Some(as_string(value)),
            "telemetry" => options.telemetry = Some(as_string(value)),
            "help" => options.help = Some(as_bool(&value)),
            "version" => options.version = Some(as_bool(&value)),
            _ => {}
        }
    }
    Ok(options)
}

/// TS `inferLang`: the `--out` extension without the dot, or the default.
fn infer_lang(options: &PartialCliOptions, default_language: &str) -> Result<String, DriverError> {
    match &options.out {
        Some(out) => {
            let extension = js::extname(out);
            if extension.is_empty() {
                return Err(DriverError::NoLanguageOrExtension);
            }
            Ok(extension[1..].to_owned())
        }
        None => Ok(default_language.to_owned()),
    }
}

/// `path.basename(file).replace(path.extname(file), "")`.
fn name_without_extension(file: &str) -> String {
    js::basename(file).replacen(js::extname(file), "", 1)
}

/// TS `inferTopLevel`: from `--out`, else from a single source, else
/// `TopLevel`.
fn infer_top_level(options: &PartialCliOptions) -> String {
    if let Some(out) = &options.out {
        return name_without_extension(out);
    }
    if let Some([src]) = options.src.as_deref() {
        return name_without_extension(src);
    }
    "TopLevel".to_owned()
}

/// TS `inferCLIOptions`: fills in the source language, the target language
/// and the top-level name. `target_language` is the language chosen by the
/// first parse, if any.
fn infer_cli_options(
    options: PartialCliOptions,
    target_language: Option<&'static dyn TargetLanguage>,
) -> Result<CliOptions, DriverError> {
    let src_lang = if options.graphql_schema.is_some() || options.graphql_introspect.is_some() {
        if options.src_lang.as_deref().is_some_and(|l| l != "graphql") {
            return Err(DriverError::SourceLangMustBeGraphQL);
        }
        "graphql".to_owned()
    } else if options
        .src
        .as_deref()
        .is_some_and(|src| !src.is_empty() && src.iter().all(|f| f.ends_with(".ts")))
    {
        "typescript".to_owned()
    } else {
        if options.src_lang.as_deref() == Some("graphql") {
            return Err(DriverError::GraphQLSchemaNeeded);
        }
        options
            .src_lang
            .clone()
            .unwrap_or_else(|| "json".to_owned())
    };

    let language = match target_language {
        Some(language) => language,
        None => {
            let name = match &options.lang {
                Some(lang) => lang.clone(),
                None => infer_lang(&options, DEFAULT_TARGET_LANGUAGE_NAME)?,
            };
            language_named(&name, default_target_languages())
                .ok_or(DriverError::UnknownOutputLanguage { lang: name })?
        }
    };

    let top_level = options
        .top_level
        .clone()
        .unwrap_or_else(|| infer_top_level(&options));
    Ok(CliOptions {
        src: options.src.unwrap_or_default(),
        src_urls: options.src_urls,
        src_lang,
        lang: language,
        top_level,
        no_render: options.no_render.unwrap_or(false),
        alphabetize_properties: options.alphabetize_properties.unwrap_or(false),
        all_properties_optional: options.all_properties_optional.unwrap_or(false),
        renderer_options: options.renderer_options,
        help: options.help.unwrap_or(false),
        quiet: options.quiet.unwrap_or(false),
        version: options.version.unwrap_or(false),
        out: options.out,
        build_markov_chain: options.build_markov_chain,
        additional_schema: options.additional_schema.unwrap_or_default(),
        graphql_schema: options.graphql_schema,
        graphql_introspect: options.graphql_introspect,
        http_method: options.http_method,
        http_header: options.http_header,
        debug: options.debug,
        telemetry: options.telemetry,
        negated_inference_flags: options.negated_inference_flags.map(|f| f.unwrap_or(false)),
    })
}

/// TS `parseCLIOptions(argv)`: no arguments means `--help`. Otherwise argv is
/// parsed twice: leniently with the global options to find the target
/// language, then strictly with the global options plus that language's
/// renderer options.
pub fn parse_cli_options(argv: &[String]) -> Result<CliOptions, DriverError> {
    if argv.is_empty() {
        let options = PartialCliOptions {
            help: Some(true),
            ..PartialCliOptions::default()
        };
        return infer_cli_options(options, None);
    }

    let target_languages = default_target_languages();
    let mut definitions = make_option_definitions(target_languages);

    let incomplete = infer_cli_options(parse_options(&definitions, argv, true)?, None)?;
    let target_language = incomplete.lang;

    definitions.extend(target_language.cli_option_definitions().actual);
    infer_cli_options(
        parse_options(&definitions, argv, false)?,
        Some(target_language),
    )
}

#[cfg(test)]
mod tests {
    use super::*;

    fn parse(args: &[&str]) -> Result<CliOptions, String> {
        let args: Vec<String> = args.iter().map(|s| (*s).to_owned()).collect();
        parse_cli_options(&args).map_err(|e| e.to_string())
    }

    #[test]
    fn no_arguments_is_help() {
        let options = parse(&[]).unwrap();
        assert!(options.help);
        assert_eq!(options.lang.name(), "go");
        assert_eq!(options.top_level, "TopLevel");
    }

    #[test]
    fn renderer_options_include_every_default() {
        let options = parse(&["-l", "csharp", "--virtual", "a.json"]).unwrap();
        assert_eq!(options.lang.name(), "cs");
        assert_eq!(options.top_level, "a");
        let keys: Vec<&str> = options.renderer_options.iter().map(|(k, _)| k).collect();
        assert_eq!(keys.len(), 21);
        assert_eq!(&keys[..3], ["framework", "array-type", "density"]);
        assert_eq!(
            options.renderer_options.get("virtual"),
            Some(&OptionValue::Bool(true))
        );
        assert_eq!(
            options.renderer_options.get("no-virtual"),
            Some(&OptionValue::Bool(true))
        );
    }

    #[test]
    fn inference_from_out() {
        let options = parse(&["-o", "Foo.bar.ts", "x.json"]).unwrap();
        assert_eq!(options.lang.name(), "typescript");
        assert_eq!(options.top_level, "Foo.bar");
        assert_eq!(
            parse(&["-o", "x.kt"]).unwrap_err(),
            "Unknown output language kt"
        );
        assert_eq!(
            parse(&["-o", "foo"]).unwrap_err(),
            "Please specify a language (--lang) or an output file extension"
        );
    }

    #[test]
    fn source_language() {
        assert_eq!(parse(&["a.ts", "b.ts"]).unwrap().src_lang, "typescript");
        assert_eq!(
            parse(&["--src-lang", "schema", "a"]).unwrap().src_lang,
            "schema"
        );
        assert_eq!(
            parse(&["--src-lang", "graphql", "a"]).unwrap_err(),
            "Please specify a GraphQL schema with --graphql-schema or --graphql-introspect"
        );
        assert_eq!(
            parse(&["--graphql-schema", "s", "q"]).unwrap().src_lang,
            "graphql"
        );
    }

    #[test]
    fn errors() {
        assert_eq!(
            parse(&["--lang"]).unwrap_err(),
            "Option parsing failed: Missing value for command line option \"lang\""
        );
        assert_eq!(
            parse(&["--framework", "x"]).unwrap_err(),
            "Option parsing failed: UNKNOWN_OPTION: Unknown option: --framework"
        );
        assert_eq!(
            parse(&["-l", "cs", "--namespace"]).unwrap_err(),
            "Option parsing failed: Missing value for command line option \"namespace\""
        );
    }
}
