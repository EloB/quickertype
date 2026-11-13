//! Node's `fetch` (undici, as bundled with Node 24) for a `GET` request, as
//! far as `NodeIO` observes it, on `ureq`.
//!
//! - **Request construction.** Header names and values above U+00FF fail
//!   the `ByteString` conversion first, then the URL must parse (WHATWG,
//!   with the `url` crate) and must not contain credentials, then each
//!   header is appended like `Headers.append` (names must be tokens; values
//!   are trimmed of HTTP whitespace and must not contain NUL, CR or LF).
//!   Names that differ only in case are combined (`3, 2`; cookies with
//!   `; `). The texts of the `TypeError`s are undici's.
//! - **Defaults.** `accept: */*`, `accept-language: *`,
//!   `sec-fetch-mode: cors`, `user-agent: node`, and
//!   `accept-encoding: br, gzip, deflate` (`gzip, deflate` over plain HTTP)
//!   unless given; a `host` header is never sent.
//! - **Redirects** are followed by hand, like undici: at most 20 (the 21st is
//!   a network error), only to HTTP(S) URLs, and a cross-origin hop drops
//!   `authorization`, `proxy-authorization`, `cookie` and `host`.
//! - **Bodies** are decoded per `Content-Encoding` (`gzip`/`x-gzip`,
//!   `deflate` with zlib or raw data, `br`, in reverse order; any other
//!   coding means no decoding, more than five fail); a corrupt or truncated
//!   stream yields what decoded, as through `NodeIO`. Statuses 101, 204,
//!   205 and 304 have no body (`None`).
//! - **Failures** of the network, ports on the fetch "bad port" list,
//!   timeouts (10 s to connect, 300 s for headers and between body reads,
//!   undici's defaults) and other schemes are all `TypeError: fetch failed`.
//!
//! One `ureq` agent is shared, for keep-alive and TLS configuration reuse.

use std::io::Read;
use std::sync::OnceLock;
use std::time::Duration;

use indexmap::IndexMap;
use url::Url;

use crate::input::io::node_io::{HttpResponse, IoError};

/// The ports fetch refuses to connect to (`badPorts` of the Fetch
/// standard).
const BAD_PORTS: &[u16] = &[
    1, 7, 9, 11, 13, 15, 17, 19, 20, 21, 22, 23, 25, 37, 42, 43, 53, 69, 77, 79, 87, 95, 101, 102,
    103, 104, 109, 110, 111, 113, 115, 117, 119, 123, 135, 137, 139, 143, 161, 179, 389, 427, 465,
    512, 513, 514, 515, 526, 530, 531, 532, 540, 548, 554, 556, 563, 587, 601, 636, 989, 990, 993,
    995, 1719, 1720, 1723, 2049, 3659, 4045, 4190, 5060, 5061, 6000, 6566, 6665, 6666, 6667, 6668,
    6669, 6679, 6697, 10080,
];

/// Statuses whose response has a `null` body.
const NULL_BODY_STATUS: [u16; 4] = [101, 204, 205, 304];

/// Statuses that redirect.
const REDIRECT_STATUS: [u16; 5] = [301, 302, 303, 307, 308];

/// The most redirects fetch follows.
const MAX_REDIRECTS: usize = 20;

const FETCH_FAILED: &str = "TypeError: fetch failed";

fn agent() -> &'static ureq::Agent {
    static AGENT: OnceLock<ureq::Agent> = OnceLock::new();
    AGENT.get_or_init(|| {
        ureq::AgentBuilder::new()
            // Redirects are followed here, with fetch's rules.
            .redirects(0)
            .timeout_connect(Duration::from_secs(10))
            .timeout_read(Duration::from_secs(300))
            .timeout_write(Duration::from_secs(300))
            .build()
    })
}

/// A request header list: lower-case name → (name as first given, value).
type HeaderList = IndexMap<String, (String, String)>;

/// webidl's `ByteString` conversion: every UTF-16 code unit must be at most
/// 255.
fn check_byte_string(s: &str) -> Result<(), IoError> {
    for (index, unit) in s.encode_utf16().enumerate() {
        if unit > 255 {
            return Err(format!(
                "TypeError: Cannot convert argument to a ByteString because the character at index {index} has a value of {unit} which is greater than 255."
            ));
        }
    }
    Ok(())
}

/// An HTTP token character (RFC 9110), as `isValidHTTPToken` checks.
fn is_token_char(c: char) -> bool {
    c.is_ascii_alphanumeric() || "!#$%&'*+-.^_`|~".contains(c)
}

fn is_http_whitespace(c: char) -> bool {
    matches!(c, '\t' | '\n' | '\r' | ' ')
}

