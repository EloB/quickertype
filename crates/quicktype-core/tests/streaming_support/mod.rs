//! Runs generated inputs through both ways of inferring JSON types, running
//! tallies and quicktype's compressed form, and compares everything that
//! comes out: each source's error, the type graph right after inference
//! (all types in index order, with every attribute) for several inference
//! flags, and a whole run for a language and an option set.

pub mod generator;

use std::io::Read;
use std::panic::{AssertUnwindSafe, catch_unwind};

use quicktype_core::input::inputs::{InputData, JsonInput, JsonSourceData};
use quicktype_core::ty::type_builder::TypeBuilder;
use quicktype_core::{
    InferenceFlags, JsonSample, MultiFileRenderResult, Options, RendererOptions, RunContext,
    SampleReader, TargetLanguage, default_target_languages, json_input_for_target_language,
    quicktype_multi_file_sync,
};

use generator::{Case, Encoding, Limits, Rng};

/// The languages every seed's full run picks from; the first eight more
/// often.
const LANGUAGES: &[&str] = &[
    "rust",
    "typescript",
    "go",
    "csharp",
    "python",
    "java",
    "swift",
    "kotlin",
];

/// The option sets of the full runs, as CLI flags.
pub const OPTION_SETS: &[&str] = &[
    "",
    "--no-enums",
    "--no-maps",
    "--all-properties-optional",
    "--alphabetize-properties",
    "--no-date-times",
    "--no-uuids",
    "--no-integer-strings",
    "--no-boolean-strings",
    "--no-combine-classes",
];

/// A reader that returns chunks of 1 to `max` bytes.
struct Chunked {
    data: Vec<u8>,
    position: usize,
    rng: Rng,
    max: u64,
}

impl Read for Chunked {
    fn read(&mut self, buf: &mut [u8]) -> std::io::Result<usize> {
        let rest = &self.data[self.position..];
        let n = (self.rng.range(1, self.max) as usize)
            .min(rest.len())
            .min(buf.len());
        buf[..n].copy_from_slice(&rest[..n]);
        self.position += n;
        Ok(n)
    }
}

fn sample(s: &generator::Sample, seed: u64) -> JsonSample {
    match s.encoding {
        Encoding::Stream => JsonSample::Stream(s.text.as_bytes().to_vec()),
        Encoding::Text => JsonSample::String(s.text.clone()),
        Encoding::Reader(max) => JsonSample::Reader(SampleReader::new(Chunked {
            data: s.text.as_bytes().to_vec(),
            position: 0,
            rng: Rng::new(seed),
            max,
        })),
    }
}

/// The JSON input for `case`, and what each `add_source` returned.
fn input(
    case: &Case,
    lang: &dyn TargetLanguage,
    renderer_options: &RendererOptions,
    tallies: bool,
) -> (JsonInput, Vec<String>) {
    let mut input = json_input_for_target_language(lang, case.handle_refs, renderer_options);
    input.set_tally_inference(tallies).expect("no sources yet");
    assert_eq!(input.tally_inference(), tallies);
    let mut results = Vec::new();
    for (i, source) in case.sources.iter().enumerate() {
        let samples = source
            .samples
            .iter()
            .enumerate()
            .map(|(j, s)| sample(s, (i * 16 + j) as u64))
            .collect();
        let result = input.add_source_sync(JsonSourceData {
            name: source.name.clone(),
            samples,
            description: source.description.clone(),
        });
        results.push(format!("{result:?}"));
    }
    (input, results)
}

/// Inference flags and type builder settings of one graph comparison.
#[derive(Clone, Copy, Debug)]
struct GraphFlags {
    infer_maps: bool,
    infer_enums: bool,
    fixed_top_levels: bool,
    alphabetize: bool,
    all_optional: bool,
    no_date_times: bool,
}

/// The type graph right after inference, printed with every detail.
fn graph(lang: &dyn TargetLanguage, input: &mut InputData, flags: GraphFlags) -> String {
    let mut inference_flags = InferenceFlags::default();
    inference_flags.infer_date_times = !flags.no_date_times;
    let ctx = RunContext::for_target_language(lang, &inference_flags);
    let result = TypeBuilder::new(
        ctx.string_type_mapping.clone(),
        flags.alphabetize,
        flags.all_optional,
        false,
        false,
    )
    .and_then(|mut builder| {
        input.add_types_sync(
            &ctx,
            &mut builder,
            flags.infer_maps,
            flags.infer_enums,
            flags.fixed_top_levels,
        )?;
        builder.finish()
    });
    match result {
        Ok(graph) => format!("{graph:?}"),
        Err(e) => format!("error {e:?}"),
    }
}

