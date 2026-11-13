//! A port of urijs 1.19.11 (`node_modules/urijs/src/URI.js`), the subset
//! quicktype uses, together with JavaScript's `encodeURIComponent` and
//! `decodeURIComponent`.
//!
//! quicktype keeps every JSON Schema address, `$ref` and `$id` as a urijs
//! `URI`, and the strings urijs builds end up in type names and error
//! messages. urijs is not an RFC 3986 implementation (and the `url` crate,
//! which follows WHATWG, is further off still): it accepts relative
//! references without a base, treats `\` as `/` in some places, recodes
//! paths through `decodeURIComponent` (which throws on a stray `%`), and has
//! quirks such as `absoluteTo` only appending `/` to a path that is exactly
//! `..`. Everything here follows the JavaScript source step by step.
//!
//! Ported: parsing (`new URI(string)`), building (`toString`), `clone`, the
//! accessors `protocol`, `host`, `path`, `query`, `fragment`/`hash`,
//! `filename`, `suffix` and `directory` (getters, and setters for path,
//! query and fragment), `normalize` (including punycode `toASCII` for
//! internationalized host names and `IPv6.best`), `absoluteTo` and `equals`.
//! The global options keep their defaults (`escapeQuerySpace`, no
//! `duplicateQueryParameters`, no `preventInvalidHostname`).
//!
//! Strings are Rust strings, so the lone surrogates a JavaScript string can
//! hold cannot occur (see "Known gaps" in `docs/PARITY.md`).

use std::fmt;
use std::sync::OnceLock;

use indexmap::IndexMap;
use regex::Regex;

use crate::json::insert_js_property;
use crate::number;

/// An exception urijs (or `decodeURIComponent`) throws.
#[derive(Clone, Debug, PartialEq, Eq)]
pub enum UriError {
    /// `URIError: URI malformed`, from `decodeURIComponent`.
    Malformed,
    /// `TypeError: Port "…" is not a valid port`.
    InvalidPort(String),
    /// `Error: URNs do not have any generally defined hierarchical
    /// components`, from `absoluteTo` on a URN.
    UrnNotHierarchical,
    /// `RangeError: …` from punycode (inputs needing wider integers).
    PunycodeOverflow,
}

impl UriError {
    /// The JavaScript error's `name`.
    pub fn name(&self) -> &'static str {
        match self {
            UriError::Malformed => "URIError",
            UriError::InvalidPort(_) => "TypeError",
            UriError::UrnNotHierarchical => "Error",
            UriError::PunycodeOverflow => "RangeError",
        }
    }

    /// The JavaScript error's `message`.
    pub fn message(&self) -> String {
        match self {
            UriError::Malformed => "URI malformed".to_owned(),
            UriError::InvalidPort(port) => format!("Port \"{port}\" is not a valid port"),
            UriError::UrnNotHierarchical => {
                "URNs do not have any generally defined hierarchical components".to_owned()
            }
            UriError::PunycodeOverflow => {
                "Overflow: input needs wider integers to process".to_owned()
            }
        }
    }
}

/// Like JavaScript's `Error.prototype.toString`: `name: message`.
impl fmt::Display for UriError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{}: {}", self.name(), self.message())
    }
}

impl std::error::Error for UriError {}

/// The result type of fallible URI operations.
pub type Result<T> = std::result::Result<T, UriError>;

// ---------------------------------------------------------------------------
// encodeURIComponent / decodeURIComponent

const HEX_UPPER: &[u8; 16] = b"0123456789ABCDEF";

fn push_percent_encoded(out: &mut String, byte: u8) {
    out.push('%');
    out.push(char::from(HEX_UPPER[usize::from(byte >> 4)]));
    out.push(char::from(HEX_UPPER[usize::from(byte & 0xF)]));
}

/// JavaScript `encodeURIComponent(s)`: every character except
/// `A-Z a-z 0-9 - _ . ! ~ * ' ( )` as percent-encoded UTF-8 (uppercase hex).
pub fn encode_uri_component(s: &str) -> String {
    let mut out = String::with_capacity(s.len());
    for &b in s.as_bytes() {
        if b.is_ascii_alphanumeric() || b"-_.!~*'()".contains(&b) {
            out.push(char::from(b));
        } else {
            push_percent_encoded(&mut out, b);
        }
    }
    out
}

/// urijs `URI.encode` (`strictEncodeURIComponent`): `encodeURIComponent`
/// that also escapes `! ' ( ) *`.
pub fn strict_encode_uri_component(s: &str) -> String {
    let mut out = String::with_capacity(s.len());
    for &b in s.as_bytes() {
        if b.is_ascii_alphanumeric() || b"-_.~".contains(&b) {
            out.push(char::from(b));
        } else {
            push_percent_encoded(&mut out, b);
        }
    }
    out
}

fn hex_value(b: u8) -> Option<u8> {
    match b {
        b'0'..=b'9' => Some(b - b'0'),
        b'a'..=b'f' => Some(b - b'a' + 10),
        b'A'..=b'F' => Some(b - b'A' + 10),
        _ => None,
    }
}

