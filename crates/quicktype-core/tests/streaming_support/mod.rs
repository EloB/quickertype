//! Runs generated inputs through the ways of inferring JSON types, running
//! tallies, tallies of the compressed form and quicktype's compressed form
//! value by value (the reference), and compares everything that comes out:
//! each source's error, the type graph right after inference (all types in
//! index order, with every attribute) for several inference flags, and a
//! whole run for a language and an option set.

pub mod generator;

use std::io::Read;
use std::panic::{AssertUnwindSafe, catch_unwind};

use quicktype_core::input::inputs::{InputData, JsonInference, JsonInput, JsonSourceData};
use quicktype_core::ty::transformed_string_type::TypeKind;
use quicktype_core::ty::ty::Type;
use quicktype_core::ty::type_builder::TypeBuilder;
use quicktype_core::ty::type_graph::TypeGraph;
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

/// A way of inferring the types of a case.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Inference {
    /// quicktype's: from the compressed form, value by value (the
    /// reference).
    Reference,
    /// From running tallies, counted while the samples are read (the
    /// CLI's).
    RunningTallies,
    /// From tallies of the compressed form the readers made, made when the
    /// types are inferred and kept with the form for the next inference:
    /// the WebAssembly engine's, for the samples it read
    /// (`JsonInput::from_shared`).
    CompressedTallies,
    /// The same of that form's tables, exported and imported again: the
    /// WebAssembly engine's, for the tables of a JavaScript
    /// `CompressedJSON` (`JsonInput::from_compressed`).
    ImportedTables,
}

/// Which ways of inferring are compared with the reference.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Path {
    /// Running tallies (the CLI's).
    RunningTallies,
    /// Tallies of the compressed form, as the readers made it and as
    /// imported tables (the WebAssembly engine's).
    CompressedTallies,
    /// All of them.
    All,
}

impl Inference {
    /// Where an input made for this way infers its types from, the first
    /// time or later: the forms the readers made, and their tables, are
    /// always tallied (never declined for values no reader makes), and the
    /// tallies kept with a form are used from the second time on.
    fn inferred_from(self, first: bool) -> JsonInference {
        match self {
            Inference::Reference => JsonInference::CompressedValues,
            Inference::RunningTallies => JsonInference::RunningTallies,
            Inference::CompressedTallies if !first => JsonInference::KeptTallies,
            Inference::CompressedTallies | Inference::ImportedTables => {
                JsonInference::CompressedTallies
            }
        }
    }
}

impl Path {
    /// The ways of inferring compared with the reference.
    fn tested(self) -> &'static [Inference] {
        match self {
            Path::RunningTallies => &[Inference::RunningTallies],
            Path::CompressedTallies => &[Inference::CompressedTallies, Inference::ImportedTables],
            Path::All => &[
                Inference::RunningTallies,
                Inference::CompressedTallies,
                Inference::ImportedTables,
            ],
        }
    }

    /// The path named `name` (`running`, `compressed` or `all`).
    pub fn named(name: &str) -> Option<Path> {
        match name {
            "running" => Some(Path::RunningTallies),
            "compressed" => Some(Path::CompressedTallies),
            "all" => Some(Path::All),
            _ => None,
        }
    }
}

