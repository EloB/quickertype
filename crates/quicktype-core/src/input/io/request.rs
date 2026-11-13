//! The checks of undici's `new Request(input, init)` (Node 24) that need no
//! network: the `ByteString` conversions of the init dictionary, the
//! method's validation and normalization, the headers' validation and
//! combination, and the rule that a `GET` or `HEAD` has no body.
//!
//! Every [`Io`](super::node_io::Io) uses them: `StdIo`'s fetch (in
//! `fetch.rs`, which also parses the URL between the conversions and the
//! method check, as undici does) and the trait's default
//! `fetch_with_init`, so the error texts do not depend on the host.

use indexmap::IndexMap;

use crate::input::io::node_io::{IoError, IoErrorKind, RequestInit};
use crate::messages::JsErrorName;

/// A `TypeError` from building or sending the request.
pub(crate) fn type_error(message: impl Into<String>) -> IoError {
    IoError::new(IoErrorKind::Network, JsErrorName::TypeError, message)
}

/// webidl's `ByteString` conversion: every UTF-16 code unit must be at most
/// 255.
fn check_byte_string(s: &str) -> Result<(), IoError> {
    for (index, unit) in s.encode_utf16().enumerate() {
        if unit > 255 {
            return Err(type_error(format!(
                "Cannot convert argument to a ByteString because the character at index {index} has a value of {unit} which is greater than 255."
            )));
        }
    }
    Ok(())
}

/// The init dictionary's `ByteString` conversions, in member order: the
/// headers (names and values), then the method.
pub(crate) fn check_byte_strings(init: &RequestInit<'_>) -> Result<(), IoError> {
    for (name, value) in init.headers {
        check_byte_string(name)?;
        check_byte_string(value)?;
    }
    check_byte_string(init.method)
}

/// An HTTP token character (RFC 9110), as `isValidHTTPToken` checks.
pub(crate) fn is_token_char(c: char) -> bool {
    c.is_ascii_alphanumeric() || "!#$%&'*+-.^_`|~".contains(c)
}

fn is_http_whitespace(c: char) -> bool {
    matches!(c, '\t' | '\n' | '\r' | ' ')
}

/// The methods undici normalizes to upper case (`normalizeMethodRecord`;
/// `patch` and `PATCH` stay as they are).
const NORMALIZED_METHODS: [&str; 6] = ["DELETE", "GET", "HEAD", "OPTIONS", "POST", "PUT"];

/// The `method` of `new Request(input, { method })`: validated and
/// normalized like undici.
pub(crate) fn request_method(method: &str) -> Result<String, IoError> {
    if method == "patch" || method == "PATCH" {
        return Ok(method.to_owned());
    }
    if NORMALIZED_METHODS.contains(&method)
        || NORMALIZED_METHODS
            .iter()
            .any(|m| m.to_ascii_lowercase() == method)
    {
        return Ok(method.to_ascii_uppercase());
    }
    if method.is_empty() || !method.chars().all(is_token_char) {
        return Err(type_error(format!(
            "'{method}' is not a valid HTTP method."
        )));
    }
    let upper_case = method.to_ascii_uppercase();
    if matches!(upper_case.as_str(), "CONNECT" | "TRACE" | "TRACK") {
        return Err(type_error(format!(
            "'{method}' HTTP method is unsupported."
        )));
    }
    if NORMALIZED_METHODS.contains(&upper_case.as_str()) {
        return Ok(upper_case);
    }
    Ok(method.to_owned())
}

/// A request header list: lower-case name → (name as first given, value).
pub(crate) type HeaderList = IndexMap<String, (String, String)>;

