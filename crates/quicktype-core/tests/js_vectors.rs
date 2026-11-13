//! Replays the vectors that `xtask/js-compat/gen-vectors.mjs` records from
//! quicktype-core's TypeScript build: `support/Strings.ts`, `Acronyms.ts`,
//! `IntegerRange.ts` and `MarkovChain.ts`.

use std::path::Path;

use quicktype_core::markov_chain;
use quicktype_core::support::acronyms::{AcronymStyleOptions, acronym_style};
use quicktype_core::support::acronyms_const::ACRONYMS;
use quicktype_core::support::integer_range::{
    INT8_RANGE, INT16_RANGE, INT32_RANGE, INT64_RANGE, IntegerRange, JS_SAFE_INTEGER_RANGE,
    compare_integer_strings, integer_string_in_range,
};
use quicktype_core::support::strings::*;
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

fn ascii_legalizer(s: &str) -> String {
    legalize_characters(s, |cp| is_ascii(cp) && is_letter_or_underscore_or_digit(cp))
}

fn unicode_legalizer(s: &str) -> String {
    legalize_characters(s, is_letter_or_underscore_or_digit)
}

/// The namer the generator calls `style/legalizer[/prefix]`.
fn namer(spec: &str) -> Box<dyn Fn(&str) -> String> {
    let mut parts = spec.split('/');
    let style = NamingStyle::from_name(parts.next().unwrap_or_default()).expect("known style");
    let legalize: fn(&str) -> String = match parts.next() {
        Some("ascii") => ascii_legalizer,
        Some("unicode") => unicode_legalizer,
        other => panic!("unknown legalizer {other:?}"),
    };
    let prefix = parts.next().map(|_| "QT");
    Box::new(make_name_style(style, legalize, prefix))
}

fn php_escape(s: &str) -> String {
    utf16_concat_map(s, |code_point| match code_point {
        0x0A => "' . \"\\n\" . '".into(),
        0x0D => "' . \"\\r\" . '".into(),
        0x27 => "\\'".into(),
        0x5C => "\\\\".into(),
        _ => MapperOutput::CharCode(code_point),
    })
}

