//! JavaScript number semantics: `Number.prototype.toString()` and `**`.
//!
//! Rust's `{}` formatting differs from JavaScript in layout (`1e21` prints as
//! `1000000000000000000000`, `-0.0` as `-0`) and, for doubles that lie exactly
//! halfway between two shortest decimal candidates, in the digits themselves:
//! ECMAScript picks the even candidate, Rust's shortest formatting rounds up.
//! [`to_string`] uses `ryu`, whose shortest digits match V8's (0 mismatches
//! over 2,000,000 random doubles against Node 24), and lays them out the
//! ECMAScript way.

/// `Number.prototype.toString()` with radix 10, which is also what `String(x)`,
/// `` `${x}` `` and `"" + x` produce.
///
/// This is ECMAScript `Number::toString`: the shortest digits that round-trip,
/// printed as an integer up to 21 digits (`1e20` → `"100000000000000000000"`),
/// as a decimal fraction down to `1e-6` (`"0.000001"`), and in exponent form
/// outside that range (`"1e+21"`, `"1e-7"`, `"1.5e+300"`). `-0` prints as
/// `"0"`, and the non-finite values as `"NaN"`, `"Infinity"` and `"-Infinity"`.
pub fn to_string(x: f64) -> String {
    let mut out = String::new();
    write_to_string(&mut out, x);
    out
}

/// Appends [`to_string`]`(x)` to `out`.
pub fn write_to_string(out: &mut String, x: f64) {
    if x.is_nan() {
        out.push_str("NaN");
        return;
    }
    if x == 0.0 {
        out.push('0');
        return;
    }
    if x.is_infinite() {
        out.push_str(if x > 0.0 { "Infinity" } else { "-Infinity" });
        return;
    }
    if x < 0.0 {
        out.push('-');
    }

    let mut buffer = ryu::Buffer::new();
    let (digits, n) = shortest_digits(buffer.format_finite(x.abs()));
    let digits = digits.as_str();
    // ECMAScript Number::toString: the value is 0.d1d2...dk × 10^n.
    let k = digits.len() as i32;
    if k <= n && n <= 21 {
        out.push_str(digits);
        push_zeros(out, n - k);
    } else if 0 < n && n <= 21 {
        let (int_part, frac_part) = digits.split_at(n as usize);
        out.push_str(int_part);
        out.push('.');
        out.push_str(frac_part);
    } else if -6 < n && n <= 0 {
        out.push_str("0.");
        push_zeros(out, -n);
        out.push_str(digits);
    } else {
        let exponent = n - 1;
        let (first, rest) = digits.split_at(1);
        out.push_str(first);
        if !rest.is_empty() {
            out.push('.');
            out.push_str(rest);
        }
        out.push('e');
        out.push(if exponent >= 0 { '+' } else { '-' });
        out.push_str(&exponent.unsigned_abs().to_string());
    }
}

fn push_zeros(out: &mut String, count: i32) {
    for _ in 0..count {
        out.push('0');
    }
}

/// Splits ryu's output for a positive finite double (`"123.45"`, `"1e21"`,
/// `"1.5e-7"`, `"0.001"`) into its significant digits, without leading or
/// trailing zeros, and the decimal exponent `n` such that the value is
/// `0.digits × 10^n`.
fn shortest_digits(formatted: &str) -> (String, i32) {
    let (mantissa, exponent) = match formatted.split_once('e') {
        Some((mantissa, exponent)) => (mantissa, exponent.parse::<i32>().unwrap_or(0)),
        None => (formatted, 0),
    };
    let (int_part, frac_part) = mantissa.split_once('.').unwrap_or((mantissa, ""));
    let mut digits = String::with_capacity(int_part.len() + frac_part.len());
    digits.push_str(int_part);
    digits.push_str(frac_part);
    let leading_zeros = digits.len() - digits.trim_start_matches('0').len();
    digits.drain(..leading_zeros);
    digits.truncate(digits.trim_end_matches('0').len());
    let n = int_part.len() as i32 + exponent - leading_zeros as i32;
    (digits, n)
}

