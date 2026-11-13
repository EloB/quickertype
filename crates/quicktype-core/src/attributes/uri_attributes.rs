//! Port of `packages/quicktype-core/src/attributes/URIAttributes.ts`.
//!
//! The protocols and file extensions seen in `uri` strings. The inference
//! producer ([`uri_inference_attributes_producer`]) is ported with the JSON
//! input; the schema producer and `addToSchema` follow with the JSON Schema
//! input and output.

use indexmap::IndexSet;
use quicktype_js_compat::whitespace;

use crate::attributes::type_attributes::{AttributeKind, TypeAttributes};

/// `URIAttributes`: `[protocols, extensions]`.
pub type UriAttributes = (IndexSet<String>, IndexSet<String>);

/// `uriTypeAttributeKind`: `uriAttributes`, part of the identity.
#[derive(Clone, Copy, Debug, Default)]
pub struct UriTypeAttributeKind;

/// `qt-uri-protocols`.
pub const PROTOCOLS_SCHEMA_PROPERTY: &str = "qt-uri-protocols";
/// `qt-uri-extensions`.
pub const EXTENSIONS_SCHEMA_PROPERTY: &str = "qt-uri-extensions";

/// `URITypeAttributeKind.combine`: the union of protocols and of extensions.
pub(crate) fn combine(attrs: &[&UriAttributes]) -> UriAttributes {
    let protocols = attrs.iter().flat_map(|a| a.0.iter().cloned()).collect();
    let extensions = attrs.iter().flat_map(|a| a.1.iter().cloned()).collect();
    (protocols, extensions)
}

/// `pathExtension(path)`: the extension matched by `/^.+(\.[^./\\]+)$/`.
pub fn path_extension(path: &str) -> Option<&str> {
    let dot = path.rfind('.')?;
    let extension = &path[dot..];
    let before = &path[..dot];
    if before.is_empty() || extension.len() < 2 {
        return None;
    }
    if extension[1..].contains(['.', '/', '\\']) {
        return None;
    }
    // `.+` does not match line terminators.
    if before.contains(['\n', '\r', '\u{2028}', '\u{2029}']) {
        return None;
    }
    Some(extension)
}

/// `uriInferenceAttributesProducer(s)`: the protocol and the path's
/// extension, both lowercased, of a string JSON inference recognized as a
/// `uri`; no attributes if urijs throws on it (an invalid port, or a
/// malformed percent-escape in the user info).
pub fn uri_inference_attributes_producer(s: &str) -> TypeAttributes {
    let Some(UriParts { protocol, path }) = parse_uri(s) else {
        return TypeAttributes::new();
    };
    let extensions = path_extension(&path)
        .map(str::to_lowercase)
        .into_iter()
        .collect();
    let protocols = [protocol.to_lowercase()].into_iter().collect();
    UriTypeAttributeKind.make_attributes((protocols, extensions))
}

/// What `uriInferenceAttributesProducer` reads of a parsed URI:
/// `uri.protocol()` and `uri.path()`.
struct UriParts {
    protocol: String,
    path: String,
}

/// The subset of urijs 1.19.11's `URI(s)` (`URI.parse`, `parseAuthority`,
/// `parseUserinfo`, `parseHost`) that decides the protocol and the path, and
/// whether the constructor throws (`None`). Hosts and user info are only
/// validated, not kept. Positions are UTF-16 code units, as in urijs.
fn parse_uri(s: &str) -> Option<UriParts> {
    // `URI.leading_whitespace_expression`, then `URI.ascii_tab_whitespace`.
    let s = s.trim_start_matches(|c: char| {
        matches!(c, '\u{0}'..='\u{20}' | '\u{a0}' | '\u{1680}' | '\u{2000}'..='\u{200a}'
            | '\u{2028}' | '\u{2029}' | '\u{202f}' | '\u{205f}' | '\u{3000}' | '\u{feff}')
    });
    let s: String = s
        .chars()
        .filter(|c| !matches!(c, '\t' | '\n' | '\r'))
        .collect();

    // Fragment, then query.
    let s = s.split_once('#').map_or(s.as_str(), |(before, _)| before);
    let s = s.split_once('?').map_or(s, |(before, _)| before);

    // `/^(https?|ftp|wss?)?:+[/\\]*/i` -> `$1://`, then `/^[/\\]{2,}/` -> `//`.
    let s = normalize_scheme_slashes(s);

    let (protocol, rest) = if let Some(rest) = s.strip_prefix("//") {
        (None, parse_authority(rest)?)
    } else if let Some(colon) = s.find(':') {
        let protocol = &s[..colon];
        let is_protocol = protocol
            .as_bytes()
            .first()
            .is_some_and(u8::is_ascii_alphabetic)
            && protocol
                .bytes()
                .all(|b| b.is_ascii_alphanumeric() || matches!(b, b'.' | b'+' | b'-'));
        let after = &s[colon + 1..];
        if !is_protocol {
            (None, s.clone())
        } else if after.starts_with("//")
            || after.starts_with("\\\\")
            || after.starts_with("/\\")
            || after.starts_with("\\/")
        {
            (Some(protocol.to_owned()), parse_authority(&after[2..])?)
        } else {
            (Some(protocol.to_owned()), after.to_owned())
        }
    } else {
        (None, s.clone())
    };

    Some(UriParts {
        protocol: protocol.unwrap_or_default(),
        path: rest,
    })
}

