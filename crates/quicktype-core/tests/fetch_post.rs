//! `Io::fetch_with_init` (`fetch(url, { method, headers, body })`, as
//! `--graphql-introspect` sends its query) against a local server: undici's
//! method validation and normalization, the `GET`/`HEAD` body rule, the
//! default `content-type`, and how redirects treat the method and body.
//! Every expectation was checked against Node 24.

#![cfg(feature = "http")]

use std::io::{BufRead, BufReader, Read, Write};
use std::net::TcpListener;

use quicktype_core::internal::block_on;
use quicktype_core::{Io, RequestInit, StdIo};

/// Serves on a free port: `/echo` answers with the request's method, path,
/// headers (lower-case names, without `host` and `connection`) and body;
/// `/301`, `/302`, `/303`, `/307` and `/308` redirect there.
fn serve() -> u16 {
    let listener = TcpListener::bind("127.0.0.1:0").unwrap();
    let port = listener.local_addr().unwrap().port();
    std::thread::spawn(move || {
        for stream in listener.incoming() {
            let Ok(mut stream) = stream else { continue };
            let mut reader = BufReader::new(stream.try_clone().unwrap());
            let mut request_line = String::new();
            if reader.read_line(&mut request_line).is_err() {
                continue;
            }
            let mut headers: Vec<(String, String)> = Vec::new();
            loop {
                let mut line = String::new();
                if reader.read_line(&mut line).is_err() || line.trim().is_empty() {
                    break;
                }
                if let Some((name, value)) = line.trim_end().split_once(':') {
                    headers.push((name.to_ascii_lowercase(), value.trim().to_owned()));
                }
            }
            let length: usize = headers
                .iter()
                .find(|(n, _)| n == "content-length")
                .and_then(|(_, v)| v.parse().ok())
                .unwrap_or(0);
            let mut body = vec![0; length];
            let _ = reader.read_exact(&mut body);
            let mut parts = request_line.split_whitespace();
            let method = parts.next().unwrap_or("").to_owned();
            let path = parts.next().unwrap_or("/").to_owned();
            let (status, extra, response) = match path.as_str() {
                "/301" | "/302" | "/303" | "/307" | "/308" => (
                    format!("{} Redirect", &path[1..]),
                    "Location: /echo\r\n".to_owned(),
                    String::new(),
                ),
                _ => {
                    let mut echo = format!("{method} {path}\n");
                    for (n, v) in &headers {
                        if n != "host" && n != "connection" {
                            echo.push_str(&format!("{n}: {v}\n"));
                        }
                    }
                    echo.push('\n');
                    echo.push_str(&String::from_utf8_lossy(&body));
                    ("200 OK".to_owned(), String::new(), echo)
                }
            };
            let _ = write!(
                stream,
                "HTTP/1.1 {status}\r\n{extra}Content-Length: {}\r\nConnection: close\r\n\r\n{response}",
                response.len()
            );
        }
    });
    port
}

fn headers(pairs: &[(&str, &str)]) -> Vec<(String, String)> {
    pairs
        .iter()
        .map(|(n, v)| ((*n).to_owned(), (*v).to_owned()))
        .collect()
}

fn send(url: &str, method: &str, headers: &[(String, String)], body: Option<&str>) -> String {
    let init = RequestInit {
        method,
        headers,
        body,
    };
    match block_on(StdIo.fetch_with_init(url, init)) {
        Ok(response) => String::from_utf8(response.body.unwrap_or_default()).unwrap(),
        Err(e) => e.to_js_string(),
    }
}

const JSON_HEADERS: [(&str, &str); 3] = [
    ("Accept", "application/json"),
    ("Content-Type", "application/json"),
    ("accept", "text/x"),
];

#[test]
fn posts_the_body_with_combined_headers() {
    let port = serve();
    let echo = send(
        &format!("http://127.0.0.1:{port}/echo"),
        "POST",
        &headers(&JSON_HEADERS),
        Some("{\"é\":1}"),
    );
    assert!(echo.starts_with("POST /echo\n"), "{echo}");
    assert!(
        echo.contains("\naccept: application/json, text/x\n"),
        "{echo}"
    );
    assert!(
        echo.contains("\ncontent-type: application/json\n"),
        "{echo}"
    );
    assert!(echo.contains("\ncontent-length: 8\n"), "{echo}");
    assert!(echo.ends_with("\n\n{\"é\":1}"), "{echo}");
}

