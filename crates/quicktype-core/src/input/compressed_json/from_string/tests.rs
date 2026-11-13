//! The one-pass reader against reading the value whole (the port of V8's
//! `JSON.parse`, then `process`): the same root values, the same objects
//! and arrays in the same order, the same string table, and the same
//! errors; and both against the tables TypeScript builds.

use std::cell::Cell;
use std::fmt::Write as _;

use super::*;
use crate::date_time::DefaultDateTimeRecognizer;
use crate::support::integer_range::{INT32_RANGE, INT64_RANGE, IntegerRange};

thread_local! {
    /// How many members [`Recorder::member_keys`] walked past.
    pub(super) static KEYS_WALKED: Cell<usize> = const { Cell::new(0) };
}

fn reader(range: Option<IntegerRange>, handle_refs: bool) -> CompressedJson {
    CompressedJson::new(Box::new(DefaultDateTimeRecognizer), handle_refs, range)
}

/// A value of `cjson` written out, with object and array indexes (which
/// must agree, since they are what TypeScript's `Value`s encode).
fn dump(cjson: &CompressedJson, root: Value) -> String {
    let mut out = String::new();
    // `None` closes a container.
    let mut stack = vec![Some(root)];
    while let Some(value) = stack.pop() {
        let Some(value) = value else {
            out.push(')');
            continue;
        };
        match value {
            Value::Object(i) => {
                let _ = write!(out, "{{#{i}");
                stack.push(None);
                for &(k, v) in cjson.get_object_for_value(value).unwrap().iter().rev() {
                    stack.push(Some(v));
                    stack.push(Some(k));
                }
            }
            Value::Array(i) => {
                let _ = write!(out, "[#{i}");
                stack.push(None);
                for &v in cjson.get_array_for_value(value).unwrap().iter().rev() {
                    stack.push(Some(v));
                }
            }
            Value::InternedString(_) => {
                let _ = write!(out, " s{:?}", cjson.get_string_for_value(value).unwrap());
            }
            Value::TransformedString(_) => {
                let _ = write!(out, " t{:?}", cjson.get_string_for_value(value).unwrap());
            }
            other => {
                let _ = write!(out, " {other:?}");
            }
        }
    }
    out
}

/// Reads `samples` one after the other into one compressed form, both
/// ways, and compares every outcome and the tables.
fn same(samples: &[&str], range: Option<IntegerRange>, handle_refs: bool) {
    let mut fast = reader(range.clone(), handle_refs);
    let mut whole = reader(range, handle_refs);
    for sample in samples {
        let a = fast.parse_string(sample);
        let b = parse_string_value_into(&mut whole, sample);
        match (&a, &b) {
            (Ok(x), Ok(y)) => {
                assert_eq!(x, y, "root of {sample:?}");
                assert_eq!(dump(&fast, *x), dump(&whole, *y), "value of {sample:?}");
            }
            (Err(x), Err(y)) => assert_eq!(x, y, "error of {sample:?}"),
            _ => panic!("{sample:?}: {a:?} against {b:?}"),
        }
        assert_eq!(
            fast.table_counts(),
            whole.table_counts(),
            "tables after {sample:?}"
        );
    }
    // Strings included, in the same order.
    assert_eq!(fast.to_tables(&[]), whole.to_tables(&[]));
}