/// The two leading-slash rewrites of `URI.parse`.
fn normalize_scheme_slashes(s: &str) -> String {
    let lower = s.to_ascii_lowercase();
    let scheme_len = ["https", "http", "ftp", "wss", "ws"]
        .iter()
        .find(|p| lower.starts_with(*p) && s[p.len()..].starts_with(':'))
        .map_or(0, |p| p.len());
    let rest = &s[scheme_len..];
    let colons = rest.len() - rest.trim_start_matches(':').len();
    if colons > 0 {
        let after = rest[colons..].trim_start_matches(['/', '\\']);
        return format!("{}://{after}", &s[..scheme_len]);
    }
    let slashes = s.len() - s.trim_start_matches(['/', '\\']).len();
    if slashes >= 2 {
        return format!("//{}", &s[slashes..]);
    }
    s.to_owned()
}

/// `URI.parseAuthority`: user info, then host; returns the path.
fn parse_authority(s: &str) -> Option<String> {
    let units: Vec<u16> = s.encode_utf16().collect();
    let rest = parse_userinfo(&units)?;
    parse_host(rest)
}

/// `URI.parseUserinfo`: validates `user:pass@` (its parts are
/// `decodeURIComponent`d, which can throw) and returns what follows.
fn parse_userinfo(units: &[u16]) -> Option<&[u16]> {
    const SLASH: u16 = b'/' as u16;
    const BACKSLASH: u16 = b'\\' as u16;
    const AT: u16 = b'@' as u16;
    let first_slash = units.iter().position(|&u| u == SLASH || u == BACKSLASH);
    // `lastIndexOf('@', firstSlash ?? length - 1)`.
    let search_end = first_slash.unwrap_or(units.len().saturating_sub(1));
    let at = units[..units.len().min(search_end + 1)]
        .iter()
        .rposition(|&u| u == AT);
    let Some(at) = at.filter(|&at| first_slash.is_none_or(|slash| at < slash)) else {
        return Some(units);
    };
    let userinfo = String::from_utf16_lossy(&units[..at]);
    let mut parts = userinfo.split(':');
    let username = parts.next().unwrap_or("");
    let password: Vec<&str> = parts.collect();
    if !username.is_empty() && !decode_uri_component_succeeds(username) {
        return None;
    }
    if password.first().is_some_and(|p| !p.is_empty())
        && !decode_uri_component_succeeds(&password.join(":"))
    {
        return None;
    }
    Some(&units[at + 1..])
}