/// JavaScript `decodeURIComponent(s)` (also urijs `URI.decode`): decodes
/// every `%XX` escape as UTF-8. Throws `URIError: URI malformed` for a `%`
/// not followed by two hex digits and for escapes that are not valid UTF-8
/// (overlong forms, surrogates, code points above U+10FFFF).
pub fn decode_uri_component(s: &str) -> Result<String> {
    let bytes = s.as_bytes();
    // The byte of the `%XX` escape at `i`.
    let byte_at = |i: usize| -> Result<u8> {
        match (bytes.get(i), bytes.get(i + 1), bytes.get(i + 2)) {
            (Some(b'%'), Some(&hi), Some(&lo)) => match (hex_value(hi), hex_value(lo)) {
                (Some(hi), Some(lo)) => Ok(hi << 4 | lo),
                _ => Err(UriError::Malformed),
            },
            _ => Err(UriError::Malformed),
        }
    };
    let mut out: Vec<u8> = Vec::with_capacity(bytes.len());
    let mut i = 0;
    while i < bytes.len() {
        if bytes[i] != b'%' {
            out.push(bytes[i]);
            i += 1;
            continue;
        }
        let first = byte_at(i)?;
        i += 3;
        if first < 0x80 {
            out.push(first);
            continue;
        }
        let (count, min, initial) = match first {
            0xC0..=0xDF => (1, 0x80, u32::from(first & 0x1F)),
            0xE0..=0xEF => (2, 0x800, u32::from(first & 0x0F)),
            0xF0..=0xF7 => (3, 0x1_0000, u32::from(first & 0x07)),
            _ => return Err(UriError::Malformed),
        };
        let mut code_point = initial;
        for _ in 0..count {
            let next = byte_at(i)?;
            if next & 0xC0 != 0x80 {
                return Err(UriError::Malformed);
            }
            code_point = (code_point << 6) | u32::from(next & 0x3F);
            i += 3;
        }
        if code_point < min || (0xD800..=0xDFFF).contains(&code_point) {
            return Err(UriError::Malformed);
        }
        let c = char::from_u32(code_point).ok_or(UriError::Malformed)?;
        let mut buf = [0; 4];
        out.extend_from_slice(c.encode_utf8(&mut buf).as_bytes());
    }
    // Only whole UTF-8 sequences were added, so this cannot fail.
    String::from_utf8(out).map_err(|_| UriError::Malformed)
}

/// Replaces the case-insensitive escapes `%XX` listed in `codes` by their
/// characters (urijs' `URI.characters[group].encode` maps).
fn unescape_listed(s: &str, codes: &[(&str, char)]) -> String {
    let mut out = String::with_capacity(s.len());
    let mut rest = s;
    while let Some(pos) = rest.find('%') {
        out.push_str(&rest[..pos]);
        let escape = rest.get(pos..pos + 3);
        match escape.and_then(|e| {
            codes
                .iter()
                .find(|(code, _)| code.eq_ignore_ascii_case(e))
                .map(|(_, c)| *c)
        }) {
            Some(c) => {
                out.push(c);
                rest = &rest[pos + 3..];
            }
            None => {
                out.push('%');
                rest = &rest[pos + 1..];
            }
        }
    }
    out.push_str(rest);
    out
}

const PATHNAME_ENCODE: &[(&str, char)] = &[
    ("%24", '$'),
    ("%26", '&'),
    ("%2B", '+'),
    ("%2C", ','),
    ("%3B", ';'),
    ("%3D", '='),
    ("%3A", ':'),
    ("%40", '@'),
];

const URNPATH_ENCODE: &[(&str, char)] = &[
    ("%21", '!'),
    ("%24", '$'),
    ("%27", '\''),
    ("%28", '('),
    ("%29", ')'),
    ("%2A", '*'),
    ("%2B", '+'),
    ("%2C", ','),
    ("%3B", ';'),
    ("%3D", '='),
    ("%40", '@'),
];

/// urijs `URI.encodePathSegment`.
pub fn encode_path_segment(s: &str) -> String {
    unescape_listed(&strict_encode_uri_component(s), PATHNAME_ENCODE)
}

fn encode_urn_path_segment(s: &str) -> String {
    unescape_listed(&strict_encode_uri_component(s), URNPATH_ENCODE)
}

/// urijs `URI.decodePathSegment`: decodes, then re-escapes `/ ? #`; returns
/// the input unchanged if it cannot be decoded.
pub fn decode_path_segment(s: &str) -> String {
    match decode_uri_component(s) {
        Ok(decoded) => {
            let mut out = String::with_capacity(decoded.len());
            for c in decoded.chars() {
                match c {
                    '/' => out.push_str("%2F"),
                    '?' => out.push_str("%3F"),
                    '#' => out.push_str("%23"),
                    c => out.push(c),
                }
            }
            out
        }
        Err(_) => s.to_owned(),
    }
}

/// urijs `URI.recodePath`: each `/`-separated segment is decoded (which
/// throws on a malformed escape) and re-encoded.
pub fn recode_path(s: &str) -> Result<String> {
    let segments: Result<Vec<String>> = s
        .split('/')
        .map(|segment| Ok(encode_path_segment(&decode_uri_component(segment)?)))
        .collect();
    Ok(segments?.join("/"))
}

/// urijs `URI.recodeUrnPath`: like [`recode_path`], with `:` separators.
fn recode_urn_path(s: &str) -> Result<String> {
    let segments: Result<Vec<String>> = s
        .split(':')
        .map(|segment| Ok(encode_urn_path_segment(&decode_uri_component(segment)?)))
        .collect();
    Ok(segments?.join(":"))
}

// ---------------------------------------------------------------------------
// JavaScript string helpers

/// JavaScript `s.substring(start, end)` with byte offsets that are known to
/// be character boundaries or beyond the end: clamps to `0..=len` and swaps
/// a reversed range.
fn js_substring(s: &str, start: isize, end: isize) -> &str {
    let len = s.len() as isize;
    let a = start.clamp(0, len) as usize;
    let b = end.clamp(0, len) as usize;
    let (a, b) = if a > b { (b, a) } else { (a, b) };
    s.get(a..b).unwrap_or("")
}

fn index_of(s: &str, c: char) -> isize {
    s.find(c).map_or(-1, |i| i as isize)
}

/// `Some(s)` unless `s` is empty (JavaScript `s || null`).
fn non_empty(s: &str) -> Option<String> {
    if s.is_empty() {
        None
    } else {
        Some(s.to_owned())
    }
}

/// `URI.leading_whitespace_expression`.
fn is_leading_whitespace(c: char) -> bool {
    matches!(
        c,
        '\u{00}'..='\u{20}'
            | '\u{A0}'
            | '\u{1680}'
            | '\u{2000}'..='\u{200A}'
            | '\u{2028}'
            | '\u{2029}'
            | '\u{202F}'
            | '\u{205F}'
            | '\u{3000}'
            | '\u{FEFF}'
    )
}

