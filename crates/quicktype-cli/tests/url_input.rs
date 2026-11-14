//! Port of `test/unit/url-input.test.ts`: URL sources (a JSON sample, and
//! a JSON Schema with a relative remote `$ref`) served by a local HTTP
//! server, through the CLI. The TypeScript test generates TypeScript; Rust
//! output exercises the same input path.

use std::io::{BufRead, BufReader, Write};
use std::net::{TcpListener, TcpStream};
use std::path::{Path, PathBuf};
use std::process::{Command, Output};

const BIN: &str = env!("CARGO_BIN_EXE_quickertype");

const SAMPLE: &str = r#"{"veryUniquePropertyName":"quicktype","count":3}"#;
const MAIN_SCHEMA: &str = r#"{"$schema":"http://json-schema.org/draft-07/schema#","type":"object","properties":{"referenced":{"$ref":"referenced.schema"}},"required":["referenced"]}"#;
/// Two samples as JSON Lines (not in quicktype), and as the array of them.
const LINES: &str = "{\"veryUniquePropertyName\":\"a\"}\n{\"count\":3}\n";
const ARRAY: &str = r#"[{"veryUniquePropertyName":"a"},{"count":3}]"#;
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
            let path = path.split('?').next().unwrap_or_default();
            let file = path.rsplit('/').next().unwrap_or_default();
            match file {
                "unauthorized.json" => respond(
                    &mut stream,
                    "401 Unauthorized",
                    r#"{"message":"Bad credentials"}"#,
                ),
                "sample.json" => respond(&mut stream, "200 OK", SAMPLE),
                "lines.jsonl" | "lines.ndjson" | "lines" => respond(&mut stream, "200 OK", LINES),
                "array.json" => respond(&mut stream, "200 OK", ARRAY),
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
    let error = quicktype_core::internal::block_on(quicktype_core::read_from_file_or_url(
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

/// A URL whose path ends in `.jsonl` or `.ndjson` is JSON Lines, whatever
/// its query; so is any URL with `--src-lang jsonl`, and the URL a `.url`
/// file in a directory holds.
#[test]
fn json_lines_urls_are_the_array_of_their_values() {
    let base = serve();
    let expected = generate("json", &format!("{base}/array.json"), "array");
    assert!(expected.contains("very_unique_property_name"), "{expected}");
    let by_name = |url: &str, name: &str| {
        let dir = work_dir(name);
        let output = run_in(
            &dir,
            &["--lang", "rust", "-t", "TopLevel", "--out", "out.rs", url],
        );
        assert_eq!(
            output.status.code(),
            Some(0),
            "{url}: {}",
            String::from_utf8_lossy(&output.stderr)
        );
        std::fs::read_to_string(dir.join("out.rs")).unwrap()
    };
    assert_eq!(
        by_name(&format!("{base}/lines.jsonl?page=1&format=json"), "jsonl"),
        expected
    );
    assert_eq!(
        by_name(&format!("{base}/lines.ndjson#top"), "ndjson"),
        expected
    );
    assert_eq!(
        generate("jsonl", &format!("{base}/lines"), "forced"),
        expected
    );
    // Without the extension, or with `--src-lang json`, a URL is JSON.
    let (plain, named) = (format!("{base}/lines"), format!("{base}/lines.jsonl"));
    for args in [
        &["--lang", "rust", &plain][..],
        &["--lang", "rust", "-s", "json", &named],
    ] {
        let output = run_in(&work_dir("json"), args);
        assert_eq!(output.status.code(), Some(1), "{args:?}");
    }
    // A `.url` file in a directory, by its URL's name: JSON Lines without
    // `--src-lang` or with `--src-lang jsonl`; with `--src-lang json`, JSON,
    // as quicktype reads it (two values: a syntax error).
    for (name, url) in [("jsonl", "lines.jsonl"), ("ndjson", "lines.ndjson")] {
        let dir = work_dir(&format!("url-file-{name}"));
        std::fs::create_dir_all(dir.join("data")).unwrap();
        std::fs::write(dir.join("data/TopLevel.url"), format!("{base}/{url}\n")).unwrap();
        for src_lang in [&[][..], &["--src-lang", "jsonl"]] {
            let mut args = vec!["--lang", "rust", "--out", "out.rs"];
            args.extend_from_slice(src_lang);
            args.push("data");
            let output = run_in(&dir, &args);
            assert_eq!(
                output.status.code(),
                Some(0),
                "{args:?}: {}",
                String::from_utf8_lossy(&output.stderr)
            );
            assert_eq!(
                std::fs::read_to_string(dir.join("out.rs")).unwrap(),
                expected
            );
        }
        let output = run_in(&dir, &["--lang", "rust", "--src-lang", "json", "data"]);
        assert_eq!(output.status.code(), Some(1));
        assert_eq!(
            String::from_utf8_lossy(&output.stderr),
            "Error: Syntax error in input JSON TopLevel: Parser cannot parse input: unexpected characters.\n"
        );
    }
}
