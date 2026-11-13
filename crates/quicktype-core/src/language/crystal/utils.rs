//! Port of `packages/quicktype-core/src/language/Crystal/utils.ts`.
//!
//! Crystal's namers (ASCII identifiers in `snake_case` or `CamelCase`) and
//! its string escaper.

use crate::naming::{Namer, fun_prefix_namer};
use crate::support::strings::{
    MapperOutput, all_lower_word_style, combine_words, escape_non_printable_mapper,
    first_upper_word_style, int_to_hex, is_ascii, is_letter_or_underscore,
    is_letter_or_underscore_or_digit, is_printable, legalize_characters, split_into_words,
    utf32_concat_map,
};

/// `isAsciiLetterOrUnderscoreOrDigit(codePoint)`.
fn is_ascii_letter_or_underscore_or_digit(code_point: u32) -> bool {
    is_ascii(code_point) && is_letter_or_underscore_or_digit(code_point)
}

/// `isAsciiLetterOrUnderscore(codePoint)`.
fn is_ascii_letter_or_underscore(code_point: u32) -> bool {
    is_ascii(code_point) && is_letter_or_underscore(code_point)
}

/// `legalizeName`: keeps ASCII letters, digits and underscores.
fn legalize_name(s: &str) -> String {
    legalize_characters(s, is_ascii_letter_or_underscore_or_digit)
}

/// `crystalStyle(original, isSnakeCase)`: `snake_case` or `CamelCase`; a
/// name that comes out as `_` becomes `_underscore`.
fn crystal_style(original: &str, is_snake_case: bool) -> String {
    let words = split_into_words(original);
    let word_style: fn(&str) -> String = if is_snake_case {
        all_lower_word_style
    } else {
        first_upper_word_style
    };
    let combined = combine_words(
        &words,
        &legalize_name,
        &word_style,
        &word_style,
        &word_style,
        &word_style,
        if is_snake_case { "_" } else { "" },
        &is_ascii_letter_or_underscore,
    );
    if combined == "_" {
        "_underscore".to_owned()
    } else {
        combined
    }
}

/// `snakeNamingFunction`: `snake_case` property names.
pub fn snake_naming_function() -> Namer {
    fun_prefix_namer("default", |original| crystal_style(original, true))
}

/// `camelNamingFunction`: `CamelCase` type, enum case and union member
/// names.
pub fn camel_naming_function() -> Namer {
    fun_prefix_namer("camel", |original| crystal_style(original, false))
}

/// `standardUnicodeCrystalEscape(codePoint)`: `\u{XXXX}`, or six hex digits
/// above U+FFFF.
fn standard_unicode_crystal_escape(code_point: u32) -> String {
    if code_point <= 0xFFFF {
        format!("\\u{{{}}}", int_to_hex(code_point, 4))
    } else {
        format!("\\u{{{}}}", int_to_hex(code_point, 6))
    }
}

/// `crystalStringEscape`: escapes a string for a Crystal string literal, per
/// code point; `#` is escaped too, since it starts an interpolation.
pub fn crystal_string_escape(s: &str) -> String {
    let mapper = escape_non_printable_mapper(
        |code_point| is_printable(code_point) && code_point != 0x23,
        standard_unicode_crystal_escape,
    );
    utf32_concat_map(s, |code_point| -> MapperOutput { mapper(code_point) })
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn styles_names() {
        assert_eq!(crystal_style("fooBar", true), "foo_bar");
        assert_eq!(crystal_style("fooBar", false), "FooBar");
        assert_eq!(crystal_style("_", true), "empty");
        assert_eq!(crystal_style("1st", true), "the_1_st");
        assert_eq!(crystal_style("1st", false), "The1St");
        assert_eq!(crystal_style("a#b\"c", false), "ABC");
    }

    #[test]
    fn escapes_strings() {
        assert_eq!(crystal_string_escape("a#b\"c"), "a\\u{0023}b\\\"c");
        assert_eq!(crystal_string_escape("\u{1F600}"), "\\u{01f600}");
    }
}