/// `URI.protocol_expression`: `/^[a-z][a-z0-9.+-]*$/i`.
fn is_valid_protocol(s: &str) -> bool {
    let mut chars = s.chars();
    chars.next().is_some_and(|c| c.is_ascii_alphabetic())
        && chars.all(|c| c.is_ascii_alphanumeric() || matches!(c, '.' | '+' | '-'))
}

/// `URI.ip4_expression`: `/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/`.
fn is_ip4(s: &str) -> bool {
    let parts: Vec<&str> = s.split('.').collect();
    parts.len() == 4
        && parts
            .iter()
            .all(|p| (1..=3).contains(&p.len()) && p.bytes().all(|b| b.is_ascii_digit()))
}

/// `URI.ip6_expression`, translated to JavaScript's `\d`, `\s` and `.`.
fn is_ip6(s: &str) -> bool {
    static IP6: OnceLock<Option<Regex>> = OnceLock::new();
    let ws = crate::whitespace::CLASS;
    IP6.get_or_init(|| {
        let h = "[0-9A-Fa-f]{1,4}";
        let d = r"(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])";
        let v4 = format!(r"({d}(\.{d}){{3}})");
        let pattern = format!(
            "^{ws}*(\
(({h}:){{7}}({h}|:))|\
(({h}:){{6}}(:{h}|{v4}|:))|\
(({h}:){{5}}(((:{h}){{1,2}})|:{v4}|:))|\
(({h}:){{4}}(((:{h}){{1,3}})|((:{h})?:{v4})|:))|\
(({h}:){{3}}(((:{h}){{1,4}})|((:{h}){{0,2}}:{v4})|:))|\
(({h}:){{2}}(((:{h}){{1,5}})|((:{h}){{0,3}}:{v4})|:))|\
(({h}:){{1}}(((:{h}){{1,6}})|((:{h}){{0,4}}:{v4})|:))|\
(:(((:{h}){{1,7}})|((:{h}){{0,5}}:{v4})|:))\
)(%[^\n\r\u{2028}\u{2029}]+)?{ws}*$"
        );
        Regex::new(&pattern).ok()
    })
    .as_ref()
    .is_some_and(|re| re.is_match(s))
}

/// `URI.idn_expression`: `/[^a-z0-9\._-]/i`.
fn has_idn_characters(s: &str) -> bool {
    s.chars()
        .any(|c| !(c.is_ascii_alphanumeric() || matches!(c, '.' | '_' | '-')))
}

/// `URI.ensureValidPort(v)`: `Number(v)` must print as an integer in
/// `1..=65535`.
fn ensure_valid_port(v: &str) -> Result<()> {
    if v.is_empty() {
        return Ok(());
    }
    let port = number::string_to_number(v);
    let printed = number::to_string(port);
    let is_integer = !printed.is_empty() && printed.bytes().all(|b| b.is_ascii_digit());
    if is_integer && port > 0.0 && port < 65536.0 {
        Ok(())
    } else {
        Err(UriError::InvalidPort(v.to_owned()))
    }
}

// ---------------------------------------------------------------------------
// Query strings

/// A parsed query (`URI.parseQuery`): a JavaScript object, so array-index
/// names come first in ascending order. A name given more than once has
/// several values; `None` is a parameter without `=`.
type QueryData = IndexMap<String, Vec<Option<String>>>;

/// urijs `URI.decodeQuery`: `+` is a space; undecodable text is kept.
fn decode_query(s: &str) -> String {
    decode_uri_component(&s.replace('+', "%20")).unwrap_or_else(|_| s.to_owned())
}

/// urijs `URI.encodeQuery`: strict encoding with spaces as `+`.
fn encode_query(s: &str) -> String {
    strict_encode_uri_component(s).replace("%20", "+")
}

/// urijs `URI.parseQuery(string)`.
fn parse_query(s: &str) -> QueryData {
    let mut items = QueryData::new();
    // Collapse `&&`, then drop leading `?`/`&` and trailing `&`.
    let mut collapsed = String::with_capacity(s.len());
    for c in s.chars() {
        if c == '&' && collapsed.ends_with('&') {
            continue;
        }
        collapsed.push(c);
    }
    let trimmed = collapsed.trim_start_matches('?');
    let trimmed = trimmed.strip_prefix('&').unwrap_or(trimmed);
    let trimmed = trimmed.strip_suffix('&').unwrap_or(trimmed);
    if trimmed.is_empty() {
        return items;
    }
    for split in trimmed.split('&') {
        let mut v = split.split('=');
        let name = decode_query(v.next().unwrap_or(""));
        let rest: Vec<&str> = v.collect();
        let value = if rest.is_empty() {
            None
        } else {
            Some(decode_query(&rest.join("=")))
        };
        if name == "__proto__" {
            continue;
        }
        if let Some(values) = items.get_mut(&name) {
            values.push(value);
        } else {
            insert_js_property(&mut items, name, vec![value]);
        }
    }
    items
}

/// urijs `URI.buildQuery(data)`, without duplicate parameters.
fn build_query(data: &QueryData) -> String {
    let mut t = String::new();
    for (key, values) in data {
        let mut unique: Vec<&str> = Vec::new();
        for value in values {
            // `unique[value + ""]`: a missing value is the key "null".
            let unique_key = value.as_deref().unwrap_or("null");
            if unique.contains(&unique_key) {
                continue;
            }
            t.push('&');
            t.push_str(&encode_query(key));
            if let Some(v) = value {
                t.push('=');
                t.push_str(&encode_query(v));
            }
            unique.push(unique_key);
        }
    }
    t.get(1..).unwrap_or("").to_owned()
}

/// `arraysEqual` on two sorted value lists (as `equals` uses it).
fn query_values_equal(one: &[Option<String>], two: &[Option<String>]) -> bool {
    if one.len() != two.len() {
        return false;
    }
    // `Array.prototype.sort()` compares the values' string forms; `null`
    // sorts as "null".
    let sorted = |values: &[Option<String>]| {
        let mut v: Vec<Option<String>> = values.to_vec();
        crate::sort::sort_by(&mut v, |a, b| {
            crate::sort::compare_utf16(
                a.as_deref().unwrap_or("null"),
                b.as_deref().unwrap_or("null"),
            )
        });
        v
    };
    sorted(one) == sorted(two)
}

