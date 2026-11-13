//! Port of `packages/quicktype-core/src/language/Pike/utils.ts`.
//!
//! Pike's namers: ASCII letters, digits and underscores only.

use crate::naming::{Namer, fun_prefix_namer};
use crate::support::strings::{
    NamingStyle, is_ascii, is_letter_or_underscore_or_digit, legalize_characters, make_name_style,
};

/// `legalizeName`: drops everything but ASCII letters, digits and
/// underscores.
fn legalize_name(s: &str) -> String {
    legalize_characters(s, |cp| is_ascii(cp) && is_letter_or_underscore_or_digit(cp))
}

/// `enumNamingFunction`: `UPPER_UNDERSCORE` enum cases.
pub fn enum_naming_function() -> Namer {
    fun_prefix_namer(
        "enumNamer",
        make_name_style(NamingStyle::UpperUnderscore, legalize_name, None),
    )
}

/// `namingFunction`: `lower_underscore` properties and union members.
pub fn naming_function() -> Namer {
    fun_prefix_namer(
        "genericNamer",
        make_name_style(NamingStyle::Underscore, legalize_name, None),
    )
}

/// `namedTypeNamingFunction`: `PascalCase` types.
pub fn named_type_naming_function() -> Namer {
    fun_prefix_namer(
        "typeNamer",
        make_name_style(NamingStyle::Pascal, legalize_name, None),
    )
}
