//! The CLI's options: definitions, the two-pass parse and the inference of
//! source language, target language and top-level name. Port of the option
//! handling in `src/index.ts` (`CLIOptions`, `makeOptionDefinitions`,
//! `parseCLIOptions`, `parseOptions`, `inferCLIOptions`, `inferLang`,
//! `inferTopLevel`).

use quicktype_core::{
    ErrorKind, OptionDefinition, OptionKind, OptionType, OptionValue, RendererOptions,
    TargetLanguage, default_target_languages, language_named,
};

use crate::command_line_args::{self, ArgValue};
use crate::js;
use crate::messages::{CliError, message_error};

/// `defaultDefaultTargetLanguageName`.
const DEFAULT_TARGET_LANGUAGE_NAME: &str = "go";

/// Declares [`GlobalOption`] together with `GlobalOption::ALL`, so the list
/// of options can never miss a variant.
macro_rules! global_options {
    ($($variant:ident),* $(,)?) => {
        /// One of the CLI's own options (`kind: "cli"`).
        #[derive(Clone, Copy, Debug, PartialEq, Eq)]
        enum GlobalOption {
            $($variant),*
        }

        impl GlobalOption {
            /// Every global option, in `makeOptionDefinitions` (help) order.
            const ALL: &'static [Self] = &[$(Self::$variant),*];
        }
    };
}

global_options![
    Out,
    TopLevel,
    Lang,
    SrcLang,
    Src,
    SrcUrls,
    NoMaps,
    NoEnums,
    NoUuids,
    NoDateTimes,
    NoIntegerStrings,
    NoBooleanStrings,
    NoCombineClasses,
    NoIgnoreJsonRefs,
    GraphqlSchema,
    GraphqlIntrospect,
    HttpMethod,
    HttpHeader,
    AdditionalSchema,
    NoRender,
    AlphabetizeProperties,
    AllPropertiesOptional,
    BuildMarkovChain,
    Quiet,
    Debug,
    Telemetry,
    Help,
    Version,
];

impl GlobalOption {
    /// The option's definition (one entry of TS `makeOptionDefinitions`).
    ///
    /// The `--no-*` inference switches are `no` + the inference flag name
    /// without `infer`, dashed; their description is the flag's
    /// `negationDescription` plus a period.
    // TODO(core): take the inference flags from quicktype_core::inference
    // once Inference.ts is ported.
    fn definition(self) -> OptionDefinition {
        use OptionType::{Boolean, String};
        let cli = |name, option_type, description| {
            OptionDefinition::new(name, option_type, description, OptionKind::Cli)
        };
        match self {
            Self::Out => cli("out", String, "The output file. Determines --lang and --top-level.")
                .with_alias('o')
                .with_type_label("FILE"),
            Self::TopLevel => cli("top-level", String, "The name for the top level type.")
                .with_alias('t')
                .with_type_label("NAME"),
            Self::Lang => cli("lang", String, "The target language.")
                .with_alias('l')
                .with_type_label("LANG"),
            Self::SrcLang => cli("src-lang", String, "The source language (default is json).")
                .with_alias('s')
                .with_type_label("SRC_LANG"),
            Self::Src => cli("src", String, "The file, url, or data directory to type.")
                .multiple()
                .default_option()
                .with_type_label("FILE|URL|DIRECTORY"),
            Self::SrcUrls => cli("src-urls", String, "Tracery grammar describing URLs to crawl.")
                .with_type_label("FILE"),
            Self::NoMaps => cli("no-maps", Boolean, "Don't infer maps, always use classes."),
            Self::NoEnums => cli("no-enums", Boolean, "Don't infer enums, always use strings."),
            Self::NoUuids => cli("no-uuids", Boolean, "Don't convert UUIDs to UUID objects."),
            Self::NoDateTimes => cli("no-date-times", Boolean, "Don't infer dates or times."),
            Self::NoIntegerStrings => cli(
                "no-integer-strings",
                Boolean,
                "Don't convert stringified integers to integers.",
            ),
            Self::NoBooleanStrings => cli(
                "no-boolean-strings",
                Boolean,
                "Don't convert stringified booleans to booleans.",
            ),
            Self::NoCombineClasses => {
                cli("no-combine-classes", Boolean, "Don't combine similar classes.")
            }
            Self::NoIgnoreJsonRefs => cli(
                "no-ignore-json-refs",
                Boolean,
                "Treat $ref as a reference in JSON.",
            ),
            Self::GraphqlSchema => {
                cli("graphql-schema", String, "GraphQL introspection file.").with_type_label("FILE")
            }
            Self::GraphqlIntrospect => cli(
                "graphql-introspect",
                String,
                "Introspect GraphQL schema from a server.",
            )
            .with_type_label("URL"),
            Self::HttpMethod => cli(
                "http-method",
                String,
                "HTTP method to use for the GraphQL introspection query.",
            )
            .with_type_label("METHOD"),
            Self::HttpHeader => cli(
                "http-header",
                String,
                "Header(s) to attach to all HTTP requests, including the GraphQL introspection query.",
            )
            .multiple()
            .with_type_label("HEADER"),
            Self::AdditionalSchema => cli(
                "additional-schema",
                String,
                "Register the $id's of additional JSON Schema files.",
            )
            .with_alias('S')
            .multiple()
            .with_type_label("FILE"),
            Self::NoRender => cli("no-render", Boolean, "Don't render output."),
            Self::AlphabetizeProperties => cli(
                "alphabetize-properties",
                Boolean,
                "Alphabetize order of class properties.",
            ),
            Self::AllPropertiesOptional => cli(
                "all-properties-optional",
                Boolean,
                "Make all class properties optional.",
            ),
            Self::BuildMarkovChain => {
                cli("build-markov-chain", String, "Markov chain corpus filename.")
                    .with_type_label("FILE")
            }
            Self::Quiet => cli("quiet", Boolean, "Don't show issues in the generated code."),
            Self::Debug => cli(
                "debug",
                String,
                "Comma separated debug options: print-graph, print-reconstitution, print-gather-names, print-transformations, print-schema-resolving, print-times, provenance",
            )
            .with_type_label("OPTIONS or all"),
            Self::Telemetry => cli(
                "telemetry",
                String,
                "Enable anonymous telemetry to help improve quicktype",
            )
            .with_type_label("enable|disable"),
            Self::Help => cli("help", Boolean, "Get some help.").with_alias('h'),
            Self::Version => {
                cli("version", Boolean, "Display the version of quicktype").with_alias('v')
            }
        }
    }

