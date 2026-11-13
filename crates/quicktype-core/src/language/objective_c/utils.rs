//! Port of `packages/quicktype-core/src/language/Objective-C/utils.ts`.
//!
//! Objective-C type and property name styles, the enum-case words that are
//! forbidden, and `splitExtension`.

use quicktype_js_compat::unicode::{self, GeneralCategory};

use crate::support::strings::{
    WordInName, add_prefix_if_necessary, all_lower_word_style, all_upper_word_style, combine_words,
    first_upper_word_style, split_into_words, utf16_legalize_characters,
};

use super::constants::{BOOLEAN_PREFIXES, FORBIDDEN_PROPERTY_NAMES};

/// `DEFAULT_CLASS_PREFIX`.
pub const DEFAULT_CLASS_PREFIX: &str = "QT";

/// `typeNameStyle(prefix, original)`: PascalCase with upper-case acronyms,
/// prefixed with `prefix` unless the name already starts with it.
pub fn type_name_style(prefix: &str, original: &str) -> String {
    let words = split_into_words(original);
    let result = combine_words(
        &words,
        &legalize_name,
        &first_upper_word_style,
        &first_upper_word_style,
        &all_upper_word_style,
        &all_upper_word_style,
        "",
        &is_start_character,
    );
    add_prefix_if_necessary(prefix, &result)
}

/// `propertyNameStyle(original, isBool)`: camelCase; `id` becomes
/// `identifier`, a boolean gets an `is` prefix unless it starts with an
/// acronym or a boolean prefix, and a name that starts with a forbidden
/// property name gets a `the` prefix.
pub fn property_name_style(original: &str, is_bool: bool) -> String {
    // Objective-C developers are uncomfortable with property "id"
    // so we use an alternate name in this special case.
    let original = if original == "id" {
        "identifier"
    } else {
        original
    };

    let mut words = split_into_words(original);

    let word = |w: &str| WordInName {
        word: w.to_owned(),
        is_acronym: false,
    };

    if is_bool {
        match words.first() {
            None => words = vec![word("flag")],
            Some(first)
                if !first.is_acronym && !BOOLEAN_PREFIXES.contains(&first.word.as_str()) =>
            {
                words.insert(0, word("is"));
            }
            Some(_) => {}
        }
    }

    // Properties cannot even begin with any of the forbidden names
    // For example, properies named new* are treated differently by ARC
    if words
        .first()
        .is_some_and(|first| FORBIDDEN_PROPERTY_NAMES.contains(&first.word.as_str()))
    {
        words.insert(0, word("the"));
    }

    combine_words(
        &words,
        &legalize_name,
        &all_lower_word_style,
        &first_upper_word_style,
        &all_lower_word_style,
        &all_upper_word_style,
        "",
        &is_start_character,
    )
}

/// `isStartCharacter(utf16Unit)`: alphabetic or `_`.
fn is_start_character(utf16_unit: u32) -> bool {
    unicode::is_alphabetic(utf16_unit) || utf16_unit == 0x5f // underscore
}

/// `isPartCharacter(utf16Unit)`: a start character, a decimal digit, a
/// connector punctuation or a (spacing) combining mark.
fn is_part_character(utf16_unit: u32) -> bool {
    matches!(
        unicode::get_category(utf16_unit),
        GeneralCategory::Nd | GeneralCategory::Pc | GeneralCategory::Mn | GeneralCategory::Mc
    ) || is_start_character(utf16_unit)
}

/// `legalizeName`: keeps the UTF-16 units that are part characters.
fn legalize_name(s: &str) -> String {
    utf16_legalize_characters(s, is_part_character)
}

/// `staticEnumValuesIdentifier`.
pub const STATIC_ENUM_VALUES_IDENTIFIER: &str = "values";

/// `forbiddenForEnumCases`.
pub const FORBIDDEN_FOR_ENUM_CASES: [&str; 2] = ["new", STATIC_ENUM_VALUES_IDENTIFIER];

/// `splitExtension(filename)`: the file name without its last extension,
/// and that extension (`"m"` if there is no dot).
pub fn split_extension(filename: &str) -> (String, String) {
    match filename.rfind('.') {
        Some(i) => (filename[..i].to_owned(), filename[i + 1..].to_owned()),
        None => (filename.to_owned(), "m".to_owned()),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn objective_c_names() {
        assert_eq!(type_name_style("QT", "user url"), "QTUserURL");
        assert_eq!(type_name_style("QT", "QTThing"), "QTThing");
        assert_eq!(property_name_style("id", false), "identifier");
        assert_eq!(property_name_style("active", true), "isActive");
        assert_eq!(property_name_style("has_value", true), "hasValue");
        assert_eq!(property_name_style("", true), "flag");
        assert_eq!(property_name_style("new_thing", false), "theNewThing");
        assert_eq!(property_name_style("description", false), "theDescription");
    }

    #[test]
    fn split_extensions() {
        assert_eq!(split_extension("a/b.c.m"), ("a/b.c".into(), "m".into()));
        assert_eq!(split_extension("Top"), ("Top".into(), "m".into()));
        assert_eq!(split_extension("Top."), ("Top".into(), String::new()));
    }
}