/// `URI.parseHost`: validates the port (`ensureValidPort`) and returns the
/// path.
fn parse_host(units: &[u16]) -> Option<String> {
    const SLASH: u16 = b'/' as u16;
    const COLON: u16 = b':' as u16;
    let mut string: Vec<u16> = units
        .iter()
        .map(|&u| if u == u16::from(b'\\') { SLASH } else { u })
        .collect();
    let index_of = |s: &[u16], unit: u16, from: usize| {
        s.iter()
            .skip(from)
            .position(|&u| u == unit)
            .map(|i| i + from)
    };
    let mut pos = index_of(&string, SLASH, 0).unwrap_or(string.len());
    let (hostname, port): (Vec<u16>, Vec<u16>);
    if string.first() == Some(&u16::from(b'[')) {
        // IPv6: `substring(1, bracketPos)` and `substring(bracketPos + 2, pos)`.
        let bracket = index_of(&string, u16::from(b']'), 0).map_or(-1, |i| i as i64);
        hostname = js_substring(&string, 1, bracket).to_vec();
        let p = js_substring(&string, bracket + 2, pos as i64).to_vec();
        port = if p == [SLASH] { Vec::new() } else { p };
    } else {
        let first_colon = index_of(&string, COLON, 0);
        let first_slash = index_of(&string, SLASH, 0);
        let next_colon = index_of(&string, COLON, first_colon.map_or(0, |c| c + 1));
        if next_colon.is_some_and(|n| first_slash.is_none_or(|s| n < s)) {
            hostname = string[..pos].to_vec();
            port = Vec::new();
        } else {
            let mut t = string[..pos].split(|&u| u == COLON);
            hostname = t.next().unwrap_or_default().to_vec();
            port = t.next().unwrap_or_default().to_vec();
        }
    }
    if !hostname.is_empty() && string.get(pos) != Some(&SLASH) {
        pos += 1;
        string.insert(0, SLASH);
    }
    if !port.is_empty() && !is_valid_port(&String::from_utf16_lossy(&port)) {
        return None;
    }
    let path = string.get(pos..).unwrap_or_default();
    Some(if path.is_empty() {
        "/".to_owned()
    } else {
        String::from_utf16_lossy(path)
    })
}

/// JavaScript `s.substring(start, end)` on code units.
fn js_substring(s: &[u16], start: i64, end: i64) -> &[u16] {
    let clamp = |i: i64| i.clamp(0, s.len() as i64) as usize;
    let (a, b) = (clamp(start), clamp(end));
    &s[a.min(b)..a.max(b)]
}

/// `URI.ensureValidPort(v)` does not throw: `Number(v)` is an integer in
/// 1–65535 (urijs tests `/^[0-9]+$/` on the number's string form).
fn is_valid_port(v: &str) -> bool {
    let n = js_string_to_number(v);
    n.fract() == 0.0 && n > 0.0 && n < 65536.0
}

/// JavaScript `Number(s)` for a string (`StringToNumber`).
fn js_string_to_number(s: &str) -> f64 {
    let s = whitespace::trim(s);
    if s.is_empty() {
        return 0.0;
    }
    let radix = |prefix: [&str; 2], radix: u32| {
        let digits = prefix.iter().find_map(|p| s.strip_prefix(p))?;
        if digits.is_empty() || !digits.chars().all(|c| c.is_digit(radix)) {
            return Some(f64::NAN);
        }
        Some(
            digits
                .chars()
                .filter_map(|c| c.to_digit(radix))
                .fold(0.0, |v, d| v * f64::from(radix) + f64::from(d)),
        )
    };
    if let Some(n) = radix(["0x", "0X"], 16)
        .or_else(|| radix(["0o", "0O"], 8))
        .or_else(|| radix(["0b", "0B"], 2))
    {
        return n;
    }
    let unsigned = s.strip_prefix(['+', '-']).unwrap_or(s);
    if unsigned == "Infinity" {
        return if s.starts_with('-') {
            f64::NEG_INFINITY
        } else {
            f64::INFINITY
        };
    }
    // StrUnsignedDecimalLiteral: digits [. digits] or . digits, then an
    // optional exponent; Rust's parser would also accept "inf" and "nan".
    let (mantissa, exponent) = match unsigned.find(['e', 'E']) {
        Some(i) => (&unsigned[..i], Some(&unsigned[i + 1..])),
        None => (unsigned, None),
    };
    let (int, frac) = mantissa.split_once('.').unwrap_or((mantissa, ""));
    let digits_ok = |d: &str| d.bytes().all(|b| b.is_ascii_digit());
    let mantissa_ok = digits_ok(int) && digits_ok(frac) && !(int.is_empty() && frac.is_empty());
    let exponent_ok = exponent.is_none_or(|e| {
        let e = e.strip_prefix(['+', '-']).unwrap_or(e);
        !e.is_empty() && digits_ok(e)
    });
    if !mantissa_ok || !exponent_ok {
        return f64::NAN;
    }
    s.parse().unwrap_or(f64::NAN)
}

