//! Differential tests of the JSON input against the TypeScript reference.
//!
//! `xtask/core-json-input/gen-fixtures.mjs` ran the reference's `JSONInput`
//! through both readers (the CLI's stream-json reader and the API's
//! `JSON.parse` reader) on every file in `tests/inputs/json` and on the
//! edge cases of `xtask/core-json-input/cases.mjs`, under the
//! configurations in `configs.json`, and recorded the type graph print
//! right after the input was added (the first print of
//! `--debug print-graph`) plus the properties of every class, or the
//! error. This test rebuilds every graph with
//! the Rust port and compares the prints byte for byte. It also replays the
//! recorded date/time recognizer answers, URI attributes, Postman
//! collection sources and the inference hooks of every target language.
//! Node is not needed.

use std::collections::BTreeMap;
use std::fmt::Write as _;
use std::future::Future;
use std::path::{Path, PathBuf};
use std::pin::pin;
use std::task::{Context, Poll, Waker};

use quicktype_core::attributes::type_attributes::AttributeKind;
use quicktype_core::attributes::uri_attributes::{
    UriTypeAttributeKind, uri_inference_attributes_producer,
};
use quicktype_core::date_time::{DateTimeRecognizer, DefaultDateTimeRecognizer};
use quicktype_core::inference::{INFERENCE_FLAGS, InferenceFlags};
use quicktype_core::input::compressed_json::{CompressedJson, JsonSample};
use quicktype_core::input::inputs::{InputData, JsonInput, JsonSourceData};
use quicktype_core::input::postman_collection::sources_from_postman_collection;
use quicktype_core::language::all::{default_target_languages, language_named};
use quicktype_core::language::kotlin::utils::KotlinDateTimeRecognizer;
use quicktype_core::language::swift::utils::SwiftDateTimeRecognizer;
use quicktype_core::messages::Result;
use quicktype_core::renderer_options::RendererOptions;
use quicktype_core::run::RunContext;
use quicktype_core::target_language::TargetLanguage;
use quicktype_core::ty::transformed_string_type::TypeKind;
use quicktype_core::ty::type_builder::TypeBuilder;
use quicktype_js_compat::json;
use serde_json::Value;

fn fixtures() -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/fixtures/core-json-input")
}

fn repo_root() -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("../..")
}

fn load(name: &str) -> Value {
    let path = fixtures().join(name);
    let text = std::fs::read_to_string(&path).unwrap_or_else(|e| panic!("{}: {e}", path.display()));
    serde_json::from_str(&text).unwrap_or_else(|e| panic!("{}: {e}", path.display()))
}

/// Polls a future that never has to wait (nothing in the JSON input
/// does), as a minimal executor.
fn block_on<F: Future>(future: F) -> F::Output {
    let mut cx = Context::from_waker(Waker::noop());
    let mut future = pin!(future);
    loop {
        if let Poll::Ready(output) = future.as_mut().poll(&mut cx) {
            return output;
        }
    }
}

/// A configuration of `configs.json`.
struct Config {
    name: String,
    stream: bool,
    lang: &'static dyn TargetLanguage,
    alphabetize: bool,
    provenance: bool,
}

fn configs() -> Vec<Config> {
    load("configs.json")
        .as_array()
        .expect("configs")
        .iter()
        .map(|c| Config {
            name: c["name"].as_str().expect("name").to_owned(),
            stream: c["reader"] == "stream",
            lang: language_named(
                c["lang"].as_str().expect("lang"),
                default_target_languages(),
            )
            .expect("known language"),
            alphabetize: c["alphabetize"].as_bool().expect("alphabetize"),
            provenance: c["provenance"].as_bool().expect("provenance"),
        })
        .collect()
}

/// A source: a top-level name, its sample texts and a description.
struct Source {
    name: String,
    samples: Vec<Vec<u8>>,
    description: Option<String>,
}

/// The options of an edge case.
#[derive(Default)]
struct Options {
    flags: InferenceFlags,
    renderer_options: RendererOptions,
    fixed_top_levels: bool,
}

/// Runs `config` on `sources` and returns what the reference recorded: the
/// graph print or `error: <message>`.
fn run(config: &Config, sources: &[Source], options: &Options) -> String {
    match build(config, sources, options) {
        Ok(lines) => lines.iter().map(|l| format!("{l}\n")).collect(),
        Err(e) => format!("error: {}\n", e.user_message()),
    }
}