/// The tables and root values (`None` for an error) TypeScript's
/// `CompressedJSONFromString` has after `parseSync` of each sample.
fn typescript_tables(
    samples: &[&str],
    strings: &[&str],
    objects: &[&[i32]],
    arrays: &[&[i32]],
    roots: &[Option<i32>],
) {
    let mut r = reader(Some(INT64_RANGE.clone()), false);
    let values: Vec<Option<Value>> = samples.iter().map(|s| r.parse_string(s).ok()).collect();
    let present: Vec<Value> = values.iter().flatten().copied().collect();
    let (tables, encoded) = r.to_tables(&present);
    let mut encoded = encoded.into_iter();
    let encoded_roots: Vec<Option<i32>> = values
        .iter()
        .map(|v| v.and_then(|_| encoded.next()))
        .collect();
    assert_eq!(tables.strings, strings, "strings of {samples:?}");
    let runs = |flat: &[i32], offsets: &[u32]| -> Vec<Vec<i32>> {
        (0..offsets.len())
            .map(|i| {
                let end = offsets.get(i + 1).map_or(flat.len(), |&e| e as usize);
                flat[offsets[i] as usize..end].to_vec()
            })
            .collect()
    };
    assert_eq!(runs(&tables.objects, &tables.object_offsets), objects);
    assert_eq!(runs(&tables.arrays, &tables.array_offsets), arrays);
    assert_eq!(encoded_roots, roots);
}