// ---------------------------------------------------------------------------
// punycode and IPv6

mod punycode {
    use super::UriError;

    const MAX_INT: u32 = 2_147_483_647;
    const BASE: u32 = 36;
    const T_MIN: u32 = 1;
    const T_MAX: u32 = 26;
    const SKEW: u32 = 38;
    const DAMP: u32 = 700;
    const INITIAL_BIAS: u32 = 72;
    const INITIAL_N: u32 = 128;

    fn digit_to_basic(digit: u32) -> char {
        // digit + 22 + 75 * (digit < 26): 0..25 -> a..z, 26..35 -> 0..9.
        let code = digit + 22 + if digit < 26 { 75 } else { 0 };
        char::from_u32(code).unwrap_or('?')
    }

    fn adapt(delta: u32, num_points: u32, first_time: bool) -> u32 {
        let mut k = 0;
        let mut delta = if first_time { delta / DAMP } else { delta >> 1 };
        delta += delta / num_points;
        while delta > ((BASE - T_MIN) * T_MAX) >> 1 {
            delta /= BASE - T_MIN;
            k += BASE;
        }
        k + (BASE - T_MIN + 1) * delta / (delta + SKEW)
    }

    /// `punycode.encode(input)`.
    fn encode(input: &str) -> Result<String, UriError> {
        let input: Vec<u32> = input.chars().map(u32::from).collect();
        let mut output: String = input
            .iter()
            .filter(|&&c| c < 0x80)
            .filter_map(|&c| char::from_u32(c))
            .collect();
        let basic_length = output.len() as u32;
        let mut handled = basic_length;
        if basic_length > 0 {
            output.push('-');
        }
        let mut n = INITIAL_N;
        let mut delta: u32 = 0;
        let mut bias = INITIAL_BIAS;
        let input_length = input.len() as u32;
        while handled < input_length {
            let m = input
                .iter()
                .copied()
                .filter(|&c| c >= n)
                .min()
                .unwrap_or(MAX_INT);
            let handled_plus_one = handled + 1;
            if m - n > (MAX_INT - delta) / handled_plus_one {
                return Err(UriError::PunycodeOverflow);
            }
            delta += (m - n) * handled_plus_one;
            n = m;
            for &c in &input {
                if c < n {
                    delta += 1;
                    if delta > MAX_INT {
                        return Err(UriError::PunycodeOverflow);
                    }
                }
                if c == n {
                    let mut q = delta;
                    let mut k = BASE;
                    loop {
                        let t = if k <= bias {
                            T_MIN
                        } else if k >= bias + T_MAX {
                            T_MAX
                        } else {
                            k - bias
                        };
                        if q < t {
                            break;
                        }
                        let q_minus_t = q - t;
                        let base_minus_t = BASE - t;
                        output.push(digit_to_basic(t + q_minus_t % base_minus_t));
                        q = q_minus_t / base_minus_t;
                        k += BASE;
                    }
                    output.push(digit_to_basic(q));
                    bias = adapt(delta, handled_plus_one, handled == basic_length);
                    delta = 0;
                    handled += 1;
                }
            }
            delta += 1;
            n += 1;
        }
        Ok(output)
    }

    /// `punycode.toASCII(domain)` (punycode.js 1.4): labels with characters
    /// outside U+0020..U+007E become `xn--` + their encoding.
    pub(super) fn to_ascii(input: &str) -> Result<String, UriError> {
        let (prefix, domain) = match input.split_once('@') {
            // `string.split('@')`: everything after the second `@` is lost.
            Some((local, rest)) => (
                format!("{local}@"),
                rest.split('@').next().unwrap_or("").to_owned(),
            ),
            None => (String::new(), input.to_owned()),
        };
        let domain: String = domain
            .chars()
            .map(|c| match c {
                '\u{3002}' | '\u{FF0E}' | '\u{FF61}' => '.',
                c => c,
            })
            .collect();
        let labels: Result<Vec<String>, UriError> = domain
            .split('.')
            .map(|label| {
                if label.chars().any(|c| !('\u{20}'..='\u{7E}').contains(&c)) {
                    Ok(format!("xn--{}", encode(label)?))
                } else {
                    Ok(label.to_owned())
                }
            })
            .collect();
        Ok(format!("{prefix}{}", labels?.join(".")))
    }
}

/// `IPv6.best(address)` (urijs `IPv6.js`): the shortest presentation, for an
/// address that passed `URI.ip6_expression`.
fn ipv6_best(address: &str) -> String {
    let lower = address.to_lowercase();
    let mut segments: Vec<String> = lower.split(':').map(str::to_owned).collect();
    let mut total = 8;
    let is_empty = |segments: &[String], i: usize| segments.get(i).is_some_and(String::is_empty);
    let length = segments.len();
    if is_empty(&segments, 0) && is_empty(&segments, 1) && is_empty(&segments, 2) {
        segments.drain(..2);
    } else if is_empty(&segments, 0) && is_empty(&segments, 1) {
        segments.remove(0);
    } else if length >= 2 && is_empty(&segments, length - 1) && is_empty(&segments, length - 2) {
        segments.pop();
    }
    if segments.last().is_some_and(|s| s.contains('.')) {
        total = 7;
    }
    let pos = segments
        .iter()
        .position(String::is_empty)
        .unwrap_or(segments.len());
    if pos < total {
        if pos < segments.len() {
            segments[pos] = "0000".to_owned();
        } else {
            segments.push("0000".to_owned());
        }
        while segments.len() < total {
            segments.insert(pos, "0000".to_owned());
        }
    }
    for segment in segments.iter_mut().take(total) {
        // Strip up to three leading zeros, keeping at least one character.
        for _ in 0..3 {
            if segment.len() > 1 && segment.starts_with('0') {
                segment.remove(0);
            } else {
                break;
            }
        }
    }
    let mut best: Option<usize> = None;
    let mut best_len = 0;
    let mut current = 0;
    let mut current_len = 0;
    let mut in_zeroes = false;
    for (i, segment) in segments.iter().enumerate().take(total) {
        if in_zeroes {
            if segment == "0" {
                current_len += 1;
            } else {
                in_zeroes = false;
                if current_len > best_len {
                    best = Some(current);
                    best_len = current_len;
                }
            }
        } else if segment == "0" {
            in_zeroes = true;
            current = i;
            current_len = 1;
        }
    }
    if current_len > best_len {
        best = Some(current);
        best_len = current_len;
    }
    if best_len > 1
        && let Some(best) = best
    {
        let end = (best + best_len).min(segments.len());
        segments.splice(best..end, [String::new()]);
    }
    let mut result = String::new();
    if segments.first().is_some_and(String::is_empty) {
        result.push(':');
    }
    result.push_str(&segments.join(":"));
    if segments.last().is_some_and(String::is_empty) {
        result.push(':');
    }
    result
}