fn build(config: &Config, sources: &[Source], options: &Options) -> Result<Vec<String>> {
    let cjson = CompressedJson::for_target_language(
        config.lang,
        !options.flags.ignore_json_refs,
        &options.renderer_options,
    );
    // The CLI's reader through the async API, the JavaScript API's reader
    // through the sync one.
    let mut input = JsonInput::new(cjson);
    for source in sources {
        let samples = source
            .samples
            .iter()
            .map(|s| {
                if config.stream {
                    JsonSample::Stream(s.clone())
                } else {
                    JsonSample::String(String::from_utf8(s.clone()).expect("UTF-8 sample"))
                }
            })
            .collect();
        let source = JsonSourceData {
            name: source.name.clone(),
            samples,
            description: source.description.clone(),
        };
        if config.stream {
            block_on(input.add_source(source))?;
        } else {
            input.add_source_sync(source)?;
        }
    }
    let mut input_data = InputData::new();
    input_data.add_input(input);

    let ctx = RunContext::for_target_language(config.lang, &options.flags);
    let mut builder = TypeBuilder::new(
        ctx.string_type_mapping.clone(),
        config.alphabetize,
        false,
        config.provenance,
        false,
    )?;
    if config.stream {
        block_on(input_data.add_types(
            &ctx,
            &mut builder,
            options.flags.infer_maps,
            options.flags.infer_enums,
            options.fixed_top_levels,
        ))?;
    } else {
        input_data.add_types_sync(
            &ctx,
            &mut builder,
            options.flags.infer_maps,
            options.flags.infer_enums,
            options.fixed_top_levels,
        )?;
    }
    let graph = builder.finish()?;
    let mut lines = graph.graph_text()?;
    // What the print leaves out: the properties of every class.
    for t in graph.types() {
        if !matches!(t.kind(), TypeKind::Class | TypeKind::Object) {
            continue;
        }
        let properties: Vec<String> = t
            .properties()?
            .iter()
            .map(|(name, p)| {
                let optional = if p.is_optional { "?" } else { "" };
                format!("{}{optional}:{}", json::quote(name), p.type_ref.index())
            })
            .collect();
        let fixed = if t.is_fixed() { " fixed" } else { "" };
        lines.push(format!(
            "props {}{fixed}: {}",
            t.index(),
            properties.join(", ")
        ));
    }
    Ok(lines)
}

/// Splits an `.expected` file into its `### <config>` sections.
fn sections(text: &str, configs: &[Config]) -> BTreeMap<String, String> {
    let mut result = BTreeMap::new();
    let mut rest = text;
    for (i, config) in configs.iter().enumerate() {
        let header = format!("### {}\n", config.name);
        let body = rest
            .strip_prefix(&header)
            .expect("section header in config order");
        // The next header starts a line.
        let end = match configs.get(i + 1) {
            Some(next) => {
                let next_header = format!("### {}\n", next.name);
                let mut from = 0;
                loop {
                    let p = from + body[from..].find(&next_header).expect("next section");
                    if p == 0 || body.as_bytes()[p - 1] == b'\n' {
                        break p;
                    }
                    from = p + 1;
                }
            }
            None => body.len(),
        };
        result.insert(config.name.clone(), body[..end].to_owned());
        rest = &body[end..];
    }
    result
}

/// Match counts per configuration.
#[derive(Default)]
struct Tally {
    matched: BTreeMap<String, (usize, usize)>,
    failures: Vec<String>,
}

impl Tally {
    fn record(&mut self, case: &str, config: &str, expected: &str, actual: &str) {
        let entry = self.matched.entry(config.to_owned()).or_default();
        entry.1 += 1;
        if expected == actual {
            entry.0 += 1;
        } else {
            let diff = expected
                .lines()
                .zip(actual.lines())
                .find(|(e, a)| e != a)
                .map_or_else(
                    || {
                        format!(
                            "lengths differ: {} vs {} lines",
                            expected.lines().count(),
                            actual.lines().count()
                        )
                    },
                    |(e, a)| format!("first difference:\n    expected {e}\n    actual   {a}"),
                );
            self.failures.push(format!("{case} [{config}]: {diff}"));
        }
    }

    fn assert_all_match(&self, what: &str) {
        let mut report = format!("{what}:\n");
        for (config, (matched, total)) in &self.matched {
            let _ = writeln!(report, "  {config}: {matched}/{total}");
        }
        eprintln!("{report}");
        assert!(
            self.failures.is_empty(),
            "{report}{} mismatches:\n{}",
            self.failures.len(),
            self.failures
                .iter()
                .take(15)
                .cloned()
                .collect::<Vec<_>>()
                .join("\n")
        );
    }
}

