//! Port of `packages/quicktype-core/src/language/Dart/utils.ts`.
//!
//! Dart identifier styling and string escaping.

use crate::naming::{Namer, fun_prefix_namer};
use crate::support::strings::{
    all_lower_word_style, all_upper_word_style, combine_words, escape_non_printable_mapper,
    first_upper_word_style, is_ascii, is_digit, is_letter, is_printable, split_into_words,
    standard_unicode_hex_escape, utf16_concat_map, utf16_legalize_characters,
};

/// `typeNamingFunction` (a module-level singleton in TypeScript: create it
/// once per renderer, so that every type name shares it).
pub fn type_naming_function() -> Namer {
    fun_prefix_namer("types", |n| dart_name_style(true, false, n))
}

/// `propertyNamingFunction` (a module-level singleton in TypeScript).
pub fn property_naming_function() -> Namer {
    fun_prefix_namer("properties", |n| dart_name_style(false, false, n))
}

/// `enumCaseNamingFunction` (a module-level singleton in TypeScript).
pub fn enum_case_naming_function() -> Namer {
    fun_prefix_namer("enum-cases", |n| dart_name_style(true, true, n))
}

/// `stringEscape(s)`: escapes per UTF-16 code unit, and escapes the dollar
/// sign, which is used in string interpolation.
pub fn string_escape(s: &str) -> String {
    utf16_concat_map(
        s,
        escape_non_printable_mapper(
            |cp| is_printable(cp) && cp != 0x24,
            standard_unicode_hex_escape,
        ),
    )
}

/// `isStartCharacter(codePoint)`: an ASCII letter.
fn is_start_character(code_point: u32) -> bool {
    if code_point == 0x5f {
        return false; // underscore
    }
    is_ascii(code_point) && is_letter(code_point)
}

/// `isPartCharacter(codePoint)`: an ASCII letter or digit.
fn is_part_character(code_point: u32) -> bool {
    is_start_character(code_point) || (is_ascii(code_point) && is_digit(code_point))
}

/// `legalizeName`: keeps the UTF-16 units that are part characters.
fn legalize_name(s: &str) -> String {
    utf16_legalize_characters(s, is_part_character)
}

// FIXME: Handle acronyms consistently.  In particular, that means that
// we have to use namers to produce the getter and setter names - we can't
// just capitalize and concatenate.
// https://stackoverflow.com/questions/8277355/naming-convention-for-upper-case-abbreviations
/// `dartNameStyle(startWithUpper, upperUnderscore, original)`: PascalCase,
/// camelCase or `UPPER_UNDERSCORE`.
pub fn dart_name_style(start_with_upper: bool, upper_underscore: bool, original: &str) -> String {
    let words = split_into_words(original);
    let first_word_style: fn(&str) -> String = if upper_underscore {
        all_upper_word_style
    } else if start_with_upper {
        first_upper_word_style
    } else {
        all_lower_word_style
    };
    let rest_word_style: fn(&str) -> String = if upper_underscore {
        all_upper_word_style
    } else {
        first_upper_word_style
    };
    combine_words(
        &words,
        &legalize_name,
        &first_word_style,
        &rest_word_style,
        &first_word_style,
        &rest_word_style,
        if upper_underscore { "_" } else { "" },
        &is_start_character,
    )
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn dart_names_and_escapes() {
        assert_eq!(dart_name_style(true, false, "user_url"), "UserUrl");
        assert_eq!(dart_name_style(false, false, "User URL"), "userUrl");
        assert_eq!(dart_name_style(true, true, "first-kind"), "FIRST_KIND");
        assert_eq!(dart_name_style(false, false, "_x"), "x");
        assert_eq!(dart_name_style(false, false, "1st"), "the1St");
        assert_eq!(
            string_escape("a$b\"\u{1F600}"),
            "a\\u0024b\\\"\\ud83d\\ude00"
        );
    }
}