/// `new Headers(init)` for a record: each header appended like
/// `Headers.append` (names must be tokens; values are trimmed of HTTP
/// whitespace and must not contain NUL, CR or LF), names that differ only
/// in case combined (`3, 2`; cookies with `; `).
pub(crate) fn header_list(headers: &[(String, String)]) -> Result<HeaderList, IoError> {
    let mut list = HeaderList::new();
    for (name, value) in headers {
        let value = value.trim_matches(is_http_whitespace);
        if name.is_empty() || !name.chars().all(is_token_char) {
            return Err(type_error(format!(
                "Headers.append: \"{name}\" is an invalid header name."
            )));
        }
        if value.starts_with(['\t', ' '])
            || value.ends_with(['\t', ' '])
            || value.contains(['\0', '\n', '\r'])
        {
            return Err(type_error(format!(
                "Headers.append: \"{value}\" is an invalid header value."
            )));
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

/// A `GET` or `HEAD` request cannot have a body.
pub(crate) fn check_body(method: &str, body: Option<&str>) -> Result<(), IoError> {
    if body.is_some() && (method == "GET" || method == "HEAD") {
        return Err(type_error("Request with GET/HEAD method cannot have body."));
    }
    Ok(())
}

/// The checks of `new Request(url, init)` other than the URL's, in
/// undici's order: the request's (normalized) method, or the `TypeError`.
pub(crate) fn check_request(init: &RequestInit<'_>) -> Result<String, IoError> {
    check_byte_strings(init)?;
    let method = request_method(init.method)?;
    header_list(init.headers)?;
    check_body(&method, init.body)?;
    Ok(method)
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::input::io::LocalBoxFuture;
    use crate::input::io::block_on;
    use crate::input::io::node_io::{HttpResponse, Io};

    /// An `Io` with only a GET `fetch`, which answers with the URL.
    struct GetOnly;

    impl Io for GetOnly {
        fn is_symbolic_link(&self, _: &str) -> Result<bool, IoError> {
            Ok(false)
        }

        fn read_link(&self, path: &str) -> Result<String, IoError> {
            Ok(path.to_owned())
        }

        fn exists(&self, _: &str) -> bool {
            false
        }

        fn read_file<'a>(&'a self, _: &'a str) -> LocalBoxFuture<'a, Result<String, IoError>> {
            Box::pin(async { Ok(String::new()) })
        }

        fn read_stdin(&self) -> LocalBoxFuture<'_, Result<String, IoError>> {
            Box::pin(async { Ok(String::new()) })
        }

        fn fetch<'a>(
            &'a self,
            url: &'a str,
            _: &'a [(String, String)],
        ) -> LocalBoxFuture<'a, Result<HttpResponse, IoError>> {
            Box::pin(async move {
                Ok(HttpResponse {
                    status: 200,
                    status_text: "OK".to_owned(),
                    body: Some(url.as_bytes().to_vec()),
                })
            })
        }
    }

    fn send(method: &str, headers: &[(&str, &str)], body: Option<&str>) -> String {
        let headers: Vec<(String, String)> = headers
            .iter()
            .map(|(n, v)| ((*n).to_owned(), (*v).to_owned()))
            .collect();
        let init = RequestInit {
            method,
            headers: &headers,
            body,
        };
        match block_on(GetOnly.fetch_with_init("u", init)) {
            Ok(response) => String::from_utf8(response.body.unwrap_or_default()).unwrap(),
            Err(e) => e.to_js_string(),
        }
    }

    /// The default `fetch_with_init` checks requests like undici, whatever
    /// the `Io`.
    #[test]
    fn the_default_checks_requests_like_undici() {
        assert_eq!(send("get", &[], None), "u");
        assert_eq!(
            send("get", &[], Some("{}")),
            "TypeError: Request with GET/HEAD method cannot have body."
        );
        assert_eq!(
            send("trace", &[], Some("{}")),
            "TypeError: 'trace' HTTP method is unsupported."
        );
        assert_eq!(
            send("BAD METHOD", &[("bad name", "x")], None),
            "TypeError: 'BAD METHOD' is not a valid HTTP method."
        );
        assert_eq!(
            send("GET", &[("bad name", "x")], Some("{}")),
            "TypeError: Headers.append: \"bad name\" is an invalid header name."
        );
        assert_eq!(
            send("PO€T", &[("x", "€")], None),
            "TypeError: Cannot convert argument to a ByteString because the character at index 0 has a value of 8364 which is greater than 255."
        );
        assert_eq!(
            send("post", &[], Some("{}")),
            "Error: this Io cannot send POST requests"
        );
    }
}
