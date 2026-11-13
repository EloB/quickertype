//! Port of `packages/quicktype-core/src/language/Smithy4s/utils.ts`.
//!
//! Smithy identifier styling and backtick quoting.

use quicktype_js_compat::whitespace;

use crate::naming::{Namer, fun_prefix_namer};
use crate::support::strings::{
    all_lower_word_style, all_upper_word_style, combine_words, first_upper_word_style, is_digit,
    is_letter_or_underscore, is_numeric, legalize_characters, split_into_words,
};

use super::constants::{INVALID_SYMBOLS, KEYWORDS};

/// `!Number.isNaN(Number.parseFloat(s))`: whether `s` starts, after
/// leading whitespace, with a decimal number or `Infinity` (optionally
/// signed).
fn parse_float_is_number(s: &str) -> bool {
    let t = whitespace::trim_start(s);
    let t = t.strip_prefix(['+', '-']).unwrap_or(t);
    t.starts_with("Infinity")
        || t.starts_with(|c: char| c.is_ascii_digit())
        || t.strip_prefix('.')
            .is_some_and(|rest| rest.starts_with(|c: char| c.is_ascii_digit()))
}

/// `shouldAddBacktick(paramName)`: whether a name is a keyword, contains an
/// invalid symbol or starts like a number.
pub fn should_add_backtick(param_name: &str) -> bool {
    KEYWORDS.contains(&param_name)
        || INVALID_SYMBOLS.iter().any(|s| param_name.contains(s))
        || parse_float_is_number(param_name)
        // `!Number.isNaN(Number.parseInt(paramName.charAt(0), 10))`
        || param_name.starts_with(|c: char| c.is_ascii_digit())
}

fn is_part_character(code_point: u32) -> bool {
    is_letter_or_underscore(code_point) || is_numeric(code_point)
}

fn is_start_character(code_point: u32) -> bool {
    is_part_character(code_point) && !is_digit(code_point)
}

fn legalize_name(s: &str) -> String {
    legalize_characters(s, is_part_character)
}

/// `scalaNameStyle(isUpper, original)`: PascalCase or camelCase.
pub fn scala_name_style(is_upper: bool, original: &str) -> String {
    let words = split_into_words(original);
    combine_words(
        &words,
        &legalize_name,
        if is_upper {
            &first_upper_word_style
        } else {
            &all_lower_word_style
        },
        &first_upper_word_style,
        if is_upper {
            &all_upper_word_style
        } else {
            &all_lower_word_style
        },
        &all_upper_word_style,
        "",
        &is_start_character,
    )
}

/// `upperNamingFunction`: a new namer for type names.
///
/// In TypeScript this is a module-level object; the renderer creates it
/// once and clones it, so that every use shares one naming group.
pub fn upper_naming_function() -> Namer {
    fun_prefix_namer("upper", |s| scala_name_style(true, s))
}

/// `lowerNamingFunction`: a new namer for property names. See
/// [`upper_naming_function`].
pub fn lower_naming_function() -> Namer {
    fun_prefix_namer("lower", |s| scala_name_style(false, s))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn backticks_like_typescript() {
        assert!(should_add_backtick("case"));
        assert!(should_add_backtick("a:b"));
        assert!(should_add_backtick("1a"));
        assert!(should_add_backtick("\t+Infinity"));
        assert!(!should_add_backtick("a?b"));
        assert!(!should_add_backtick("a$b"));
        assert!(!should_add_backtick("type"));
    }
}