#[test]
fn strings_ts() {
    let vectors = load("strings.json");
    let mut m = Mismatches::default();
    let namers: Vec<_> = arr(&vectors["namers"])
        .iter()
        .map(|n| (str_of(n), namer(str_of(n))))
        .collect();
    let java_escape = escape_non_printable_mapper(is_ascii, standard_unicode_hex_escape);

    for case in arr(&vectors["cases"]) {
        let s = str_of(&case["s"]);
        let words: Vec<Value> = split_into_words(s)
            .into_iter()
            .map(|w| Value::Array(vec![Value::String(w.word), Value::Bool(w.is_acronym)]))
            .collect();
        m.check(
            || format!("splitIntoWords({s:?})"),
            &Value::Array(words),
            &case["words"],
        );
        for ((name, f), want) in namers.iter().zip(arr(&case["names"])) {
            m.check(|| format!("{name}({s:?})"), f(s), str_of(want).to_owned());
        }
        let golang = combine_words(
            &split_into_words(s),
            &ascii_legalizer,
            &first_upper_word_style,
            &first_upper_word_style,
            &all_upper_word_style,
            &all_upper_word_style,
            "",
            &|cp| is_ascii(cp) && is_letter(cp),
        );
        m.check(
            || format!("golang({s:?})"),
            golang,
            str_of(&case["golang"]).to_owned(),
        );
        let checks: [(&str, String); 13] = [
            ("capitalize", capitalize(s)),
            ("decapitalize", decapitalize(s)),
            ("pascal_case", pascal_case(s)),
            ("camel_case", camel_case(s)),
            ("snake_case", snake_case(s)),
            ("trim_end", trim_end(s).to_owned()),
            ("utf16_string_escape", utf16_string_escape(s)),
            ("string_escape", string_escape(s)),
            ("java_escape", utf16_concat_map(s, &java_escape)),
            ("php_escape", php_escape(s)),
            ("legalize", legalize_characters(s, is_letter_or_underscore)),
            (
                "start_with_letter/0",
                start_with_letter(is_letter_or_underscore, true, s),
            ),
            (
                "start_with_letter/1",
                start_with_letter(is_letter_or_underscore, false, s),
            ),
        ];
        for (name, got) in checks {
            let want = match name.split_once('/') {
                Some((key, index)) => &case[key][index.parse::<usize>().expect("index")],
                None => &case[name],
            };
            m.check(|| format!("{name}({s:?})"), got, str_of(want).to_owned());
        }
        let utf16_legalized: Vec<i64> = utf16_legalize_characters(s, is_letter_or_underscore)
            .encode_utf16()
            .map(i64::from)
            .collect();
        let want: Vec<i64> = arr(&case["utf16_legalize"]).iter().map(int).collect();
        m.check(
            || format!("utf16LegalizeCharacters({s:?})"),
            utf16_legalized,
            want,
        );
        if !s.is_empty() {
            for (style, want) in AcronymStyleOptions::ALL
                .iter()
                .zip(arr(&case["acronym_styles"]))
            {
                m.check(
                    || format!("acronymStyle({style:?})({s:?})"),
                    acronym_style(*style)(s),
                    str_of(want).to_owned(),
                );
            }
            let styles = [
                first_upper_word_style(s),
                all_upper_word_style(s),
                all_lower_word_style(s),
            ];
            for (i, (got, want)) in styles
                .into_iter()
                .zip(arr(&case["word_styles"]))
                .enumerate()
            {
                m.check(
                    || format!("word style {i} ({s:?})"),
                    got,
                    str_of(want).to_owned(),
                );
            }
        }
    }

    let predicates: [fn(u32) -> bool; 10] = [
        is_printable,
        is_ascii,
        is_letter,
        is_digit,
        is_numeric,
        is_letter_or_digit,
        is_letter_or_underscore,
        is_letter_or_underscore_or_digit,
        is_word_character,
        fast_is_upper_case,
    ];
    for case in arr(&vectors["predicates"]) {
        let cp = int(&case[0]) as u32;
        let mask = predicates
            .iter()
            .enumerate()
            .fold(0, |mask, (i, p)| mask | (i64::from(p(cp)) << i));
        m.check(|| format!("predicates(U+{cp:04X})"), mask, int(&case[1]));
    }

    let misc = &vectors["misc"];
    for case in arr(&misc["repeat_string"]) {
        let (s, n) = (str_of(&case[0]), int(&case[1]) as usize);
        m.check(
            || format!("repeatString({s:?}, {n})"),
            repeat_string(s, n),
            str_of(&case[2]).to_owned(),
        );
    }
    for case in arr(&misc["int_to_hex"]) {
        let (i, width) = (int(&case[0]) as u32, int(&case[1]) as usize);
        m.check(
            || format!("intToHex({i}, {width})"),
            int_to_hex(i, width),
            str_of(&case[2]).to_owned(),
        );
    }
    for case in arr(&misc["unicode_hex_escape"]) {
        let cp = int(&case[0]) as u32;
        m.check(
            || format!("standardUnicodeHexEscape({cp})"),
            standard_unicode_hex_escape(cp),
            str_of(&case[1]).to_owned(),
        );
    }
    for case in arr(&misc["add_prefix"]) {
        let (prefix, name) = (str_of(&case[0]), str_of(&case[1]));
        m.check(
            || format!("addPrefixIfNecessary({prefix:?}, {name:?})"),
            add_prefix_if_necessary(prefix, name),
            str_of(&case[2]).to_owned(),
        );
    }
    m.finish("Strings.ts");
}

#[test]
fn acronyms_ts() {
    let vectors = load("acronyms.json");
    let mut m = Mismatches::default();
    let want: Vec<&str> = arr(&vectors["acronyms"]).iter().map(str_of).collect();
    m.check(|| "acronyms".to_owned(), ACRONYMS.to_vec(), want);
    let options: Vec<&str> = arr(&vectors["options"])
        .iter()
        .map(|o| str_of(&o[1]))
        .collect();
    let ours: Vec<&str> = AcronymStyleOptions::ALL
        .iter()
        .map(|o| o.as_str())
        .collect();
    m.check(|| "AcronymStyleOptions".to_owned(), ours, options);
    m.finish("Acronyms.ts");
}

#[test]
fn integer_range_ts() {
    let vectors = load("integer_range.json");
    let mut m = Mismatches::default();
    let ranges: Vec<(&str, &IntegerRange)> = vec![
        ("INT64_RANGE", &INT64_RANGE),
        ("INT32_RANGE", &INT32_RANGE),
        ("INT16_RANGE", &INT16_RANGE),
        ("INT8_RANGE", &INT8_RANGE),
        ("JS_SAFE_INTEGER_RANGE", &JS_SAFE_INTEGER_RANGE),
    ];
    let names: Vec<&str> = arr(&vectors["range_names"]).iter().map(str_of).collect();
    m.check(
        || "range names".to_owned(),
        ranges.iter().map(|(n, _)| *n).collect::<Vec<_>>(),
        names,
    );
    for (name, range) in &ranges {
        let want = &vectors["ranges"][name];
        m.check(|| format!("{name}.min"), range.min(), str_of(&want["min"]));
        m.check(|| format!("{name}.max"), range.max(), str_of(&want["max"]));
    }
    for case in arr(&vectors["in_range"]) {
        let s = str_of(&case[0]);
        for ((name, range), want) in ranges.iter().zip(arr(&case[1])) {
            let want = want.as_bool().expect("bool");
            m.check(
                || format!("integerStringInRange({s:?}, {name})"),
                integer_string_in_range(s, range),
                want,
            );
        }
    }
    for case in arr(&vectors["compare"]) {
        let (a, b) = (str_of(&case[0]), str_of(&case[1]));
        m.check(
            || format!("compareIntegerStrings({a:?}, {b:?})"),
            compare_integer_strings(a, b) as i64,
            int(&case[2]),
        );
    }
    m.finish("IntegerRange.ts");
}

