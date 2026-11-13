//! Deeply nested (and self-referencing) JSON through the library API, with
//! both readers: where TypeScript's recursion overflows Node's stack, the
//! run fails with V8's `RangeError: Maximum call stack size exceeded`, and
//! it never overflows the native stack (a million levels used to abort the
//! process). The rules are in `docs/PARITY.md` ("Very deeply nested JSON").
//!
//! The runs use a thread with the CLI's stack size, as the CLI does.

use quicktype_core::{
    InferenceFlags, InputData, JsonSample, JsonSourceData, Options, get_target_language,
    json_input_for_target_language, quicktype_multi_file_sync,
};

const OVERFLOW: &str = "Maximum call stack size exceeded";
const PARSE_OVERFLOW: &str = "Syntax error in input JSON Deep: Maximum call stack size exceeded";

/// Runs `json` into Go without rendering (as `--no-render`); the error's
/// message if it fails. `parse` reads it with `JSON.parse` semantics (the
/// JavaScript API), otherwise with stream-json's (the CLI).
fn run(json: String, parse: bool) -> Result<(), String> {
    std::thread::Builder::new()
        .stack_size(256 << 20)
        .spawn(move || {
            let lang = get_target_language("go").unwrap();
            let mut input = json_input_for_target_language(lang, false, &Default::default());
            let sample = if parse {
                JsonSample::String(json)
            } else {
                JsonSample::Stream(json.into_bytes())
            };
            let mut input_data = InputData::new();
            input
                .add_source_sync(JsonSourceData {
                    name: "Deep".to_owned(),
                    samples: vec![sample],
                    description: None,
                })
                .map_err(|e| e.user_message().to_owned())?;
            input_data.add_input(input);
            let options = Options::new(lang, input_data).with_no_render(true);
            quicktype_multi_file_sync(options)
                .map(|_| ())
                .map_err(|e| e.user_message().to_owned())
        })
        .unwrap()
        .join()
        .unwrap()
}

fn arrays(n: usize) -> String {
    format!("{}{}", "[".repeat(n), "]".repeat(n))
}

fn objects(n: usize) -> String {
    format!("{}1{}", r#"{"a":"#.repeat(n), "}".repeat(n))
}

/// Inference recurses once per nested array or object: 999 levels are
/// inferred, 1,000 overflow, with either reader.
#[test]
fn inference_overflows_past_999_levels() {
    for parse in [false, true] {
        assert_eq!(run(arrays(999), parse), Ok(()), "parse: {parse}");
        assert_eq!(run(arrays(1_000), parse), Err(OVERFLOW.to_owned()));
    }
}

/// `JSON.parse` semantics: `CompressedJSONFromString.process` overflows
/// first, past 4,578 nested values, which TypeScript reports as the
/// sample's parse error.
#[test]
fn json_parse_samples_overflow_while_read() {
    assert_eq!(run(arrays(4_578), true), Err(OVERFLOW.to_owned()));
    assert_eq!(run(arrays(4_579), true), Err(PARSE_OVERFLOW.to_owned()));
    assert_eq!(run(objects(4_577), true), Err(OVERFLOW.to_owned()));
    assert_eq!(run(objects(4_578), true), Err(PARSE_OVERFLOW.to_owned()));
    for json in [arrays(1_000_000), objects(1_000_000)] {
        assert_eq!(run(json.clone(), true), Err(PARSE_OVERFLOW.to_owned()));
        assert_eq!(run(json, false), Err(OVERFLOW.to_owned()));
    }
}

/// With `$ref`s handled (`--no-ignore-json-refs`), references from inside
/// the values they point to make types that contain themselves without a
/// class in between: a union among its own members (also across two
/// samples), an array that is its own items. TypeScript recurses through
/// them (`UnionBuilder`, `typeNameForUnionMember`) until V8's stack
/// overflows, as the port does under its guards (it used to overflow the
/// native stack, also the CLI's, or run for minutes). On the test thread's
/// own small stack.
#[test]
fn self_referencing_json_overflows_like_node() {
    let cases: &[(&str, &[&str])] = &[
        ("go", &[r##"{"": [{"$ref": "#//0"}, null]}"##]),
        ("go", &[r##"{"a": [null, {"$ref": "#/a"}]}"##]),
        ("go", &[r##"{"0": true, "1": [[{"$ref": "#/1/0"}]]}"##]),
        ("java", &[r#"{"a":"x"}"#, r##"{"a":{"$ref":"#/a"}}"##]),
        ("typescript", &[r#"{"a":1}"#, r##"{"a":{"$ref":"#/a"}}"##]),
    ];
    for (lang, samples) in cases {
        let lang = get_target_language(lang).unwrap();
        let mut input = json_input_for_target_language(lang, true, &Default::default());
        input
            .add_source_sync(JsonSourceData {
                name: "Cycle".to_owned(),
                samples: samples
                    .iter()
                    .map(|s| JsonSample::Stream(s.as_bytes().to_vec()))
                    .collect(),
                description: None,
            })
            .unwrap();
        let mut input_data = InputData::new();
        input_data.add_input(input);
        let mut flags = InferenceFlags::default();
        flags.ignore_json_refs = false;
        let options = Options::new(lang, input_data).with_inference_flags(flags);
        let e = quicktype_multi_file_sync(options).unwrap_err();
        assert_eq!(e.user_message(), OVERFLOW, "{samples:?}");
    }
}
