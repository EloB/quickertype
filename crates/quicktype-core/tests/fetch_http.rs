//! `readFromFileOrURL` over HTTP against a local server: Node's `fetch`
//! semantics for redirects, request headers, content codings and `null`
//! bodies (`input/io/fetch.rs`). The expected texts were checked against
//! Node 24.

#![cfg(feature = "http")]

use std::io::{BufRead, BufReader, Write};
use std::net::TcpListener;

use flate2::Compression;
use flate2::write::{DeflateEncoder, GzEncoder, ZlibEncoder};
use quicktype_core::input::io::block_on;
use quicktype_core::input::io::node_io::{StdIo, read_from_file_or_url};

fn gzip() -> Vec<u8> {
    let mut e = GzEncoder::new(Vec::new(), Compression::default());
    e.write_all(b"{\"a\":1}").unwrap();
    e.finish().unwrap()
}

fn zlib() -> Vec<u8> {
    let mut e = ZlibEncoder::new(Vec::new(), Compression::default());
    e.write_all(b"{\"a\":1}").unwrap();
    e.finish().unwrap()
}

fn deflate_raw() -> Vec<u8> {
    let mut e = DeflateEncoder::new(Vec::new(), Compression::default());
    e.write_all(b"{\"a\":1}").unwrap();
    e.finish().unwrap()
}

/// `zlib.brotliCompressSync('{"br":true}')`.
const BROTLI: [u8; 15] = [
    0x0b, 0x05, 0x80, 0x7b, 0x22, 0x62, 0x72, 0x22, 0x3a, 0x74, 0x72, 0x75, 0x65, 0x7d, 0x03,
];

/// Serves the test routes on a free port; returns the port.
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
            let path = request_line
                .split_whitespace()
                .nth(1)
                .unwrap_or("/")
                .to_owned();
            let respond = |stream: &mut std::net::TcpStream,
                           status: &str,
                           extra: &str,
                           body: &[u8]| {
                let _ = write!(
                    stream,
                    "HTTP/1.1 {status}\r\n{extra}Content-Length: {}\r\nConnection: close\r\n\r\n",
                    body.len()
                );
                let _ = stream.write_all(body);
            };
            if let Some(n) = path.strip_prefix("/redirect/") {
                let n: usize = n.parse().unwrap_or(0);
                if n == 0 {
                    respond(&mut stream, "200 OK", "", b"{\"redirected\":true}");
                } else {
                    let location = format!("Location: /redirect/{}\r\n", n - 1);
                    respond(&mut stream, "302 Found", &location, b"");
                }
                continue;
            }
            match path.as_str() {
                "/echo" => {
                    let body: Vec<String> = headers
                        .iter()
                        .filter(|(n, _)| n != "host" && n != "connection")
                        .map(|(n, v)| format!("{n}: {v}"))
                        .collect();
                    respond(&mut stream, "200 OK", "", body.join("\n").as_bytes());
                }
                "/same-origin" => respond(
                    &mut stream,
                    "307 Temporary Redirect",
                    "Location: /echo\r\n",
                    b"",
                ),
                "/cross-origin" => {
                    let location = format!("Location: http://localhost:{port}/echo\r\n");
                    respond(&mut stream, "301 Moved Permanently", &location, b"");
                }
                "/no-location" => respond(&mut stream, "302 Found", "", b""),
                "/gzip" => respond(&mut stream, "200 OK", "Content-Encoding: gzip\r\n", &gzip()),
                "/deflate" => respond(
                    &mut stream,
                    "200 OK",
                    "Content-Encoding: deflate\r\n",
                    &zlib(),
                ),
                "/deflate-raw" => respond(
                    &mut stream,
                    "200 OK",
                    "Content-Encoding: deflate\r\n",
                    &deflate_raw(),
                ),
                "/br" => respond(&mut stream, "200 OK", "Content-Encoding: br\r\n", &BROTLI),
                "/unknown-coding" => respond(
                    &mut stream,
                    "200 OK",
                    "Content-Encoding: compress\r\n",
                    b"raw",
                ),
                "/204" => respond(&mut stream, "204 No Content", "", b""),
                "/205" => respond(&mut stream, "205 Reset Content", "", b""),
                "/304" => respond(&mut stream, "304 Not Modified", "", b""),
                _ => respond(&mut stream, "404 Not Found", "", b""),
            }
        }
    });
    port
}