    /// Stores a parsed value in the matching field (the camel-cased key in
    /// TS `parseOptions`).
    fn store(self, value: &ArgValue, options: &mut PartialCliOptions) {
        let string = || Some(value.to_js_string());
        let list = || Some(as_list(value));
        let flag = || Some(as_bool(value));
        let negated = &mut options.negated_inference_flags;
        match self {
            Self::Out => options.out = string(),
            Self::TopLevel => options.top_level = string(),
            Self::Lang => options.lang = string(),
            Self::SrcLang => options.src_lang = string(),
            Self::Src => options.src = list(),
            Self::SrcUrls => options.src_urls = string(),
            Self::NoMaps => negated[0] = flag(),
            Self::NoEnums => negated[1] = flag(),
            Self::NoUuids => negated[2] = flag(),
            Self::NoDateTimes => negated[3] = flag(),
            Self::NoIntegerStrings => negated[4] = flag(),
            Self::NoBooleanStrings => negated[5] = flag(),
            Self::NoCombineClasses => negated[6] = flag(),
            Self::NoIgnoreJsonRefs => negated[7] = flag(),
            Self::GraphqlSchema => options.graphql_schema = string(),
            Self::GraphqlIntrospect => options.graphql_introspect = string(),
            Self::HttpMethod => options.http_method = string(),
            Self::HttpHeader => options.http_header = list(),
            Self::AdditionalSchema => options.additional_schema = list(),
            Self::NoRender => options.no_render = flag(),
            Self::AlphabetizeProperties => options.alphabetize_properties = flag(),
            Self::AllPropertiesOptional => options.all_properties_optional = flag(),
            Self::BuildMarkovChain => options.build_markov_chain = string(),
            Self::Quiet => options.quiet = flag(),
            Self::Debug => options.debug = string(),
            Self::Telemetry => options.telemetry = string(),
            Self::Help => options.help = flag(),
            Self::Version => options.version = flag(),
        }
    }
}