/// Runs `f` on a thread with a large stack: inference recurses once per
/// nesting level, which debug builds need room for.
fn with_big_stack(f: impl FnOnce() + Send + 'static) {
    std::thread::Builder::new()
        .stack_size(256 << 20)
        .spawn(f)
        .expect("spawn")
        .join()
        .expect("test thread");
}

#[test]
fn input_files_match_reference_graphs() {
    with_big_stack(|| {
        let configs = configs();
        let mut tally = Tally::default();
        for dir in ["priority", "samples", "misc"] {
            let inputs = repo_root().join("tests/inputs/json").join(dir);
            let mut files: Vec<_> = std::fs::read_dir(&inputs)
                .expect("inputs")
                .map(|e| e.expect("entry").path())
                .filter(|p| p.extension().is_some_and(|e| e == "json"))
                .collect();
            files.sort();
            for file in files {
                let name = file
                    .file_name()
                    .expect("name")
                    .to_string_lossy()
                    .into_owned();
                let expected_path = fixtures()
                    .join("inputs")
                    .join(dir)
                    .join(format!("{name}.expected"));
                let expected = std::fs::read_to_string(&expected_path)
                    .unwrap_or_else(|e| panic!("{}: {e}", expected_path.display()));
                let expected = sections(&expected, &configs);
                let sources = [Source {
                    name: "TopLevel".to_owned(),
                    samples: vec![std::fs::read(&file).expect("input")],
                    description: None,
                }];
                for config in &configs {
                    let actual = run(config, &sources, &Options::default());
                    tally.record(
                        &format!("{dir}/{name}"),
                        &config.name,
                        &expected[&config.name],
                        &actual,
                    );
                }
            }
        }
        tally.assert_all_match("tests/inputs/json, graphs right after input");
    });
}

fn options_of(case: &Value) -> Options {
    let mut options = Options::default();
    if let Some(flags) = case["flags"].as_object() {
        for (name, value) in flags {
            let flag = INFERENCE_FLAGS
                .iter()
                .find(|f| f.js_name == name)
                .unwrap_or_else(|| panic!("unknown flag {name}"));
            options
                .flags
                .set(flag.name, value.as_bool().expect("bool flag"));
        }
    }
    if let Some(renderer_options) = case["rendererOptions"].as_object() {
        for (name, value) in renderer_options {
            options
                .renderer_options
                .set(name.clone(), value.as_str().expect("string option"));
        }
    }
    options.fixed_top_levels = case["fixedTopLevels"].as_bool().unwrap_or(false);
    options
}

#[test]
fn edge_cases_match_reference_graphs() {
    with_big_stack(|| {
        let configs = configs();
        let mut tally = Tally::default();
        for case in load("edge.json").as_array().expect("cases") {
            let id = case["id"].as_str().expect("id");
            let sources: Vec<Source> = case["sources"]
                .as_array()
                .expect("sources")
                .iter()
                .map(|s| Source {
                    name: s["name"].as_str().expect("name").to_owned(),
                    samples: s["samples"]
                        .as_array()
                        .expect("samples")
                        .iter()
                        .map(|t| t.as_str().expect("sample").as_bytes().to_vec())
                        .collect(),
                    description: s["description"].as_str().map(str::to_owned),
                })
                .collect();
            let options = options_of(case);
            for (config_name, lines) in case["expected"].as_object().expect("expected") {
                let config = configs
                    .iter()
                    .find(|c| &c.name == config_name)
                    .expect("config");
                let expected: String = lines
                    .as_array()
                    .expect("lines")
                    .iter()
                    .map(|l| format!("{}\n", l.as_str().expect("line")))
                    .collect();
                tally.record(id, config_name, &expected, &run(config, &sources, &options));
            }
        }
        tally.assert_all_match("edge cases, graphs right after input");
    });
}

fn answers(r: &dyn DateTimeRecognizer, s: &str) -> Value {
    serde_json::json!([r.is_date(s), r.is_time(s), r.is_date_time(s)])
}

#[test]
fn date_time_recognizers_match_reference() {
    let recognizers: [(&str, &dyn DateTimeRecognizer); 3] = [
        ("default", &DefaultDateTimeRecognizer),
        ("kotlin", &KotlinDateTimeRecognizer),
        ("swift", &SwiftDateTimeRecognizer),
    ];
    let mut failures = Vec::new();
    for vector in load("recognizers.json").as_array().expect("vectors") {
        let input = vector["input"].as_str().expect("input");
        for (name, recognizer) in recognizers {
            if answers(recognizer, input) != vector[name] {
                failures.push(format!("{name} {input:?}: expected {}", vector[name]));
            }
        }
    }
    assert!(failures.is_empty(), "{}", failures.join("\n"));
}