fn read(url: &str, headers: &[&str]) -> Result<String, String> {
    let headers: Vec<String> = headers.iter().map(|h| (*h).to_owned()).collect();
    block_on(read_from_file_or_url(&StdIo, url, &headers)).map_err(|e| e.user_message().to_owned())
}

#[test]
fn follows_twenty_redirects_but_not_twenty_one() {
    let port = serve();
    assert_eq!(
        read(&format!("http://127.0.0.1:{port}/redirect/20"), &[]),
        Ok("{\"redirected\":true}".to_owned())
    );
    let url = format!("http://127.0.0.1:{port}/redirect/21");
    assert_eq!(
        read(&url, &[]),
        Err(format!(
            "Cannot read from file or URL {url}: TypeError: fetch failed"
        ))
    );
    let url = format!("http://127.0.0.1:{port}/no-location");
    assert_eq!(
        read(&url, &[]),
        Err(format!(
            "Cannot read from file or URL {url}: Error: HTTP 302 Found"
        ))
    );
}

#[test]
fn sends_fetchs_headers() {
    let port = serve();
    let echo = read(
        &format!("http://127.0.0.1:{port}/echo"),
        &[
            "X-A: 3",
            "x-a: 2",
            "Host: evil.example",
            "Authorization: Bearer t",
        ],
    )
    .unwrap();
    let lines: Vec<&str> = echo.lines().collect();
    for expected in [
        "x-a: 3, 2",
        "authorization: Bearer t",
        "accept: */*",
        "accept-language: *",
        "accept-encoding: gzip, deflate",
        "user-agent: node",
        "sec-fetch-mode: cors",
    ] {
        assert!(lines.contains(&expected), "{expected:?} not in {lines:?}");
    }
    assert!(!echo.contains("evil.example"), "{echo}");
}

#[test]
fn keeps_credentials_on_same_origin_redirects_only() {
    let port = serve();
    let headers = ["Authorization: Bearer t", "Cookie: c=1", "X-Other: o"];
    let same = read(&format!("http://127.0.0.1:{port}/same-origin"), &headers).unwrap();
    assert!(same.contains("authorization: Bearer t"), "{same}");
    assert!(same.contains("cookie: c=1"), "{same}");
    let cross = read(&format!("http://127.0.0.1:{port}/cross-origin"), &headers).unwrap();
    assert!(!cross.contains("authorization"), "{cross}");
    assert!(!cross.contains("cookie"), "{cross}");
    assert!(cross.contains("x-other: o"), "{cross}");
}

#[test]
fn decodes_content_codings() {
    let port = serve();
    for path in ["gzip", "deflate", "deflate-raw"] {
        assert_eq!(
            read(&format!("http://127.0.0.1:{port}/{path}"), &[]),
            Ok("{\"a\":1}".to_owned()),
            "{path}"
        );
    }
    assert_eq!(
        read(&format!("http://127.0.0.1:{port}/br"), &[]),
        Ok("{\"br\":true}".to_owned())
    );
    assert_eq!(
        read(&format!("http://127.0.0.1:{port}/unknown-coding"), &[]),
        Ok("raw".to_owned())
    );
}

#[test]
fn null_bodies_fail_like_node_io() {
    let port = serve();
    for status in ["204", "205"] {
        let url = format!("http://127.0.0.1:{port}/{status}");
        assert_eq!(
            read(&url, &[]),
            Err(format!(
                "Cannot read from file or URL {url}: TypeError: Cannot read properties of null (reading 'getReader')"
            ))
        );
    }
    let url = format!("http://127.0.0.1:{port}/304");
    assert_eq!(
        read(&url, &[]),
        Err(format!(
            "Cannot read from file or URL {url}: Error: HTTP 304 Not Modified"
        ))
    );
}

#[test]
fn invalid_requests_fail_before_sending() {
    let url = "http://u:p@127.0.0.1:9/x.json";
    assert_eq!(
        read(url, &[]),
        Err(format!(
            "Cannot read from file or URL {url}: TypeError: Request cannot be constructed from a URL that includes credentials: {url}"
        ))
    );
    let url = "http://localhost:99999/x.json";
    assert_eq!(
        read(url, &[]),
        Err(format!(
            "Cannot read from file or URL {url}: TypeError: Failed to parse URL from {url}"
        ))
    );
    let port = serve();
    let url = format!("http://127.0.0.1:{port}/echo");
    assert_eq!(
        read(&url, &["Bad Name: x"]),
        Err(format!(
            "Cannot read from file or URL {url}: TypeError: Headers.append: \"Bad Name\" is an invalid header name."
        ))
    );
}