// ---------------------------------------------------------------------------
// URI

/// A urijs `URI`: the parsed parts. `toString()` ([`fmt::Display`]) builds
/// the string from them, as urijs does after every change.
///
/// urijs distinguishes `null` from `""` (and `undefined`) for several parts,
/// but no operation ported here observes the difference, so missing parts
/// are `None` and present parts are never empty (except `path`, which is
/// always a string).
#[derive(Clone, Debug, Default, PartialEq, Eq, Hash)]
pub struct Uri {
    protocol: Option<String>,
    username: Option<String>,
    password: Option<String>,
    hostname: Option<String>,
    port: Option<String>,
    urn: bool,
    path: String,
    query: Option<String>,
    fragment: Option<String>,
}

impl Uri {
    /// `new URI(string)` (`URI.parse`). Throws for an invalid port or a
    /// malformed escape in the user name or password.
    pub fn parse(input: &str) -> Result<Uri> {
        let mut uri = Uri::default();
        let mut s: String = input.trim_start_matches(is_leading_whitespace).to_owned();
        s.retain(|c| !matches!(c, '\t' | '\n' | '\r'));

        if let Some(pos) = s.find('#') {
            uri.fragment = non_empty(&s[pos + 1..]);
            s.truncate(pos);
        }
        if let Some(pos) = s.find('?') {
            uri.query = non_empty(&s[pos + 1..]);
            s.truncate(pos);
        }

        // `^(https?|ftp|wss?)?:+[/\\]*` → `$1://` (case-insensitive).
        s = rewrite_web_protocol(&s);
        // `^[/\\]{2,}` → `//`.
        let slashes = s.len() - s.trim_start_matches(['/', '\\']).len();
        if slashes >= 2 {
            s = format!("//{}", &s[slashes..]);
        }

        let rest: String;
        if let Some(authority) = s.strip_prefix("//") {
            uri.protocol = None;
            rest = parse_authority(authority, &mut uri)?;
        } else if let Some(pos) = s.find(':') {
            let protocol = &s[..pos];
            if !protocol.is_empty() && !is_valid_protocol(protocol) {
                // `:` may be within the path.
                uri.protocol = None;
                rest = s.clone();
            } else {
                uri.protocol = non_empty(protocol);
                let after = &s[pos + 1..];
                let two: String = after.chars().take(2).collect();
                if two.replace('\\', "/") == "//" {
                    let authority: String = after.chars().skip(2).collect();
                    rest = parse_authority(&authority, &mut uri)?;
                } else {
                    rest = after.to_owned();
                    uri.urn = true;
                }
            }
        } else {
            rest = s.clone();
        }
        uri.path = rest;
        Ok(uri)
    }

    /// `clone()`: `new URI(this)`. Like urijs, it sets the query through the
    /// query setter, which drops a leading `?` (`a??b` clones as `a?b`).
    pub fn js_clone(&self) -> Uri {
        let mut copy = self.clone();
        copy.query = self
            .query
            .as_deref()
            .and_then(|q| non_empty(q.strip_prefix('?').unwrap_or(q)));
        copy
    }

    /// `protocol()`.
    pub fn protocol(&self) -> &str {
        self.protocol.as_deref().unwrap_or("")
    }

    /// `hostname()`.
    pub fn hostname(&self) -> &str {
        if self.urn {
            return "";
        }
        self.hostname.as_deref().unwrap_or("")
    }

    /// `host()`: host name and port.
    pub fn host(&self) -> String {
        if self.urn {
            return String::new();
        }
        if self.hostname.is_some() {
            self.build_host()
        } else {
            String::new()
        }
    }

    /// Whether this is a URN (`scheme:path` without `//`).
    pub fn is_urn(&self) -> bool {
        self.urn
    }

    /// `path()`.
    pub fn path(&self) -> &str {
        if !self.path.is_empty() {
            &self.path
        } else if self.hostname.is_some() {
            "/"
        } else {
            ""
        }
    }

    /// `path(v)`: recodes `v` (throws on a malformed escape); an empty path
    /// becomes `/` (or `""` for a URN).
    pub fn set_path(&mut self, v: &str) -> Result<()> {
        self.path = if self.urn {
            if v.is_empty() {
                String::new()
            } else {
                recode_urn_path(v)?
            }
        } else if v.is_empty() {
            "/".to_owned()
        } else {
            recode_path(v)?
        };
        Ok(())
    }

    /// `query()`.
    pub fn query(&self) -> &str {
        self.query.as_deref().unwrap_or("")
    }

    /// `query(v)` with a string: a leading `?` is dropped.
    pub fn set_query(&mut self, v: &str) {
        self.query = non_empty(v.strip_prefix('?').unwrap_or(v));
    }

    /// `fragment()`.
    pub fn fragment(&self) -> &str {
        self.fragment.as_deref().unwrap_or("")
    }

    /// `fragment(v)` (and `hash(v)`): a leading `#` is dropped.
    pub fn set_fragment(&mut self, v: &str) {
        self.fragment = non_empty(v.strip_prefix('#').unwrap_or(v));
    }