#[test]
fn a_body_defaults_to_plain_text() {
    let port = serve();
    let echo = send(
        &format!("http://127.0.0.1:{port}/echo"),
        "PUT",
        &[],
        Some("x"),
    );
    assert!(echo.starts_with("PUT /echo\n"), "{echo}");
    assert!(
        echo.contains("\ncontent-type: text/plain;charset=UTF-8\n"),
        "{echo}"
    );
}

#[test]
fn methods_are_normalized_like_undici() {
    let port = serve();
    let url = format!("http://127.0.0.1:{port}/echo");
    for (method, sent) in [
        ("post", "POST"),
        ("Post", "POST"),
        ("delete", "DELETE"),
        ("PATCH", "PATCH"),
        ("Patch", "Patch"),
        ("PROPFIND", "PROPFIND"),
    ] {
        let echo = send(&url, method, &[], Some("{}"));
        assert!(
            echo.starts_with(&format!("{sent} /echo\n")),
            "{method}: {echo}"
        );
    }
}

#[test]
fn bad_methods_and_bodies_fail_before_sending() {
    let url = "http://127.0.0.1:9/x";
    let fail = |method: &str, headers: &[(String, String)], body| send(url, method, headers, body);
    assert_eq!(
        fail("GET", &[], Some("{}")),
        "TypeError: Request with GET/HEAD method cannot have body."
    );
    assert_eq!(
        fail("head", &[], Some("{}")),
        "TypeError: Request with GET/HEAD method cannot have body."
    );
    assert_eq!(
        fail("CONNECT", &[], Some("{}")),
        "TypeError: 'CONNECT' HTTP method is unsupported."
    );
    assert_eq!(
        fail("trace", &[], Some("{}")),
        "TypeError: 'trace' HTTP method is unsupported."
    );
    assert_eq!(
        fail("BAD METHOD", &headers(&[("bad name", "x")]), Some("{}")),
        "TypeError: 'BAD METHOD' is not a valid HTTP method."
    );
    assert_eq!(
        fail("", &[], Some("{}")),
        "TypeError: '' is not a valid HTTP method."
    );
    assert_eq!(
        fail("GET", &headers(&[("bad name", "x")]), Some("{}")),
        "TypeError: Headers.append: \"bad name\" is an invalid header name."
    );
    // The headers' ByteString conversion comes before the method's.
    assert_eq!(
        fail("PO€T", &headers(&[("x-a", "€")]), Some("{}")),
        "TypeError: Cannot convert argument to a ByteString because the character at index 0 has a value of 8364 which is greater than 255."
    );
    assert_eq!(
        fail("PO€T", &[], Some("{}")),
        "TypeError: Cannot convert argument to a ByteString because the character at index 2 has a value of 8364 which is greater than 255."
    );
    assert_eq!(
        send("http://u:p@127.0.0.1:9/x", "BAD METHOD", &[], Some("{}")),
        "TypeError: Request cannot be constructed from a URL that includes credentials: http://u:p@127.0.0.1:9/x"
    );
}

#[test]
fn redirects_turn_posts_into_gets_like_undici() {
    let port = serve();
    let json_headers = headers(&JSON_HEADERS);
    let redirected = |status: &str, method: &str| {
        send(
            &format!("http://127.0.0.1:{port}/{status}"),
            method,
            &json_headers,
            Some("{}"),
        )
    };
    for (status, method, expected) in [
        ("301", "POST", "GET"),
        ("302", "POST", "GET"),
        ("303", "PUT", "GET"),
        ("301", "PUT", "PUT"),
        ("307", "POST", "POST"),
        ("308", "POST", "POST"),
    ] {
        let echo = redirected(status, method);
        assert!(
            echo.starts_with(&format!("{expected} /echo\n")),
            "{status} {method}: {echo}"
        );
        if expected == "GET" {
            assert!(!echo.contains("content-type"), "{status} {method}: {echo}");
            assert!(
                !echo.contains("content-length"),
                "{status} {method}: {echo}"
            );
            assert!(echo.ends_with("\n\n"), "{status} {method}: {echo}");
        } else {
            assert!(
                echo.contains("\ncontent-type: application/json\n"),
                "{echo}"
            );
            assert!(echo.ends_with("\n\n{}"), "{status} {method}: {echo}");
        }
    }
}
