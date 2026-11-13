//! Replays the vectors recorded from Node by `xtask/js-compat/gen-vectors.mjs`.
//!
//! Each test compares one module against the JavaScript original on curated
//! edge cases, property names from the golden corpus and seeded random data.

use std::path::Path;

use indexmap::IndexMap;
use quicktype_js_compat::json::{self, JsonValue};
use quicktype_js_compat::wordwrap::WordWrap;
use quicktype_js_compat::{number, pluralize, sort, unicode, utf16, whitespace};
use serde_json::Value;

fn load(name: &str) -> Value {
    let path = Path::new(env!("CARGO_MANIFEST_DIR"))
        .join("tests/vectors")
        .join(name);
    let text = std::fs::read_to_string(&path).unwrap_or_else(|e| panic!("{}: {e}", path.display()));
    serde_json::from_str(&text).unwrap_or_else(|e| panic!("{}: {e}", path.display()))
}

fn arr(v: &Value) -> &Vec<Value> {
    v.as_array()
        .unwrap_or_else(|| panic!("expected an array, got {v}"))
}

fn str_of(v: &Value) -> &str {
    v.as_str()
        .unwrap_or_else(|| panic!("expected a string, got {v}"))
}

fn int(v: &Value) -> i64 {
    v.as_i64()
        .unwrap_or_else(|| panic!("expected an integer, got {v}"))
}

fn f64_hex(v: &Value) -> f64 {
    f64::from_bits(u64::from_str_radix(str_of(v), 16).expect("hex bits"))
}

fn units_of(v: &Value) -> Vec<u16> {
    arr(v)
        .iter()
        .map(|u| u16::try_from(int(u)).expect("code unit"))
        .collect()
}

/// Collects mismatches so a failing test reports how many cases differ.
#[derive(Default)]
struct Mismatches(Vec<String>, usize);

impl Mismatches {
    fn check<T: PartialEq + std::fmt::Debug>(
        &mut self,
        what: impl FnOnce() -> String,
        got: T,
        want: T,
    ) {
        self.1 += 1;
        if got != want {
            self.0
                .push(format!("{}: got {got:?}, want {want:?}", what()));
        }
    }

    fn finish(self, name: &str) {
        let Self(failures, total) = self;
        assert!(total > 0, "{name}: no cases");
        assert!(
            failures.is_empty(),
            "{name}: {} of {total} cases differ:\n{}",
            failures.len(),
            failures
                .iter()
                .take(25)
                .cloned()
                .collect::<Vec<_>>()
                .join("\n")
        );
    }
}

#[test]
fn number_to_string() {
    let vectors = load("number.json");
    let mut m = Mismatches::default();
    for case in arr(&vectors["to_string"]) {
        let x = f64_hex(&case[0]);
        m.check(
            || format!("{x:e}"),
            number::to_string(x),
            str_of(&case[1]).to_owned(),
        );
    }
    m.finish("Number#toString");
}

#[test]
fn number_pow() {
    let vectors = load("number.json");
    let mut m = Mismatches::default();
    // The golden corpus and these vectors come from macOS, where V8 and Rust
    // call the same libm `pow`. Elsewhere the platform `pow` may differ from
    // Apple's in the last bit, so allow one unit in the last place there.
    let max_ulps: u64 = if cfg!(target_os = "macos") { 0 } else { 1 };
    for case in arr(&vectors["pow"]) {
        let (x, y, want) = (f64_hex(&case[0]), f64_hex(&case[1]), f64_hex(&case[2]));
        let got = number::pow(x, y);
        let close = (got.is_nan() && want.is_nan())
            || (got.is_sign_positive() == want.is_sign_positive()
                && got.to_bits().abs_diff(want.to_bits()) <= max_ulps);
        let got_bits = if close { want.to_bits() } else { got.to_bits() };
        m.check(|| format!("{x:e} ** {y:e}"), got_bits, want.to_bits());
    }
    m.finish("**");
}