/// JavaScript `x ** y` / `Math.pow(x, y)` as V8 computes it.
///
/// V8 calls the platform's `pow`, except that it returns NaN for a NaN
/// exponent and for `(±1) ** ±Infinity`, computes `x ** 2` as `x * x` and
/// `x ** 0.5` (for `x` without the sign bit) as `sqrt(x)`. This reproduces
/// that with [`f64::powf`], which calls the same platform `pow` natively.
/// Never use the `libm` crate here: it disagrees with Node on about 7% of
/// inputs.
///
/// # Warning: not exact on `wasm32`
///
/// On `wasm32` there is no platform `pow`: `f64::powf` is compiler-builtins'
/// port of `libm`, which disagrees with Node in the last bit on about 7% of
/// inputs. Through `MarkovChain.evaluate` that can flip `InferMaps`' class
/// versus map decision near its threshold. A correctly rounded `pow` is a
/// known gap (see `docs/PARITY.md`, "Known gaps").
pub fn pow(x: f64, y: f64) -> f64 {
    if y.is_nan() || (y.is_infinite() && x.abs() == 1.0) {
        return f64::NAN;
    }
    if y == 2.0 {
        return x * x;
    }
    if y == 0.5 && x.is_sign_positive() {
        return x.sqrt();
    }
    platform_pow(x, y)
}

/// The platform `pow`, as V8 calls it.
#[cfg(not(target_arch = "wasm32"))]
fn platform_pow(x: f64, y: f64) -> f64 {
    // Keep LLVM from constant-folding with its own pow implementation.
    std::hint::black_box(x).powf(std::hint::black_box(y))
}

/// Not the platform `pow`: wasm32 has none, and this libm port differs from
/// Node on about 7% of inputs.
#[cfg(target_arch = "wasm32")]
fn platform_pow(x: f64, y: f64) -> f64 {
    // TODO(wasm): correctly rounded pow (e.g. a port of glibc's or CORE-MATH's
    // pow) so that wasm32 matches Node; see "Known gaps" in docs/PARITY.md.
    std::hint::black_box(x).powf(std::hint::black_box(y))
}

/// JavaScript `Number(s)` for a string (ECMAScript `StringToNumber`).
///
/// Surrounding JavaScript whitespace is ignored and the empty string is 0.
/// Accepted are decimal literals with optional sign, fraction and exponent
/// (`"1.5"`, `".5"`, `"5."`, `"-1e3"`), `Infinity` with optional sign, and
/// unsigned `0x`/`0o`/`0b` integers; anything else is `NaN`. Unlike Rust's
/// `str::parse::<f64>`, `"inf"`, `"NaN"` and `"1_000"` are `NaN`.
pub fn string_to_number(s: &str) -> f64 {
    let s = crate::whitespace::trim(s);
    if s.is_empty() {
        return 0.0;
    }
    for (prefix, radix) in [
        ("0x", 16),
        ("0X", 16),
        ("0o", 8),
        ("0O", 8),
        ("0b", 2),
        ("0B", 2),
    ] {
        if let Some(digits) = s.strip_prefix(prefix) {
            return radix_integer(digits, radix);
        }
    }
    let unsigned = s.strip_prefix(['+', '-']).unwrap_or(s);
    if unsigned == "Infinity" {
        return if s.starts_with('-') {
            f64::NEG_INFINITY
        } else {
            f64::INFINITY
        };
    }
    if !is_decimal_literal(unsigned) {
        return f64::NAN;
    }
    // A validated decimal literal: Rust's parser is correctly rounded, like V8.
    s.parse().unwrap_or(f64::NAN)
}

