//! Regression cases found by differential fuzzing (`xtask/fuzz`).
//!
//! Each `tests/fuzz-regressions/<name>/case.json` was recorded by
//! `xtask/fuzz/record.mjs` from the reference CLI: a CLI step (`args`
//! relative to the case directory, reading `in/`), its exit code, and its
//! stdout, stderr and written files (`cli.stdout`, `cli.stderr`,
//! `expected/<file>`). This test runs the step with our binary in a fresh
//! directory holding a copy of `in/` and compares all of it, with the
//! directory replaced by `{CWD}` as the recorder did. Node is not needed.
//! (The npm differential suite runs the same cases through the JavaScript
//! API.)

use std::fs;
use std::io::Read;
use std::path::{Path, PathBuf};
use std::process::{Command, Output, Stdio};
use std::thread;
use std::time::{Duration, Instant};

use serde_json::Value;

const BIN: &str = env!("CARGO_BIN_EXE_quickertype");

/// How long one case may run (debug builds are slow).
const TIMEOUT: Duration = Duration::from_secs(120);

fn cases_dir() -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("../../tests/fuzz-regressions")
}

fn copy_dir(from: &Path, to: &Path) {
    fs::create_dir_all(to).unwrap();
    for entry in fs::read_dir(from).unwrap() {
        let entry = entry.unwrap();
        let target = to.join(entry.file_name());
        if entry.file_type().unwrap().is_dir() {
            copy_dir(&entry.path(), &target);
        } else {
            fs::copy(entry.path(), target).unwrap();
        }
    }
}

/// Every file below `dir`, by path relative to `base`.
fn files(base: &Path, dir: &Path, acc: &mut Vec<(String, Vec<u8>)>) {
    let Ok(entries) = fs::read_dir(dir) else {
        return;
    };
    for entry in entries {
        let path = entry.unwrap().path();
        if path.is_dir() {
            files(base, &path, acc);
        } else {
            let rel = path
                .strip_prefix(base)
                .unwrap()
                .to_string_lossy()
                .into_owned();
            acc.push((rel, fs::read(&path).unwrap()));
        }
    }
}

fn read_or_empty(path: &Path) -> Vec<u8> {
    fs::read(path).unwrap_or_default()
}

fn normalize(bytes: &[u8], work: &Path) -> Vec<u8> {
    let text = String::from_utf8_lossy(bytes);
    let dir = work.to_string_lossy();
    text.replace(dir.as_ref(), "{CWD}").into_bytes()
}

fn first_difference(expected: &[u8], actual: &[u8]) -> String {
    let (e, a) = (
        String::from_utf8_lossy(expected),
        String::from_utf8_lossy(actual),
    );
    for (i, (el, al)) in e.split('\n').zip(a.split('\n')).enumerate() {
        if el != al {
            return format!("line {}: expected {el:?}, got {al:?}", i + 1);
        }
    }
    format!(
        "{} lines expected, {} lines got",
        e.split('\n').count(),
        a.split('\n').count()
    )
}

/// Runs `command` (stdin empty) and collects its output; a run that takes
/// longer than [`TIMEOUT`] is killed and reported (some of these cases made
/// the port recurse for minutes).
fn run_with_timeout(mut command: Command) -> Result<Output, String> {
    let mut child = command
        .stdin(Stdio::null())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .map_err(|e| format!("cannot run {BIN}: {e}"))?;
    let mut stdout = child.stdout.take().unwrap();
    let mut stderr = child.stderr.take().unwrap();
    let out_reader = thread::spawn(move || {
        let mut buf = Vec::new();
        stdout.read_to_end(&mut buf).map(|_| buf)
    });
    let err_reader = thread::spawn(move || {
        let mut buf = Vec::new();
        stderr.read_to_end(&mut buf).map(|_| buf)
    });
    let start = Instant::now();
    let status = loop {
        if let Some(status) = child.try_wait().map_err(|e| e.to_string())? {
            break status;
        }
        if start.elapsed() > TIMEOUT {
            let _ = child.kill();
            let _ = child.wait();
            return Err(format!("timed out after {TIMEOUT:?}"));
        }
        thread::sleep(Duration::from_millis(10));
    };
    Ok(Output {
        status,
        stdout: out_reader.join().unwrap().map_err(|e| e.to_string())?,
        stderr: err_reader.join().unwrap().map_err(|e| e.to_string())?,
    })
}

