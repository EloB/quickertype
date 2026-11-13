//! JavaScript whitespace: the regex class `\s` and `String.prototype.trim`,
//! and the line terminators among it ([`is_line_terminator`]).
//!
//! ECMAScript defines both as *WhiteSpace* ∪ *LineTerminator*: TAB, VT, FF,
//! SP, U+00A0, U+FEFF, the `Zs` characters (U+1680, U+2000–U+200A, U+202F,
//! U+205F, U+3000), LF, CR, U+2028 and U+2029. Rust's
//! [`char::is_whitespace`], [`str::trim`] and the `regex` crate's `\s` differ
//! from it in exactly two places: they include U+0085 (NEXT LINE) and exclude
//! U+FEFF (BYTE ORDER MARK).
//!
//! Every member is in the Basic Multilingual Plane, so testing `char`s gives
//! the same answers as JavaScript's tests on UTF-16 code units.

/// The `regex`-crate character class equivalent to JavaScript's `\s`.
pub const CLASS: &str = r"[\t\n\x0B\x0C\r \u{A0}\u{1680}\u{2000}-\u{200A}\u{2028}\u{2029}\u{202F}\u{205F}\u{3000}\u{FEFF}]";

/// The `regex`-crate character class equivalent to JavaScript's `\S`.
pub const NOT_CLASS: &str = r"[^\t\n\x0B\x0C\r \u{A0}\u{1680}\u{2000}-\u{200A}\u{2028}\u{2029}\u{202F}\u{205F}\u{3000}\u{FEFF}]";

/// Whether `c` matches JavaScript's `\s` (and is removed by `trim()`).
pub fn is_whitespace(c: char) -> bool {
    matches!(
        c,
        '\t' | '\n' | '\u{0B}' | '\u{0C}' | '\r' | ' ' | '\u{A0}' | '\u{1680}'
    ) || ('\u{2000}'..='\u{200A}').contains(&c)
        || matches!(
            c,
            '\u{2028}' | '\u{2029}' | '\u{202F}' | '\u{205F}' | '\u{3000}' | '\u{FEFF}'
        )
}

/// Whether `c` is a JavaScript *LineTerminator* (LF, CR, U+2028, U+2029):
/// the characters a regular expression's `.` does not match.
pub fn is_line_terminator(c: char) -> bool {
    matches!(c, '\n' | '\r' | '\u{2028}' | '\u{2029}')
}

/// `String.prototype.trim()`.
pub fn trim(s: &str) -> &str {
    s.trim_matches(is_whitespace)
}

/// `String.prototype.trimStart()`; also the effect of `s.replace(/^\s+/, "")`.
pub fn trim_start(s: &str) -> &str {
    s.trim_start_matches(is_whitespace)
}

/// `String.prototype.trimEnd()`; also the effect of `s.replace(/\s+$/, "")`.
pub fn trim_end(s: &str) -> &str {
    s.trim_end_matches(is_whitespace)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn differs_from_rust_at_nel_and_bom() {
        assert!(!is_whitespace('\u{85}'));
        assert!('\u{85}'.is_whitespace());
        assert!(is_whitespace('\u{FEFF}'));
        assert!(!'\u{FEFF}'.is_whitespace());
        assert_eq!(trim("\u{FEFF} a\u{85}\u{A0}"), "a\u{85}");
    }

    #[test]
    fn regex_classes_agree_with_predicate() {
        let class = regex::Regex::new(&format!("^{CLASS}$")).expect("valid class");
        let not_class = regex::Regex::new(&format!("^{NOT_CLASS}$")).expect("valid class");
        for c in (0..=0x10FFFF).filter_map(char::from_u32) {
            let s = c.to_string();
            assert_eq!(class.is_match(&s), is_whitespace(c), "U+{:04X}", c as u32);
            assert_eq!(
                not_class.is_match(&s),
                !is_whitespace(c),
                "U+{:04X}",
                c as u32
            );
        }
    }
}