#[test]
fn utf16_strings() {
    let vectors = load("utf16.json");
    let mut m = Mismatches::default();
    for case in arr(&vectors["strings"]) {
        let s = str_of(&case["s"]);
        m.check(
            || format!("len({s:?})"),
            utf16::len(s),
            int(&case["len"]) as usize,
        );
        let units: Vec<u16> = utf16::units(s).collect();
        m.check(
            || format!("units({s:?})"),
            units.clone(),
            units_of(&case["units"]),
        );
        for (i, want) in arr(&case["code_point_at"]).iter().enumerate() {
            let want = want.as_u64().map(|cp| cp as u32);
            m.check(
                || format!("codePointAt({s:?}, {i})"),
                utf16::code_point_at(s, i),
                want,
            );
            m.check(
                || format!("codePointAt(units {s:?}, {i})"),
                utf16::code_point_at_units(&units, i),
                want,
            );
            let want_unit = units.get(i).copied();
            m.check(
                || format!("charCodeAt({s:?}, {i})"),
                utf16::char_code_at(s, i),
                want_unit,
            );
        }
        for slice in arr(&case["slices"]) {
            let start = int(&slice[0]);
            let end = slice[1].as_i64();
            let (want_slice, want_substring) = (units_of(&slice[2]), units_of(&slice[3]));
            let what = || format!("{s:?}.slice({start}, {end:?})");
            m.check(
                what,
                utf16::slice_units(&units, start, end).to_vec(),
                want_slice.clone(),
            );
            m.check(
                what,
                utf16::slice(s, start, end).to_owned(),
                utf16::units_to_string(&want_slice),
            );
            let what = || format!("{s:?}.substring({start}, {end:?})");
            m.check(
                what,
                utf16::substring_units(&units, start, end).to_vec(),
                want_substring.clone(),
            );
            m.check(
                what,
                utf16::substring(s, start, end).to_owned(),
                utf16::units_to_string(&want_substring),
            );
        }
        m.check(
            || format!("upper first {s:?}"),
            utf16::upper_first_unit(s),
            str_of(&case["upper_first"]).to_owned(),
        );
        m.check(
            || format!("lower first {s:?}"),
            utf16::lower_first_unit(s),
            str_of(&case["lower_first"]).to_owned(),
        );
    }
    for case in arr(&vectors["case_mapping"]) {
        let units = units_of(&case[0]);
        m.check(
            || format!("toLowerCase {units:x?}"),
            utf16::to_lowercase_units(&units),
            units_of(&case[1]),
        );
        m.check(
            || format!("toUpperCase {units:x?}"),
            utf16::to_uppercase_units(&units),
            units_of(&case[2]),
        );
    }
    for case in arr(&vectors["compare"]) {
        let (a, b) = (str_of(&case[0]), str_of(&case[1]));
        m.check(
            || format!("compare({a:?}, {b:?})"),
            sort::compare_utf16(a, b) as i64,
            int(&case[2]),
        );
    }
    m.finish("UTF-16 strings");
}

#[test]
fn whitespace_class_and_trim() {
    let vectors = load("whitespace.json");
    let mut m = Mismatches::default();
    let expected: Vec<u32> = arr(&vectors["whitespace"])
        .iter()
        .map(|v| int(v) as u32)
        .collect();
    let actual: Vec<u32> = (0..=0x10FFFF)
        .filter_map(char::from_u32)
        .filter(|&c| whitespace::is_whitespace(c))
        .map(u32::from)
        .collect();
    m.check(|| "\\s code points".to_owned(), actual, expected);
    for case in arr(&vectors["trims"]) {
        let s = str_of(&case[0]);
        m.check(
            || format!("trim({s:?})"),
            whitespace::trim(s),
            str_of(&case[1]),
        );
        m.check(
            || format!("trimStart({s:?})"),
            whitespace::trim_start(s),
            str_of(&case[2]),
        );
        m.check(
            || format!("trimEnd({s:?})"),
            whitespace::trim_end(s),
            str_of(&case[3]),
        );
    }
    m.finish("whitespace");
}

