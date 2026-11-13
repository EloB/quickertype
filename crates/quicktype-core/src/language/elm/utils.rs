//! Port of `packages/quicktype-core/src/language/Elm/utils.ts`.

use crate::naming::{Namer, fun_prefix_namer};
use crate::support::strings::{
    WordStyle, all_lower_word_style, all_upper_word_style, combine_words,
    escape_non_printable_mapper, first_upper_word_style, int_to_hex, is_ascii, is_letter,
    is_letter_or_underscore_or_digit, is_printable, legalize_characters, split_into_words,
    utf32_concat_map,
};
use crate::ty::ty::ClassProperty;

/// `legalizeName`: keeps ASCII letters, digits and underscores.
fn legalize_name(s: &str) -> String {
    legalize_characters(s, |cp| is_ascii(cp) && is_letter_or_underscore_or_digit(cp))
}

/// `elmNameStyle(original, upper)`.
fn elm_name_style(original: &str, upper: bool) -> String {
    let words = split_into_words(original);
    let first_word_style: WordStyle<'_> = if upper {
        &first_upper_word_style
    } else {
        &all_lower_word_style
    };
    let first_word_acronym_style: WordStyle<'_> = if upper {
        &all_upper_word_style
    } else {
        &all_lower_word_style
    };
    combine_words(
        &words,
        &legalize_name,
        first_word_style,
        &first_upper_word_style,
        first_word_acronym_style,
        &all_upper_word_style,
        "",
        // Elm identifiers must not start with an underscore.
        &is_letter,
    )
}

/// `unicodeEscape(codePoint)`: `\u{XXXX}`.
fn unicode_escape(code_point: u32) -> String {
    format!("\\u{{{}}}", int_to_hex(code_point, 4).to_uppercase())
}

/// `elmStringEscape`: escapes per code point.
pub fn elm_string_escape(s: &str) -> String {
    utf32_concat_map(s, escape_non_printable_mapper(is_printable, unicode_escape))
}

/// `upperNamingFunction` (a module-level singleton in TypeScript).
pub fn upper_naming_function() -> Namer {
    fun_prefix_namer("upper", |n| elm_name_style(n, true))
}

/// `lowerNamingFunction` (a module-level singleton in TypeScript).
pub fn lower_naming_function() -> Namer {
    fun_prefix_namer("lower", |n| elm_name_style(n, false))
}

/// `RequiredOrOptional`: how the pipeline decodes a property.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct RequiredOrOptional {
    /// `fallback`: the default of an optional property.
    pub fallback: &'static str,
    /// `reqOrOpt`: the `Jpipe` function.
    pub req_or_opt: &'static str,
}

/// `requiredOrOptional(p)`.
pub fn required_or_optional(p: &ClassProperty) -> RequiredOrOptional {
    if p.is_optional {
        return RequiredOrOptional {
            req_or_opt: "Jpipe.optional",
            fallback: " Nothing",
        };
    }

    RequiredOrOptional {
        req_or_opt: "Jpipe.required",
        fallback: "",
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn escapes_like_elm() {
        assert_eq!(elm_string_escape("a\"b\\c\n"), "a\\\"b\\\\c\\n");
        assert_eq!(elm_string_escape("\u{7}"), "\\u{0007}");
        assert_eq!(elm_string_escape("😀"), "\\u{1F600}");
    }

    #[test]
    fn names() {
        let upper = upper_naming_function();
        assert_eq!(upper.name_style("_foo bar"), "FooBar");
        let lower = lower_naming_function();
        assert_eq!(lower.name_style("URL value"), "urlValue");
    }
}