/// `new Headers(init)` for the record `NodeIO` passes, then the defaults.
fn header_list(headers: &[(String, String)]) -> Result<HeaderList, IoError> {
    let mut list = HeaderList::new();
    for (name, value) in headers {
        let value = value.trim_matches(is_http_whitespace);
        if name.is_empty() || !name.chars().all(is_token_char) {
            return Err(format!(
                "TypeError: Headers.append: \"{name}\" is an invalid header name."
            ));
        }
        if value.starts_with(['\t', ' '])
            || value.ends_with(['\t', ' '])
            || value.contains(['\0', '\n', '\r'])
        {
            return Err(format!(
                "TypeError: Headers.append: \"{value}\" is an invalid header value."
            ));
        }
        let key = name.to_ascii_lowercase();
        match list.get_mut(&key) {
            Some((_, existing)) => {
                let delimiter = if key == "cookie" { "; " } else { ", " };
                existing.push_str(delimiter);
                existing.push_str(value);
            }
            None => {
                list.insert(key, (name.clone(), value.to_owned()));
            }
        }
    }
    Ok(list)
}

/// Adds undici's default request headers for `url`.
fn add_default_headers(list: &mut HeaderList, url: &Url) {
    let mut default = |name: &str, value: &str| {
        list.entry(name.to_owned())
            .or_insert_with(|| (name.to_owned(), value.to_owned()));
    };
    default("accept", "*/*");
    default("accept-language", "*");
    default(
        "accept-encoding",
        if url.scheme() == "https" {
            "br, gzip, deflate"
        } else {
            "gzip, deflate"
        },
    );
    default("user-agent", "node");
    list.insert(
        "sec-fetch-mode".to_owned(),
        ("sec-fetch-mode".to_owned(), "cors".to_owned()),
    );
    list.shift_remove("host");
}

/// `fetch(input, { headers })` for a `GET`.
pub(crate) fn fetch(input: &str, headers: &[(String, String)]) -> Result<HttpResponse, IoError> {
    // `new Request(input, init)`: the init dictionary (with the headers'
    // ByteString conversion) is converted before the URL is parsed.
    for (name, value) in headers {
        check_byte_string(name)?;
        check_byte_string(value)?;
    }
    let mut url =
        Url::parse(input).map_err(|_| format!("TypeError: Failed to parse URL from {input}"))?;
    if !url.username().is_empty() || url.password().is_some() {
        return Err(format!(
            "TypeError: Request cannot be constructed from a URL that includes credentials: {input}"
        ));
    }
    let mut list = header_list(headers)?;

    let mut redirects = 0;
    loop {
        if !matches!(url.scheme(), "http" | "https") {
            return Err(FETCH_FAILED.to_owned());
        }
        if url.port().is_some_and(|port| BAD_PORTS.contains(&port)) {
            return Err(FETCH_FAILED.to_owned());
        }
        let mut sent = list.clone();
        add_default_headers(&mut sent, &url);
        let mut request = agent().request_url("GET", &url);
        for (name, value) in sent.values() {
            request = request.set(name, value);
        }
        let response = match request.call() {
            Ok(response) | Err(ureq::Error::Status(_, response)) => response,
            Err(ureq::Error::Transport(_)) => return Err(FETCH_FAILED.to_owned()),
        };
        let status = response.status();

        if REDIRECT_STATUS.contains(&status)
            && let Some(location) = response.header("location")
        {
            let next = url.join(location).map_err(|_| FETCH_FAILED.to_owned())?;
            if !matches!(next.scheme(), "http" | "https") || redirects == MAX_REDIRECTS {
                return Err(FETCH_FAILED.to_owned());
            }
            redirects += 1;
            if next.origin() != url.origin() {
                for name in ["authorization", "proxy-authorization", "cookie", "host"] {
                    list.shift_remove(name);
                }
            }
            url = next;
            continue;
        }

        let status_text = response.status_text().to_owned();
        if NULL_BODY_STATUS.contains(&status) {
            return Ok(HttpResponse {
                status,
                status_text,
                body: None,
            });
        }
        let content_encoding = response.header("content-encoding").map(str::to_owned);
        let mut raw = Vec::new();
        response
            .into_reader()
            .read_to_end(&mut raw)
            .map_err(|_| "TypeError: terminated".to_owned())?;
        let body = decode_body(raw, content_encoding.as_deref())?;
        return Ok(HttpResponse {
            status,
            status_text,
            body: Some(body),
        });
    }
}