#[test]
fn uri_attributes_match_reference() {
    let mut failures = Vec::new();
    for vector in load("uri-attributes.json").as_array().expect("vectors") {
        let input = vector["input"].as_str().expect("input");
        let attributes = uri_inference_attributes_producer(input);
        let actual = match UriTypeAttributeKind.try_get_in_attributes(&attributes) {
            None => Value::Null,
            Some((protocols, extensions)) => serde_json::json!([
                protocols.iter().collect::<Vec<_>>(),
                extensions.iter().collect::<Vec<_>>()
            ]),
        };
        if actual != vector["attributes"] {
            failures.push(format!(
                "{input:?}: expected {}, got {actual}",
                vector["attributes"]
            ));
        }
    }
    assert!(failures.is_empty(), "{}", failures.join("\n"));
}

#[test]
fn language_inference_hooks_match_reference() {
    let recognizer_vectors = load("recognizers.json");
    let reference = load("language-hooks.json");
    let languages = default_target_languages();
    assert_eq!(
        languages.len(),
        reference.as_array().expect("languages").len()
    );
    for (language, expected) in languages
        .iter()
        .zip(reference.as_array().expect("languages"))
    {
        let name = language.name();
        assert_eq!(name, expected["name"], "language order");
        let mapping: Vec<Value> = language
            .string_type_mapping()
            .iter()
            .map(|(k, v)| serde_json::json!([k.as_str(), v.as_str()]))
            .collect();
        assert_eq!(
            Value::from(mapping),
            expected["stringTypeMapping"],
            "{name} stringTypeMapping"
        );
        assert_eq!(
            language.supports_optional_class_properties(),
            expected["supportsOptionalClassProperties"],
            "{name} supportsOptionalClassProperties"
        );
        assert_eq!(
            language.supports_unions_with_both_number_types(),
            expected["supportsUnionsWithBothNumberTypes"],
            "{name} supportsUnionsWithBothNumberTypes"
        );
        let option_sets = expected["optionSets"].as_array().expect("option sets");
        for (options, range) in option_sets
            .iter()
            .zip(expected["integerRanges"].as_array().expect("ranges"))
        {
            let mut renderer_options = RendererOptions::new();
            for (k, v) in options.as_object().expect("options") {
                renderer_options.set(k.clone(), v.as_str().expect("string"));
            }
            let actual = match language.get_supported_integer_range(&renderer_options) {
                None => Value::Null,
                Some(r) => serde_json::json!([r.min, r.max]),
            };
            assert_eq!(&actual, range, "{name} getSupportedIntegerRange({options})");
        }
        // The recognizer, by its answers on the recognizer vectors.
        let column = match expected["dateTimeRecognizer"].as_str().expect("class") {
            "DefaultDateTimeRecognizer" => "default",
            "KotlinDateTimeRecognizer" => "kotlin",
            "SwiftDateTimeRecognizer" => "swift",
            other => panic!("unknown recognizer {other}"),
        };
        let recognizer = language.date_time_recognizer();
        for vector in recognizer_vectors.as_array().expect("vectors") {
            let input = vector["input"].as_str().expect("input");
            assert_eq!(
                answers(recognizer.as_ref(), input),
                vector[column],
                "{name} recognizer on {input:?}"
            );
        }
    }
}

#[test]
fn postman_collections_match_reference() {
    let mut failures = Vec::new();
    for vector in load("postman.json").as_array().expect("vectors") {
        let input = vector["input"].as_str().expect("input");
        let actual = match sources_from_postman_collection(input, Some("collection.json")) {
            Err(e) => serde_json::json!({ "input": input, "error": e.user_message() }),
            Ok(result) => serde_json::json!({
                "input": input,
                "sources": result.sources.iter().map(|s| {
                    let mut source = serde_json::json!({ "name": s.name, "samples": s.samples });
                    if let Some(description) = &s.description {
                        source["description"] = description.clone().into();
                    }
                    source
                }).collect::<Vec<_>>(),
                "description": result.description,
            }),
        };
        if &actual != vector {
            failures.push(format!("expected {vector}\n  actual {actual}"));
        }
    }
    assert!(failures.is_empty(), "{}", failures.join("\n"));
}