/// The JSON input for `case`, and what each `add_source` returned; it
/// infers as `inference` says, or as `JsonInput::new` chooses
/// (`QUICKTYPE_INFERENCE`).
fn input(
    case: &Case,
    lang: &dyn TargetLanguage,
    renderer_options: &RendererOptions,
    inference: Option<Inference>,
) -> (JsonInput, Vec<String>) {
    let mut input = json_input_for_target_language(lang, case.handle_refs, renderer_options);
    if let Some(inference) = inference {
        let tallies = inference == Inference::RunningTallies;
        input.set_tally_inference(tallies).expect("no sources yet");
        assert_eq!(input.tally_inference(), tallies);
    }
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
    match inference {
        Some(Inference::Reference) => input.set_tally_compressed(false),
        Some(Inference::CompressedTallies) => {
            input.set_tally_compressed(true);
            input.set_keep_tallies(true);
        }
        Some(Inference::ImportedTables) => {
            let (tables, top_levels) = input.to_compressed().expect("the compressed form");
            input = JsonInput::from_compressed(
                &tables,
                case.handle_refs,
                lang.date_time_recognizer(),
                top_levels,
            )
            .expect("its own tables");
            input.set_tally_compressed(true);
        }
        Some(Inference::RunningTallies) | None => {}
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

/// The type graph right after inference.
fn graph_of(
    lang: &dyn TargetLanguage,
    input: &mut JsonInput,
    flags: GraphFlags,
) -> quicktype_core::Result<TypeGraph> {
    let mut inference_flags = InferenceFlags::default();
    inference_flags.infer_date_times = !flags.no_date_times;
    let ctx = RunContext::for_target_language(lang, &inference_flags);
    let mut builder = TypeBuilder::new(
        ctx.string_type_mapping.clone(),
        flags.alphabetize,
        flags.all_optional,
        false,
        false,
    )?;
    input.add_types_sync(
        &ctx,
        &mut builder,
        flags.infer_maps,
        flags.infer_enums,
        flags.fixed_top_levels,
    )?;
    builder.finish()
}

/// Whether `graph` has a cycle through unions and intersections alone,
/// which `$ref`s can make (`{"a": "x"}` and `{"a": {"$ref": "#/a"}}`: the
/// union of `a` contains the reference to itself). TypeScript overflows
/// its stack on it (`attributesForTypes`); the port overflows the native
/// stack in the same place, on both paths alike: a known gap after
/// inference, so such cases get no whole runs.
fn has_set_operation_cycle(graph: &TypeGraph) -> bool {
    let types = graph.types();
    let is_set_operation = |t: &Type| matches!(t.kind(), TypeKind::Union | TypeKind::Intersection);
    // 0: unvisited, 1: on the path, 2: done.
    let mut state = vec![0u8; types.len()];
    for start in 0..types.len() {
        if state[start] != 0 || !is_set_operation(&types[start]) {
            continue;
        }
        let mut stack: Vec<(usize, usize)> = vec![(start, 0)];
        state[start] = 1;
        while let Some(&mut (t, ref mut next)) = stack.last_mut() {
            let members: Vec<usize> = types[t]
                .members()
                .map(|m| m.iter().map(|r| r.index()).collect())
                .unwrap_or_default();
            if let Some(&m) = members.get(*next) {
                *next += 1;
                if m >= types.len() || !is_set_operation(&types[m]) {
                    continue;
                }
                match state[m] {
                    1 => return true,
                    0 => {
                        state[m] = 1;
                        stack.push((m, 0));
                    }
                    _ => {}
                }
            } else {
                state[t] = 2;
                stack.pop();
            }
        }
    }
    false
}

/// The type graph right after inference, printed with every detail.
fn graph(lang: &dyn TargetLanguage, input: &mut JsonInput, flags: GraphFlags) -> String {
    match graph_of(lang, input, flags) {
        Ok(graph) => format!("{graph:?}"),
        Err(e) => format!("error {e:?}"),
    }
}

/// A whole run of `lang` with the CLI flags `option_set`, inferring as
/// `inference` says (see [`input`]).
pub fn run(
    case: &Case,
    lang: &'static dyn TargetLanguage,
    option_set: &str,
    inference: Option<Inference>,
) -> (Vec<String>, Result<MultiFileRenderResult, String>) {
    let renderer_options = RendererOptions::new();
    let (input, sources) = input(case, lang, &renderer_options, inference);
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

pub fn language(name: &str) -> &'static dyn TargetLanguage {
    *default_target_languages()
        .iter()
        .find(|l| l.names().contains(&name) || l.name() == name)
        .unwrap_or_else(|| panic!("no language {name}"))
}

/// What one seed compared.
#[derive(Default, Debug)]
pub struct Stats {
    /// Graphs compared with the reference's: one per combination of the
    /// inference flags and way of inferring.
    pub graphs: u64,
    /// Whole runs (a case, a language and an option set) whose every way
    /// of inferring was compared with the reference: one each, however
    /// many ways.
    pub runs: u64,
    /// Whole runs not made: a `$ref` cycle through unions (see
    /// `has_set_operation_cycle`).
    pub skipped_runs: u64,
    /// Of `runs`, those that failed (alike on every way).
    pub failed_runs: u64,
    pub source_errors: u64,
}

/// Compares the sources' results and the graphs of `case` read for
/// `lang`, for each of `flags`, inferred the ways of `path` and as the
/// reference.
fn compare_graphs(
    case: &Case,
    lang: &dyn TargetLanguage,
    flags: &[GraphFlags],
    stats: &mut Stats,
    path: Path,
) -> Result<(), String> {
    let renderer_options = RendererOptions::new();
    let (mut reference, reference_sources) =
        input(case, lang, &renderer_options, Some(Inference::Reference));
    let mut tested = Vec::new();
    for &inference in path.tested() {
        let (input, sources) = input(case, lang, &renderer_options, Some(inference));
        if sources != reference_sources {
            return Err(format!(
                "add_source differs\n  {inference:?}: {sources:?}\n  reference: {reference_sources:?}"
            ));
        }
        tested.push((inference, input));
    }
    stats.source_errors += reference_sources
        .iter()
        .filter(|r| r.starts_with("Err"))
        .count() as u64;
    // Each way must have inferred as it says, not fallen back to the
    // values (which would compare the reference with itself).
    let check_path = |inference: Inference, input: &JsonInput, first: bool| {
        let expected = inference.inferred_from(first);
        match input.inferred_from() {
            Some(actual) if actual == expected => Ok(()),
            actual => Err(format!(
                "{inference:?} inferred from {actual:?}, not {expected:?} ({})",
                lang.name()
            )),
        }
    };
    for (i, &flags) in flags.iter().enumerate() {
        if std::env::var_os("QUICKTYPE_STREAMING_TRACE").is_some() {
            eprintln!("  graph {} {flags:?}", lang.name());
        }
        let b = graph(lang, &mut reference, flags);
        check_path(Inference::Reference, &reference, i == 0)?;
        for (inference, input) in &mut tested {
            let a = graph(lang, input, flags);
            check_path(*inference, input, i == 0)?;
            if a != b {
                return Err(format!(
                    "graphs differ ({}, {flags:?})\n  {inference:?}: {a}\n  reference: {b}",
                    lang.name()
                ));
            }
            stats.graphs += 1;
        }
    }
    Ok(())
}

/// Compares whole runs of `case` with `lang` and `option_set`, inferred
/// the ways of `path` and as the reference.
fn compare_run(
    case: &Case,
    lang: &'static dyn TargetLanguage,
    option_set: &str,
    stats: &mut Stats,
    path: Path,
) -> Result<(), String> {
    if case.handle_refs {
        let (mut input, _) = input(
            case,
            lang,
            &RendererOptions::new(),
            Some(Inference::Reference),
        );
        let flags = GraphFlags {
            infer_maps: option_set != "--no-maps",
            infer_enums: option_set != "--no-enums",
            fixed_top_levels: false,
            alphabetize: false,
            all_optional: false,
            no_date_times: false,
        };
        if graph_of(lang, &mut input, flags).is_ok_and(|g| has_set_operation_cycle(&g)) {
            stats.skipped_runs += 1;
            return Ok(());
        }
    }
    if std::env::var_os("QUICKTYPE_STREAMING_TRACE").is_some() {
        eprintln!("  run {} {option_set}", lang.name());
    }
    let b = run(case, lang, option_set, Some(Inference::Reference));
    for &inference in path.tested() {
        let a = run(case, lang, option_set, Some(inference));
        if a != b {
            return Err(format!(
                "{} {option_set} differs\n  {inference:?}: {a:?}\n  reference: {b:?}",
                lang.name()
            ));
        }
    }
    stats.runs += 1;
    if b.1.is_err() {
        stats.failed_runs += 1;
    }
    Ok(())
}

/// How much each seed compares.
#[derive(Clone, Copy, Debug)]
pub struct Effort {
    /// Graphs per seed, each for another combination of the inference
    /// flags (the first four cover `inferMaps` × `inferEnums`).
    pub graphs: usize,
    /// Whole runs per seed that has runs.
    pub runs: usize,
    /// Whole runs on every this many seeds.
    pub runs_every: u64,
}

/// Compares the ways of inferring of `path` with the reference for the
/// case of `seed`: `Err` describes the first difference.
pub fn check(seed: u64, limits: Limits, effort: Effort, path: Path) -> Result<Stats, String> {
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
    let first = rng.below(4) as usize;
    let flags: Vec<GraphFlags> = (0..effort.graphs)
        .map(|j| (first + j) % 5)
        .map(|i| GraphFlags {
            infer_maps: i & 1 == 0,
            infer_enums: i & 2 == 0,
            fixed_top_levels: i == 4 || rng.chance(20),
            alphabetize: rng.chance(20),
            all_optional: rng.chance(20),
            no_date_times: rng.chance(20),
        })
        .collect();
    compare_graphs(&case, lang, &flags, &mut stats, path)
        .map_err(|e| format!("seed {seed}: {e}"))?;

    // Whole runs.
    let runs = if seed % effort.runs_every.max(1) == 0 {
        effort.runs
    } else {
        0
    };
    for _ in 0..runs {
        let lang = if rng.chance(80) {
            language(rng.pick(LANGUAGES))
        } else {
            *rng.pick(all)
        };
        let mut option_set = *rng.pick(OPTION_SETS);
        if case.deep {
            // Combining classes compares every pair of classes along a
            // chain of a thousand: minutes, on both paths, and nothing
            // to do with inference.
            option_set = "--no-combine-classes";
        }
        compare_run(&case, lang, option_set, &mut stats, path)
            .map_err(|e| format!("seed {seed}: {e}"))?;
    }
    Ok(stats)
}

/// Compares `case` thoroughly, every way of inferring with the reference:
/// the graphs for all combinations of the inference flags, every language
/// of [`LANGUAGES`] with the default options, and every option set of
/// [`OPTION_SETS`].
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
    compare_graphs(case, language("typescript"), &flags, &mut stats, Path::All)?;
    for name in LANGUAGES {
        compare_run(case, language(name), "", &mut stats, Path::All)?;
    }
    for (i, option_set) in OPTION_SETS.iter().enumerate() {
        let lang = language(LANGUAGES[i % LANGUAGES.len()]);
        compare_run(case, lang, option_set, &mut stats, Path::All)?;
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

/// Compares `case` cheaply, every way of inferring with the reference: the
/// graphs for two settings of the inference flags and one whole run.
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
    compare_graphs(case, language("typescript"), &flags, &mut stats, Path::All)?;
    // Combining classes compares classes pairwise, which is slow on a deep
    // chain of classes (on both paths) and has nothing to do with inference.
    compare_run(
        case,
        language("go"),
        "--no-combine-classes",
        &mut stats,
        Path::All,
    )?;
    Ok(stats)
}

/// The type graph of `case` after inference from tallies (or the error
/// of adding a source, or of inference), for TypeScript with the default
/// flags.
pub fn graph_text(case: &Case) -> String {
    let lang = language("typescript");
    let (mut input, sources) = input(
        case,
        lang,
        &RendererOptions::new(),
        Some(Inference::RunningTallies),
    );
    if let Some(failed) = sources.iter().find(|result| result.starts_with("Err")) {
        return format!("error adding a source: {failed}");
    }
    graph(
        lang,
        &mut input,
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

/// Checks `count` seeds from `start` on `jobs` threads, the ways of
/// inferring of `path` against the reference; returns the totals or the
/// differences.
pub fn check_many(
    start: u64,
    count: u64,
    jobs: usize,
    limits: Limits,
    effort: Effort,
    progress: bool,
    path: Path,
) -> Result<Stats, Vec<String>> {
    use std::sync::Mutex;
    use std::sync::atomic::{AtomicU64, Ordering};

    let trace = std::env::var_os("QUICKTYPE_STREAMING_TRACE").is_some();
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
                        if trace {
                            eprintln!("seed {seed}");
                        }
                        match check(seed, limits, effort, path) {
                            Ok(stats) => {
                                let mut t = totals.lock().unwrap();
                                t.graphs += stats.graphs;
                                t.runs += stats.runs;
                                t.skipped_runs += stats.skipped_runs;
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
