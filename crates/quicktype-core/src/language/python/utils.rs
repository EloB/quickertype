//! Port of `packages/quicktype-core/src/language/Python/utils.ts`.
//!
//! Python 3 identifier styling. A character is legal if its NFKC form is
//! (`isStartCharacter3`/`isPartCharacter3`); JavaScript's `normalize` is
//! not available here, so the answers for every UTF-16 code unit come from
//! a table that `xtask/js-compat/gen-python-identifiers.mjs` generates with
//! Node and `unicode-properties`.

use super::identifier_table::IDENTIFIER_RUNS;
use crate::support::strings::{
    all_lower_word_style, all_upper_word_style, combine_words, first_upper_word_style,
    original_word, split_into_words, utf16_legalize_characters,
};

/// The flags of `IDENTIFIER_RUNS` for `String.fromCharCode(value)`, which
/// keeps the low 16 bits of `value` (ToUint16).
fn identifier_flags(value: u32) -> u8 {
    let unit = (value & 0xFFFF) as u16;
    let index = IDENTIFIER_RUNS.partition_point(|&(start, _)| start <= unit);
    // The first run starts at 0, so `index` is at least 1.
    IDENTIFIER_RUNS
        .get(index.wrapping_sub(1))
        .map_or(0, |&(_, flags)| flags)
}

/// `isStartCharacter3(utf16Unit)`: the NFKC form starts with a letter (or
/// letter number) and continues with identifier characters. Also called
/// with a code point, which `String.fromCharCode` truncates.
fn is_start_character3(utf16_unit: u32) -> bool {
    identifier_flags(utf16_unit) & 1 != 0
}

/// `isPartCharacter3(utf16Unit)`: every unit of the NFKC form is an
/// identifier character.
fn is_part_character3(utf16_unit: u32) -> bool {
    identifier_flags(utf16_unit) & 2 != 0
}

/// `legalizeName3`.
fn legalize_name3(s: &str) -> String {
    utf16_legalize_characters(s, is_part_character3)
}

/// `classNameStyle(original)`: `PascalCase`.
pub fn class_name_style(original: &str) -> String {
    let words = split_into_words(original);
    combine_words(
        &words,
        &legalize_name3,
        &first_upper_word_style,
        &first_upper_word_style,
        &all_upper_word_style,
        &all_upper_word_style,
        "",
        &is_start_character3,
    )
}

/// `getWordStyle(uppercase, forceSnakeNameStyle)`.
fn get_word_style(uppercase: bool, force_snake_name_style: bool) -> fn(&str) -> String {
    if !force_snake_name_style {
        return original_word;
    }

    if uppercase {
        all_upper_word_style
    } else {
        all_lower_word_style
    }
}

/// `snakeNameStyle(original, uppercase, forceSnakeNameStyle)`:
/// `snake_case` (or `UPPER_SNAKE`), or the words as they are without
/// `nice-property-names`.
pub fn snake_name_style(original: &str, uppercase: bool, force_snake_name_style: bool) -> String {
    let word_style = get_word_style(uppercase, force_snake_name_style);
    let separator = if force_snake_name_style { "_" } else { "" };
    let words = split_into_words(original);
    combine_words(
        &words,
        &legalize_name3,
        &word_style,
        &word_style,
        &word_style,
        &word_style,
        separator,
        &is_start_character3,
    )
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn identifier_characters_follow_their_nfkc_form() {
        // Letters and digits as such.
        assert!(is_start_character3(u32::from('a')));
        assert!(is_part_character3(u32::from('7')));
        assert!(!is_start_character3(u32::from('7')));
        assert!(is_part_character3(u32::from('_')));
        assert!(!is_start_character3(u32::from('_')));
        assert!(!is_part_character3(u32::from('-')));
        // U+FB01 LATIN SMALL LIGATURE FI is "fi" in NFKC.
        assert!(is_start_character3(0xFB01));
        // U+2460 CIRCLED DIGIT ONE and U+00B2 SUPERSCRIPT TWO are digits.
        assert!(is_part_character3(0x2460));
        assert!(!is_start_character3(0x2460));
        assert!(is_part_character3(0x00B2));
        // A lone surrogate is neither.
        assert!(!is_part_character3(0xD800));
        // `String.fromCharCode` keeps the low 16 bits of a code point:
        // U+10061 is looked up as U+0061.
        assert!(is_start_character3(0x10061));
    }

    #[test]
    fn names_are_styled_like_typescript() {
        assert_eq!(class_name_style("hello world"), "HelloWorld");
        assert_eq!(snake_name_style("helloWorld", false, true), "hello_world");
        assert_eq!(snake_name_style("helloWorld", true, true), "HELLO_WORLD");
        assert_eq!(snake_name_style("helloWorld", false, false), "helloWorld");
        assert_eq!(class_name_style("ﬁle"), "FIle");
        assert_eq!(class_name_style("①abc"), "Abc");
        assert_eq!(snake_name_style("²x", false, true), "x");
    }
}
