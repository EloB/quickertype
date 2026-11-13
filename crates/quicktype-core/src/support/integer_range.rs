//! Port of `packages/quicktype-core/src/support/IntegerRange.ts`.

use std::borrow::Cow;
use std::cmp::Ordering;

use quicktype_js_compat::{sort::compare_utf16, utf16};

/// `IntegerRange`: an inclusive range of integers that a target language's
/// integer type can represent exactly. The bounds are decimal strings because
/// they can lie outside the range in which JavaScript numbers are exact (the
/// int64 bounds are not representable as doubles).
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct IntegerRange {
    max: Cow<'static, str>,
    min: Cow<'static, str>,
    /// `min` and `max` split as [`integer_string_in_range`] compares them,
    /// so that only the tested number is split on each call.
    split: [Bound; 2],
}

impl IntegerRange {
    /// The range `min..=max`, with the bounds as decimal strings.
    pub fn new(min: impl Into<Cow<'static, str>>, max: impl Into<Cow<'static, str>>) -> Self {
        let (min, max) = (min.into(), max.into());
        let split = [Bound::of(&min), Bound::of(&max)];
        IntegerRange { max, min, split }
    }

    const fn borrowed(min: &'static str, max: &'static str) -> Self {
        IntegerRange {
            max: Cow::Borrowed(max),
            min: Cow::Borrowed(min),
            split: [Bound::of(min), Bound::of(max)],
        }
    }

    /// The smallest integer in the range.
    pub fn min(&self) -> &str {
        &self.min
    }

    /// The largest integer in the range.
    pub fn max(&self) -> &str {
        &self.max
    }
}

/// A bound as [`split_integer_string`] splits it: where its digits start
/// and whether it is negative, if it is ASCII (otherwise it is split when
/// compared).
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
struct Bound {
    digits_start: usize,
    negative: bool,
    ascii: bool,
}

impl Bound {
    /// `splitIntegerString(s)` for an ASCII `s`, in a constant context.
    const fn of(s: &str) -> Bound {
        let bytes = s.as_bytes();
        let mut i = 0;
        while i < bytes.len() {
            if bytes[i] >= 0x80 {
                return Bound {
                    digits_start: 0,
                    negative: false,
                    ascii: false,
                };
            }
            i += 1;
        }
        let has_sign = !bytes.is_empty() && bytes[0] == b'-';
        let mut start = if has_sign { 1 } else { 0 };
        // Skip leading zeros, keeping at least one digit.
        while start + 1 < bytes.len() && bytes[start] == b'0' {
            start += 1;
        }
        let is_zero = start + 1 == bytes.len() && bytes[start] == b'0';
        Bound {
            digits_start: start,
            negative: has_sign && !is_zero,
            ascii: true,
        }
    }

    fn split(self, s: &str) -> SplitInteger<'_> {
        if self.ascii {
            SplitInteger {
                digits: &s[self.digits_start..],
                negative: self.negative,
                ascii: true,
            }
        } else {
            split_integer_string(s)
        }
    }
}

/// The range of a signed 64-bit integer, which most target languages use.
pub static INT64_RANGE: IntegerRange =
    IntegerRange::borrowed("-9223372036854775808", "9223372036854775807");

/// The range of a signed 32-bit integer.
pub static INT32_RANGE: IntegerRange = IntegerRange::borrowed("-2147483648", "2147483647");

/// The range of a signed 16-bit integer.
pub static INT16_RANGE: IntegerRange = IntegerRange::borrowed("-32768", "32767");

/// The range of a signed 8-bit integer.
pub static INT8_RANGE: IntegerRange = IntegerRange::borrowed("-128", "127");

/// The range in which every integer is exactly representable as an IEEE-754
/// double, which is how JavaScript and its relatives represent all numbers.
pub static JS_SAFE_INTEGER_RANGE: IntegerRange =
    IntegerRange::borrowed("-9007199254740991", "9007199254740991");

/// `splitIntegerString(s)`: the digits without sign and leading zeros
/// (keeping one digit), and whether the number is negative (`"-0"` is
/// not). Also notes whether the digits are ASCII, as every integer literal
/// is, so that comparing them can work on bytes.
#[derive(Clone, Copy)]
struct SplitInteger<'a> {
    digits: &'a str,
    negative: bool,
    ascii: bool,
}

fn split_integer_string(s: &str) -> SplitInteger<'_> {
    let has_sign = s.starts_with('-');
    let digits = if has_sign { &s[1..] } else { s };
    let ascii = digits.is_ascii();

    // `firstNonZero < digits.length - 1`: keep at least one UTF-16 unit. The
    // skipped units are ASCII zeros, so unit and byte indices agree.
    let length = if ascii {
        digits.len()
    } else {
        utf16::len(digits)
    };
    let first_non_zero = digits
        .bytes()
        .take(length.saturating_sub(1))
        .take_while(|&b| b == b'0')
        .count();
    let digits = &digits[first_non_zero..];

    SplitInteger {
        digits,
        negative: has_sign && digits != "0",
        ascii,
    }
}

