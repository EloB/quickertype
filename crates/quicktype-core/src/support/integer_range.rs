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
    /// The largest integer in the range.
    pub max: Cow<'static, str>,
    /// The smallest integer in the range.
    pub min: Cow<'static, str>,
}

impl IntegerRange {
    const fn borrowed(min: &'static str, max: &'static str) -> Self {
        IntegerRange {
            max: Cow::Borrowed(max),
            min: Cow::Borrowed(min),
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

/// `splitIntegerString`: the digits without sign and leading zeros (keeping
/// one digit), and whether the number is negative (`"-0"` is not).
fn split_integer_string(s: &str) -> (&str, bool) {
    let has_sign = s.starts_with('-');
    let digits = if has_sign { &s[1..] } else { s };

    // `firstNonZero < digits.length - 1`: keep at least one UTF-16 unit. The
    // skipped units are ASCII zeros, so unit and byte indices agree.
    let keep_from = utf16::len(digits).saturating_sub(1);
    let first_non_zero = digits
        .bytes()
        .take(keep_from)
        .take_while(|&b| b == b'0')
        .count();
    let digits = &digits[first_non_zero..];

    (digits, has_sign && digits != "0")
}

/// `compareIntegerStrings(a, b)`: compares two integers given as decimal
/// strings, exactly and for any size, ignoring leading zeros.
pub fn compare_integer_strings(a: &str, b: &str) -> Ordering {
    let (a_digits, a_negative) = split_integer_string(a);
    let (b_digits, b_negative) = split_integer_string(b);

    if a_negative != b_negative {
        return if a_negative {
            Ordering::Less
        } else {
            Ordering::Greater
        };
    }

    // Equal-length runs of digits compare lexicographically the same way they
    // compare numerically.
    let magnitude = utf16::len(a_digits)
        .cmp(&utf16::len(b_digits))
        .then_with(|| compare_utf16(a_digits, b_digits));
    if a_negative {
        magnitude.reverse()
    } else {
        magnitude
    }
}

/// `integerStringInRange(s, range)`: whether the integer `s` (a decimal
/// string) lies within `range`, inclusive.
pub fn integer_string_in_range(s: &str, range: &IntegerRange) -> bool {
    compare_integer_strings(s, &range.min).is_ge() && compare_integer_strings(s, &range.max).is_le()
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