#[test]
fn unicode_properties() {
    let vectors = load("unicode.json");
    let mut m = Mismatches::default();
    let runs: Vec<(u32, &str)> = arr(&vectors["runs"])
        .iter()
        .map(|r| (int(&r[0]) as u32, str_of(&r[1])))
        .collect();
    for (i, &(start, category)) in runs.iter().enumerate() {
        let end = runs.get(i + 1).map_or(0x110000, |&(next, _)| next);
        for cp in start..end {
            let got = unicode::get_category(cp).as_str();
            if got != category {
                m.check(|| format!("getCategory(U+{cp:04X})"), got, category);
            }
        }
        m.check(
            || format!("run at U+{start:04X}"),
            unicode::get_category(start).as_str(),
            category,
        );
    }
    for case in arr(&vectors["predicates"]) {
        let cp = int(&case[0]) as u32;
        let mask = u32::from(unicode::is_alphabetic(cp))
            | u32::from(unicode::is_digit(cp)) << 1
            | u32::from(unicode::is_lower_case(cp)) << 2
            | u32::from(unicode::is_upper_case(cp)) << 3
            | u32::from(unicode::is_white_space(cp)) << 4;
        m.check(
            || format!("predicates(U+{cp:04X})"),
            i64::from(mask),
            int(&case[1]),
        );
    }
    for case in arr(&vectors["out_of_range"]) {
        let cp = int(&case[0]) as u32;
        m.check(
            || format!("getCategory({cp:#x})"),
            unicode::get_category(cp).as_str(),
            str_of(&case[1]),
        );
    }
    m.finish("unicode-properties");
}

/// The hash `gen-vectors.mjs` uses to build reproducible comparators.
fn mix(seed: u32, a: u32, b: u32) -> u32 {
    let mut h = (seed ^ 0x9E37_79B9).wrapping_mul(0x85EB_CA6B);
    h = (h ^ a).wrapping_mul(0xC2B2_AE35);
    h ^= h >> 16;
    h = (h ^ b).wrapping_mul(0x27D4_EB2F);
    h ^= h >> 15;
    h = h.wrapping_mul(0x1656_67B1);
    h ^= h >> 13;
    h
}

fn sort_with(kind: &str, n: u32, seed: u32) -> Vec<u32> {
    let mut v: Vec<u32> = (0..n).collect();
    match kind {
        "random3" => sort::sort_by(&mut v, |&a, &b| i64::from(mix(seed, a, b) % 3) - 1),
        "keys" => sort::sort_by(&mut v, |&a, &b| {
            i64::from(mix(seed, a, 7) % 13) - i64::from(mix(seed, b, 7) % 13)
        }),
        "noisy" => sort::sort_by(&mut v, |&a, &b| {
            if mix(seed, a, b) % 17 == 0 {
                i64::from(mix(seed, b, a) % 3) - 1
            } else {
                i64::from(mix(seed, a, 7) % 50) - i64::from(mix(seed, b, 7) % 50)
            }
        }),
        "runs" => {
            let period = 20 + mix(seed, 0, 0) % 80;
            let key = |i: u32| {
                let segment = i / period;
                let base = i64::from(mix(seed, segment, 2) % 1000);
                if mix(seed, segment, 1) % 2 == 0 {
                    base - i64::from(i)
                } else {
                    base + i64::from(i)
                }
            };
            sort::sort_by(&mut v, |&a, &b| {
                if mix(seed, a, b) % 101 == 0 {
                    -1
                } else {
                    key(a) - key(b)
                }
            });
        }
        "nan" => sort::sort_by(&mut v, |&a, &b| {
            if mix(seed, a, b) % 5 == 0 {
                f64::NAN
            } else {
                (f64::from(mix(seed, a, 3) % 9) - f64::from(mix(seed, b, 3) % 9)) / 3.0
            }
        }),
        other => panic!("unknown comparator kind {other}"),
    }
    v
}

#[test]
fn v8_array_sort() {
    let vectors = load("sort.json");
    let mut m = Mismatches::default();
    for case in arr(&vectors["comparators"]) {
        let (kind, n, seed) = (
            str_of(&case["kind"]),
            int(&case["n"]) as u32,
            int(&case["seed"]) as u32,
        );
        let want: Vec<u32> = arr(&case["expected"])
            .iter()
            .map(|v| int(v) as u32)
            .collect();
        m.check(
            || format!("{kind} n={n} seed={seed}"),
            sort_with(kind, n, seed),
            want,
        );
    }
    for case in arr(&vectors["tables"]) {
        let n = int(&case["n"]) as usize;
        let table: Vec<i64> = arr(&case["table"]).iter().map(int).collect();
        let mut v: Vec<usize> = (0..n).collect();
        sort::sort_by(&mut v, |&a, &b| table[a * n + b]);
        let want: Vec<usize> = arr(&case["expected"])
            .iter()
            .map(|v| int(v) as usize)
            .collect();
        m.check(|| format!("table keys {}", case["keys"]), v, want);
    }
    for case in arr(&vectors["strings"]) {
        let mut v: Vec<&str> = arr(&case["input"]).iter().map(str_of).collect();
        sort::sort_strings(&mut v);
        let want: Vec<&str> = arr(&case["expected"]).iter().map(str_of).collect();
        m.check(|| format!("sort() {}", case["input"]), v, want);
    }
    m.finish("Array.prototype.sort");
}

