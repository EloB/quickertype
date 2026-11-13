//! Port of `packages/quicktype-core/src/DateTime.ts`.
//!
//! The date/time recognizers JSON inference uses to tell `date`, `time` and
//! `date-time` strings from plain strings (strict RFC 3339, adapted from
//! ajv). Target languages can supply their own recognizer
//! ([`TargetLanguage::date_time_recognizer`](crate::target_language::TargetLanguage::date_time_recognizer));
//! Kotlin and Swift do.
//!
//! The TypeScript regexes are hand-translated: JavaScript's `\d` matches
//! only ASCII digits, the `regex` crate's would match any Unicode digit.

/// `DateTimeRecognizer`: decides which strings are dates, times and
/// date-times.
pub trait DateTimeRecognizer {
    /// Whether `s` is a date (`2020-01-31`).
    fn is_date(&self, s: &str) -> bool;
    /// Whether `s` is a time (`10:00:00Z`).
    fn is_time(&self, s: &str) -> bool;
    /// Whether `s` is a date-time (`2020-01-31T10:00:00Z`).
    fn is_date_time(&self, s: &str) -> bool;
}

/// `DAYS`: the days per month, with February at 29 (no leap-year check).
const DAYS: [u32; 13] = [0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

/// `DefaultDateTimeRecognizer`: strict RFC 3339 full-date, full-time (the
/// offset is mandatory) and date-time (separated by `T` or `t`).
#[derive(Clone, Copy, Debug, Default)]
pub struct DefaultDateTimeRecognizer;

impl DateTimeRecognizer for DefaultDateTimeRecognizer {
    fn is_date(&self, s: &str) -> bool {
        default_is_date(s)
    }

    fn is_time(&self, s: &str) -> bool {
        default_is_time(s)
    }

    fn is_date_time(&self, s: &str) -> bool {
        default_is_date_time(self, s)
    }
}

/// `DefaultDateTimeRecognizer.isDate`: `^(\d\d\d\d)-(\d\d)-(\d\d)$`, a
/// non-zero year, month 1–12 and day 1–`DAYS[month]` (February has 29).
pub fn default_is_date(s: &str) -> bool {
    let Some([year, month, day]) = parse_date(s) else {
        return false;
    };
    year != 0 && (1..=12).contains(&month) && day >= 1 && day <= DAYS[month as usize]
}

/// The year, month and day of `^(\d\d\d\d)-(\d\d)-(\d\d)$`.
pub(crate) fn parse_date(s: &str) -> Option<[u32; 3]> {
    let mut c = Cursor::new(s);
    let year = c.digits(4)?;
    c.byte(b'-')?;
    let month = c.digits(2)?;
    c.byte(b'-')?;
    let day = c.digits(2)?;
    c.end()?;
    Some([year, month, day])
}

/// `DefaultDateTimeRecognizer.isTime`:
/// `/^(\d\d):(\d\d):(\d\d)(\.\d+)?(z|[+-]\d\d:\d\d)$/i` with hours ≤ 23,
/// minutes ≤ 59 and seconds ≤ 59.
pub fn default_is_time(s: &str) -> bool {
    let mut c = Cursor::new(s);
    let Some([hour, minute, second]) = c.hh_mm_ss() else {
        return false;
    };
    if c.byte(b'.').is_some() && c.digit_run() == 0 {
        return false;
    }
    let offset_ok = if c.byte(b'z').is_some() || c.byte(b'Z').is_some() {
        true
    } else {
        c.offset_hh_mm().is_some()
    };
    offset_ok && c.end().is_some() && hour <= 23 && minute <= 59 && second <= 59
}

/// `DefaultDateTimeRecognizer.isDateTime`: `s.split(/t/i)` must give a date
/// and a time, checked with `recognizer`'s own `is_date` and `is_time`.
pub fn default_is_date_time(recognizer: &(impl DateTimeRecognizer + ?Sized), s: &str) -> bool {
    let mut parts = s.split(['t', 'T']);
    match (parts.next(), parts.next(), parts.next()) {
        (Some(date), Some(time), None) => recognizer.is_date(date) && recognizer.is_time(time),
        _ => false,
    }
}

/// A cursor over ASCII syntax for the hand-translated regexes. Every method
/// returns `None` without consuming anything the pattern does not match.
pub(crate) struct Cursor<'a> {
    bytes: &'a [u8],
    pos: usize,
}

impl<'a> Cursor<'a> {
    pub(crate) fn new(s: &'a str) -> Self {
        Cursor {
            bytes: s.as_bytes(),
            pos: 0,
        }
    }

    /// The `n` ASCII digits `\d{n}`, as a number.
    pub(crate) fn digits(&mut self, n: usize) -> Option<u32> {
        let digits = self.bytes.get(self.pos..self.pos + n)?;
        if !digits.iter().all(u8::is_ascii_digit) {
            return None;
        }
        self.pos += n;
        Some(digits.iter().fold(0, |v, &d| v * 10 + u32::from(d - b'0')))
    }

    /// Consumes `\d*` and returns how many digits it matched.
    pub(crate) fn digit_run(&mut self) -> usize {
        let start = self.pos;
        while self.bytes.get(self.pos).is_some_and(u8::is_ascii_digit) {
            self.pos += 1;
        }
        self.pos - start
    }