/// Whether `decodeURIComponent(s)` returns instead of throwing `URIError`:
/// every `%` starts a `%XX` escape, and the escapes of each non-ASCII byte
/// sequence form one valid UTF-8 code point.
fn decode_uri_component_succeeds(s: &str) -> bool {
    let bytes = s.as_bytes();
    let hex_byte = |i: usize| -> Option<u8> {
        if bytes.get(i) != Some(&b'%') {
            return None;
        }
        let hex = std::str::from_utf8(bytes.get(i + 1..i + 3)?).ok()?;
        u8::from_str_radix(hex, 16)
            .ok()
            .filter(|_| hex.bytes().all(|b| b.is_ascii_hexdigit()))
    };
    let mut i = 0;
    while i < bytes.len() {
        if bytes[i] != b'%' {
            i += 1;
            continue;
        }
        let Some(first) = hex_byte(i) else {
            return false;
        };
        i += 3;
        if first < 0x80 {
            continue;
        }
        let n = first.leading_ones() as usize;
        if n == 1 || n > 4 {
            return false;
        }
        let mut sequence = vec![first];
        for _ in 1..n {
            match hex_byte(i) {
                Some(b) if b & 0xC0 == 0x80 => sequence.push(b),
                _ => return false,
            }
            i += 3;
        }
        if std::str::from_utf8(&sequence).is_err() {
            return false;
        }
    }
    true
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn extensions() {
        assert_eq!(path_extension("/a/b.jpg"), Some(".jpg"));
        assert_eq!(path_extension("/a/b.tar.gz"), Some(".gz"));
        assert_eq!(path_extension(".jpg"), None);
        assert_eq!(path_extension("/a.b/c"), None);
        assert_eq!(path_extension("/"), None);
    }

    fn producer(s: &str) -> Option<(Vec<String>, Vec<String>)> {
        let attributes = uri_inference_attributes_producer(s);
        UriTypeAttributeKind
            .try_get_in_attributes(&attributes)
            .map(|(p, e)| (p.iter().cloned().collect(), e.iter().cloned().collect()))
    }

    #[test]
    fn inference_producer() {
        let some = |p: &str, e: &[&str]| {
            Some((
                vec![p.to_owned()],
                e.iter().map(|&e| e.to_owned()).collect(),
            ))
        };
        assert_eq!(producer("http://a/b.JSON"), some("http", &[".json"]));
        assert_eq!(
            producer("https://a/x.tar.gz?q=1#f"),
            some("https", &[".gz"])
        );
        assert_eq!(producer("ftp://a/.htaccess"), some("ftp", &[".htaccess"]));
        assert_eq!(producer("http://a"), some("http", &[]));
        assert_eq!(producer("http://a:99999/x"), None);
        assert_eq!(producer("http://a:0/x"), None);
        assert_eq!(producer("http://a:8080/x.png"), some("http", &[".png"]));
        assert_eq!(producer("http://a:0x50/x"), some("http", &[]));
        assert_eq!(producer("http://u%zz@a/x"), None);
        assert_eq!(producer("http://u%C3%A9@a/x"), some("http", &[]));
        assert_eq!(producer("http://u%C3@a/x"), None);
        assert_eq!(producer("http:///\\a/b.c"), some("http", &[".c"]));
    }

    #[test]
    fn js_numbers() {
        assert_eq!(js_string_to_number(" 80 "), 80.0);
        assert_eq!(js_string_to_number("0x1F"), 31.0);
        assert_eq!(js_string_to_number("1e3"), 1000.0);
        assert_eq!(js_string_to_number(".5"), 0.5);
        assert_eq!(js_string_to_number("5."), 5.0);
        assert!(js_string_to_number("inf").is_nan());
        assert!(js_string_to_number("1_0").is_nan());
        assert!(js_string_to_number("-0x1").is_nan());
        assert_eq!(js_string_to_number(""), 0.0);
        assert_eq!(js_string_to_number("-Infinity"), f64::NEG_INFINITY);
    }

    #[test]
    fn combine_unites() {
        let a: UriAttributes = (["http".into()].into_iter().collect(), IndexSet::new());
        let b: UriAttributes = (
            ["https".into(), "http".into()].into_iter().collect(),
            [".png".into()].into_iter().collect(),
        );
        let c = combine(&[&a, &b]);
        assert_eq!(c.0.iter().collect::<Vec<_>>(), vec!["http", "https"]);
        assert_eq!(c.1.len(), 1);
    }
}
