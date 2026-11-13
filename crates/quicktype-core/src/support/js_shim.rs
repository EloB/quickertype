//! Temporary stand-ins for helpers that the `quicktype-js-compat` crate will
//! provide (JS number formatting, UTF-16 string comparison, `JSON.stringify`,
//! `splitIntoWords`, `pluralize`).
//!
//! Each function is marked `TODO(js-compat)` with the function that replaces
//! it. They are correct for the cases the type graph needs today, but the
//! word splitting and singularization are approximations: replace them as
//! soon as the js-compat work package is merged.

use std::cmp::Ordering;

/// JavaScript `Number.prototype.toString()` for any `f64`.
// TODO(js-compat): replace with quicktype_js_compat::number::to_string
pub(crate) fn number_to_string(x: f64) -> String {
    if x.is_nan() {
        return "NaN".to_owned();
    }
    if x == 0.0 {
        return "0".to_owned();
    }
    if x.is_infinite() {
        return if x > 0.0 { "Infinity" } else { "-Infinity" }.to_owned();
    }
    if x < 0.0 {
        return format!("-{}", number_to_string(-x));
    }
    // Rust's `{:e}` prints the shortest digits that round-trip, which are the
    // digits ECMAScript's Number::toString uses.
    let formatted = format!("{x:e}");
    let (mantissa, exponent) = formatted.split_once('e').unwrap_or((&formatted, "0"));
    let digits: String = mantissa.chars().filter(|c| *c != '.').collect();
    let exponent: i64 = exponent.parse().unwrap_or(0);
    let k = digits.len() as i64;
    let n = exponent + 1;
    if k <= n && n <= 21 {
        format!("{digits}{}", "0".repeat((n - k) as usize))
    } else if 0 < n && n <= 21 {
        format!("{}.{}", &digits[..n as usize], &digits[n as usize..])
    } else if -6 < n && n <= 0 {
        format!("0.{}{digits}", "0".repeat((-n) as usize))
    } else {
        let sign = if n - 1 < 0 { '-' } else { '+' };
        let e = (n - 1).abs();
        if k == 1 {
            format!("{digits}e{sign}{e}")
        } else {
            format!("{}.{}e{sign}{e}", &digits[..1], &digits[1..])
        }
    }
}

/// Compares two strings like JavaScript's `<`/`>`: by UTF-16 code units.
// TODO(js-compat): replace with quicktype_js_compat::string::cmp_utf16
pub(crate) fn utf16_cmp(a: &str, b: &str) -> Ordering {
    a.encode_utf16().cmp(b.encode_utf16())
}

/// JavaScript `s.length`: the number of UTF-16 code units.
// TODO(js-compat): replace with quicktype_js_compat::string::utf16_len
pub(crate) fn utf16_len(s: &str) -> usize {
    s.encode_utf16().count()
}

/// `JSON.stringify(s)` for a string.
// TODO(js-compat): replace with quicktype_js_compat::json::stringify_string
pub(crate) fn json_stringify_string(s: &str) -> String {
    let mut out = String::with_capacity(s.len() + 2);
    out.push('"');
    for c in s.chars() {
        match c {
            '"' => out.push_str("\\\""),
            '\\' => out.push_str("\\\\"),
            '\u{8}' => out.push_str("\\b"),
            '\u{c}' => out.push_str("\\f"),
            '\n' => out.push_str("\\n"),
            '\r' => out.push_str("\\r"),
            '\t' => out.push_str("\\t"),
            c if (c as u32) < 0x20 => out.push_str(&format!("\\u{:04x}", c as u32)),
            c => out.push(c),
        }
    }
    out.push('"');
    out
}

/// `JSON.stringify(x)` for a number.
// TODO(js-compat): replace with quicktype_js_compat::json::stringify_number
pub(crate) fn json_stringify_number(x: f64) -> String {
    if x.is_finite() {
        number_to_string(x)
    } else {
        "null".to_owned()
    }
}