/// mulberry32, the generator the vectors substitute for `Math.random`.
fn mulberry32(seed: u32) -> impl FnMut() -> f64 {
    let mut a = seed;
    move || {
        a = a.wrapping_add(0x6D2B_79F5);
        let mut t = a;
        t = (t ^ (t >> 15)).wrapping_mul(t | 1);
        t ^= t.wrapping_add((t ^ (t >> 7)).wrapping_mul(t | 61));
        f64::from(t ^ (t >> 14)) / 4_294_967_296.0
    }
}

#[test]
fn markov_chain_ts() {
    let vectors = load("markov_chain.json");
    let mut m = Mismatches::default();
    let mc = markov_chain::load();

    let fnv = mc.probability_codes.iter().fold(0x811C_9DC5_u32, |h, &c| {
        (h ^ u32::from(c)).wrapping_mul(0x0100_0193)
    });
    m.check(
        || "codes FNV-1a".to_owned(),
        i64::from(fnv),
        int(&vectors["codes_fnv1a"]),
    );
    m.check(
        || "codes length".to_owned(),
        mc.probability_codes.len() as i64,
        int(&vectors["codes_length"]),
    );
    let mut histogram = vec![0i64; mc.probabilities.len()];
    for &code in &mc.probability_codes {
        histogram[usize::from(code)] += 1;
    }
    let want: Vec<i64> = arr(&vectors["codes_histogram"]).iter().map(int).collect();
    m.check(|| "codes histogram".to_owned(), histogram, want);
    let probabilities: Vec<u64> = mc
        .probabilities
        .iter()
        .map(|&p| f64::from(p).to_bits())
        .collect();
    let want: Vec<u64> = arr(&vectors["probabilities"])
        .iter()
        .map(|p| f64_hex(p).to_bits())
        .collect();
    m.check(|| "probabilities".to_owned(), probabilities, want);

    // The final `**` calls the platform pow; the vectors come from macOS. On
    // other platforms allow one unit in the last place (see number::pow).
    let max_ulps: u64 = if cfg!(target_os = "macos") { 0 } else { 1 };
    // Maps a result within tolerance to the expected value.
    let close = |got: f64, want: f64| {
        if got.to_bits().abs_diff(want.to_bits()) <= max_ulps {
            want
        } else {
            got
        }
    };
    for case in arr(&vectors["evaluate"]) {
        let word = str_of(&case[0]);
        let want = f64_hex(&case[1]);
        let got = markov_chain::evaluate(&mc, word);
        m.check(|| format!("evaluate({word:?})"), close(got, want), want);
        if let Some(full) = case[2].as_array() {
            let (probability, scores) = markov_chain::evaluate_full(&mc, word);
            let want = f64_hex(&full[0]);
            m.check(
                || format!("evaluateFull({word:?})"),
                close(probability, want),
                want,
            );
            let want: Vec<f64> = arr(&full[1]).iter().map(f64_hex).collect();
            m.check(|| format!("evaluateFull({word:?}) scores"), scores, want);
        }
    }

    for case in arr(&vectors["train"]) {
        let lines: Vec<&str> = arr(&case[0]).iter().map(str_of).collect();
        m.check(
            || format!("train({lines:?})"),
            markov_chain::train(&lines, 3).to_json(),
            str_of(&case[1]).to_owned(),
        );
    }

    for case in arr(&vectors["generate"]) {
        let (state, seed) = (str_of(&case[0]), int(&case[1]) as u32);
        let unseen_weight = case[2].as_f64().expect("number");
        let mut random = mulberry32(seed);
        let got: Vec<Option<String>> = (0..20)
            .map(|_| markov_chain::generate(&mc, state, unseen_weight, &mut random))
            .collect();
        let want: Vec<Option<String>> = arr(&case[3])
            .iter()
            .map(|s| Some(str_of(s).to_owned()))
            .collect();
        m.check(
            || format!("generate({state:?}, {unseen_weight})"),
            got,
            want,
        );
    }
    m.finish("MarkovChain.ts");
}
