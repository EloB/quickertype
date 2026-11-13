//! JavaScript number formatting and parsing (`quicktype_js_compat::number`):
//! `Number.prototype.toString` must round-trip through `Number(string)`,
//! and `Math.pow` and `Number(string)` must not fail on anything.
//! Input: 16 bytes as two doubles, then text for `Number(string)`.

#![no_main]

use libfuzzer_sys::fuzz_target;
use quicktype_js_compat::number;

fuzz_target!(|data: &[u8]| {
    let mut bits = [0u8; 16];
    let n = data.len().min(16);
    bits[..n].copy_from_slice(&data[..n]);
    let x = f64::from_le_bytes(bits[..8].try_into().unwrap());
    let y = f64::from_le_bytes(bits[8..].try_into().unwrap());

    for v in [x, y] {
        let s = number::to_string(v);
        let back = number::string_to_number(&s);
        if v.is_nan() {
            assert!(back.is_nan(), "{s}");
        } else if v == 0.0 {
            assert_eq!(back, 0.0, "{s}");
        } else {
            assert_eq!(back.to_bits(), v.to_bits(), "{v:?} -> {s} -> {back:?}");
        }
        let mut out = String::from("x");
        number::write_to_string(&mut out, v);
        assert_eq!(&out[1..], s);
        let _ = quicktype_js_compat::json::number(v);
    }
    let _ = number::pow(x, y);

    let text = quicktype_fuzz::text(&data[n..]);
    let parsed = number::string_to_number(&text);
    let _ = number::to_string(parsed);
});