/// The global options for `target_languages`, in help order: `lang` only
/// exists when there is more than one target language.
fn global_options(target_languages: &[&'static dyn TargetLanguage]) -> Vec<GlobalOption> {
    GlobalOption::ALL
        .iter()
        .copied()
        .filter(|o| *o != GlobalOption::Lang || target_languages.len() >= 2)
        .collect()
}

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
    /// Whether each inference switch was given, in `inferenceFlagNames`
    /// order: `--no-maps`, `--no-enums`, `--no-uuids`, `--no-date-times`,
    /// `--no-integer-strings`, `--no-boolean-strings`,
    /// `--no-combine-classes`, `--no-ignore-json-refs`.
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

/// The global option definitions (TS `makeOptionDefinitions`), in help
/// order.
pub fn make_option_definitions(
    target_languages: &[&'static dyn TargetLanguage],
) -> Vec<OptionDefinition> {
    global_options(target_languages)
        .into_iter()
        .map(GlobalOption::definition)
        .collect()
}

fn as_list(value: &ArgValue) -> Vec<String> {
    match value {
        ArgValue::List(items) => items.iter().map(ArgValue::to_js_string).collect(),
        other => vec![other.to_js_string()],
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

/// Parses `argv` against the global options followed by `renderer`
/// definitions and splits the result into global and renderer options (TS
/// `parseOptions`). In strict mode (`partial == false`) unknown options are
/// errors.
fn parse_options(
    globals: &[GlobalOption],
    renderer: &[OptionDefinition],
    argv: &[String],
    partial: bool,
) -> Result<PartialCliOptions, CliError> {
    let mut definitions: Vec<OptionDefinition> = globals.iter().map(|o| o.definition()).collect();
    definitions.extend_from_slice(renderer);
    let parsing_failed = |message: String| {
        message_error(
            ErrorKind::DriverCLIOptionParsingFailed,
            vec![("message", message.into())],
        )
    };
    let parsed = command_line_args::parse(&definitions, argv, partial)
        .map_err(|e| parsing_failed(e.to_string()))?;

    if let Some((name, _)) = parsed.values.iter().find(|(_, v)| *v == ArgValue::Null) {
        return Err(parsing_failed(format!(
            "Missing value for command line option \"{name}\""
        )));
    }

    let mut options = PartialCliOptions::default();
    for (option, definition) in globals.iter().zip(&definitions) {
        if let Some(value) = parsed.get(&definition.name) {
            option.store(value, &mut options);
        }
    }
    for definition in renderer {
        if let Some(value) = parsed.get(&definition.name) {
            let value = match value {
                ArgValue::Bool(b) => OptionValue::Bool(*b),
                other => OptionValue::String(other.to_js_string()),
            };
            options
                .renderer_options
                .set(definition.name.to_string(), value);
        }
    }
    Ok(options)
}

/// TS `inferLang`: the `--out` extension without the dot, or the default.
fn infer_lang(options: &PartialCliOptions, default_language: &str) -> Result<String, CliError> {
    match &options.out {
        Some(out) => {
            let extension = js::extname(out);
            if extension.is_empty() {
                return Err(message_error(
                    ErrorKind::DriverNoLanguageOrExtension,
                    vec![],
                ));
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
) -> Result<CliOptions, CliError> {
    let src_lang = if options.graphql_schema.is_some() || options.graphql_introspect.is_some() {
        if options.src_lang.as_deref().is_some_and(|l| l != "graphql") {
            return Err(message_error(
                ErrorKind::DriverSourceLangMustBeGraphQL,
                vec![],
            ));
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
            return Err(message_error(ErrorKind::DriverGraphQLSchemaNeeded, vec![]));
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
            match language_named(&name, default_target_languages()) {
                Some(language) => language,
                None => {
                    return Err(message_error(
                        ErrorKind::DriverUnknownOutputLanguage,
                        vec![("lang", name.into())],
                    ));
                }
            }
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
pub fn parse_cli_options(argv: &[String]) -> Result<CliOptions, CliError> {
    if argv.is_empty() {
        let options = PartialCliOptions {
            help: Some(true),
            ..PartialCliOptions::default()
        };
        return infer_cli_options(options, None);
    }

    let globals = global_options(default_target_languages());

    let incomplete = infer_cli_options(parse_options(&globals, &[], argv, true)?, None)?;
    let target_language = incomplete.lang;

    let renderer = target_language.cli_option_definitions().actual;
    infer_cli_options(
        parse_options(&globals, &renderer, argv, false)?,
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
    fn global_options_are_unique_and_complete() {
        let names: Vec<String> = GlobalOption::ALL
            .iter()
            .map(|o| o.definition().name.into_owned())
            .collect();
        assert_eq!(names.len(), 28);
        for (i, name) in names.iter().enumerate() {
            assert!(!names[..i].contains(name), "duplicate option {name}");
        }
        assert_eq!(names[0], "out");
        assert_eq!(names[27], "version");
        let single: Vec<&'static dyn TargetLanguage> = vec![default_target_languages()[0]];
        assert_eq!(make_option_definitions(&single).len(), 27);
    }

    #[test]
    fn every_global_option_is_stored() {
        for option in GlobalOption::ALL {
            let definition = option.definition();
            let mut args = vec![format!("--{}", definition.name)];
            if definition.option_type != OptionType::Boolean {
                args.push("v".to_owned());
            }
            let parsed = parse_options(GlobalOption::ALL, &[], &args, false)
                .unwrap_or_else(|e| panic!("{}: {e}", definition.name));
            let stored = format!("{parsed:?}");
            assert!(
                stored.contains("Some(true)") || stored.contains("\"v\""),
                "--{} was not stored: {stored}",
                definition.name
            );
        }
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