    /// `hash()`: `#` and the fragment, or `""`.
    pub fn hash(&self) -> String {
        match &self.fragment {
            Some(f) => format!("#{f}"),
            None => String::new(),
        }
    }

    /// `filename()`: the text after the path's last `/`.
    pub fn filename(&self) -> &str {
        if self.urn || self.path.is_empty() || self.path == "/" {
            return "";
        }
        match self.path.rfind('/') {
            Some(pos) => &self.path[pos + 1..],
            None => &self.path,
        }
    }

    /// `suffix()`: the filename's extension, if it is ASCII alphanumeric
    /// (or `%`).
    pub fn suffix(&self) -> &str {
        if self.urn || self.path.is_empty() || self.path == "/" {
            return "";
        }
        let filename = self.filename();
        let Some(pos) = filename.rfind('.') else {
            return "";
        };
        let s = &filename[pos + 1..];
        if !s.is_empty() && s.bytes().all(|b| b.is_ascii_alphanumeric() || b == b'%') {
            s
        } else {
            ""
        }
    }

    /// `directory()`: the path up to its last `/`.
    pub fn directory(&self) -> &str {
        if self.urn {
            return "";
        }
        if self.path.is_empty() && self.hostname.is_none() {
            return "";
        }
        if self.path == "/" {
            return "/";
        }
        let res = match self.path.rfind('/') {
            Some(pos) => &self.path[..pos],
            None => "",
        };
        if !res.is_empty() {
            res
        } else if self.hostname.is_some() {
            "/"
        } else {
            ""
        }
    }

    /// `URI.buildHost(parts)`.
    fn build_host(&self) -> String {
        let Some(hostname) = &self.hostname else {
            return String::new();
        };
        let mut t = if is_ip6(hostname) {
            format!("[{hostname}]")
        } else {
            hostname.clone()
        };
        if let Some(port) = &self.port {
            t.push(':');
            t.push_str(port);
        }
        t
    }

    /// `URI.buildUserinfo(parts)`.
    fn build_userinfo(&self) -> String {
        let mut t = String::new();
        if let Some(username) = &self.username {
            t.push_str(&strict_encode_uri_component(username));
        }
        if let Some(password) = &self.password {
            t.push(':');
            t.push_str(&strict_encode_uri_component(password));
        }
        if !t.is_empty() {
            t.push('@');
        }
        t
    }

    /// `is("relative")`.
    fn is_relative(&self) -> bool {
        !self.urn && self.hostname.is_none()
    }

    /// `normalize()`: lowercases protocol and host name (punycode-encoding
    /// internationalized names, shortening IPv6 addresses), drops default
    /// ports, recodes and resolves the path, and rebuilds the query. Throws
    /// on a malformed escape in the path.
    pub fn normalize(&mut self) -> Result<()> {
        self.normalize_protocol();
        if !self.urn {
            self.normalize_hostname()?;
            self.normalize_port();
        }
        self.normalize_path()?;
        self.normalize_query();
        // normalizeFragment: an empty fragment is already `None`.
        Ok(())
    }

    fn normalize_protocol(&mut self) {
        if let Some(p) = &mut self.protocol {
            *p = p.to_lowercase();
        }
    }

    fn normalize_hostname(&mut self) -> Result<()> {
        let Some(hostname) = &self.hostname else {
            return Ok(());
        };
        let ip = is_ip4(hostname) || is_ip6(hostname);
        let mut h = if !ip && has_idn_characters(hostname) {
            punycode::to_ascii(hostname)?
        } else if is_ip6(hostname) {
            ipv6_best(hostname)
        } else {
            hostname.clone()
        };
        h = h.to_lowercase();
        self.hostname = non_empty(&h);
        Ok(())
    }

    fn normalize_port(&mut self) {
        let default = match self.protocol.as_deref() {
            Some("http") | Some("ws") => "80",
            Some("https") | Some("wss") => "443",
            Some("ftp") => "21",
            Some("gopher") => "70",
            _ => return,
        };
        if self.port.as_deref() == Some(default) {
            self.port = None;
        }
    }

    /// `normalizePath()`.
    fn normalize_path(&mut self) -> Result<()> {
        if self.path.is_empty() {
            return Ok(());
        }
        if self.urn {
            self.path = recode_urn_path(&self.path)?;
            return Ok(());
        }
        if self.path == "/" {
            return Ok(());
        }
        let mut path = recode_path(&self.path)?;

        let was_relative = !path.starts_with('/');
        if was_relative {
            path.insert(0, '/');
        }
        // Relative files (as opposed to directories).
        if path.ends_with("/..") || path.ends_with("/.") {
            path.push('/');
        }
        // Resolve `/./` and collapse `//`.
        static SIMPLES: OnceLock<(Regex, Regex)> = OnceLock::new();
        let (simples, slashes) = SIMPLES.get_or_init(|| {
            (
                Regex::new(r"(/(\./)+)|(/\.$)").expect("valid regex"),
                Regex::new(r"/{2,}").expect("valid regex"),
            )
        });
        path = simples.replace_all(&path, "/").into_owned();
        path = slashes.replace_all(&path, "/").into_owned();

        let leading_parents = if was_relative {
            let after = &path[1..];
            let mut end = 0;
            while after[end..].starts_with("../") {
                end += 3;
            }
            after[..end].to_owned()
        } else {
            String::new()
        };

        // Resolve `..`.
        while let Some(parent) = find_parent_segment(&path) {
            if parent == 0 {
                // The top level cannot be relative; skip it.
                path = path.get(3..).unwrap_or("").to_owned();
                continue;
            }
            let pos = path[..parent].rfind('/').unwrap_or(parent);
            path = format!("{}{}", &path[..pos], path.get(parent + 3..).unwrap_or(""));
        }

        if was_relative && self.is_relative() {
            path = format!("{leading_parents}{}", path.get(1..).unwrap_or(""));
        }
        self.path = path;
        Ok(())
    }