/// Recorded from quicktype's TypeScript (`QUICKTYPE_ENGINE=ts`): a key is
/// interned after its value, only for the members `JSON.parse` keeps, and
/// a string format interns its kind's name; nothing of a sample that is
/// not JSON is interned.
#[test]
fn string_tables_are_typescripts() {
    typescript_tables(
        &[r#"{"__proto__":1,"__proto__":2}"#],
        &["__proto__"],
        &[&[6, 4]],
        &[],
        &[Some(8)],
    );
    typescript_tables(
        &[r#"{"a": {"b": 1}, "c": "2020-01-01", "d": ["x", "a"]}"#],
        &["b", "a", "date", "c", "x", "d"],
        &[&[6, 4], &[22, 8, 54, 42, 86, 9]],
        &[&[70, 22]],
        &[Some(24)],
    );
    typescript_tables(
        &[r#"{"key1": [1, {"key2": "#, r#"{"k": "v"}"#],
        &["v", "k"],
        &[&[22, 6]],
        &[],
        &[None, Some(8)],
    );
    typescript_tables(
        &[r#"{"b": 1, "2": {"q": "date"}, "a": "2020-01-01", "1": [4], "b": "x"}"#],
        &["1", "date", "q", "2", "x", "b", "a"],
        &[&[38, 22], &[6, 9, 54, 8, 86, 70, 102, 26]],
        &[&[4]],
        &[Some(24)],
    );
    typescript_tables(
        &[r#"{"__proto__": {"__proto__": 1}, "x": {"__proto__": [2], "__proto__": 3}}"#],
        &["__proto__", "__proto__", "__proto__", "x"],
        &[&[6, 4], &[38, 4], &[22, 8, 54, 24]],
        &[],
        &[Some(40)],
    );
    typescript_tables(
        &[r#"{"x": "y", "y": "x", "$ref": "x"}"#],
        &["y", "x", "$ref"],
        &[&[22, 6, 6, 22, 38, 22]],
        &[],
        &[Some(8)],
    );
}

#[test]
fn values_like_reading_the_value_whole() {
    let samples = [
        "null",
        " true ",
        "false",
        "0",
        "-0",
        "1.0",
        "1e2",
        "1.5",
        "-12.5e-3",
        "123456789012345",
        "1234567890123456",
        "9223372036854775807",
        "-9223372036854775808",
        "9223372036854774784",
        "1e21",
        "1e400",
        "-1e400",
        r#""x""#,
        r#""2020-01-01""#,
        r#""http://a/b.png""#,
        r#""a\"b\\c\/d\b\f\n\r\té😀""#,
        r#""\ud800""#,
        r#""\udc00x\ud800𐀀""#,
        "[]",
        "{}",
        r#"[1, [2, [3, []]], {}]"#,
        r#"{"a": 1, "b": [true, null], "c": {"d": "e"}}"#,
        r#"{"b": 1, "2": 2, "a": 3, "1": 4, "01": 5, "4294967295": 6, "b": 7}"#,
        r#"{"a": {"x": 1}, "b": [1], "a": {"y": [2, {"z": 3}]}}"#,
        r#"{"__proto__": 1, "__proto__": {"a": 2}, "b": 3}"#,
        r#"{"__proto__": [1], "a": {"__proto__": 2}}"#,
        r#"{"1": {"2": 2, "1": 1}, "0": [{"k": 1, "k": 2}]}"#,
        r#"{"0": 0, "1": 1, "2": 2, "x": 3}"#,
        r#"{"x": 3, "0": 0}"#,
        r#"{"a": {"a": {"a": 1}, "b": 2}, "b": {"a": 3}, "a": 4}"#,
        r#"{"key": 1, "key": 2}"#,
        r#"{"\ud800": 1, "\udbff": 2}"#,
        r##"{"$ref": "#/x", "a": {"$ref": "http://x/y"}}"##,
        r#"["a", "a", "b", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"]"#,
        r#"["éééééééééééééééééééééééééééééééééééééééééééééééééééééééééééééééé", "ééééééééééééééééééééééééééééééééééééééééééééééééééééééééééééééééé"]"#,
        r#"["123", "true", "12:00:00", "2020-01-01T00:00:00Z", "6ba7b810-9dad-11d1-80b4-00c04fd430c8"]"#,
    ];
    same(&samples, Some(INT64_RANGE.clone()), false);
    same(&samples, Some(INT32_RANGE.clone()), true);
    same(&samples, None, false);
    same(
        &samples,
        Some(IntegerRange::new("1", "99999999999999999999")),
        false,
    );
    same(&samples, Some(IntegerRange::new("x", "-")), false);
}

#[test]
fn errors_like_reading_the_value_whole() {
    let samples = [
        "",
        " ",
        "[",
        "]",
        "{",
        "}",
        "[1,]",
        "[1 2]",
        "{\"a\"}",
        "{\"a\":}",
        "{\"a\":1,}",
        "{a:1}",
        "{'a':1}",
        "01",
        "-",
        "-a",
        "1.",
        ".5",
        "1e",
        "1e+",
        "+1",
        "0x10",
        "NaN",
        "Infinity",
        "tru",
        "truex",
        "nul",
        "\"abc",
        "\"a\\x\"",
        "\"a\\u12\"",
        "\"a\\u12g4\"",
        "\"\t\"",
        "\"\u{1}\"",
        "\u{feff}{}",
        "[1] [2]",
        "{} x",
        "\"\\\u{e9}\"",
        "[\"a\" \"b\"]",
        "{\"a\" 1}",
        "[,1]",
        "{,}",
        "nulll",
        "[1,2",
        "{\"a\":[1,{\"b\":",
    ];
    same(&samples, Some(INT64_RANGE.clone()), false);
}

/// Every `JSON.parse` vector recorded from Node: the same values, and the
/// same errors, as the port of V8's parser.
#[test]
fn json_parse_vectors() {
    std::thread::Builder::new()
        .stack_size(64 << 20)
        .spawn(|| {
            let path = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
                .join("../quicktype-js-compat/tests/vectors/json_parse.json");
            let text = std::fs::read_to_string(path).unwrap();
            let vectors: Vec<serde_json::Value> = serde_json::from_str(&text).unwrap();
            assert!(vectors.len() > 5000);
            let inputs: Vec<&str> = vectors
                .iter()
                .map(|v| v["input"].as_str().unwrap())
                .collect();
            // One compressed form for all of them, as for the samples of
            // one input.
            same(&inputs, Some(INT64_RANGE.clone()), false);
        })
        .unwrap()
        .join()
        .unwrap();
}

/// SplitMix64.
struct Rng(u64);

impl Rng {
    fn next(&mut self) -> u64 {
        self.0 = self.0.wrapping_add(0x9E37_79B9_7F4A_7C15);
        let mut z = self.0;
        z = (z ^ (z >> 30)).wrapping_mul(0xBF58_476D_1CE4_E5B9);
        z = (z ^ (z >> 27)).wrapping_mul(0x94D0_49BB_1331_11EB);
        z ^ (z >> 31)
    }

    fn below(&mut self, n: usize) -> usize {
        (self.next() % n as u64) as usize
    }
}

const KEYS: &[&str] = &[
    "a",
    "b",
    "id",
    "name",
    "0",
    "1",
    "2",
    "10",
    "01",
    "4294967294",
    "4294967295",
    "-1",
    "__proto__",
    "$ref",
    "k\\u0065y",
    "key",
    "\\ud800",
    "é",
    "😀",
    "",
];
const STRINGS: &[&str] = &[
    "x",
    "",
    "2020-01-01",
    "12:30:00",
    "2020-01-01T00:00:00Z",
    "123",
    "-5",
    "true",
    "false",
    "http://example.com/a.png",
    "6ba7b810-9dad-11d1-80b4-00c04fd430c8",
    "a\\nb",
    "\\u00e9",
    "\\ud83d\\ude00",
    "\\ud800",
    "\\udc00",
    "#/definitions/x",
    "a long string that is longer than sixty-four characters, so it is not interned",
];
const NUMBERS: &[&str] = &[
    "0",
    "-0",
    "1",
    "-1",
    "1.0",
    "1.5",
    "1e2",
    "1E-2",
    "123456789012345",
    "1234567890123456",
    "9007199254740993",
    "9223372036854775807",
    "9223372036854775808",
    "-9223372036854775809",
    "2147483647",
    "2147483648",
    "1e21",
    "1e400",
    "0.1e1",
];

fn random_value(rng: &mut Rng, depth: usize, out: &mut String) {
    let pick = if depth > 5 {
        rng.below(5)
    } else {
        rng.below(8)
    };
    let ws = |rng: &mut Rng, out: &mut String| {
        if rng.below(4) == 0 {
            out.push_str([" ", "\n", "\t", "\r\n  "][rng.below(4)]);
        }
    };
    match pick {
        0 => out.push_str(["null", "true", "false"][rng.below(3)]),
        1 | 2 => out.push_str(NUMBERS[rng.below(NUMBERS.len())]),
        3 | 4 => {
            let _ = write!(out, "\"{}\"", STRINGS[rng.below(STRINGS.len())]);
        }
        5 => {
            out.push('[');
            for i in 0..rng.below(5) {
                if i > 0 {
                    out.push(',');
                }
                ws(rng, out);
                random_value(rng, depth + 1, out);
                ws(rng, out);
            }
            out.push(']');
        }
        _ => {
            out.push('{');
            for i in 0..rng.below(7) {
                if i > 0 {
                    out.push(',');
                }
                ws(rng, out);
                let _ = write!(out, "\"{}\"", KEYS[rng.below(KEYS.len())]);
                ws(rng, out);
                out.push(':');
                random_value(rng, depth + 1, out);
            }
            out.push('}');
        }
    }
}

/// Random documents full of duplicate, array-index and `__proto__` keys,
/// escapes, lone surrogates and numbers at the integer range's edges,
/// read into shared compressed forms, and mutations of them (dropped,
/// doubled or replaced bytes), which are mostly syntax errors.
#[test]
fn random_documents_and_mutations() {
    let mut rng = Rng(0x5EED);
    let ranges = [Some(INT64_RANGE.clone()), Some(INT32_RANGE.clone()), None];
    for round in 0..300 {
        let mut samples = Vec::new();
        for _ in 0..8 {
            let mut text = String::new();
            random_value(&mut rng, 0, &mut text);
            samples.push(text);
        }
        let mut mutated = Vec::new();
        for sample in &samples {
            let bytes = sample.as_bytes();
            if bytes.is_empty() {
                continue;
            }
            let at = rng.below(bytes.len());
            let mut m = bytes.to_vec();
            match rng.below(3) {
                0 => {
                    m.remove(at);
                }
                1 => m.insert(at, bytes[at]),
                _ => {
                    let replacements = b"{}[]\",:0e-.\\ax ";
                    m[at] = replacements[rng.below(replacements.len())];
                }
            }
            if let Ok(m) = String::from_utf8(m) {
                mutated.push(m);
            }
        }
        let all: Vec<&str> = samples.iter().chain(&mutated).map(String::as_str).collect();
        same(&all, ranges[round % 3].clone(), round % 2 == 0);
    }
}

#[test]
fn syntax_errors_commit_nothing() {
    let mut r = reader(Some(INT64_RANGE.clone()), false);
    r.parse_string(r#"[{"a": [1]}]"#).unwrap();
    let before = r.table_counts();
    for bad in [r#"[{"a": [1]}, {"b": 2}"#, r#"{"c": [[], {}] x"#] {
        assert!(r.parse_string(bad).is_err());
        assert_eq!(r.table_counts(), before);
    }
    assert_eq!(r.parse_string("[{}]").unwrap(), Value::Array(2));
    assert_eq!(r.to_tables(&[]).0.strings, ["a"]);
}

/// The tape and the key table of a large sample are not kept; those of a
/// small one are, and are reused.
#[test]
fn large_buffers_are_not_kept() {
    let mut r = reader(None, false);
    let records: Vec<String> = (0..10_000)
        .map(|i| format!(r#"{{"key{i}": [{i}, {{"k": "v"}}]}}"#))
        .collect();
    r.parse_string(&format!("[{}]", records.join(","))).unwrap();
    assert!(r.string_reader.spare_nodes.capacity() <= KEEP_NODES);
    assert!(r.string_reader.keys.spans.is_empty());
    assert_eq!(r.string_reader.serial, 0);
    r.parse_string(r#"{"a": {"b": 1}}"#).unwrap();
    assert!(r.string_reader.spare_nodes.capacity() > 0);
    assert_eq!(r.string_reader.keys.spans.len(), 2);
    // Keys of a declined sample are no more than read: a later sample
    // interns them where TypeScript does.
    let limits = StringSampleLimits {
        max_depth: Some(2),
        lone_surrogates: false,
    };
    assert!(
        r.read_string_sample(r#"{"c": {"d": [1]}}"#, limits)
            .is_err()
    );
    let strings = r.to_tables(&[]).0.strings;
    assert_eq!(strings.len(), 10_004);
    assert_eq!(strings[..3], ["v", "k", "key0"]);
    assert_eq!(strings[10_002..], ["b", "a"]);
}

#[test]
fn limits() {
    let limits = StringSampleLimits {
        max_depth: Some(3),
        lone_surrogates: false,
    };
    let mut r = reader(None, false);
    assert_eq!(r.read_string_sample("[[[1]]]", limits), Ok(Value::Array(2)));
    assert_eq!(
        r.read_string_sample("[[{}, 1]]", limits),
        Ok(Value::Array(4))
    );
    let before = r.table_counts();
    for (text, decline) in [
        ("[[[[1]]]]", Decline::TooDeep),
        ("[[[{}]]]", Decline::TooDeep),
        (r#"{"a": {"b": {"c": []}}}"#, Decline::TooDeep),
        // Declined at the depth, before the syntax error.
        ("[[[[1}", Decline::TooDeep),
        (r#"["\ud800"]"#, Decline::LoneSurrogate),
        (r#"[{"\udc00": 1}]"#, Decline::LoneSurrogate),
        (r#"["\ud800A"]"#, Decline::LoneSurrogate),
    ] {
        assert_eq!(
            r.read_string_sample(text, limits),
            Err(ReadStringError::Declined(decline)),
            "{text}"
        );
        assert_eq!(r.table_counts(), before, "{text}");
    }
    assert_eq!(
        r.read_string_sample(r#"["😀"]"#, limits),
        Ok(Value::Array(5))
    );
    assert!(matches!(
        r.read_string_sample("[1,", limits),
        Err(ReadStringError::Parse(ParseError::Js(_)))
    ));
}

/// What the reader falls back on (for a text it rejects but V8's parser
/// accepts, or one too long for its tape) reads the value whole, which
/// cannot be checked against limits: with any, a sample that parses is
/// declined and nothing is committed, so lone surrogates and nesting
/// beyond them never get in; without limits, it is read as `process`
/// reads it.
#[test]
fn the_fallback_honors_the_limits() {
    let limits = StringSampleLimits {
        max_depth: Some(3),
        lone_surrogates: false,
    };
    let arrays = |n: usize| format!("{}{}", "[".repeat(n), "]".repeat(n));
    let mut r = reader(None, false);
    r.parse_string(r#"{"a": ["b"]}"#).unwrap();
    let before = r.table_counts();
    for text in [
        r#"["\ud800"]"#,
        r#"{"\udc00": 1}"#,
        r#"["\ud800A"]"#,
        "[[[[1]]]]",
        r#"{"a": {"b": {"c": []}}}"#,
        &arrays(PROCESS_MAX_DEPTH + 1),
        "[1]",
    ] {
        assert_eq!(
            read_whole(&mut r, text, limits),
            Err(ReadStringError::Declined(Decline::Unchecked)),
            "{text}"
        );
        assert_eq!(r.table_counts(), before, "{text}");
    }
    // Not JSON: V8's error, and nothing committed.
    assert_eq!(
        read_whole(&mut r, "[1,", limits),
        Err(ReadStringError::Parse(ParseError::Js(
            crate::messages::JsException::new(
                crate::messages::JsErrorName::SyntaxError,
                "Unexpected end of JSON input"
            )
        )))
    );
    assert_eq!(r.table_counts(), before);
    // Without limits: read, a lone surrogate as U+FFFD, and too deep for
    // `process` as it fails.
    let none = StringSampleLimits::default();
    assert_eq!(
        read_whole(&mut r, r#"["\ud800"]"#, none),
        Ok(Value::Array(1))
    );
    assert_eq!(
        read_whole(&mut r, &arrays(PROCESS_MAX_DEPTH + 1), none),
        Err(ReadStringError::Parse(ParseError::Quicktype(
            stack_overflow()
        )))
    );
    assert_eq!(r.to_tables(&[]).0.strings, ["b", "a", "\u{FFFD}"]);
}

/// Objects nested a million levels deep are read without recursion (and
/// fail as `process` does), and a large reordered object without
/// quadratic work.
#[test]
fn deep_and_wide() {
    let n = 1_000_000;
    let mut deep = r#"{"a":"#.repeat(n);
    deep.push('1');
    deep.push_str(&"}".repeat(n));
    assert_eq!(
        reader(None, false).parse_string(&deep),
        Err(ParseError::Quicktype(stack_overflow()))
    );
    let wide: String = (0..200_000)
        .rev()
        .map(|i| format!(r#""{i}": {{"{i}": {i}, "k": {i}}}"#))
        .collect::<Vec<_>>()
        .join(",");
    same(&[&format!("{{{wide}}}")], None, false);
}

/// Wide objects whose keys reappear in the objects nested in them are
/// read in linear time: past `SCAN_MEMBERS` members, an object walks its
/// members to find a duplicate once (it used to walk them for every such
/// key).
#[test]
fn keys_reused_by_nested_objects() {
    let n = 10_000;
    let members = |n: usize| -> Vec<String> {
        (0..n)
            .map(|i| format!(r#""k{i}": {{"k{}": 0, "k{}": 1}}"#, i + 1, i + 2))
            .collect()
    };
    let wide = |n: usize| format!("{{{}}}", members(n).join(", "));
    // With a duplicate at the end.
    let duplicated = format!(r#"{{{}, "k5": 2}}"#, members(n).join(", "));
    let walked = |text: &str| {
        KEYS_WALKED.with(|w| w.set(0));
        reader(None, false).parse_string(text).unwrap();
        KEYS_WALKED.with(Cell::get)
    };
    // One by one up to `SCAN_MEMBERS` members, then a set made once.
    let bound = SCAN_MEMBERS * SCAN_MEMBERS;
    assert!(walked(&wide(n)) <= bound, "{}", walked(&wide(n)));
    assert!(walked(&duplicated) <= bound);
    // As many walked for ten times the members.
    assert_eq!(walked(&wide(10 * n)), walked(&wide(n)));
    same(&[&wide(n), &duplicated, &wide(100)], None, false);
    let records: Vec<String> = (0..n)
        .map(|i| format!(r#"{{"a": {{"b": {i}}}, "b": [{{"a": 1, "a": 2}}], "c": {i}}}"#))
        .collect();
    same(&[&format!("[{}]", records.join(","))], None, false);
}

/// `process` overflows Node's stack at its 4,579th nested value: the
/// reader fails at the same value, with the same error, after committing
/// the same values before it (strings interned, objects and arrays that
/// ended), with or without limits; a syntax error anywhere comes first.
#[test]
fn as_deep_as_process_goes() {
    let m = PROCESS_MAX_DEPTH;
    let arrays = |n: usize| format!("{}{}", "[".repeat(n), "]".repeat(n));
    let nested = |n: usize, inner: &str| {
        format!(
            r#"[{{"k": "v", "n": [1]}}, "s", {}{inner}{}, {{"after": "x"}}]"#,
            r#"{"a":["#.repeat(n),
            "]}".repeat(n)
        )
    };
    // `nested(n, …)`: the innermost value is 2n + 2 deep.
    let deepest = (m - 2) / 2;
    let samples = [
        arrays(m),
        arrays(m + 1),
        nested(deepest, "1"),
        nested(deepest, "[]"),
        nested(deepest, "[1]"),
        nested(deepest + 1, r#""deep""#),
        format!("{} x", arrays(m + 1)),
        format!("[{}", arrays(m + 1)),
        r#"{"later": ["strings"]}"#.to_owned(),
    ];
    let texts: Vec<&str> = samples.iter().map(String::as_str).collect();
    same(&texts, None, false);
    let mut r = reader(None, false);
    let outcomes: Vec<bool> = texts.iter().map(|t| r.parse_string(t).is_ok()).collect();
    assert_eq!(
        outcomes,
        [true, false, true, true, false, false, false, false, true]
    );
    assert_eq!(
        r.parse_string(&arrays(m + 1)),
        Err(ParseError::Quicktype(stack_overflow()))
    );
    // What `process` committed before it overflowed stays in the tables,
    // as in TypeScript.
    let strings = r.to_tables(&[]).0.strings;
    assert!(strings.starts_with(&["v".into(), "k".into(), "n".into(), "s".into()]));
}

/// The eight-bytes-at-a-time scan stops exactly where the byte-wise one
/// does, for every byte value at every position.
#[test]
fn plain_runs() {
    for b in 0..=255u8 {
        for at in 0..8 {
            let mut word = [b'a'; 8];
            word[at] = b;
            assert_eq!(
                has_string_stop(u64::from_le_bytes(word)),
                STRING_STOP[b as usize],
                "{b} at {at}"
            );
        }
    }
    for b in 0..=255u8 {
        for at in 0..20 {
            let mut bytes = vec![0xC3; 20];
            bytes[at] = b;
            let expected = (0..20)
                .find(|&i| STRING_STOP[bytes[i] as usize])
                .unwrap_or(20);
            assert_eq!(plain_run(&bytes, 0), expected);
        }
    }
}
