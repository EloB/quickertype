//! Port of `packages/quicktype-core/src/language/Haskell/utils.ts`.
//!
//! Haskell identifier styling.

use crate::naming::{Namer, fun_prefix_namer};
use crate::support::strings::{
    all_lower_word_style, all_upper_word_style, combine_words, first_upper_word_style, is_ascii,
    is_letter_or_underscore, is_letter_or_underscore_or_digit, legalize_characters,
    split_into_words,
};

/// `legalizeName`: keeps ASCII letters, digits and underscores.
fn legalize_name(s: &str) -> String {
    legalize_characters(s, |cp| is_ascii(cp) && is_letter_or_underscore_or_digit(cp))
}

/// `haskellNameStyle(original, upper)`: PascalCase for `upper`, camelCase
/// otherwise.
pub fn haskell_name_style(original: &str, upper: bool) -> String {
    let words = split_into_words(original);
    combine_words(
        &words,
        &legalize_name,
        if upper {
            &first_upper_word_style
        } else {
            &all_lower_word_style
        },
        &first_upper_word_style,
        if upper {
            &all_upper_word_style
        } else {
            &all_lower_word_style
        },
        &all_upper_word_style,
        "",
        &is_letter_or_underscore,
    )
}

/// `upperNamingFunction`: a new namer for PascalCase names (types, enum
/// cases, union members).
///
/// In TypeScript this is a module-level object; the renderer creates it
/// once and clones it, so that every use shares one naming group.
pub fn upper_naming_function() -> Namer {
    fun_prefix_namer("upper", |n| haskell_name_style(n, true))
}

/// `lowerNamingFunction`: a new namer for camelCase names (properties).
/// See [`upper_naming_function`].
pub fn lower_naming_function() -> Namer {
    fun_prefix_namer("lower", |n| haskell_name_style(n, false))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn styles_names() {
        assert_eq!(haskell_name_style("foo bar", true), "FooBar");
        assert_eq!(haskell_name_style("foo bar", false), "fooBar");
        assert_eq!(haskell_name_style("1st", true), "The1St");
        assert_eq!(haskell_name_style("", false), "empty");
        assert_eq!(haskell_name_style("héllo", true), "Hllo");
    }
}