/// A whole run of `lang` with the CLI flags `option_set`.
fn run(
    case: &Case,
    lang: &'static dyn TargetLanguage,
    option_set: &str,
    tallies: bool,
) -> (Vec<String>, Result<MultiFileRenderResult, String>) {
    let renderer_options = RendererOptions::new();
    let (input, sources) = input(case, lang, &renderer_options, tallies);
    let mut input_data = InputData::new();
    input_data.add_input(input);
    let mut options = Options::new(lang, input_data);
    let flags = &mut options.inference_flags;
    flags.ignore_json_refs = !case.handle_refs;
    match option_set {
        "--no-enums" => flags.infer_enums = false,
        "--no-maps" => flags.infer_maps = false,
        "--no-date-times" => flags.infer_date_times = false,
        "--no-uuids" => flags.infer_uuids = false,
        "--no-integer-strings" => flags.infer_integer_strings = false,
        "--no-boolean-strings" => flags.infer_boolean_strings = false,
        "--no-combine-classes" => flags.combine_classes = false,
        "--all-properties-optional" => options.all_properties_optional = true,
        "--alphabetize-properties" => options.alphabetize_properties = true,
        _ => {}
    }
    let result = catch_unwind(AssertUnwindSafe(|| quicktype_multi_file_sync(options)));
    let result = match result {
        Ok(Ok(files)) => Ok(files),
        Ok(Err(e)) => Err(format!("{e:?}")),
        Err(panic) => Err(format!(
            "panic: {}",
            panic
                .downcast_ref::<String>()
                .cloned()
                .or_else(|| panic.downcast_ref::<&str>().map(|s| (*s).to_owned()))
                .unwrap_or_default()
        )),
    };
    (sources, result)
}

fn language(name: &str) -> &'static dyn TargetLanguage {
    *default_target_languages()
        .iter()
        .find(|l| l.names().contains(&name) || l.name() == name)
        .unwrap_or_else(|| panic!("no language {name}"))
}

/// What one seed compared.
#[derive(Default, Debug)]
pub struct Stats {
    pub graphs: u64,
    pub runs: u64,
    pub failed_runs: u64,
    pub source_errors: u64,
}

/// Compares the sources' results and the graphs of `case` read for
/// `lang`, for each of `flags`.
fn compare_graphs(
    case: &Case,
    lang: &dyn TargetLanguage,
    flags: &[GraphFlags],
    stats: &mut Stats,
) -> Result<(), String> {
    let renderer_options = RendererOptions::new();
    let (tallied, tallied_sources) = input(case, lang, &renderer_options, true);
    let (reference, reference_sources) = input(case, lang, &renderer_options, false);
    if tallied_sources != reference_sources {
        return Err(format!(
            "add_source differs\n  tallies:   {tallied_sources:?}\n  reference: {reference_sources:?}"
        ));
    }
    stats.source_errors += reference_sources
        .iter()
        .filter(|r| r.starts_with("Err"))
        .count() as u64;
    let mut tallied_data = InputData::new();
    tallied_data.add_input(tallied);
    let mut reference_data = InputData::new();
    reference_data.add_input(reference);
    for &flags in flags {
        let a = graph(lang, &mut tallied_data, flags);
        let b = graph(lang, &mut reference_data, flags);
        if a != b {
            return Err(format!(
                "graphs differ ({}, {flags:?})\n  tallies:   {a}\n  reference: {b}",
                lang.name()
            ));
        }
        stats.graphs += 1;
    }
    Ok(())
}

/// Compares whole runs of `case` with `lang` and `option_set`.
fn compare_run(
    case: &Case,
    lang: &'static dyn TargetLanguage,
    option_set: &str,
    stats: &mut Stats,
) -> Result<(), String> {
    let a = run(case, lang, option_set, true);
    let b = run(case, lang, option_set, false);
    if a != b {
        return Err(format!(
            "{} {option_set} differs\n  tallies:   {a:?}\n  reference: {b:?}",
            lang.name()
        ));
    }
    stats.runs += 1;
    if b.1.is_err() {
        stats.failed_runs += 1;
    }
    Ok(())
}

/// Compares both ways of inferring for the case of `seed`: `Err` describes
/// the first difference.
pub fn check(seed: u64, limits: Limits, runs: usize) -> Result<Stats, String> {
    let case = generator::case(seed, limits);
    let mut rng = Rng::new(seed ^ 0x5EED_C4EC);
    let mut stats = Stats::default();
    let all = default_target_languages();

    // The graphs right after inference, for every combination of the
    // inference flags.
    let lang = if rng.chance(70) {
        language(rng.pick(LANGUAGES))
    } else {
        *rng.pick(all)
    };
    let flags: Vec<GraphFlags> = (0..5)
        .map(|i| GraphFlags {
            infer_maps: i & 1 == 0,
            infer_enums: i & 2 == 0,
            fixed_top_levels: i == 4 || rng.chance(20),
            alphabetize: rng.chance(20),
            all_optional: rng.chance(20),
            no_date_times: rng.chance(20),
        })
        .collect();
    compare_graphs(&case, lang, &flags, &mut stats).map_err(|e| format!("seed {seed}: {e}"))?;

    // Whole runs.
    for _ in 0..runs {
        let lang = if rng.chance(80) {
            language(rng.pick(LANGUAGES))
        } else {
            *rng.pick(all)
        };
        let option_set = *rng.pick(OPTION_SETS);
        compare_run(&case, lang, option_set, &mut stats)
            .map_err(|e| format!("seed {seed}: {e}"))?;
    }
    Ok(stats)
}