/// Whether `s` is an ECMAScript `StrUnsignedDecimalLiteral` other than
/// `Infinity`: `digits [. digits?] | . digits`, then an optional exponent.
fn is_decimal_literal(s: &str) -> bool {
    let bytes = s.as_bytes();
    let digits_from = |mut i: usize| {
        while i < bytes.len() && bytes[i].is_ascii_digit() {
            i += 1;
        }
        i
    };
    let int_end = digits_from(0);
    let mut i = int_end;
    let mut have_digits = int_end > 0;
    if i < bytes.len() && bytes[i] == b'.' {
        let frac_end = digits_from(i + 1);
        have_digits |= frac_end > i + 1;
        i = frac_end;
    }
    if !have_digits {
        return false;
    }
    if i < bytes.len() && (bytes[i] == b'e' || bytes[i] == b'E') {
        i += 1;
        if i < bytes.len() && (bytes[i] == b'+' || bytes[i] == b'-') {
            i += 1;
        }
        let exp_end = digits_from(i);
        if exp_end == i {
            return false;
        }
        i = exp_end;
    }
    i == bytes.len()
}

/// The value of a non-empty run of `radix` digits, correctly rounded; `NaN`
/// if there is a non-digit (or no digit).
fn radix_integer(digits: &str, radix: u32) -> f64 {
    if digits.is_empty() || !digits.chars().all(|c| c.is_digit(radix)) {
        return f64::NAN;
    }
    let digits = digits.trim_start_matches('0');
    if let Ok(n) = u64::from_str_radix(digits, radix) {
        return n as f64;
    }
    // More than 64 significant bits: keep the top 64 bits plus a sticky bit
    // for the rest, which rounds to nearest-even exactly like V8.
    let bits_per_digit = radix.trailing_zeros();
    let mut mantissa: u64 = 0;
    let mut exponent: i32 = 0;
    let mut sticky = false;
    for c in digits.chars() {
        let d = u64::from(c.to_digit(radix).unwrap_or(0));
        if mantissa.leading_zeros() >= bits_per_digit {
            mantissa = (mantissa << bits_per_digit) | d;
        } else {
            sticky |= d != 0;
            exponent += bits_per_digit as i32;
        }
    }
    // Round the 64-bit mantissa to 53 bits by hand (ties to even, with the
    // dropped digits as sticky bits).
    let shift = 64 - mantissa.leading_zeros() as i32 - 53;
    if shift <= 0 {
        return mantissa as f64 * 2f64.powi(exponent);
    }
    let shift = shift as u32;
    let kept = mantissa >> shift;
    let dropped = mantissa & ((1u64 << shift) - 1);
    let half = 1u64 << (shift - 1);
    let round_up = dropped > half || (dropped == half && (sticky || kept & 1 == 1));
    let rounded = if round_up { kept + 1 } else { kept };
    rounded as f64 * 2f64.powi(exponent + shift as i32)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn layout_matches_ecmascript() {
        for (x, s) in [
            (0.0, "0"),
            (-0.0, "0"),
            (f64::NAN, "NaN"),
            (f64::NEG_INFINITY, "-Infinity"),
            (1e21, "1e+21"),
            (1e20, "100000000000000000000"),
            (1e-7, "1e-7"),
            (1e-6, "0.000001"),
            (123e-20, "1.23e-18"),
            (1.5e300, "1.5e+300"),
            (0.1 + 0.2, "0.30000000000000004"),
            (-5e-324, "-5e-324"),
            (123456789012345680000.0, "123456789012345680000"),
            // 2877847019984.40625 lies exactly halfway between two shortest
            // candidates: ECMAScript picks the even one.
            (f64::from_bits(0x4284_F068_650E_8340), "2877847019984.4062"),
        ] {
            assert_eq!(to_string(x), s);
        }
    }

    #[test]
    fn pow_special_cases() {
        assert!(pow(1.0, f64::NAN).is_nan());
        assert!(pow(-1.0, f64::INFINITY).is_nan());
        assert_eq!(pow(f64::NAN, 0.0), 1.0);
        assert_eq!(pow(3.0, 2.0), 9.0);
        assert_eq!(pow(-0.0, 0.5).to_bits(), 0.0f64.to_bits());
        assert_eq!(pow(f64::NEG_INFINITY, 0.5), f64::INFINITY);
        assert_eq!(pow(4.0, 0.5), 2.0);
    }
}