/// The body decoded per `Content-Encoding`, like undici.
fn decode_body(raw: Vec<u8>, content_encoding: Option<&str>) -> Result<Vec<u8>, IoError> {
    let Some(content_encoding) = content_encoding else {
        return Ok(raw);
    };
    let codings: Vec<String> = content_encoding
        .to_lowercase()
        .split(',')
        .map(|c| c.trim().to_owned())
        .collect();
    if codings.len() > 5 {
        return Err(FETCH_FAILED.to_owned());
    }
    if !codings
        .iter()
        .all(|c| matches!(c.as_str(), "gzip" | "x-gzip" | "deflate" | "br"))
    {
        return Ok(raw);
    }
    let mut body = raw;
    for coding in codings.iter().rev() {
        body = match coding.as_str() {
            "gzip" | "x-gzip" => lenient_read(flate2::read::MultiGzDecoder::new(&body[..])),
            "deflate" if body.first().is_some_and(|b| b & 0x0F == 0x08) => {
                lenient_read(flate2::read::ZlibDecoder::new(&body[..]))
            }
            "deflate" => lenient_read(flate2::read::DeflateDecoder::new(&body[..])),
            _ => lenient_read(brotli_decompressor::Decompressor::new(&body[..], 4096)),
        };
    }
    Ok(body)
}

/// Reads a decoder to the end. Like Node's `Z_SYNC_FLUSH` decoding seen
/// through `NodeIO`'s stream wrapper, a truncated or corrupt stream yields
/// what was decoded before the problem (possibly nothing), not an error.
fn lenient_read(mut decoder: impl Read) -> Vec<u8> {
    let mut out = Vec::new();
    // On an error, `read_to_end` has appended everything decoded so far.
    let _ = decoder.read_to_end(&mut out);
    out
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn headers_combine_case_insensitively() {
        let list = header_list(&[
            ("X-A".to_owned(), "3".to_owned()),
            ("x-a".to_owned(), "2".to_owned()),
            ("Cookie".to_owned(), "a=1".to_owned()),
            ("cookie".to_owned(), "b=2".to_owned()),
        ])
        .unwrap();
        assert_eq!(list["x-a"], ("X-A".to_owned(), "3, 2".to_owned()));
        assert_eq!(list["cookie"].1, "a=1; b=2");
    }

    #[test]
    fn request_errors_use_undicis_texts() {
        let err = |url: &str, headers: &[(&str, &str)]| {
            let headers: Vec<(String, String)> = headers
                .iter()
                .map(|(n, v)| ((*n).to_owned(), (*v).to_owned()))
                .collect();
            fetch(url, &headers).unwrap_err()
        };
        assert_eq!(
            err("http://[::1/", &[]),
            "TypeError: Failed to parse URL from http://[::1/"
        );
        assert_eq!(
            err("//example.com/x", &[]),
            "TypeError: Failed to parse URL from //example.com/x"
        );
        assert_eq!(
            err("http://u:p@a.bc/", &[("bad name", "x")]),
            "TypeError: Request cannot be constructed from a URL that includes credentials: http://u:p@a.bc/"
        );
        assert_eq!(
            err("http://[::1/", &[("a", "€")]),
            "TypeError: Cannot convert argument to a ByteString because the character at index 0 has a value of 8364 which is greater than 255."
        );
        assert_eq!(
            err("http://127.0.0.1:1/", &[("bad name", "x")]),
            "TypeError: Headers.append: \"bad name\" is an invalid header name."
        );
        assert_eq!(
            err("http://127.0.0.1:1/", &[("", "x")]),
            "TypeError: Headers.append: \"\" is an invalid header name."
        );
        assert_eq!(
            err("http://127.0.0.1:1/", &[("a", "x\ny")]),
            "TypeError: Headers.append: \"x\ny\" is an invalid header value."
        );
        // Port 1 is on fetch's bad-port list.
        assert_eq!(err("http://127.0.0.1:1/", &[]), FETCH_FAILED);
        assert_eq!(err("ftp://a.bc/x", &[]), FETCH_FAILED);
    }

    #[test]
    fn unknown_codings_disable_decoding() {
        assert_eq!(
            decode_body(b"abc".to_vec(), Some("identity")).unwrap(),
            b"abc"
        );
        assert_eq!(
            decode_body(b"abc".to_vec(), Some("gzip, zstd")).unwrap(),
            b"abc"
        );
        assert_eq!(
            decode_body(b"abc".to_vec(), Some("gzip,gzip,gzip,gzip,gzip,gzip")).unwrap_err(),
            FETCH_FAILED
        );
        assert_eq!(
            decode_body(b"not gzip".to_vec(), Some("gzip")).unwrap(),
            b""
        );
        // `zlib.brotliCompressSync('{"br":true}')`.
        let br = [
            0x0b, 0x05, 0x80, 0x7b, 0x22, 0x62, 0x72, 0x22, 0x3a, 0x74, 0x72, 0x75, 0x65, 0x7d,
            0x03,
        ];
        assert_eq!(
            decode_body(br.to_vec(), Some("br")).unwrap(),
            b"{\"br\":true}"
        );
    }
}
