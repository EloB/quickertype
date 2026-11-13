//! JavaScript string semantics: strings are sequences of UTF-16 code units.
//!
//! `length`, indexing (`s[i]`, `charCodeAt`, `codePointAt`), `slice` and
//! `substring` all count UTF-16 code units, so a character outside the Basic
//! Multilingual Plane (an emoji, `𝐀`) counts as two. These helpers reproduce
//! that on Rust `&str`s.
//!
//! A Rust `String` cannot hold a lone surrogate, which JavaScript strings can.
//! Where a JavaScript operation would split a surrogate pair, the `&str`
//! helpers here drop the orphaned half (documented per function), and the
//! `*_units` variants return the exact code units for callers that need them.

use std::str::EncodeUtf16;

/// `s.length`: the number of UTF-16 code units.
pub fn len(s: &str) -> usize {
    s.chars().map(char::len_utf16).sum()
}

/// The UTF-16 code units of `s`, i.e. `s.charCodeAt(0)`, `s.charCodeAt(1)`, ...
pub fn units(s: &str) -> EncodeUtf16<'_> {
    s.encode_utf16()
}

/// The code points of `s`, as `for (const c of s)` or `[...s]` yield them.
///
/// For a Rust string, which holds no lone surrogates, these are its `char`s.
pub fn code_points(s: &str) -> impl Iterator<Item = u32> + '_ {
    s.chars().map(u32::from)
}

/// `s.charCodeAt(index)`; `None` where JavaScript returns `NaN` (index out of
/// range).
///
/// **O(n) per call**: it walks `s` from the start. To port a loop such as
/// `for (let i = 0; i < s.length; i++) s.charCodeAt(i)`, build a
/// [`CodeUnits`] once and index that instead.
pub fn char_code_at(s: &str, index: usize) -> Option<u16> {
    s.encode_utf16().nth(index)
}

/// `s.codePointAt(index)`; `None` where JavaScript returns `undefined`.
///
/// `index` counts UTF-16 code units. At the high half of a surrogate pair this
/// is the whole code point; at the low half it is the low surrogate itself.
///
/// **O(n) per call**, like [`char_code_at`]; use [`CodeUnits`] in loops.
pub fn code_point_at(s: &str, index: usize) -> Option<u32> {
    let mut position = 0;
    for c in s.chars() {
        let width = c.len_utf16();
        if index < position + width {
            return Some(if index == position {
                u32::from(c)
            } else {
                // The low surrogate of an astral character.
                let mut pair = [0; 2];
                c.encode_utf16(&mut pair);
                u32::from(pair[1])
            });
        }
        position += width;
    }
    None
}

/// `codePointAt(index)` on a slice of UTF-16 code units, which may contain
/// lone surrogates.
pub fn code_point_at_units(units: &[u16], index: usize) -> Option<u32> {
    let first = *units.get(index)?;
    match units.get(index + 1) {
        Some(&second) if is_high_surrogate(first) && is_low_surrogate(second) => {
            Some(0x10000 + ((u32::from(first) - 0xD800) << 10) + (u32::from(second) - 0xDC00))
        }
        _ => Some(u32::from(first)),
    }
}

/// Whether `unit` is a high (leading) surrogate, U+D800–U+DBFF.
pub fn is_high_surrogate(unit: u16) -> bool {
    (0xD800..=0xDBFF).contains(&unit)
}

/// Whether `unit` is a low (trailing) surrogate, U+DC00–U+DFFF.
pub fn is_low_surrogate(unit: u16) -> bool {
    (0xDC00..=0xDFFF).contains(&unit)
}

/// Resolves `slice(start, end)` arguments against a string of `len` code units
/// into a code-unit range, as ECMAScript does: negative indices count from the
/// end, and both are clamped to `0..=len`. The range is empty if `start`
/// lands at or after `end`.
pub fn slice_range(len: usize, start: i64, end: Option<i64>) -> std::ops::Range<usize> {
    let len_i = i64::try_from(len).unwrap_or(i64::MAX);
    let resolve = |i: i64| {
        let i = if i < 0 {
            len_i.saturating_add(i).max(0)
        } else {
            i.min(len_i)
        };
        usize::try_from(i).unwrap_or(0)
    };
    let from = resolve(start);
    let to = end.map_or(len, resolve);
    from..to.max(from)
}

/// Resolves `substring(start, end)` arguments into a code-unit range: both
/// are clamped to `0..=len` (negative means 0) and swapped if out of order.
pub fn substring_range(len: usize, start: i64, end: Option<i64>) -> std::ops::Range<usize> {
    let clamp = |i: i64| usize::try_from(i.max(0)).unwrap_or(0).min(len);
    let a = clamp(start);
    let b = end.map_or(len, clamp);
    a.min(b)..a.max(b)
}

/// `s.slice(start, end)`.
///
/// A surrogate pair cut in half by either boundary is dropped from the
/// result; JavaScript would keep the lone half.
pub fn slice(s: &str, start: i64, end: Option<i64>) -> &str {
    sub_str(s, slice_range(len(s), start, end))
}

