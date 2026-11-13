//! Port of `src/GraphQLIntrospection.ts`.
//!
//! `--graphql-introspect URL` sends graphql-js's introspection query to a
//! GraphQL server with `fetch` (method `--http-method`, default `POST`,
//! plus the `--http-header`s) and returns the result as the text of a
//! `--graphql-schema` file.

use indexmap::IndexMap;
use quicktype_core::support::recursion::stack_overflow;
use quicktype_core::{Io, JsErrorName, QuickTypeError, RequestInit};
use quicktype_graphql_input::graphql::get_introspection_query;
use quicktype_js_compat::json::{self, JsonValue, insert_js_property};
use quicktype_js_compat::whitespace;

/// `panic(message)`: an internal error.
fn panic(message: String) -> QuickTypeError {
    QuickTypeError::internal(message)
}

/// The deepest value `JSON.stringify` writes here before Node's stack
/// overflows, as [`json::depth`] counts. V8 checks its stack on entering
/// each non-empty array or object, not for scalars and empty ones (which
/// `json::depth` counts alike): the reference CLI (Node 24) writes the
/// result, or its `errors`, with 5,986 of them nested (a depth of 5,987),
/// and throws `RangeError: Maximum call stack size exceeded` at 5,987.
/// Measured with arrays and with objects, around a number, `[]` and `{}`,
/// in fresh processes, the same however the response arrives. Node's limit
/// moves with the size of its environment and command line, which share
/// the main thread's stack: about one level less for every 170 bytes more
/// (measured with a 3 KB environment).
const STRINGIFY_MAX_DEPTH: usize = 5_987;

/// `JSON.stringify(value, null, gap)`, or V8's `RangeError` where it
/// overflows Node's stack. (Without the limit, a response nested a
/// million levels deep took the indented text, quadratic in the depth,
/// all the memory there was.)
fn stringify(value: &JsonValue, gap: Option<&str>) -> Result<String, QuickTypeError> {
    if json::depth_exceeds(value, STRINGIFY_MAX_DEPTH) {
        return Err(stack_overflow());
    }
    Ok(json::stringify(value, gap))
}

/// `headerRegExp.exec(str)` with `/^([^:]+):\s*(.*)$/`: the name (up to
/// the first colon, not empty) and the value (after any whitespace, to the
/// end, without line terminators).
fn match_header(s: &str) -> Option<(&str, &str)> {
    let colon = s.find(':')?;
    if colon == 0 {
        return None;
    }
    let value = s[colon + 1..].trim_start_matches(whitespace::is_whitespace);
    if value.contains(['\n', '\r', '\u{2028}', '\u{2029}']) {
        return None;
    }
    Some((&s[..colon], value))
}

/// `result[key]` for a key no prototype has: `None` for `undefined`, a
/// `TypeError` if `result` is `null`.
fn get<'a>(result: &'a JsonValue, key: &str) -> Result<Option<&'a JsonValue>, QuickTypeError> {
    json::get_property(Some(result), key)
        .map_err(|e| QuickTypeError::js_exception(JsErrorName::TypeError, e.message()))
}

/// `await response.json()`: the body as UTF-8 (without a byte-order mark,
/// invalid sequences replaced) through `JSON.parse`; its `SyntaxError` as
/// `exceptionToString` gives it.
fn response_json(body: Option<&[u8]>) -> Result<JsonValue, String> {
    let bytes = body.unwrap_or_default();
    let bytes = bytes.strip_prefix(b"\xef\xbb\xbf").unwrap_or(bytes);
    json::parse(&String::from_utf8_lossy(bytes)).map_err(|e| format!("SyntaxError: {e}"))
}