/// `compareIntegerStrings` on split integers.
fn compare_split(a: SplitInteger<'_>, b: SplitInteger<'_>) -> Ordering {
    if a.negative != b.negative {
        return if a.negative {
            Ordering::Less
        } else {
            Ordering::Greater
        };
    }

    // Equal-length runs of digits compare lexicographically the same way they
    // compare numerically. For ASCII, UTF-16 units are bytes.
    let magnitude = if a.ascii && b.ascii {
        a.digits
            .len()
            .cmp(&b.digits.len())
            .then_with(|| a.digits.as_bytes().cmp(b.digits.as_bytes()))
    } else {
        utf16::len(a.digits)
            .cmp(&utf16::len(b.digits))
            .then_with(|| compare_utf16(a.digits, b.digits))
    };
    if a.negative {
        magnitude.reverse()
    } else {
        magnitude
    }
}

/// `compareIntegerStrings(a, b)`: compares two integers given as decimal
/// strings, exactly and for any size, ignoring leading zeros.
pub fn compare_integer_strings(a: &str, b: &str) -> Ordering {
    compare_split(split_integer_string(a), split_integer_string(b))
}

/// `integerStringInRange(s, range)`: whether the integer `s` (a decimal
/// string) lies within `range`, inclusive.
pub fn integer_string_in_range(s: &str, range: &IntegerRange) -> bool {
    let s = split_integer_string(s);
    compare_split(s, range.split[0].split(&range.min)).is_ge()
        && compare_split(s, range.split[1].split(&range.max)).is_le()
}

#[cfg(test)]
mod tests {
    use super::*;

    // Ported from test/unit/integer-range-inference.test.ts,
    // describe("integerStringInRange").

    #[test]
    fn accepts_values_inside_the_int64_range() {
        assert!(integer_string_in_range("0", &INT64_RANGE));
        assert!(integer_string_in_range("-0", &INT64_RANGE));
        assert!(integer_string_in_range("1", &INT64_RANGE));
        assert!(integer_string_in_range("-1", &INT64_RANGE));
        assert!(integer_string_in_range("123456789", &INT64_RANGE));
        // INT64_MAX and INT64_MIN are still integers.
        assert!(integer_string_in_range("9223372036854775807", &INT64_RANGE));
        assert!(integer_string_in_range(
            "-9223372036854775808",
            &INT64_RANGE
        ));
    }

    /// The bounds' stored splits are what splitting them gives.
    #[test]
    fn bounds_are_split_like_numbers() {
        for text in [
            "0",
            "-0",
            "007",
            "-007",
            "-",
            "",
            "-9223372036854775808",
            "2147483647",
        ] {
            let bound = Bound::of(text);
            let expected = split_integer_string(text);
            let actual = bound.split(text);
            assert_eq!(
                (actual.digits, actual.negative, actual.ascii),
                (expected.digits, expected.negative, expected.ascii),
                "{text:?}"
            );
        }
        let range = IntegerRange::new("-5", "5");
        assert!(integer_string_in_range("-5", &range));
        assert!(!integer_string_in_range("6", &range));
        assert_eq!((range.min(), range.max()), ("-5", "5"));
    }

    /// Every pair of a set of decimal strings (signs, leading zeros, the
    /// int64 and int32 edges) compares as the numbers do.
    #[test]
    fn compares_like_the_numbers() {
        let strings = [
            "0",
            "-0",
            "00",
            "-000",
            "7",
            "-7",
            "007",
            "-007",
            "2147483647",
            "2147483648",
            "-2147483648",
            "-2147483649",
            "9223372036854775807",
            "9223372036854775808",
            "-9223372036854775808",
            "-9223372036854775809",
            "0009223372036854775807",
            "123456789012345678901234567890",
            "-123456789012345678901234567890",
        ];
        for a in strings {
            for b in strings {
                let (x, y): (i128, i128) = (a.parse().unwrap(), b.parse().unwrap());
                assert_eq!(compare_integer_strings(a, b), x.cmp(&y), "{a} vs {b}");
            }
        }
    }

    #[test]
    fn ignores_leading_zeros() {
        assert!(integer_string_in_range(
            "00000000000000000000042",
            &INT64_RANGE
        ));
        assert!(integer_string_in_range(
            "-00000000000000000000042",
            &INT64_RANGE
        ));
        assert!(integer_string_in_range(
            "009223372036854775807",
            &INT64_RANGE
        ));
        assert!(!integer_string_in_range(
            "009223372036854775808",
            &INT64_RANGE
        ));
    }

    #[test]
    fn rejects_values_just_outside_the_int64_range() {
        assert!(!integer_string_in_range(
            "9223372036854775808",
            &INT64_RANGE
        ));
        assert!(!integer_string_in_range(
            "-9223372036854775809",
            &INT64_RANGE
        ));
    }

    #[test]
    fn rejects_values_far_outside_the_int64_range() {
        assert!(!integer_string_in_range(
            "123456789012345678901234567890",
            &INT64_RANGE
        ));
        assert!(!integer_string_in_range(
            "-123456789012345678901234567890",
            &INT64_RANGE
        ));
    }

    #[test]
    fn the_js_safe_integer_range_is_narrower_than_int64() {
        assert!(integer_string_in_range(
            "9007199254740991",
            &JS_SAFE_INTEGER_RANGE
        ));
        assert!(!integer_string_in_range(
            "9007199254740992",
            &JS_SAFE_INTEGER_RANGE
        ));
        assert!(integer_string_in_range(
            "-9007199254740991",
            &JS_SAFE_INTEGER_RANGE
        ));
        assert!(!integer_string_in_range(
            "-9007199254740992",
            &JS_SAFE_INTEGER_RANGE
        ));
    }
}
