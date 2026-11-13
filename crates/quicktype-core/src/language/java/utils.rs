//! Port of `packages/quicktype-core/src/language/Java/utils.ts`.
//!
//! Java identifier styling and string-literal escaping.

use crate::support::strings::{
    all_lower_word_style, all_upper_word_style, combine_words, escape_non_printable_mapper,
    first_upper_word_style, is_ascii, is_digit, is_letter, split_into_words,
    standard_unicode_hex_escape, utf16_concat_map, utf16_legalize_characters,
};

/// `stringEscape`: escapes per UTF-16 code unit, keeping printable ASCII and
/// writing everything else as `\uXXXX` (an astral character becomes two
/// escapes).
pub fn string_escape(s: &str) -> String {
    utf16_concat_map(
        s,
        escape_non_printable_mapper(is_ascii, standard_unicode_hex_escape),
    )
}

/// `isStartCharacter(codePoint)`: `_` or an ASCII letter.
fn is_start_character(code_point: u32) -> bool {
    if code_point == 0x5F {
        return true; // underscore
    }
    is_ascii(code_point) && is_letter(code_point)
}

/// `isPartCharacter(codePoint)`: a start character or an ASCII digit.
fn is_part_character(code_point: u32) -> bool {
    is_start_character(code_point) || (is_ascii(code_point) && is_digit(code_point))
}

/// `legalizeName`: keeps the UTF-16 code units that are part characters.
fn legalize_name(s: &str) -> String {
    utf16_legalize_characters(s, is_part_character)
}

/// `javaNameStyle(startWithUpper, upperUnderscore, original,
/// acronymsStyle)`: `PascalCase` (types), `camelCase` (properties) or
/// `UPPER_UNDERSCORE` (enum constants, whose acronyms are always upper
/// case, e.g. `XXX_SPA_XXX`).
pub fn java_name_style(
    start_with_upper: bool,
    upper_underscore: bool,
    original: &str,
    acronyms_style: fn(&str) -> String,
) -> String {
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
    let first_word_acronym_style: fn(&str) -> String = if upper_underscore || start_with_upper {
        all_upper_word_style
    } else {
        all_lower_word_style
    };
    // For UPPER_UNDERSCORE style (Java enum constants), always use
    // allUpperWordStyle for acronyms to maintain consistency with the naming
    // convention (e.g., XXX_SPA_XXX)
    let rest_acronym_style: fn(&str) -> String = if upper_underscore {
        all_upper_word_style
    } else {
        acronyms_style
    };
    combine_words(
        &words,
        &legalize_name,
        &first_word_style,
        &rest_word_style,
        &first_word_acronym_style,
        &rest_acronym_style,
        if upper_underscore { "_" } else { "" },
        &is_start_character,
    )
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::support::acronyms::{AcronymStyleOptions, acronym_style};

    #[test]
    fn name_styles() {
        let pascal = acronym_style(AcronymStyleOptions::Pascal);
        assert_eq!(
            java_name_style(true, false, "top_level", pascal),
            "TopLevel"
        );
        assert_eq!(java_name_style(false, false, "user_id", pascal), "userID");
        assert_eq!(
            java_name_style(true, true, "xxx-spa-xxx", pascal),
            "XXX_SPA_XXX"
        );
        assert_eq!(java_name_style(false, false, "1st", pascal), "the1St");
        assert_eq!(java_name_style(true, false, "", pascal), "Empty");
    }

    #[test]
    fn escapes_per_utf16_unit() {
        assert_eq!(string_escape("a\"b\\c\n"), "a\\\"b\\\\c\\n");
        assert_eq!(string_escape("é"), "\\u00e9");
        assert_eq!(string_escape("😀"), "\\ud83d\\ude00");
    }
}