/// `s.substring(start, end)`.
///
/// A surrogate pair cut in half by either boundary is dropped from the
/// result; JavaScript would keep the lone half.
pub fn substring(s: &str, start: i64, end: Option<i64>) -> &str {
    sub_str(s, substring_range(len(s), start, end))
}

/// `slice(start, end)` on UTF-16 code units, exact (it may split pairs).
pub fn slice_units(units: &[u16], start: i64, end: Option<i64>) -> &[u16] {
    let range = slice_range(units.len(), start, end);
    &units[range]
}

/// `substring(start, end)` on UTF-16 code units, exact (it may split pairs).
pub fn substring_units(units: &[u16], start: i64, end: Option<i64>) -> &[u16] {
    let range = substring_range(units.len(), start, end);
    &units[range]
}

/// The characters of `s` that lie entirely inside the code-unit `range`.
fn sub_str(s: &str, range: std::ops::Range<usize>) -> &str {
    let mut position = 0;
    let mut start_byte = None;
    let mut end_byte = 0;
    for (byte, c) in s.char_indices() {
        let width = c.len_utf16();
        if position >= range.end {
            break;
        }
        if position >= range.start && position + width <= range.end {
            start_byte.get_or_insert(byte);
            end_byte = byte + c.len_utf8();
        }
        position += width;
    }
    start_byte.map_or("", |start| &s[start..end_byte])
}

/// Converts UTF-16 code units into a `String`, dropping lone surrogates
/// (which a Rust string cannot hold).
pub fn units_to_string(units: &[u16]) -> String {
    char::decode_utf16(units.iter().copied())
        .filter_map(Result::ok)
        .collect()
}

/// `toLowerCase()` on UTF-16 code units that may contain lone surrogates.
///
/// Lone surrogates are kept and, as in V8, break the context of the
/// final-sigma rule (they are neither cased nor case-ignorable).
pub fn to_lowercase_units(units: &[u16]) -> Vec<u16> {
    map_case_units(units, str::to_lowercase)
}

/// `toUpperCase()` on UTF-16 code units that may contain lone surrogates.
pub fn to_uppercase_units(units: &[u16]) -> Vec<u16> {
    map_case_units(units, str::to_uppercase)
}

fn map_case_units(units: &[u16], map: fn(&str) -> String) -> Vec<u16> {
    let mut out = Vec::with_capacity(units.len());
    let mut segment = String::new();
    for decoded in char::decode_utf16(units.iter().copied()) {
        match decoded {
            Ok(c) => segment.push(c),
            Err(error) => {
                out.extend(map(&segment).encode_utf16());
                segment.clear();
                out.push(error.unpaired_surrogate());
            }
        }
    }
    out.extend(map(&segment).encode_utf16());
    out
}

/// `s[0].toUpperCase() + s.slice(1)` (`""` stays `""`).
///
/// Only the first UTF-16 code unit is mapped, so an astral first character is
/// left unchanged (`"𐐨x"` stays `"𐐨x"`), while a full case mapping can
/// lengthen the string (`"ßa"` → `"SSa"`).
pub fn upper_first_unit(s: &str) -> String {
    map_first_unit(s, |c| c.to_uppercase().collect(), str::to_owned)
}

/// `s[0].toLowerCase() + s.slice(1)` (`""` stays `""`); see
/// [`upper_first_unit`].
pub fn lower_first_unit(s: &str) -> String {
    map_first_unit(s, |c| c.to_lowercase().collect(), str::to_owned)
}

/// `map_first(s[0]) + map_rest(s.slice(1))` for a case mapping `map_first`
/// of the first UTF-16 code unit and a case mapping (or the identity)
/// `map_rest`; `""` stays `""`.
///
/// If `s` starts with an astral character, `s[0]` is its high surrogate,
/// which no case mapping changes, and `s.slice(1)` starts with the lone low
/// surrogate, which is unchanged too and cuts the case-mapping context (as
/// for the final-sigma rule). So the character is kept and `map_rest` sees
/// only the text after it.
pub fn map_first_unit(
    s: &str,
    map_first: impl FnOnce(char) -> String,
    map_rest: impl FnOnce(&str) -> String,
) -> String {
    let mut chars = s.chars();
    let Some(first) = chars.next() else {
        return String::new();
    };
    let mut out = if first.len_utf16() == 1 {
        map_first(first)
    } else {
        first.to_string()
    };
    out.push_str(&map_rest(chars.as_str()));
    out
}

/// Whether the single UTF-16 code unit `unit` is unchanged by `toUpperCase()`,
/// i.e. JavaScript's `c === c.toUpperCase()` for a one-unit string `c`.
pub fn unit_is_own_uppercase(unit: u16) -> bool {
    match char::from_u32(u32::from(unit)) {
        // A lone surrogate has no case mapping.
        None => true,
        Some(c) => {
            let mut upper = c.to_uppercase();
            upper.next() == Some(c) && upper.next().is_none()
        }
    }
}

