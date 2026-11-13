//! Port of `packages/quicktype-core/src/language/JSONSchema/utils.ts`.
//!
//! The namer of definition names.

use crate::naming::{Namer, fun_prefix_namer};
use crate::support::strings::{
    all_upper_word_style, combine_words, first_upper_word_style, legalize_characters,
    split_into_words,
};

/// `namingFunction`: `funPrefixNamer("namer", jsonNameStyle)`.
pub fn naming_function() -> Namer {
    fun_prefix_namer("namer", json_name_style)
}

/// `legalizeName`: printable ASCII except `/` (which would break a
/// `#/definitions/...` reference).
fn legalize_name(s: &str) -> String {
    legalize_characters(s, |cp| (32..128).contains(&cp) && cp != 0x2f)
}

/// `jsonNameStyle(original)`: `FirstUpper` words, acronyms all upper case,
/// no separator, any first character.
pub fn json_name_style(original: &str) -> String {
    let words = split_into_words(original);
    combine_words(
        &words,
        &legalize_name,
        &first_upper_word_style,
        &first_upper_word_style,
        &all_upper_word_style,
        &all_upper_word_style,
        "",
        &|_| true,
    )
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn definition_names_keep_printable_ascii() {
        assert_eq!(json_name_style("top_level"), "TopLevel");
        assert_eq!(json_name_style("a/b"), "AB");
        assert_eq!(json_name_style("1st"), "1St");
        assert_eq!(json_name_style("json-url"), "JSONURL");
    }
}