fn check_case(dir: &Path, work: &Path) -> Result<(), String> {
    let case: Value = serde_json::from_slice(&fs::read(dir.join("case.json")).unwrap()).unwrap();
    let Some(cli) = case.get("cli") else {
        return Ok(());
    };
    let _ = fs::remove_dir_all(work);
    fs::create_dir_all(work).unwrap();
    let work = work.canonicalize().unwrap();
    if dir.join("in").is_dir() {
        copy_dir(&dir.join("in"), &work.join("in"));
    }
    for d in cli["dirs"].as_array().into_iter().flatten() {
        fs::create_dir_all(work.join(d.as_str().unwrap())).unwrap();
    }
    let mut before = Vec::new();
    files(&work, &work, &mut before);

    let args: Vec<&str> = cli["args"]
        .as_array()
        .unwrap()
        .iter()
        .map(|a| a.as_str().unwrap())
        .collect();
    let mut command = Command::new(BIN);
    command
        .args(&args)
        .current_dir(&work)
        .env("TZ", "UTC")
        .env_remove("FORCE_COLOR")
        .env_remove("NO_COLOR");
    let out = run_with_timeout(command)?;

    let expected_exit = cli["exit"].as_i64().unwrap();
    if out.status.code().map(i64::from) != Some(expected_exit) {
        return Err(format!(
            "exit {:?}, expected {expected_exit}; stderr: {}",
            out.status.code(),
            String::from_utf8_lossy(&out.stderr)
                .lines()
                .next()
                .unwrap_or("")
        ));
    }
    for (stream, actual) in [("stdout", &out.stdout), ("stderr", &out.stderr)] {
        let expected = read_or_empty(&dir.join(format!("cli.{stream}")));
        let actual = normalize(actual, &work);
        if expected != actual {
            return Err(format!(
                "{stream} differs: {}",
                first_difference(&expected, &actual)
            ));
        }
    }

    let mut after = Vec::new();
    files(&work, &work, &mut after);
    let written: Vec<&(String, Vec<u8>)> = after.iter().filter(|f| !before.contains(f)).collect();
    let expected_files: Vec<&str> = cli["files"]
        .as_array()
        .into_iter()
        .flatten()
        .map(|f| f.as_str().unwrap())
        .collect();
    let mut names: Vec<&str> = written.iter().map(|(n, _)| n.as_str()).collect();
    names.sort_unstable();
    if names != expected_files {
        return Err(format!("wrote {names:?}, expected {expected_files:?}"));
    }
    for (name, bytes) in written {
        let expected = fs::read(dir.join("expected").join(name)).unwrap();
        let actual = normalize(bytes, &work);
        if expected != actual {
            return Err(format!(
                "{name} differs: {}",
                first_difference(&expected, &actual)
            ));
        }
    }
    Ok(())
}

#[test]
fn fuzz_regressions_match_reference() {
    let mut dirs: Vec<PathBuf> = fs::read_dir(cases_dir())
        .map(|entries| {
            entries
                .map(|e| e.unwrap().path())
                .filter(|p| p.join("case.json").is_file())
                .collect()
        })
        .unwrap_or_default();
    dirs.sort();
    let work_root = Path::new(env!("CARGO_TARGET_TMPDIR")).join("fuzz-regressions");
    let mut failures = Vec::new();
    for dir in &dirs {
        let name = dir.file_name().unwrap().to_string_lossy().into_owned();
        if let Err(e) = check_case(dir, &work_root.join(&name)) {
            failures.push(format!("{name}: {e}"));
        }
    }
    println!("fuzz regressions: {} cases", dirs.len());
    assert!(
        failures.is_empty(),
        "{} of {} fuzz regression(s) differ from the reference:\n{}",
        failures.len(),
        dirs.len(),
        failures.join("\n")
    );
}

/// Why `name` (one path component) cannot be checked out on every platform
/// CI tests on, if it cannot: the rules of `xtask/fuzz/file-names.mjs`
/// (which the recorder applies, also checking that names are in NFC).
fn unportable_file_name(name: &str) -> Option<&'static str> {
    const DEVICE_NAMES: [&str; 6] = ["con", "prn", "aux", "nul", "conin$", "conout$"];
    if name.is_empty() || name == "." || name == ".." {
        return Some("empty, . or ..");
    }
    if name
        .chars()
        .any(|c| c.is_control() || "/\\:*?\"<>|".contains(c))
    {
        return Some("a character Windows does not allow");
    }
    if name.ends_with(' ') || name.ends_with('.') {
        return Some("ends in a space or a dot");
    }
    let stem = name
        .split('.')
        .next()
        .unwrap_or("")
        .trim_end_matches(' ')
        .to_lowercase();
    let numbered = ["com", "lpt"].iter().any(|prefix| {
        stem.strip_prefix(prefix).is_some_and(|rest| {
            let mut chars = rest.chars();
            matches!(
                (chars.next(), chars.next()),
                (Some('0'..='9' | '¹' | '²' | '³'), None)
            )
        })
    });
    if DEVICE_NAMES.contains(&stem.as_str()) || numbered {
        return Some("a Windows device name");
    }
    if name.encode_utf16().count() > 120 || name.len() > 240 {
        return Some("too long");
    }
    None
}

#[test]
fn fuzz_regression_file_names_are_portable() {
    let mut all = Vec::new();
    files(&cases_dir(), &cases_dir(), &mut all);
    let mut problems = Vec::new();
    let mut folded = std::collections::HashMap::new();
    for (rel, _) in &all {
        let rel = rel.replace('\\', "/");
        let components: Vec<&str> = rel.split('/').collect();
        for component in &components {
            if let Some(why) = unportable_file_name(component) {
                problems.push(format!("{rel:?}: {component:?} is {why}"));
            }
        }
        for i in 1..=components.len() {
            let prefix = components[..i].join("/");
            if let Some(other) = folded.insert(prefix.to_lowercase(), prefix.clone()) {
                if other != prefix {
                    problems.push(format!("{prefix:?} and {other:?} differ only in case"));
                }
            }
        }
    }
    problems.sort();
    problems.dedup();
    assert!(
        problems.is_empty(),
        "tests/fuzz-regressions has file names Windows, macOS or Linux cannot check out:\n{}",
        problems.join("\n")
    );
}