/// A string's UTF-16 code units, for porting JavaScript code that indexes a
/// string in a loop: `length`, `charCodeAt` and `codePointAt` are O(1) here,
/// where the `&str` functions of this module are O(n) per call.
///
/// The units may contain lone surrogates (for example after
/// [`CodeUnits::slice`]); converting back with [`CodeUnits::to_string_lossy`]
/// drops them.
#[derive(Debug, Clone, Default, PartialEq, Eq, Hash)]
pub struct CodeUnits {
    units: Vec<u16>,
}

impl CodeUnits {
    /// The code units of `s`.
    pub fn new(s: &str) -> Self {
        CodeUnits {
            units: s.encode_utf16().collect(),
        }
    }

    /// `s.length`.
    pub fn len(&self) -> usize {
        self.units.len()
    }

    /// `s.length === 0`.
    pub fn is_empty(&self) -> bool {
        self.units.is_empty()
    }

    /// The code units.
    pub fn as_units(&self) -> &[u16] {
        &self.units
    }

    /// `s.charCodeAt(index)`; `None` where JavaScript returns `NaN`.
    pub fn char_code_at(&self, index: usize) -> Option<u16> {
        self.units.get(index).copied()
    }

    /// `s.codePointAt(index)`; `None` where JavaScript returns `undefined`.
    pub fn code_point_at(&self, index: usize) -> Option<u32> {
        code_point_at_units(&self.units, index)
    }

    /// `s.slice(start, end)`, exact (it may split surrogate pairs).
    pub fn slice(&self, start: i64, end: Option<i64>) -> &[u16] {
        slice_units(&self.units, start, end)
    }

    /// `s.substring(start, end)`, exact (it may split surrogate pairs).
    pub fn substring(&self, start: i64, end: Option<i64>) -> &[u16] {
        substring_units(&self.units, start, end)
    }

    /// The string, with any lone surrogates dropped (see [`units_to_string`]).
    pub fn to_string_lossy(&self) -> String {
        units_to_string(&self.units)
    }
}

impl From<&str> for CodeUnits {
    fn from(s: &str) -> Self {
        CodeUnits::new(s)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn lengths_and_indexing() {
        assert_eq!(len("a😀b"), 4);
        assert_eq!(char_code_at("a😀b", 1), Some(0xD83D));
        assert_eq!(char_code_at("a😀b", 4), None);
        assert_eq!(code_point_at("a😀b", 1), Some(0x1F600));
        assert_eq!(code_point_at("a😀b", 2), Some(0xDE00));
        assert_eq!(code_point_at("a😀b", 3), Some(u32::from('b')));
    }

    #[test]
    fn slicing() {
        assert_eq!(slice("hello", 1, Some(-1)), "ell");
        assert_eq!(slice("hello", -3, None), "llo");
        assert_eq!(slice("hello", 3, Some(1)), "");
        assert_eq!(substring("hello", 3, Some(1)), "el");
        assert_eq!(substring("hello", -3, None), "hello");
        // Cutting through a surrogate pair drops the orphaned half.
        assert_eq!(slice("a😀b", 0, Some(2)), "a");
        assert_eq!(slice("a😀b", 2, None), "b");
        let units: Vec<u16> = units("a😀b").collect();
        assert_eq!(slice_units(&units, 0, Some(2)), &[0x61, 0xD83D]);
    }

    #[test]
    fn code_units_index_in_constant_time() {
        let units = CodeUnits::new("a😀b");
        assert_eq!(units.len(), 4);
        assert_eq!(units.char_code_at(1), Some(0xD83D));
        assert_eq!(units.code_point_at(1), Some(0x1F600));
        assert_eq!(units.code_point_at(2), Some(0xDE00));
        assert_eq!(units.char_code_at(4), None);
        assert_eq!(units.slice(0, Some(2)), &[0x61, 0xD83D]);
        assert_eq!(units.to_string_lossy(), "a😀b");
    }

    #[test]
    fn first_unit_case() {
        assert_eq!(upper_first_unit("ßtraße"), "SStraße");
        assert_eq!(upper_first_unit("𐐨x"), "𐐨x");
        assert_eq!(lower_first_unit("ABC"), "aBC");
        assert_eq!(upper_first_unit(""), "");
        let first_upper_rest_lower =
            |s| map_first_unit(s, |c| c.to_uppercase().collect(), str::to_lowercase);
        assert_eq!(first_upper_rest_lower("ßTRASSE"), "SStrasse");
        assert_eq!(first_upper_rest_lower("𐐨XΣ"), "𐐨xς");
        assert!(unit_is_own_uppercase(0xD800));
        assert!(!unit_is_own_uppercase(u16::from(b'a')));
        assert!(!unit_is_own_uppercase(0xDF)); // ß → SS
    }

    #[test]
    fn case_mapping_with_lone_surrogates() {
        let units: Vec<u16> = "ΑΣ"
            .encode_utf16()
            .chain([0xDC00])
            .chain("Σ".encode_utf16())
            .collect();
        assert_eq!(to_lowercase_units(&units), [0x3B1, 0x3C2, 0xDC00, 0x3C3]);
    }
}
