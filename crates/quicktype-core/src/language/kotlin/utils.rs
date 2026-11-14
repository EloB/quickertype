//! Port of `packages/quicktype-core/src/language/Kotlin/utils.ts`.
//!
//! Kotlin identifier styling and string escaping, the
//! [`KotlinDateTimeRecognizer`] that JSON inference uses, and the order in
//! which unions try their members.

use crate::date_time::{Cursor, DateTimeRecognizer, default_is_date, parse_date};
use crate::support::strings::{
    all_lower_word_style, all_upper_word_style, combine_words, escape_non_printable_mapper,
    first_upper_word_style, int_to_hex, is_digit, is_letter_or_underscore, is_numeric,
    is_printable, legalize_characters, split_into_words, utf16_concat_map,
};
use crate::ty::transformed_string_type::TypeKind;

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

/// `kotlinNameStyle(isUpper, original, acronymsStyle)`: `PascalCase` or
/// `camelCase`, with `acronyms_style` for acronyms after the first word
/// (TypeScript's default is `allUpperWordStyle`).
pub fn kotlin_name_style(
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
        all_upper_word_style
    } else {
        all_lower_word_style
    };
    combine_words(
        &words,
        &legalize_name,
        &first_word_style,
        &first_upper_word_style,
        &first_word_acronym_style,
        &acronyms_style,
        "",
        &is_start_character,
    )
}

/// `unicodeEscape(codePoint)`: `\uXXXX`.
fn unicode_escape(code_point: u32) -> String {
    format!("\\u{}", int_to_hex(code_point, 4))
}

/// `stringEscape(s)`: escapes per UTF-16 code unit, and escapes `$`
/// because `"$this"` is a template string in Kotlin.
pub fn string_escape(s: &str) -> String {
    utf16_concat_map(s, escape_non_printable_mapper(is_printable, unicode_escape))
        .replace('$', "\\$")
}

/// `unionMemberMatchPriority(t)`: when several union members are guarded
/// by the same JSON node/value type (e.g. date, time and enum values are
/// all strings), parse attempts must be ordered strictest first:
/// transformed string types (strict ISO parsers), then enums (known values
/// only), then plain strings (accept anything).
pub fn union_member_match_priority(kind: TypeKind) -> u32 {
    match kind {
        TypeKind::DateTime | TypeKind::Date | TypeKind::Time => 0,
        TypeKind::Enum => 1,
        TypeKind::String => 2,
        _ => 3,
    }
}

/// `isLeapYear(year)`.
fn is_leap_year(year: u32) -> bool {
    year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)
}

/// `KotlinDateTimeRecognizer`: only the dates, times and date-times that
/// java.time's ISO formatters (which the generated code round-trips
/// through) reproduce byte for byte:
///
/// - fractional seconds must not end in `0` and have at most 9 digits;
/// - the offset must be `Z` or a non-zero `±hh:mm` within ±18:00;
/// - `T` and `Z` must be uppercase;
/// - February 29 only exists in leap years.
#[derive(Clone, Copy, Debug, Default)]
pub struct KotlinDateTimeRecognizer;

impl DateTimeRecognizer for KotlinDateTimeRecognizer {
    fn is_date(&self, s: &str) -> bool {
        if !default_is_date(s) {
            return false;
        }
        match parse_date(s) {
            Some([year, month, day]) => month != 2 || day != 29 || is_leap_year(year),
            None => false,
        }
    }

    /// `KOTLIN_TIME` =
    /// `/^(\d\d):(\d\d):(\d\d)(?:\.(\d{1,9}))?(Z|[+-]\d\d:\d\d)$/`.
    fn is_time(&self, s: &str) -> bool {
        let mut c = Cursor::new(s);
        let Some([hour, minute, second]) = c.hh_mm_ss() else {
            return false;
        };
        let mut fraction = None;
        if c.byte(b'.').is_some() {
            match c.digit_text() {
                Some(digits) if digits.len() <= 9 => fraction = Some(digits),
                _ => return false,
            }
        }
        let offset = if c.byte(b'Z').is_some() {
            None
        } else {
            match c.offset_hh_mm() {
                Some(offset) => Some(offset),
                None => return false,
            }
        };
        if c.end().is_none() {
            return false;
        }

        if hour > 23 || minute > 59 || second > 59 {
            return false;
        }
        if fraction.is_some_and(|f| f.ends_with('0')) {
            return false;
        }
        let Some([offset_hour, offset_minute]) = offset else {
            return true;
        };
        if offset_hour == 0 && offset_minute == 0 {
            return false;
        }
        offset_minute <= 59 && offset_hour * 60 + offset_minute <= 18 * 60
    }

