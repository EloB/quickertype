//! `--graphql-introspect` end to end, against the TypeScript reference.
//!
//! `xtask/graphql-input/record-introspection.mjs` ran the reference CLI
//! with `--graphql-introspect` (and `--http-method`, `--http-header`,
//! `--graphql-schema`, query files) against a local server with scripted
//! responses, and recorded the exit code, stdout, stderr, the files the run
//! wrote and the requests the server received
//! (`tests/fixtures/graphql-introspect.json`). This test serves the same
//! responses, runs the Rust CLI the same way and compares everything.

use std::collections::BTreeMap;
use std::fs;
use std::io::{BufRead, BufReader, Read, Write};
use std::net::TcpListener;
use std::path::{Path, PathBuf};
use std::process::Command;
use std::sync::{Arc, Mutex};

use quicktype_graphql_input::graphql::get_introspection_query;
use quicktype_js_compat::json;
use serde_json::{Map, Value, json};

const BIN: &str = env!("CARGO_BIN_EXE_quicktype");

fn manifest() -> Value {
    let path = Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/fixtures/graphql-introspect.json");
    serde_json::from_str(&fs::read_to_string(path).unwrap()).unwrap()
}

/// What the server records of a request, like the recorder's server.
type Requests = Arc<Mutex<Vec<Value>>>;

/// Serves the manifest's routes on a free port, recording each request's
/// method, path, the listed headers (lower-case names, repeated headers
/// joined like Node) and body.
fn serve(routes: Map<String, Value>, recorded_headers: Vec<String>) -> (String, Requests) {
    let listener = TcpListener::bind("127.0.0.1:0").unwrap();
    let url = format!("http://127.0.0.1:{}", listener.local_addr().unwrap().port());
    let requests: Requests = Arc::default();
    let log = Arc::clone(&requests);
    let mut introspection_body = String::from("{\"query\":");
    json::write_quoted(&mut introspection_body, get_introspection_query());
    introspection_body.push('}');
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
                if reader.read_line(&mut line).is_err() {
                    break;
                }
                let Some((name, value)) = line.trim_end().split_once(':') else {
                    break;
                };
                headers.push((name.to_ascii_lowercase(), value.trim().to_owned()));
            }
            let header = |name: &str| {
                let values: Vec<&str> = headers
                    .iter()
                    .filter(|(n, _)| n == name)
                    .map(|(_, v)| v.as_str())
                    .collect();
                (!values.is_empty()).then(|| values.join(", "))
            };
            let length: usize = header("content-length")
                .and_then(|v| v.parse().ok())
                .unwrap_or(0);
            let mut body = vec![0; length];
            let _ = reader.read_exact(&mut body);
            let body = String::from_utf8_lossy(&body).into_owned();
            let mut parts = request_line.split_whitespace();
            let method = parts.next().unwrap_or("").to_owned();
            let path = parts.next().unwrap_or("").to_owned();
            let mut recorded = Map::new();
            for name in &recorded_headers {
                if let Some(value) = header(name) {
                    recorded.insert(name.clone(), Value::String(value));
                }
            }
            log.lock().unwrap().push(json!({
                "method": method,
                "path": path,
                "headers": recorded,
                "body": if body == introspection_body { "<introspection query>".to_owned() } else { body },
            }));
            let route = routes
                .get(&path)
                .cloned()
                .unwrap_or(json!({"status": 404, "headers": {}, "body": ""}));
            let route_body = route["body"].as_str().unwrap_or("").as_bytes().to_vec();
            let mut head = format!("HTTP/1.1 {} X\r\n", route["status"]);
            for (name, value) in route["headers"].as_object().unwrap() {
                head.push_str(&format!("{name}: {}\r\n", value.as_str().unwrap()));
            }
            head.push_str(&format!(
                "Content-Length: {}\r\nConnection: close\r\n\r\n",
                route_body.len()
            ));
            let _ = stream.write_all(head.as_bytes());
            let _ = stream.write_all(&route_body);
        }
    });
    (url, requests)
}

/// A fresh, empty directory for one case.
fn work_dir(id: &str) -> PathBuf {
    let dir = Path::new(env!("CARGO_TARGET_TMPDIR"))
        .join("graphql-introspect")
        .join(id);
    let _ = fs::remove_dir_all(&dir);
    fs::create_dir_all(&dir).unwrap();
    dir
}

#[test]
fn graphql_introspect_matches_the_reference() {
    let manifest = manifest();
    let recorded_headers: Vec<String> = manifest["headers"]
        .as_array()
        .unwrap()
        .iter()
        .map(|h| h.as_str().unwrap().to_owned())
        .collect();
    let (url, requests) = serve(
        manifest["routes"].as_object().unwrap().clone(),
        recorded_headers,
    );
    let mut failures = Vec::new();
    for case in manifest["cases"].as_array().unwrap() {
        let id = case["id"].as_str().unwrap();
        let dir = work_dir(id);
        let files = case.get("files").and_then(Value::as_object);
        for (name, content) in files.into_iter().flatten() {
            fs::write(dir.join(name), content.as_str().unwrap()).unwrap();
        }
        requests.lock().unwrap().clear();
        let args: Vec<String> = case["args"]
            .as_array()
            .unwrap()
            .iter()
            .map(|a| a.as_str().unwrap().replace("{URL}", &url))
            .collect();
        let output = Command::new(BIN)
            .args(&args)
            .current_dir(&dir)
            .output()
            .unwrap();
        let unport = |bytes: &[u8]| String::from_utf8_lossy(bytes).replace(&url, "{URL}");
        let mut written = BTreeMap::new();
        for entry in fs::read_dir(&dir).unwrap() {
            let name = entry.unwrap().file_name().to_string_lossy().into_owned();
            if !files.is_some_and(|f| f.contains_key(&name)) {
                written.insert(name.clone(), fs::read_to_string(dir.join(&name)).unwrap());
            }
        }
        let actual = json!({
            "exit": output.status.code(),
            "stdout": unport(&output.stdout),
            "stderr": unport(&output.stderr),
            "written": written,
            "requests": requests.lock().unwrap().clone(),
        });
        let expected = json!({
            "exit": case["exit"],
            "stdout": case["stdout"],
            "stderr": case["stderr"],
            "written": case["written"],
            "requests": case["requests"],
        });
        if actual != expected {
            failures.push(format!(
                "--- {id}\nexpected: {expected:#}\nactual:   {actual:#}"
            ));
        }
    }
    assert!(failures.is_empty(), "{}", failures.join("\n"));
}