    /// The text of the next `\d+`, if any.
    pub(crate) fn digit_text(&mut self) -> Option<&'a str> {
        let start = self.pos;
        if self.digit_run() == 0 {
            return None;
        }
        std::str::from_utf8(&self.bytes[start..self.pos]).ok()
    }

    /// The byte `b`.
    pub(crate) fn byte(&mut self, b: u8) -> Option<()> {
        if self.bytes.get(self.pos) == Some(&b) {
            self.pos += 1;
            Some(())
        } else {
            None
        }
    }

    /// One of `bs`, returning it.
    pub(crate) fn one_of(&mut self, bs: &[u8]) -> Option<u8> {
        let b = *self.bytes.get(self.pos)?;
        if bs.contains(&b) {
            self.pos += 1;
            Some(b)
        } else {
            None
        }
    }

    /// `(\d\d):(\d\d):(\d\d)`.
    pub(crate) fn hh_mm_ss(&mut self) -> Option<[u32; 3]> {
        let hour = self.digits(2)?;
        self.byte(b':')?;
        let minute = self.digits(2)?;
        self.byte(b':')?;
        let second = self.digits(2)?;
        Some([hour, minute, second])
    }

    /// `[+-]\d\d:\d\d`, as hours and minutes.
    pub(crate) fn offset_hh_mm(&mut self) -> Option<[u32; 2]> {
        self.one_of(b"+-")?;
        let hours = self.digits(2)?;
        self.byte(b':')?;
        let minutes = self.digits(2)?;
        Some([hours, minutes])
    }

    /// `$`: the end of the string.
    pub(crate) fn end(&self) -> Option<()> {
        (self.pos == self.bytes.len()).then_some(())
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    // Port of test/unit/date-time-recognizer.test.ts (the default
    // recognizer; the Kotlin part lives with KotlinDateTimeRecognizer).
    const R: DefaultDateTimeRecognizer = DefaultDateTimeRecognizer;

    #[test]
    fn is_date_time_accepts_rfc_3339_date_times_with_offset() {
        assert!(R.is_date_time("2018-08-14T02:45:50Z"));
        assert!(R.is_date_time("2018-08-14T02:45:50+01:00"));
        assert!(R.is_date_time("2018-08-14T02:45:50-11:30"));
    }

    #[test]
    fn is_date_time_accepts_lowercase_t_and_z() {
        assert!(R.is_date_time("2018-08-14t02:45:50z"));
    }

    #[test]
    fn is_date_time_accepts_fractional_seconds() {
        assert!(R.is_date_time("2015-04-24T01:46:50.342496Z"));
        assert!(R.is_date_time("2010-01-12T00:00:00.000Z"));
        assert!(R.is_date_time("2015-07-15T23:25:21.541+02:00"));
    }

    #[test]
    fn is_date_time_rejects_a_space_separator() {
        assert!(!R.is_date_time("2013-06-15 21:10:28"));
        assert!(!R.is_date_time("1970-01-01 00:00:00"));
        assert!(!R.is_date_time("2015-04-24 01:46:50.342496Z"));
    }

    #[test]
    fn is_date_time_rejects_a_missing_timezone_offset() {
        assert!(!R.is_date_time("2018-08-14T02:45:50"));
        assert!(!R.is_date_time("2018-08-14T02:45:50.123"));
    }

    #[test]
    fn is_date_time_rejects_invalid_dates_and_times() {
        assert!(!R.is_date_time("0000-00-00T00:00:00Z"));
        assert!(!R.is_date_time("2018-13-01T00:00:00Z"));
        assert!(!R.is_date_time("2018-08-14T24:00:00Z"));
        assert!(!R.is_date_time("2018-08-14X02:45:50Z"));
    }

    #[test]
    fn is_date_accepts_rfc_3339_full_date() {
        assert!(R.is_date("2018-08-14"));
        assert!(R.is_date("1970-01-01"));
    }

    #[test]
    fn is_date_rejects_invalid_dates() {
        assert!(!R.is_date("0000-00-00"));
        assert!(!R.is_date("2018-13-01"));
        assert!(!R.is_date("2018-02-30"));
        assert!(!R.is_date("2018-8-14"));
    }

    #[test]
    fn is_time_accepts_rfc_3339_full_time_offset_required() {
        assert!(R.is_time("02:45:50Z"));
        assert!(R.is_time("02:45:50z"));
        assert!(R.is_time("02:45:50.123+01:00"));
        assert!(R.is_time("23:59:59-11:30"));
    }

    #[test]
    fn is_time_rejects_a_missing_timezone_offset() {
        assert!(!R.is_time("02:45:50"));
        assert!(!R.is_time("02:45:50.123"));
    }

    #[test]
    fn is_time_rejects_invalid_times() {
        assert!(!R.is_time("24:00:00Z"));
        assert!(!R.is_time("02:60:00Z"));
        assert!(!R.is_time("02:45:60Z"));
    }

    #[test]
    fn edge_cases_from_research() {
        assert!(!R.is_date("2020-02-30"));
        assert!(R.is_date("2021-02-29"));
        assert!(!R.is_date("0000-01-01"));
        assert!(!R.is_date("2020-01-00"));
        assert!(!R.is_date("２０２０-01-01"));
        assert!(!R.is_date_time("2020-01-01T23:59:60Z"));
        assert!(!R.is_time("10:00:00+0100"));
        assert!(!R.is_time("10:00:00.Z"));
        assert!(!R.is_date_time("2020-01-01T10:00:00ZT"));
    }
}