/// Compares `case` thoroughly: the graphs for all combinations of the
/// inference flags, every language of [`LANGUAGES`] with the default
/// options, and every option set of [`OPTION_SETS`].
pub fn check_all(case: &Case) -> Result<Stats, String> {
    let mut stats = Stats::default();
    let flags: Vec<GraphFlags> = (0..16)
        .map(|i| GraphFlags {
            infer_maps: i & 1 == 0,
            infer_enums: i & 2 == 0,
            fixed_top_levels: i & 4 != 0,
            alphabetize: i == 8,
            all_optional: i == 9,
            no_date_times: i & 8 != 0,
        })
        .collect();
    compare_graphs(case, language("typescript"), &flags, &mut stats)?;
    for name in LANGUAGES {
        compare_run(case, language(name), "", &mut stats)?;
    }
    for (i, option_set) in OPTION_SETS.iter().enumerate() {
        let lang = language(LANGUAGES[i % LANGUAGES.len()]);
        compare_run(case, lang, option_set, &mut stats)?;
    }
    Ok(stats)
}

/// Runs `f` on a thread with the CLI's stack size (256 MiB): the rewrites
/// after inference recurse natively over the graph, which for a document
/// nested near inference's depth limit needs more than a test thread's
/// stack, on both paths alike.
pub fn on_cli_stack<T: Send>(f: impl FnOnce() -> T + Send) -> T {
    std::thread::scope(|s| {
        std::thread::Builder::new()
            .stack_size(256 << 20)
            .spawn_scoped(s, f)
            .expect("spawn")
            .join()
            .unwrap_or_else(|panic| std::panic::resume_unwind(panic))
    })
}

/// Compares `case` cheaply: the graphs for two settings of the inference
/// flags and one whole run.
pub fn check_light(case: &Case) -> Result<Stats, String> {
    let mut stats = Stats::default();
    let flags = [false, true].map(|maps| GraphFlags {
        infer_maps: maps,
        infer_enums: true,
        fixed_top_levels: false,
        alphabetize: false,
        all_optional: false,
        no_date_times: false,
    });
    compare_graphs(case, language("typescript"), &flags, &mut stats)?;
    // Combining classes compares classes pairwise, which is slow on a deep
    // chain of classes (on both paths) and has nothing to do with inference.
    compare_run(case, language("go"), "--no-combine-classes", &mut stats)?;
    Ok(stats)
}

/// The type graph of `case` after inference from tallies (or the error),
/// for TypeScript with the default flags.
pub fn graph_text(case: &Case) -> String {
    let lang = language("typescript");
    let (input, _) = input(case, lang, &RendererOptions::new(), true);
    let mut data = InputData::new();
    data.add_input(input);
    graph(
        lang,
        &mut data,
        GraphFlags {
            infer_maps: true,
            infer_enums: true,
            fixed_top_levels: false,
            alphabetize: false,
            all_optional: false,
            no_date_times: false,
        },
    )
}

/// Checks `count` seeds from `start` on `jobs` threads; returns the totals
/// or the differences.
pub fn check_many(
    start: u64,
    count: u64,
    jobs: usize,
    limits: Limits,
    runs: usize,
    progress: bool,
) -> Result<Stats, Vec<String>> {
    use std::sync::Mutex;
    use std::sync::atomic::{AtomicU64, Ordering};

    let next = AtomicU64::new(0);
    let totals = Mutex::new(Stats::default());
    let failures = Mutex::new(Vec::new());
    std::thread::scope(|s| {
        for _ in 0..jobs.max(1) {
            std::thread::Builder::new()
                .stack_size(256 << 20)
                .spawn_scoped(s, || {
                    loop {
                        let i = next.fetch_add(1, Ordering::Relaxed);
                        if i >= count {
                            break;
                        }
                        let seed = start + i;
                        match check(seed, limits, runs) {
                            Ok(stats) => {
                                let mut t = totals.lock().unwrap();
                                t.graphs += stats.graphs;
                                t.runs += stats.runs;
                                t.failed_runs += stats.failed_runs;
                                t.source_errors += stats.source_errors;
                            }
                            Err(e) => {
                                let mut f = failures.lock().unwrap();
                                if f.len() < 20 {
                                    f.push(e);
                                }
                            }
                        }
                        if progress && (i + 1) % 10_000 == 0 {
                            eprintln!("{} / {count} seeds", i + 1);
                        }
                    }
                })
                .expect("spawn");
        }
    });
    let failures = failures.into_inner().unwrap();
    if failures.is_empty() {
        Ok(totals.into_inner().unwrap())
    } else {
        Err(failures)
    }
}