/// `introspectServer(url, method, headerStrings)`: the introspection
/// result, as `JSON.stringify(result, null, 2)`.
pub async fn introspect_server(
    io: &dyn Io,
    url: &str,
    method: &str,
    header_strings: &[String],
) -> Result<String, QuickTypeError> {
    // `headers` is a plain object: the defaults, then each header in turn,
    // a later one of the same name replacing it in place.
    let mut headers: IndexMap<String, String> = IndexMap::new();
    headers.insert("Accept".to_owned(), "application/json".to_owned());
    headers.insert("Content-Type".to_owned(), "application/json".to_owned());
    for s in header_strings {
        let Some((name, value)) = match_header(s) else {
            return Err(panic(format!("Not a valid HTTP header: \"{s}\"")));
        };
        // Assigning a string to `__proto__` does nothing.
        if name != "__proto__" {
            insert_js_property(&mut headers, name.to_owned(), value.to_owned());
        }
    }
    let headers: Vec<(String, String)> = headers.into_iter().collect();

    let mut body = String::from("{\"query\":");
    json::write_quoted(&mut body, get_introspection_query());
    body.push('}');

    let response = io
        .fetch_with_init(
            url,
            RequestInit {
                method,
                headers: &headers,
                body: Some(&body),
            },
        )
        .await;
    let result = response
        .map_err(|e| e.to_js_string())
        .and_then(|response| response_json(response.body.as_deref()))
        .map_err(|e| {
            panic(format!(
                "Error while fetching introspection query result: {e}"
            ))
        })?;

    if let Some(errors) = get(&result, "errors")?
        && json::is_truthy(errors)
    {
        return Err(panic(format!(
            "Errors in introspection query result: {}",
            stringify(errors, None)?
        )));
    }
    if !get(&result, "data")?.is_some_and(json::is_truthy) {
        return Err(panic(format!(
            "No introspection query result data found, server responded with: {}",
            stringify(&result, None)?
        )));
    }
    stringify(&result, Some("  "))
}

#[cfg(test)]
mod tests {
    //! Includes a port of `test/unit/graphql-introspection.test.ts`.

    use std::io::{BufRead, BufReader, Read, Write};
    use std::net::TcpListener;
    use std::sync::mpsc;

    use quicktype_core::StdIo;
    use quicktype_core::internal::block_on;

    use super::*;

    /// What the server received.
    struct ReceivedRequest {
        method: String,
        headers: Vec<(String, String)>,
        body: String,
    }

    /// Serves one request on a free port with a 200 JSON `response`;
    /// returns the port and where the request arrives.
    fn serve_once(response: impl Into<String>) -> (u16, mpsc::Receiver<ReceivedRequest>) {
        let response = response.into();
        let listener = TcpListener::bind("127.0.0.1:0").unwrap();
        let port = listener.local_addr().unwrap().port();
        let (sender, receiver) = mpsc::channel();
        std::thread::spawn(move || {
            let (mut stream, _) = listener.accept().unwrap();
            let mut reader = BufReader::new(stream.try_clone().unwrap());
            let mut request_line = String::new();
            reader.read_line(&mut request_line).unwrap();
            let mut headers = Vec::new();
            loop {
                let mut line = String::new();
                reader.read_line(&mut line).unwrap();
                let Some((name, value)) = line.trim_end().split_once(':') else {
                    break;
                };
                headers.push((name.to_ascii_lowercase(), value.trim().to_owned()));
            }
            let length = headers
                .iter()
                .find(|(n, _)| n == "content-length")
                .and_then(|(_, v)| v.parse().ok())
                .unwrap_or(0);
            let mut body = vec![0; length];
            reader.read_exact(&mut body).unwrap();
            write!(
                stream,
                "HTTP/1.1 200 OK\r\nContent-Type: application/json\r\nContent-Length: {}\r\nConnection: close\r\n\r\n{response}",
                response.len()
            )
            .unwrap();
            let method = request_line.split(' ').next().unwrap_or("").to_owned();
            sender
                .send(ReceivedRequest {
                    method,
                    headers,
                    body: String::from_utf8(body).unwrap(),
                })
                .unwrap();
        });
        (port, receiver)
    }