/// `splitIntoWords(s).map(w => w.word.toLowerCase()).join("_")`, i.e.
/// `snakeCase` from `support/Strings.ts`. Approximates `unicode-properties`
/// 1.4.1 with Rust's `char` predicates.
// TODO(js-compat): replace with crate::support::strings::snake_case once the
// strings port (with the unicode-properties tables) is merged.
pub(crate) fn snake_case(s: &str) -> String {
    let units: Vec<u16> = s.encode_utf16().collect();
    let len = units.len();
    let code_point_at = |i: usize| -> u32 {
        let u = units[i] as u32;
        if (0xd800..0xdc00).contains(&u) && i + 1 < len {
            let l = units[i + 1] as u32;
            if (0xdc00..0xe000).contains(&l) {
                return 0x10000 + ((u - 0xd800) << 10) + (l - 0xdc00);
            }
        }
        u
    };
    let as_char = |cp: u32| char::from_u32(cp);
    let is_lower = |cp: u32| as_char(cp).is_some_and(char::is_lowercase);
    let is_upper = |cp: u32| as_char(cp).is_some_and(char::is_uppercase);
    let is_digit = |cp: u32| as_char(cp).is_some_and(|c| c.is_numeric() && c.is_alphanumeric());
    let is_letter = |cp: u32| as_char(cp).is_some_and(char::is_alphabetic);
    let is_word = |cp: u32| is_letter(cp) || is_digit(cp);
    let is_low_surrogate = |cp: u32| (0xdc00..0xe000).contains(&cp);

    let mut intervals: Vec<(usize, usize)> = Vec::new();
    let mut i = 0usize;
    let skip_while = |i: &mut usize, p: &dyn Fn(u32) -> bool| {
        while *i < len && p(code_point_at(*i)) {
            *i += 1;
        }
    };
    loop {
        skip_while(&mut i, &|cp| !is_word(cp));
        if i >= len {
            break;
        }
        let start = i;
        let cp = code_point_at(i);
        if is_lower(cp) {
            skip_while(&mut i, &is_lower);
            skip_while(&mut i, &is_digit);
        } else if is_upper(cp) {
            skip_while(&mut i, &is_upper);
            if i >= len {
            } else if i - start == 1 {
                skip_while(&mut i, &is_lower);
                skip_while(&mut i, &is_digit);
            } else if is_digit(code_point_at(i)) {
                skip_while(&mut i, &is_digit);
            } else if is_word(code_point_at(i)) {
                i -= 1;
            }
        } else {
            skip_while(&mut i, &|cp| !is_lower(cp) && !is_upper(cp));
        }
        if i < len && is_low_surrogate(code_point_at(i)) {
            i += 1;
        }
        intervals.push((start, i));
    }
    intervals
        .iter()
        .map(|&(start, end)| String::from_utf16_lossy(&units[start..end]).to_lowercase())
        .collect::<Vec<_>>()
        .join("_")
}

/// `pluralize.singular(word)` for the common English suffixes.
// TODO(js-compat): replace with quicktype_js_compat::pluralize::singular
pub(crate) fn pluralize_singular(word: &str) -> String {
    let lower = word.to_ascii_lowercase();
    const UNCHANGED: &[&str] = &["data", "media", "news", "series", "species", "status"];
    if UNCHANGED.contains(&lower.as_str()) || lower.ends_with("ss") || lower.ends_with("us") {
        return word.to_owned();
    }
    const IRREGULAR: &[(&str, &str)] = &[
        ("people", "person"),
        ("children", "child"),
        ("men", "man"),
        ("women", "woman"),
        ("mice", "mouse"),
    ];
    for (plural, singular) in IRREGULAR {
        if lower == *plural {
            return restore_case(word, singular);
        }
    }
    let strip = |n: usize, add: &str| format!("{}{add}", &word[..word.len() - n]);
    if lower.ends_with("ies") && lower.len() > 3 {
        strip(3, "y")
    } else if lower.ends_with("ses") || lower.ends_with("xes") || lower.ends_with("ches") {
        strip(2, "")
    } else if lower.ends_with('s') && lower.len() > 1 {
        strip(1, "")
    } else {
        word.to_owned()
    }
}

fn restore_case(word: &str, token: &str) -> String {
    if word == word.to_uppercase() {
        return token.to_uppercase();
    }
    let mut chars = word.chars();
    match chars.next() {
        Some(first) if first.is_uppercase() => {
            let mut t = token.chars();
            match t.next() {
                Some(f) => f.to_uppercase().chain(t).collect(),
                None => String::new(),
            }
        }
        _ => token.to_owned(),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn numbers_format_like_javascript() {
        let cases = [
            (0.0, "0"),
            (-0.0, "0"),
            (1.0, "1"),
            (-1.5, "-1.5"),
            (0.1, "0.1"),
            (1e21, "1e+21"),
            (1e-7, "1e-7"),
            (123e-20, "1.23e-18"),
            (1.5e300, "1.5e+300"),
            (123456789012345680000.0, "123456789012345680000"),
            (0.000001, "0.000001"),
            (2147483648.0, "2147483648"),
            (f64::NAN, "NaN"),
            (f64::INFINITY, "Infinity"),
        ];
        for (x, expected) in cases {
            assert_eq!(number_to_string(x), expected, "{x}");
        }
    }

    #[test]
    fn strings_compare_by_utf16_units() {
        // U+FF5E sorts after U+1F600 in UTF-16 (0xD83D < 0xFF5E is false).
        assert_eq!(utf16_cmp("\u{1F600}", "\u{FF5E}"), Ordering::Less);
        assert_eq!("\u{1F600}".cmp("\u{FF5E}"), Ordering::Greater);
        assert_eq!(utf16_len("a\u{1F600}"), 3);
    }

    #[test]
    fn json_strings() {
        assert_eq!(
            json_stringify_string("a\"b\\\n\u{1}é"),
            "\"a\\\"b\\\\\\n\\u0001é\""
        );
    }

    #[test]
    fn snake_case_words() {
        assert_eq!(snake_case("fooBar"), "foo_bar");
        assert_eq!(snake_case("URLPath"), "url_path");
        assert_eq!(snake_case("s1"), "s1");
        assert_eq!(snake_case("HTTP2Server"), "http2_server");
        assert_eq!(snake_case("a-b c"), "a_b_c");
    }
}
