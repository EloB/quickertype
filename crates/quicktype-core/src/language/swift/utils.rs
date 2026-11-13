//! Port of `packages/quicktype-core/src/language/Swift/utils.ts`.
//!
//! The [`SwiftDateTimeRecognizer`] that JSON inference uses, Swift
//! identifier styling and string escaping.

use crate::date_time::{Cursor, DateTimeRecognizer, default_is_date, default_is_time};
use crate::naming::Name;
use crate::renderer::ForEachPosition;
use crate::support::strings::{
    add_prefix_if_necessary, all_lower_word_style, combine_words, escape_non_printable_mapper,
    first_upper_word_style, int_to_hex, is_digit, is_letter_or_underscore, is_numeric,
    is_printable, legalize_characters, split_into_words, utf32_concat_map,
};
use crate::ty::ty::ClassProperty;

/// `MAX_SAMELINE_PROPERTIES`: how many properties of the same type a dense
/// class declares on one line.
pub const MAX_SAMELINE_PROPERTIES: usize = 4;

/// `SwiftDateTimeRecognizer`: the default dates and times, but every
/// date-time Swift's ISO 8601 decoder accepts (no range checks):
/// `/^\d+-\d+-\d+T\d+:\d+:\d+(?:\.\d+)?([zZ]|[+-]\d+(:\d+)?)$/`.
#[derive(Clone, Copy, Debug, Default)]
pub struct SwiftDateTimeRecognizer;

impl DateTimeRecognizer for SwiftDateTimeRecognizer {
    fn is_date(&self, s: &str) -> bool {
        default_is_date(s)
    }

    fn is_time(&self, s: &str) -> bool {
        default_is_time(s)
    }

    fn is_date_time(&self, s: &str) -> bool {
        is_swift_date_time(s).is_some()
    }
}

/// `SwiftProperty`: a property as `initializableProperties` collects it.
#[derive(Clone, Debug)]
pub struct SwiftProperty {
    /// `jsonName`.
    pub json_name: String,
    /// `name`.
    pub name: Name,
    /// `parameter`.
    pub parameter: ClassProperty,
    /// `position`.
    pub position: ForEachPosition,
}

/// `isPartCharacter(codePoint)`: a letter, `_` or a numeric character.
fn is_part_character(code_point: u32) -> bool {
    is_letter_or_underscore(code_point) || is_numeric(code_point)
}

/// `isStartCharacter(codePoint)`: a part character other than a digit.
fn is_start_character(code_point: u32) -> bool {
    is_part_character(code_point) && !is_digit(code_point)
}

/// `legalizeName`: keeps the code points that are part characters.
fn legalize_name(s: &str) -> String {
    legalize_characters(s, is_part_character)
}

/// `swiftNameStyle(prefix, isUpper, original, acronymsStyle)`: `PascalCase`
/// (with `prefix`, unless the name already starts with it) or `camelCase`,
/// with `acronyms_style` for acronyms (TypeScript's default is
/// `allUpperWordStyle`).
pub fn swift_name_style(
    prefix: &str,
    is_upper: bool,
    original: &str,
    acronyms_style: fn(&str) -> String,
) -> String {
    let words = split_into_words(original);
    let first_word_style: fn(&str) -> String = if is_upper {
        first_upper_word_style
    } else {
        all_lower_word_style
    };
    let first_word_acronym_style: fn(&str) -> String = if is_upper {
        acronyms_style
    } else {
        all_lower_word_style
    };
    let combined = combine_words(
        &words,
        &legalize_name,
        &first_word_style,
        &first_upper_word_style,
        &first_word_acronym_style,
        &acronyms_style,
        "",
        &is_start_character,
    );
    add_prefix_if_necessary(prefix, &combined)
}

/// `unicodeEscape(codePoint)`: `\u{X}`, in lower-case hexadecimal without
/// padding.
fn unicode_escape(code_point: u32) -> String {
    format!("\\u{{{}}}", int_to_hex(code_point, 0))
}

/// `stringEscape(s)`: escapes per code point, so an astral character
/// becomes one `\u{...}` escape.
pub fn string_escape(s: &str) -> String {
    utf32_concat_map(s, escape_non_printable_mapper(is_printable, unicode_escape))
}

fn is_swift_date_time(s: &str) -> Option<()> {
    let mut c = Cursor::new(s);
    c.digit_text()?;
    c.byte(b'-')?;
    c.digit_text()?;
    c.byte(b'-')?;
    c.digit_text()?;
    c.byte(b'T')?;
    c.digit_text()?;
    c.byte(b':')?;
    c.digit_text()?;
    c.byte(b':')?;
    c.digit_text()?;
    if c.byte(b'.').is_some() {
        c.digit_text()?;
    }
    if c.one_of(b"zZ").is_none() {
        c.one_of(b"+-")?;
        c.digit_text()?;
        if c.byte(b':').is_some() {
            c.digit_text()?;
        }
    }
    c.end()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn swift_date_times() {
        let r = SwiftDateTimeRecognizer;
        for s in [
            "2018-08-14T02:45:50+00:00",
            "2018-08-14T02:45:50+00",
            "2018-08-14T02:45:50+1",
            "2018-08-14T02:45:50+1111",
            "2018-08-14T02:45:50-00",
            "2018-08-14T02:45:50z",
            "2018-00008-1T002:45:3Z",
            "2018-8-1T2:45:50.5+1",
        ] {
            assert!(r.is_date_time(s), "{s}");
        }
        for s in [
            "2018-08-14T02:45:50+1111:1:33",
            "2018-08-14t02:45:50Z",
            "2018-08-14T02:45:50",
            "2018-08-14T02:45:50.Z",
            "2018-08-14T02:45:50+",
            "2018-08-14T02:45:50+1:",
            "-08-14T02:45:50Z",
        ] {
            assert!(!r.is_date_time(s), "{s}");
        }
        assert!(r.is_date("2018-08-14") && !r.is_date("2018-8-14"));
        assert!(r.is_time("02:45:50Z"));
    }

    #[test]
    fn swift_names_and_escapes() {
        use crate::support::strings::all_upper_word_style;
        assert_eq!(
            swift_name_style("", true, "user_url", all_upper_word_style),
            "UserURL"
        );
        assert_eq!(
            swift_name_style("", false, "URL value", all_upper_word_style),
            "urlValue"
        );
        assert_eq!(
            swift_name_style("QT", true, "QTThing", all_upper_word_style),
            "QTThing"
        );
        assert_eq!(
            swift_name_style("", false, "1st", all_upper_word_style),
            "the1St"
        );
        assert_eq!(
            string_escape("a\"b\u{1}\u{1F600}"),
            "a\\\"b\\u{1}\\u{1f600}"
        );
    }
}
