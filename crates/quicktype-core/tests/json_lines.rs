//! JSON Lines samples (`JsonSample::StringLines`, `StreamLines`,
//! `ReaderLines`) give exactly what the JSON array of their values gives
//! (`String`, `Stream`, `Reader`): for generated values, separators and
//! sources, every target language and a range of options, the whole run's
//! files, or its error, are identical. That the array gives what quicktype
//! gives is the parity tests' business; `node xtask/fuzz/fuzz.mjs --modes
//! jsonl` compares our CLI on JSON Lines with quicktype's on the array.

#[allow(dead_code)]
#[path = "streaming_support/generator.rs"]
mod generator;

use std::io::Read;

use quicktype_core::{
    InputData, JsonSample, JsonSourceData, Options, SampleReader, TargetLanguage,
    default_target_languages, json_input_for_target_language, quicktype_multi_file_sync,
};

use generator::{Limits, Rng};

const LIMITS: Limits = Limits {
    lone_surrogates: false,
    max_depth: 6,
    big_maps: false,
    max_bytes: 4_000,
    deep_permille: 0,
};

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

/// How a sample is given: which reader, and for a stream, in chunks of up
/// to how many bytes.
#[derive(Clone, Copy, Debug)]
enum Reader {
    String,
    Stream,
    Chunks(u64),
}

/// A sample: its values as JSON Lines, or as the JSON array of them.
#[derive(Clone, Debug)]
struct Sample {
    values: Vec<String>,
    /// JSON Lines, or one plain JSON value (a sample that stays as it is).
    lines: bool,
    reader: Reader,
    /// The separators between the values, in turn, and the whitespace
    /// before the first and after the last.
    separators: Vec<&'static str>,
    around: (&'static str, &'static str),
}

impl Sample {
    fn text(&self, as_lines: bool) -> String {
        if !self.lines {
            return self.values[0].clone();
        }
        if !as_lines {
            return format!("[{}]", self.values.join(","));
        }
        let mut text = self.around.0.to_owned();
        for (i, value) in self.values.iter().enumerate() {
            if i > 0 {
                text.push_str(self.separators[i % self.separators.len()]);
            }
            text.push_str(value);
        }
        text.push_str(self.around.1);
        text
    }

    /// The sample as JSON Lines (`as_lines`) or as the array of its values.
    fn json_sample(&self, as_lines: bool, seed: u64) -> JsonSample {
        let text = self.text(as_lines);
        let lines = self.lines && as_lines;
        match self.reader {
            Reader::String if lines => JsonSample::StringLines(text),
            Reader::String => JsonSample::String(text),
            Reader::Stream if lines => JsonSample::StreamLines(text.into_bytes()),
            Reader::Stream => JsonSample::Stream(text.into_bytes()),
            Reader::Chunks(max) => {
                let reader = SampleReader::new(Chunked {
                    data: text.into_bytes(),
                    position: 0,
                    rng: Rng::new(seed),
                    max,
                });
                if lines {
                    JsonSample::ReaderLines(reader)
                } else {
                    JsonSample::Reader(reader)
                }
            }
        }
    }
}

/// One `add_source` call.
#[derive(Clone, Debug)]
struct Source {
    name: String,
    samples: Vec<Sample>,
}

/// The sources of a run, and how it runs.
#[derive(Debug)]
struct Case {
    sources: Vec<Source>,
    lang: &'static dyn TargetLanguage,
    tally_inference: bool,
    handle_refs: bool,
    option_set: usize,
}

fn case(seed: u64) -> Case {
    let mut rng = Rng::new(seed);
    let languages = default_target_languages();
    let lang = languages[rng.below(languages.len() as u64) as usize];
    let separators: &[&str] = &["\n", "\r\n", "\n\n", " \n\t", "\r\n  \r\n", "\n\n\n"];
    let arounds: &[&str] = &["", "\n", "\r\n", " \n", "\n\n"];
    // String samples are read with `JSON.parse` semantics, streams with
    // stream-json's: one or the other per run, as an input has one reader.
    let text = rng.chance(40);
    let mut sources = Vec::new();
    for s in 0..rng.range(1, 4) {
        let name = (*rng.pick(&["TopLevel", "Cards", "Item", "élan"])).to_owned();
        let name = if rng.chance(70) {
            name
        } else {
            format!("{name}{s}")
        };
        let mut samples = Vec::new();
        for i in 0..rng.range(1, 3) {
            let values = generator::line_values(seed * 64 + s * 8 + i, LIMITS);
            let lines = values.len() != 1 || rng.chance(80);
            let reader = if text {
                Reader::String
            } else if rng.chance(50) {
                Reader::Stream
            } else {
                Reader::Chunks(*rng.pick(&[1, 3, 16, 4096]))
            };
            let separators = (0..rng.range(1, 3))
                .map(|_| *rng.pick(separators))
                .collect();
            let around = (*rng.pick(arounds), *rng.pick(arounds));
            samples.push(Sample {
                values: if lines || !values.is_empty() {
                    values
                } else {
                    vec!["{}".to_owned()]
                },
                lines,
                reader,
                separators,
                around,
            });
        }
        sources.push(Source { name, samples });
    }
    Case {
        sources,
        lang,
        tally_inference: rng.chance(80),
        handle_refs: rng.chance(20),
        option_set: rng.below(6) as usize,
    }
}