    /// `normalizeQuery()`.
    fn normalize_query(&mut self) {
        if let Some(query) = &self.query {
            let built = build_query(&parse_query(query));
            self.query = non_empty(&built);
        }
    }

    /// `absoluteTo(base)`: this reference resolved against `base`.
    pub fn absolute_to(&self, base: &Uri) -> Result<Uri> {
        let mut resolved = self.js_clone();
        if self.urn {
            return Err(UriError::UrnNotHierarchical);
        }
        if resolved.protocol.is_some() {
            return Ok(resolved);
        }
        resolved.protocol = base.protocol.clone();
        if self.hostname.is_some() {
            return Ok(resolved);
        }
        resolved.username = base.username.clone();
        resolved.password = base.password.clone();
        resolved.hostname = base.hostname.clone();
        resolved.port = base.port.clone();

        if resolved.path.is_empty() {
            resolved.path = base.path.clone();
            if resolved.query.is_none() {
                resolved.query = base.query.clone();
            }
        } else {
            // urijs bug: `substring(-2)` is the whole path, so this only
            // fires for a path that is exactly "..".
            if resolved.path == ".." {
                resolved.path.push('/');
            }
            if !resolved.path().starts_with('/') {
                let directory = base.directory();
                let basedir = if !directory.is_empty() {
                    directory
                } else if base.path().starts_with('/') {
                    "/"
                } else {
                    ""
                };
                if !basedir.is_empty() {
                    resolved.path = format!("{basedir}/{}", resolved.path);
                }
                resolved.normalize_path()?;
            }
        }
        Ok(resolved)
    }

    /// `equals(other)`: equal after normalizing both, with query parameters
    /// compared as unordered sets.
    pub fn equals(&self, other: &Uri) -> Result<bool> {
        let mut one = self.js_clone();
        let mut two = other.js_clone();
        one.normalize()?;
        two.normalize()?;
        if one.to_string() == two.to_string() {
            return Ok(true);
        }
        let one_query = one.query.take().unwrap_or_default();
        let two_query = two.query.take().unwrap_or_default();
        if one.to_string() != two.to_string() {
            return Ok(false);
        }
        if one_query.encode_utf16().count() != two_query.encode_utf16().count() {
            return Ok(false);
        }
        let one_map = parse_query(&one_query);
        let two_map = parse_query(&two_query);
        for (key, values) in &one_map {
            let Some(other_values) = two_map.get(key) else {
                return Ok(false);
            };
            let equal = match (values.as_slice(), other_values.as_slice()) {
                ([a], [b]) => a == b,
                _ => {
                    values.len() > 1
                        && other_values.len() > 1
                        && query_values_equal(values, other_values)
                }
            };
            if !equal {
                return Ok(false);
            }
        }
        Ok(two_map.keys().all(|k| one_map.contains_key(k)))
    }
}

/// `/\/\.\.(\/|$)/` search: the index of the first `/..` segment.
fn find_parent_segment(path: &str) -> Option<usize> {
    let mut from = 0;
    while let Some(i) = path[from..].find("/..") {
        let at = from + i;
        let after = &path[at + 3..];
        if after.is_empty() || after.starts_with('/') {
            return Some(at);
        }
        from = at + 1;
    }
    None
}

/// The `^(https?|ftp|wss?)?:+[/\\]*` → `$1://` rewrite of `URI.parse`.
fn rewrite_web_protocol(s: &str) -> String {
    for scheme in ["https", "http", "ftp", "wss", "ws", ""] {
        let Some(prefix) = s.get(..scheme.len()) else {
            continue;
        };
        if !prefix.eq_ignore_ascii_case(scheme) {
            continue;
        }
        let after = &s[scheme.len()..];
        let without_colons = after.trim_start_matches(':');
        if without_colons.len() == after.len() {
            continue;
        }
        let rest = without_colons.trim_start_matches(['/', '\\']);
        return format!("{prefix}://{rest}");
    }
    s.to_owned()
}

/// `URI.parseAuthority(string, parts)`: user info, then host and port.
/// Returns the rest (the path).
fn parse_authority(s: &str, uri: &mut Uri) -> Result<String> {
    let rest = parse_userinfo(s, uri)?;
    parse_host(&rest, uri)
}

/// `URI.parseUserinfo(string, parts)`.
fn parse_userinfo(original: &str, uri: &mut Uri) -> Result<String> {
    let s = original.replace('\\', "/");
    let first_slash = s.find('/');
    // `lastIndexOf('@', firstSlash ?? length - 1)`.
    let search_end = match first_slash {
        Some(i) => i + 1,
        None => s.len(),
    };
    let at = s[..search_end.min(s.len())].rfind('@');
    match at {
        Some(pos) if first_slash.is_none_or(|slash| pos < slash) => {
            let mut t = s[..pos].split(':');
            let user = t.next().unwrap_or("");
            uri.username = if user.is_empty() {
                None
            } else {
                Some(decode_uri_component(user)?)
            };
            let password: Vec<&str> = t.collect();
            uri.password = match password.first() {
                Some(first) if !first.is_empty() => {
                    Some(decode_uri_component(&password.join(":"))?)
                }
                _ => None,
            };
            Ok(original[pos + 1..].to_owned())
        }
        _ => {
            uri.username = None;
            uri.password = None;
            Ok(original.to_owned())
        }
    }
}