    /// `posts the introspection query and forwards custom headers`.
    #[test]
    fn posts_the_introspection_query_and_forwards_custom_headers() {
        let (port, received) =
            serve_once(r#"{"data":{"__schema":{"queryType":{"name":"Query"}}}}"#);
        let result = block_on(introspect_server(
            &StdIo,
            &format!("http://127.0.0.1:{port}/graphql"),
            "POST",
            &["Authorization: Bearer test-token".to_owned()],
        ))
        .unwrap();
        assert_eq!(
            result,
            "{\n  \"data\": {\n    \"__schema\": {\n      \"queryType\": {\n        \"name\": \"Query\"\n      }\n    }\n  }\n}"
        );
        let request = received.recv().unwrap();
        let header = |name: &str| {
            request
                .headers
                .iter()
                .find(|(n, _)| n == name)
                .map(|(_, v)| v.as_str())
        };
        assert_eq!(request.method, "POST");
        assert_eq!(header("authorization"), Some("Bearer test-token"));
        assert_eq!(header("content-type"), Some("application/json"));
        let body = json::parse(&request.body).unwrap();
        let JsonValue::Object(body) = &body else {
            panic!("an object");
        };
        let Some(JsonValue::String(query)) = body.get("query") else {
            panic!("a query");
        };
        assert!(query.contains("__schema"));
    }

    /// Where Node's `JSON.stringify` overflows its stack, with the result
    /// or its errors (a million levels used to run out of memory), whatever
    /// the innermost value: V8 checks its stack in non-empty arrays and
    /// objects only. On a thread with the CLI's stack: writing 5,987 levels
    /// recurses.
    #[test]
    fn deep_results_overflow_like_node() {
        std::thread::Builder::new()
            .stack_size(256 << 20)
            .spawn(deep_results_overflow_like_node_on_a_large_stack)
            .unwrap()
            .join()
            .unwrap();
    }

    fn deep_results_overflow_like_node_on_a_large_stack() {
        let introspect = |response: String| {
            let (port, _received) = serve_once(response);
            block_on(introspect_server(
                &StdIo,
                &format!("http://127.0.0.1:{port}/graphql"),
                "POST",
                &[],
            ))
            .map(|text| text.len())
            .map_err(|e| e.to_string())
        };
        let overflow = Err("Maximum call stack size exceeded".to_owned());
        // `{"key": [[…leaf…]]}` with `n` arrays, or with `n` objects
        // `{"k": …}`.
        let nested = |key: &str, n: usize, leaf: &str, objects: bool| {
            let (open, close) = if objects {
                (r#"{"k":"#, "}")
            } else {
                ("[", "]")
            };
            format!(r#"{{"{key}":{}{leaf}{}}}"#, open.repeat(n), close.repeat(n))
        };
        for leaf in ["1", "[]", "{}"] {
            for objects in [false, true] {
                // The result and 5,985 arrays: 5,986 checked.
                assert!(introspect(nested("data", 5_985, leaf, objects)).is_ok());
                assert_eq!(introspect(nested("data", 5_986, leaf, objects)), overflow);
                // Only the errors are written.
                assert!(
                    introspect(nested("errors", 5_986, leaf, objects))
                        .unwrap_err()
                        .starts_with("Internal error: Errors in introspection query result: ")
                );
                assert_eq!(introspect(nested("errors", 5_987, leaf, objects)), overflow);
            }
        }
        // Without data, the whole result is written into the error.
        let no_data =
            |n: usize| format!(r#"{{"data":null,"x":{}1{}}}"#, "[".repeat(n), "]".repeat(n));
        assert!(
            introspect(no_data(5_985))
                .unwrap_err()
                .starts_with("Internal error: No introspection query result data found")
        );
        assert_eq!(introspect(no_data(5_986)), overflow);
        assert_eq!(introspect(nested("data", 1_000_000, "1", false)), overflow);
    }

    #[test]
    fn headers_match_like_the_regular_expression() {
        assert_eq!(match_header("a: b"), Some(("a", "b")));
        assert_eq!(match_header("a:b:c"), Some(("a", "b:c")));
        assert_eq!(match_header("a:  \u{a0}b "), Some(("a", "b ")));
        assert_eq!(match_header("a:\n b"), Some(("a", "b")));
        assert_eq!(match_header("a: \n"), Some(("a", "")));
        assert_eq!(match_header("x y\nz: b"), Some(("x y\nz", "b")));
        assert_eq!(match_header("a: b\nc"), None);
        assert_eq!(match_header(": b"), None);
        assert_eq!(match_header("ab"), None);
    }

    #[test]
    fn invalid_headers_fail_before_fetching() {
        let error = block_on(introspect_server(
            &StdIo,
            "http://127.0.0.1:9/",
            "POST",
            &["nocolon".to_owned()],
        ))
        .unwrap_err();
        assert_eq!(
            error.user_message(),
            "Internal error: Not a valid HTTP header: \"nocolon\""
        );
    }
}
