//! Port of `packages/quicktype-core/src/language/Kotlin/utils.ts`.
//!
//! So far only [`KotlinDateTimeRecognizer`], which JSON inference needs; the
//! renderer helpers follow with the Kotlin renderer.

use crate::date_time::{Cursor, DateTimeRecognizer, default_is_date, parse_date};

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
    fn accepts_times_java_time_round_trips_identically() {
        assert!(K.is_time("02:45:50Z"));
        assert!(K.is_time("23:20:50.52Z"));
        assert!(!K.is_time("23:20:50.520Z"));
    }
}