    fn is_date_time(&self, s: &str) -> bool {
        let mut parts = s.split('T');
        match (parts.next(), parts.next(), parts.next()) {
            (Some(date), Some(time), None) => self.is_date(date) && self.is_time(time),
            _ => false,
        }
    }

    /// A date has 10 characters, where a UUID has 36; a time has `:` third,
    /// where a UUID has a hex digit; and a date-time has an upper-case `T`,
    /// which a UUID (lower-case hex) never has.
    fn rejects_uuids(&self) -> bool {
        true
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    // Port of the KotlinDateTimeRecognizer part of
    // test/unit/date-time-recognizer.test.ts.
    const K: KotlinDateTimeRecognizer = KotlinDateTimeRecognizer;

    #[test]
    fn accepts_date_times_java_time_round_trips_identically() {
        assert!(K.is_date_time("2018-08-14T02:45:50Z"));
        assert!(K.is_date_time("2010-12-01T00:00:00Z"));
        assert!(K.is_date_time("2018-08-14T02:45:50+05:30"));
        assert!(K.is_date_time("2015-04-24T01:46:50.342496Z"));
        assert!(K.is_date_time("2018-08-14T02:45:50.5Z"));
        assert!(K.is_date_time("2018-08-14T02:45:50.123456789Z"));
        assert!(K.is_date_time("2016-02-29T00:00:00Z"));
    }

    #[test]
    fn rejects_fractional_seconds_with_trailing_zeros() {
        assert!(!K.is_date_time("2010-01-12T00:00:00.000Z"));
        assert!(!K.is_date_time("2018-08-14T02:45:50.50Z"));
        assert!(!K.is_date_time("2008-09-10T13:21:30.828000Z"));
        assert!(!K.is_date_time("2015-04-24T02:04:02.997570Z"));
    }

    #[test]
    fn rejects_fractions_beyond_nanosecond_precision() {
        assert!(!K.is_date_time("2018-08-14T02:45:50.1234567891Z"));
    }

    #[test]
    fn rejects_zero_offsets_which_format_back_as_z() {
        assert!(!K.is_date_time("2018-08-14T02:45:50+00:00"));
        assert!(!K.is_date_time("2018-08-14T02:45:50-00:00"));
        assert!(!K.is_time("10:30:00+00:00"));
    }

    #[test]
    fn rejects_offsets_outside_java_times_18_hour_range() {
        assert!(K.is_date_time("2018-08-14T02:45:50+18:00"));
        assert!(K.is_date_time("2018-08-14T02:45:50-18:00"));
        assert!(!K.is_date_time("2018-08-14T02:45:50+18:01"));
        assert!(!K.is_date_time("2018-08-14T02:45:50+19:00"));
    }

    #[test]
    fn rejects_lowercase_t_and_z_which_format_back_in_uppercase() {
        assert!(!K.is_date_time("2018-08-14t02:45:50Z"));
        assert!(!K.is_date_time("2018-08-14T02:45:50z"));
        assert!(!K.is_time("02:45:50z"));
    }

    #[test]
    fn rejects_feb_29_outside_leap_years_which_java_time_cannot_parse() {
        assert!(K.is_date("2016-02-29"));
        assert!(K.is_date("2000-02-29"));
        assert!(!K.is_date("2015-02-29"));
        assert!(!K.is_date("1900-02-29"));
        assert!(!K.is_date_time("2015-02-29T00:00:00Z"));
    }

    #[test]
    fn name_styles_and_escapes() {
        let pascal = crate::support::acronyms::acronym_style(
            crate::support::acronyms::AcronymStyleOptions::Pascal,
        );
        assert_eq!(kotlin_name_style(true, "top_level", pascal), "TopLevel");
        assert_eq!(kotlin_name_style(false, "user_id", pascal), "userID");
        assert_eq!(kotlin_name_style(false, "1st", pascal), "the1St");
        assert_eq!(string_escape("$x \"é😀"), "\\$x \\\"é\\ud83d\\ude00");
        assert_eq!(string_escape("\u{7}"), "\\u0007");
    }

    #[test]
    fn accepts_times_java_time_round_trips_identically() {
        assert!(K.is_time("02:45:50Z"));
        assert!(K.is_time("23:20:50.52Z"));
        assert!(!K.is_time("23:20:50.520Z"));
    }
}