/// `URI.parseHost(string, parts)`. Returns the rest (the path, at least
/// `/`).
fn parse_host(original: &str, uri: &mut Uri) -> Result<String> {
    let s = original.replace('\\', "/");
    let pos = s.find('/').unwrap_or(s.len());
    if s.starts_with('[') {
        // IPv6 host: `[addr]:port`. Without `]`, urijs' `substring(1, -1)`
        // is `substring(0, 1)`, i.e. "[".
        let bracket = index_of(&s, ']');
        uri.hostname = non_empty(js_substring(&s, 1, bracket));
        // `substring(bracketPos + 2, pos)` skips the character after `]`.
        let port_start = if bracket < 0 {
            1
        } else {
            let after_bracket = bracket as usize + 1;
            after_bracket + s[after_bracket..].chars().next().map_or(1, char::len_utf8)
        };
        uri.port = non_empty(js_substring(&s, port_start as isize, pos as isize));
        if uri.port.as_deref() == Some("/") {
            uri.port = None;
        }
    } else {
        let first_colon = s.find(':');
        let first_slash = s.find('/');
        let next_colon = first_colon.and_then(|c| s[c + 1..].find(':').map(|i| c + 1 + i));
        if let Some(next) = next_colon
            && first_slash.is_none_or(|slash| next < slash)
        {
            // An IPv6 host with several colons but no port.
            uri.hostname = non_empty(&s[..pos]);
            uri.port = None;
        } else {
            let mut t = s[..pos].split(':');
            uri.hostname = non_empty(t.next().unwrap_or(""));
            uri.port = non_empty(t.next().unwrap_or(""));
        }
    }
    if let Some(port) = &uri.port {
        ensure_valid_port(port)?;
    }
    let rest = &s[pos..];
    Ok(if rest.is_empty() { "/" } else { rest }.to_owned())
}

/// `toString()` (`URI.build(parts)`).
impl fmt::Display for Uri {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let mut t = String::new();
        if let Some(protocol) = &self.protocol {
            t.push_str(protocol);
            t.push(':');
        }
        let mut require_absolute_path = false;
        if !self.urn && (!t.is_empty() || self.hostname.is_some()) {
            t.push_str("//");
            require_absolute_path = true;
        }
        t.push_str(&self.build_userinfo());
        t.push_str(&self.build_host());
        if !self.path.starts_with('/') && require_absolute_path {
            t.push('/');
        }
        t.push_str(&self.path);
        if let Some(query) = &self.query {
            t.push('?');
            t.push_str(query);
        }
        if let Some(fragment) = &self.fragment {
            t.push('#');
            t.push_str(fragment);
        }
        f.write_str(&t)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn s(input: &str) -> String {
        Uri::parse(input).unwrap().to_string()
    }

    fn normalized(input: &str) -> String {
        let mut uri = Uri::parse(input).unwrap();
        uri.normalize().unwrap();
        uri.to_string()
    }

    fn absolute(r: &str, base: &str) -> String {
        Uri::parse(r)
            .unwrap()
            .absolute_to(&Uri::parse(base).unwrap())
            .unwrap()
            .to_string()
    }

    #[test]
    fn components() {
        assert_eq!(decode_uri_component("a%20b").unwrap(), "a b");
        assert_eq!(decode_uri_component("%C3%A9").unwrap(), "é");
        assert_eq!(decode_uri_component("100%"), Err(UriError::Malformed));
        assert_eq!(decode_uri_component("%zz"), Err(UriError::Malformed));
        assert_eq!(decode_uri_component("%ED%A0%80"), Err(UriError::Malformed));
        assert_eq!(decode_uri_component("%C0%80"), Err(UriError::Malformed));
        assert_eq!(encode_uri_component("a b!'()*é"), "a%20b!'()*%C3%A9");
        assert_eq!(strict_encode_uri_component("!'()*"), "%21%27%28%29%2A");
        assert_eq!(UriError::Malformed.to_string(), "URIError: URI malformed");
    }

    #[test]
    fn parse_and_build() {
        assert_eq!(s("a/test2.json#/foo"), "a/test2.json#/foo");
        assert_eq!(s("http://Example.com"), "http://Example.com/");
        assert_eq!(s("http:\\\\x\\a\\b.jpg"), "http://x/a/b.jpg");
        assert_eq!(s("urn:isbn:1"), "urn:isbn:1");
        assert_eq!(s("1a:b"), "1a:b");
        assert_eq!(s("#"), "");
        assert_eq!(
            Uri::parse("http://x:99999/").unwrap_err().to_string(),
            "TypeError: Port \"99999\" is not a valid port"
        );
        assert_eq!(
            Uri::parse("http://[::1").unwrap_err().to_string(),
            "TypeError: Port \"::1\" is not a valid port"
        );
        let uri = Uri::parse("dir/x.schema.json").unwrap();
        assert_eq!(uri.filename(), "x.schema.json");
        assert_eq!(uri.suffix(), "json");
        assert_eq!(uri.directory(), "dir");
    }

    #[test]
    fn normalization() {
        assert_eq!(normalized("./a/../b/c.json"), "b/c.json");
        assert_eq!(
            normalized("HTTP://Example.COM:80/a/./b/../c.json"),
            "http://example.com/a/c.json"
        );
        assert_eq!(normalized("My Type"), "My%20Type");
        assert_eq!(
            normalized("http://bücher.example/"),
            "http://xn--bcher-kva.example/"
        );
        assert_eq!(
            normalized("http://[2001:DB8:0:0:0:0:0:1]/"),
            "http://[2001:db8::1]/"
        );
        let mut bad = Uri::parse("100%.schema").unwrap();
        assert_eq!(bad.normalize(), Err(UriError::Malformed));
    }

    #[test]
    fn resolution() {
        assert_eq!(absolute("a/test2.json", "test.json"), "a/test2.json");
        assert_eq!(
            absolute("a/test2.json", "dir/sub/t.json"),
            "dir/sub/a/test2.json"
        );
        assert_eq!(absolute("../../../c.json", "a/x.json"), "c.json");
        assert_eq!(absolute("c.json", "http://h"), "http://h/c.json");
        assert_eq!(absolute("?q", "dir/x.json"), "dir/x.json?q");
        assert_eq!(
            absolute("../d.json", "http://ex.com/a/b/c.json"),
            "http://ex.com/a/d.json"
        );
    }

    #[test]
    fn equality() {
        let a = Uri::parse("http://h/x?a=1&b=2").unwrap();
        let b = Uri::parse("HTTP://h:80/x?b=2&a=1").unwrap();
        assert!(a.equals(&b).unwrap());
        assert!(!a.equals(&Uri::parse("http://h/y").unwrap()).unwrap());
    }
}
