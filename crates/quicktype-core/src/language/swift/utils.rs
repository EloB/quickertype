//! Port of `packages/quicktype-core/src/language/Swift/utils.ts`.
//!
//! So far only [`SwiftDateTimeRecognizer`], which JSON inference needs; the
//! renderer helpers follow with the Swift renderer.

use crate::date_time::{Cursor, DateTimeRecognizer, default_is_date, default_is_time};

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
}