fn json_tree(v: &Value) -> JsonValue {
    match str_of(&v[0]) {
        "null" => JsonValue::Null,
        "bool" => JsonValue::Bool(v[1].as_bool().expect("bool")),
        "num" => JsonValue::Number(f64_hex(&v[1])),
        "str" => JsonValue::String(str_of(&v[1]).to_owned()),
        "arr" => JsonValue::Array(arr(&v[1]).iter().map(json_tree).collect()),
        "obj" => {
            let mut map = IndexMap::new();
            for entry in arr(&v[1]) {
                json::insert_js_property(
                    &mut map,
                    str_of(&entry[0]).to_owned(),
                    json_tree(&entry[1]),
                );
            }
            JsonValue::Object(map)
        }
        other => panic!("unknown tree tag {other}"),
    }
}

#[test]
fn json_stringify() {
    let vectors = load("json.json");
    let mut m = Mismatches::default();
    for case in arr(&vectors["quote"]) {
        let s = str_of(&case[0]);
        m.check(
            || format!("quote({s:?})"),
            json::quote(s),
            str_of(&case[1]).to_owned(),
        );
    }
    for case in arr(&vectors["stringify"]) {
        let value = json_tree(&case["value"]);
        let gap = match (case["spaces"].as_f64(), case["str"].as_str()) {
            (Some(spaces), _) => json::gap_from_spaces(spaces),
            (None, Some(s)) => json::gap_from_str(s),
            (None, None) => None,
        };
        let got = json::stringify(&value, gap.as_deref());
        m.check(
            || format!("stringify({value:?}, {gap:?})"),
            got,
            str_of(&case["expected"]).to_owned(),
        );
    }
    m.finish("JSON.stringify");
}

#[test]
fn pluralize_8_0_0() {
    let vectors = load("pluralize.json");
    let mut m = Mismatches::default();
    for case in arr(&vectors["words"]) {
        let word = str_of(&case[0]);
        m.check(
            || format!("singular({word:?})"),
            pluralize::singular(word),
            str_of(&case[1]).to_owned(),
        );
        m.check(
            || format!("plural({word:?})"),
            pluralize::plural(word),
            str_of(&case[2]).to_owned(),
        );
        m.check(
            || format!("isSingular({word:?})"),
            pluralize::is_singular(word),
            case[3].as_bool().expect("bool"),
        );
        m.check(
            || format!("isPlural({word:?})"),
            pluralize::is_plural(word),
            case[4].as_bool().expect("bool"),
        );
    }
    for case in arr(&vectors["counted"]) {
        let (word, count, inclusive) = (
            str_of(&case[0]),
            f64_hex(&case[1]),
            case[2].as_bool().expect("bool"),
        );
        m.check(
            || format!("pluralize({word:?}, {count}, {inclusive})"),
            pluralize::pluralize(word, count, inclusive),
            str_of(&case[3]).to_owned(),
        );
    }
    m.finish("pluralize");
}

#[test]
fn wordwrap_1_0_0() {
    let vectors = load("wordwrap.json");
    let mut m = Mismatches::default();
    for case in arr(&vectors["cases"]) {
        let (text, start) = (str_of(&case[0]), int(&case[1]) as usize);
        let stop = case[2].as_u64().map_or(0, |s| s as usize);
        m.check(
            || format!("wordwrap({start}, {stop})({text:?})"),
            WordWrap::with_start(start, stop).wrap(text),
            str_of(&case[3]).to_owned(),
        );
    }
    m.finish("wordwrap");
}
