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
