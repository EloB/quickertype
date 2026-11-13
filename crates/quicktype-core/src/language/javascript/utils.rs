//! Port of `packages/quicktype-core/src/language/JavaScript/utils.ts`.

use crate::support::strings::utf16_legalize_characters;

use super::unicode_maps::is_es3_identifier_part;

/// `legalizeName`: drops every UTF-16 code unit that cannot continue an ES3
/// identifier.
pub fn legalize_name(s: &str) -> String {
    utf16_legalize_characters(s, is_es3_identifier_part)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn drops_illegal_units() {
        assert_eq!(legalize_name("a-b c$1"), "abc$1");
        // Both surrogates of an astral character are dropped.
        assert_eq!(legalize_name("x😀y"), "xy");
    }
}
