//! Port of `test/unit/url-input.test.ts`: URL sources (a JSON sample, and
//! a JSON Schema with a relative remote `$ref`) served by a local HTTP
//! server, through the CLI. The TypeScript test generates TypeScript; Rust
//! output exercises the same input path.

use std::io::{BufRead, BufReader, Write};
use std::net::{TcpListener, TcpStream};
use std::path::{Path, PathBuf};
use std::process::{Command, Output};

const BIN: &str = env!("CARGO_BIN_EXE_quicktype");

const SAMPLE: &str = r#"{"veryUniquePropertyName":"quicktype","count":3}"#;
const MAIN_SCHEMA: &str = r#"{"$schema":"http://json-schema.org/draft-07/schema#","type":"object","properties":{"referenced":{"$ref":"referenced.schema"}},"required":["referenced"]}"#;
const REFERENCED_SCHEMA: &str = r#"{"$schema":"http://json-schema.org/draft-07/schema#","type":"object","properties":{"veryUniqueReferencedProperty":{"type":"string"}},"required":["veryUniqueReferencedProperty"]}"#;

fn respond(stream: &mut TcpStream, status: &str, body: &str) {
    let _ = write!(
        stream,
        "HTTP/1.1 {status}\r\nContent-Type: application/json\r\nContent-Length: {}\r\nConnection: close\r\n\r\n{body}",
        body.len()
    );
}

/// Serves the test files on a free port; returns the base URL.
fn serve() -> String {
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
            loop {
                let mut line = String::new();
                if reader.read_line(&mut line).is_err() || line.trim().is_empty() {
                    break;
                }
            }
            let path = request_line.split_whitespace().nth(1).unwrap_or("/");
            let file = path.rsplit('/').next().unwrap_or_default();
            match file {
                "unauthorized.json" => respond(
                    &mut stream,
                    "401 Unauthorized",
                    r#"{"message":"Bad credentials"}"#,
                ),
                "sample.json" => respond(&mut stream, "200 OK", SAMPLE),
                "main.schema" => respond(&mut stream, "200 OK", MAIN_SCHEMA),
                "referenced.schema" => respond(&mut stream, "200 OK", REFERENCED_SCHEMA),
                _ => respond(&mut stream, "404 Not Found", ""),
            }
        }
    });
    format!("http://127.0.0.1:{port}")
}

fn work_dir(name: &str) -> PathBuf {
    let dir = Path::new(env!("CARGO_TARGET_TMPDIR"))
        .join("url-tests")
        .join(name);
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).unwrap();
    dir
}

/// `main({srcLang, src: [url], lang, out, topLevel: "TopLevel", quiet,
/// telemetry: "disable"})`, returning the written file.
fn generate(source_language: &str, url: &str, name: &str) -> String {
    let dir = work_dir(name);
    let output = run_in(
        &dir,
        &[
            "--src-lang",
            source_language,
            "--src",
            url,
            "--lang",
            "rust",
            "--out",
            "out.rs",
            "--top-level",
            "TopLevel",
            "--quiet",
            "--telemetry",
            "disable",
        ],
    );
    assert_eq!(
        output.status.code(),
        Some(0),
        "{}",
        String::from_utf8_lossy(&output.stderr)
    );
    std::fs::read_to_string(dir.join("out.rs")).unwrap()
}

fn run_in(dir: &Path, args: &[&str]) -> Output {
    Command::new(BIN)
        .args(args)
        .current_dir(dir)
        .output()
        .unwrap()
}

#[test]
fn generates_types_from_a_json_url() {
    let base = serve();
    let output = generate("json", &format!("{base}/sample.json"), "json");
    assert!(output.contains("very_unique_property_name"), "{output}");
}

#[test]
fn rejects_an_http_error_response() {
    let base = serve();
    let url = format!("{base}/unauthorized.json");
    let error = quicktype_core::block_on(quicktype_core::read_from_file_or_url(
        &quicktype_core::StdIo,
        &url,
        &[],
    ))
    .unwrap_err();
    assert!(
        error.user_message().contains("HTTP 401 Unauthorized"),
        "{error}"
    );

    let output = run_in(&work_dir("unauthorized"), &["--lang", "rust", &url]);
    assert_eq!(output.status.code(), Some(1));
    assert_eq!(
        String::from_utf8_lossy(&output.stderr),
        format!("Error: Cannot read from file or URL {url}: Error: HTTP 401 Unauthorized.\n")
    );
}

#[test]
fn resolves_a_relative_remote_json_schema_reference() {
    let base = serve();
    let output = generate("schema", &format!("{base}/main.schema"), "schema");
    assert!(
        output.contains("very_unique_referenced_property"),
        "{output}"
    );
}