/// The run's files, or its error, with the samples as JSON Lines or as
/// arrays.
fn run(case: &Case, as_lines: bool, seed: u64) -> String {
    let lang = case.lang;
    let renderer_options = Default::default();
    let mut input = json_input_for_target_language(lang, case.handle_refs, &renderer_options);
    input.set_tally_inference(case.tally_inference).unwrap();
    let mut added = Vec::new();
    for (i, source) in case.sources.iter().enumerate() {
        let samples = source
            .samples
            .iter()
            .enumerate()
            .map(|(j, sample)| sample.json_sample(as_lines, seed + (i * 8 + j) as u64))
            .collect();
        added.push(format!(
            "{:?}",
            input.add_source_sync(JsonSourceData {
                name: source.name.clone(),
                samples,
                description: None,
            })
        ));
    }
    let mut input_data = InputData::new();
    input_data.add_input(input);
    let mut options = Options::new(lang, input_data);
    options.inference_flags.ignore_json_refs = !case.handle_refs;
    match case.option_set {
        1 => options.inference_flags.infer_enums = false,
        2 => options.inference_flags.infer_maps = false,
        3 => options.all_properties_optional = true,
        4 => options.inference_flags.combine_classes = false,
        5 => options.alphabetize_properties = true,
        _ => {}
    }
    let result = match quicktype_multi_file_sync(options) {
        Ok(files) => files
            .iter()
            .map(|(name, file)| format!("// {name}\n{}", file.lines.join("\n")))
            .collect::<Vec<_>>()
            .join("\n"),
        Err(e) => format!("error: {}", e.user_message()),
    };
    format!("{}\n{result}", added.join("\n"))
}

fn check(seeds: std::ops::Range<u64>) {
    for seed in seeds {
        let case = case(seed);
        let lines = run(&case, true, seed);
        let array = run(&case, false, seed);
        assert!(
            lines == array,
            "seed {seed}, {}: JSON Lines differ from the arrays\n{case:?}\n--- lines\n{lines}\n--- arrays\n{array}",
            case.lang.name()
        );
    }
}

#[test]
fn json_lines_give_what_their_array_gives() {
    check(0..300);
}

/// More seeds: `QUICKTYPE_JSON_LINES_SEEDS` (default 20,000) from
/// `QUICKTYPE_JSON_LINES_START` (default 300).
#[test]
#[ignore]
fn json_lines_give_what_their_array_gives_fuzz() {
    let env = |name: &str, default: u64| {
        std::env::var(name)
            .ok()
            .and_then(|v| v.replace('_', "").parse().ok())
            .unwrap_or(default)
    };
    let start = env("QUICKTYPE_JSON_LINES_START", 300);
    check(start..start + env("QUICKTYPE_JSON_LINES_SEEDS", 20_000));
}

/// Errors: the line of the bad value, the reader's message, and the
/// source's name, as `JSON.parse` and stream-json report a JSON error.
#[test]
fn json_lines_errors() {
    let lang = default_target_languages()[0];
    let error = |sample: JsonSample| {
        let mut input = json_input_for_target_language(lang, false, &Default::default());
        input
            .add_source_sync(JsonSourceData {
                name: "Cards".to_owned(),
                samples: vec![sample],
                description: None,
            })
            .unwrap_err()
            .user_message()
            .to_owned()
    };
    let text = "{\"a\": 1}\n{\"a\": 2} {\"a\": 3}\n";
    assert_eq!(
        error(JsonSample::StreamLines(text.as_bytes().to_vec())),
        "Syntax error in input JSON Cards: line 2: Parser cannot parse input: unexpected characters"
    );
    assert_eq!(
        error(JsonSample::ReaderLines(SampleReader::new(text.as_bytes()))),
        "Syntax error in input JSON Cards: line 2: Parser cannot parse input: unexpected characters"
    );
    assert_eq!(
        error(JsonSample::StringLines(text.to_owned())),
        "Syntax error in input JSON Cards: line 2: Unexpected non-whitespace character after JSON at position 18"
    );
}
