//! End-to-end tests of the `quicktype` binary: the port of
//! `test/unit/cli-epipe.test.ts`, and the generation path of
//! `src/index.ts` (sources, output, issues, errors and exit codes).
//!
//! Byte-for-byte parity with the TypeScript CLI is checked by
//! `cargo xtask parity`; these tests pin the behavior that the golden
//! corpus does not cover, with the expectations taken from the reference.

use std::fs;
use std::io::Write;
use std::path::{Path, PathBuf};
use std::process::{Command, Output, Stdio};

const BIN: &str = env!("CARGO_BIN_EXE_quicktype");

fn inputs() -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("../../tests/inputs")
}

fn sample(name: &str) -> String {
    inputs()
        .join("json/samples")
        .join(name)
        .to_string_lossy()
        .into_owned()
}

/// A fresh, empty directory for one test.
fn work_dir(name: &str) -> PathBuf {
    let dir = Path::new(env!("CARGO_TARGET_TMPDIR"))
        .join("cli-tests")
        .join(name);
    let _ = fs::remove_dir_all(&dir);
    fs::create_dir_all(&dir).unwrap();
    dir
}

fn quicktype_in(dir: &Path, args: &[&str], stdin: Option<&[u8]>) -> Output {
    let mut child = Command::new(BIN)
        .args(args)
        .current_dir(dir)
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    let mut child_stdin = child.stdin.take().unwrap();
    child_stdin.write_all(stdin.unwrap_or_default()).unwrap();
    drop(child_stdin);
    child.wait_with_output().unwrap()
}

fn quicktype(args: &[&str]) -> Output {
    quicktype_in(Path::new(env!("CARGO_MANIFEST_DIR")), args, None)
}

fn stdout(output: &Output) -> String {
    String::from_utf8_lossy(&output.stdout).into_owned()
}

fn stderr(output: &Output) -> String {
    String::from_utf8_lossy(&output.stderr).into_owned()
}

/// Port of `cli-epipe.test.ts`: "exits successfully when stdout is closed
/// early". (The TypeScript test renders Swift from a JSON Schema; any
/// large output exercises the same path.)
#[test]
fn exits_successfully_when_stdout_is_closed_early() {
    let mut child = Command::new(BIN)
        .args(["--lang", "rust", &sample("github-events.json")])
        .stdin(Stdio::null())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    drop(child.stdout.take());
    let output = child.wait_with_output().unwrap();
    let stderr = stderr(&output);
    assert_eq!(output.status.code(), Some(0), "{stderr}");
    assert!(!stderr.contains("EPIPE"), "{stderr}");
    assert!(!stderr.contains("Broken pipe"), "{stderr}");
}

#[test]
fn renders_to_stdout_with_the_inferred_top_level() {
    let output = quicktype(&["--lang", "rust", "--quiet", &sample("simple-object.json")]);
    assert_eq!(output.status.code(), Some(0), "{}", stderr(&output));
    let code = stdout(&output);
    assert!(code.contains("pub struct SimpleObject {"), "{code}");
    assert!(code.ends_with("}\n"));
}

#[test]
fn writes_the_out_file_and_infers_the_language_from_it() {
    let dir = work_dir("out-file");
    let output = quicktype_in(
        &dir,
        &["-o", "Person.rs", &sample("simple-object.json")],
        None,
    );
    assert_eq!(output.status.code(), Some(0), "{}", stderr(&output));
    assert_eq!(stdout(&output), "");
    let code = fs::read_to_string(dir.join("Person.rs")).unwrap();
    assert!(code.contains("pub struct Person {"), "{code}");
}

#[test]
fn a_missing_output_directory_is_node_s_error() {
    let dir = work_dir("missing-dir");
    let output = quicktype_in(
        &dir,
        &[
            "-o",
            "missing-dir/TopLevel.rs",
            &sample("simple-object.json"),
        ],
        None,
    );
    assert_eq!(output.status.code(), Some(1));
    assert_eq!(
        stderr(&output),
        "Error: ENOENT: no such file or directory, open 'missing-dir/TopLevel.rs'.\n"
    );
}

#[test]
fn reads_standard_input() {
    let json = fs::read(sample("getting-started.json")).unwrap();
    let dir = work_dir("stdin");
    for args in [
        &["--lang", "rust", "-t", "Person"][..],
        &["--lang", "rust", "-t", "Person", "-"][..],
    ] {
        let output = quicktype_in(&dir, args, Some(&json));
        assert_eq!(output.status.code(), Some(0), "{}", stderr(&output));
        assert!(stdout(&output).contains("pub struct Person {"));
    }
    let output = quicktype_in(&dir, &["--lang", "rust"], Some(b""));
    assert_eq!(output.status.code(), Some(1));
    assert_eq!(
        stderr(&output),
        "Error: Syntax error in input JSON TopLevel: Parser has expected a value.\n"
    );
}

#[test]
fn several_files_are_samples_of_one_top_level() {
    let output = quicktype(&[
        "--lang",
        "rust",
        "-t",
        "Merged",
        &sample("getting-started.json"),
        &sample("simple-object.json"),
    ]);
    assert_eq!(output.status.code(), Some(0), "{}", stderr(&output));
    let code = stdout(&output);
    assert!(code.contains("pub struct Merged {"), "{code}");
    assert!(!code.contains("pub struct GettingStarted"), "{code}");
}

#[test]
fn directories_name_top_levels_after_files_and_subdirectories() {
    let dir = work_dir("directory");
    let data = dir.join("data");
    fs::create_dir_all(data.join("Sub")).unwrap();
    fs::write(data.join("Beta.json"), r#"{"b": 1}"#).unwrap();
    fs::write(data.join("Alpha.json"), r#"{"a": "x"}"#).unwrap();
    fs::write(data.join("ignored.txt"), "not json").unwrap();
    fs::write(data.join("Sub/one.json"), r#"{"s": true}"#).unwrap();
    fs::write(data.join("Sub/two.json"), r#"{"s": false, "t": 2}"#).unwrap();
    let output = quicktype_in(&dir, &["--lang", "rust", "data"], None);
    assert_eq!(output.status.code(), Some(0), "{}", stderr(&output));
    let code = stdout(&output);
    for name in ["Alpha", "Beta", "Sub"] {
        assert!(
            code.contains(&format!("pub struct {name} {{")),
            "{name}: {code}"
        );
    }
    assert!(!code.contains("Ignored"), "{code}");
}

#[test]
fn directories_cannot_mix_json_with_schemas() {
    let dir = work_dir("mixed-directory");
    let data = dir.join("data");
    fs::create_dir_all(data.join("Mixed")).unwrap();
    fs::write(data.join("Mixed/a.json"), "{}").unwrap();
    fs::write(data.join("Mixed/b.schema"), "{}").unwrap();
    let output = quicktype_in(&dir, &["--lang", "rust", "data"], None);
    assert_eq!(output.status.code(), Some(1));
    assert_eq!(
        stderr(&output),
        "Error: Cannot mix JSON samples with JSON Schems, GraphQL, or TypeScript in input subdirectory data/Mixed.\n"
    );
}

#[test]
fn issues_go_to_stderr_unless_quiet() {
    let dir = work_dir("issues");
    fs::write(dir.join("nulls.json"), r#"{"nothing": null}"#).unwrap();
    let output = quicktype_in(&dir, &["--lang", "rust", "nulls.json"], None);
    assert_eq!(output.status.code(), Some(0));
    assert_eq!(
        stderr(&output),
        "\nIssue in line 18: The only value for this in the input is null, which means you probably need a more complete input sample.\n18:     pub nothing: Option<serde_json::Value>,\n"
    );
    let quiet = quicktype_in(&dir, &["--lang", "rust", "--quiet", "nulls.json"], None);
    assert_eq!(stderr(&quiet), "");
    assert_eq!(stdout(&quiet), stdout(&output));
}

#[test]
fn no_render_prints_done() {
    // `--no-render` runs the whole pipeline but no renderer, so it works
    // for every language.
    for lang in ["rust", "go", "kotlin"] {
        let output = quicktype(&["--lang", lang, "--no-render", &sample("kitchen-sink.json")]);
        assert_eq!(output.status.code(), Some(0), "{}", stderr(&output));
        assert_eq!(stdout(&output), "Done.\n");
    }
}

#[test]
fn builds_a_markov_chain() {
    let dir = work_dir("markov");
    fs::write(dir.join("corpus.txt"), "abcd\nbcde\n").unwrap();
    let output = quicktype_in(&dir, &["--build-markov-chain", "corpus.txt"], None);
    assert_eq!(output.status.code(), Some(0));
    let json = stdout(&output);
    assert!(
        json.starts_with(r#"{"trie":{"count":0,"arr":[null,"#),
        "{json}"
    );
    assert!(json.ends_with(",\"depth\":3}\n"), "{json}");

    let missing = quicktype_in(&dir, &["--build-markov-chain", "nope.txt"], None);
    assert_eq!(missing.status.code(), Some(1));
    assert_eq!(
        stderr(&missing),
        "Error: ENOENT: no such file or directory, open 'nope.txt'.\n"
    );
}

#[test]
fn url_grammars_name_their_top_levels() {
    let dir = work_dir("src-urls");
    let samples = inputs().join("json/samples");
    let grammar = format!(
        r#"{{"Started": ["{}/", {{"oneOf": ["getting-started"]}}, ".json"]}}"#,
        samples.display()
    );
    fs::write(dir.join("grammar.json"), grammar).unwrap();
    let output = quicktype_in(
        &dir,
        &["--lang", "rust", "--src-urls", "grammar.json"],
        None,
    );
    assert_eq!(output.status.code(), Some(0), "{}", stderr(&output));
    assert!(stdout(&output).contains("pub struct Started {"));

    fs::write(dir.join("bad.json"), r#"{"Bad": 3}"#).unwrap();
    let output = quicktype_in(&dir, &["--lang", "rust", "--src-urls", "bad.json"], None);
    assert_eq!(output.status.code(), Some(1));
    assert_eq!(
        stderr(&output),
        "Error: Internal error: Value is not a valid URL grammar: 3.\n"
    );
}

#[test]
fn errors_before_rendering() {
    let cases: &[(&[&str], &str)] = &[
        (
            &["--lang", "rust", "nonexistent.json"],
            "Error: Cannot read from file or URL nonexistent.json: Error: ENOENT: no such file or directory, lstat 'nonexistent.json'.\n",
        ),
        (
            &[
                "--lang",
                "rust",
                "--debug",
                "provenance,bad",
                "nonexistent.json",
            ],
            "Error: Cannot read from file or URL nonexistent.json: Error: ENOENT: no such file or directory, lstat 'nonexistent.json'.\n",
        ),
        (
            &["--lang", "rust", "--src-lang", "bogus", "x.json"],
            "Error: Unknown source language bogus.\n",
        ),
        (
            &["--src-lang", "graphql", "--graphql-schema", "schema.json"],
            "Error: Please specify at least one GraphQL query as input.\n",
        ),
        (
            &["--lang", "rust", "--density", "sparse", "x.json"],
            "Error: Cannot read from file or URL x.json: Error: ENOENT: no such file or directory, lstat 'x.json'.\n",
        ),
    ];
    for (args, expected) in cases {
        let output = quicktype(args);
        assert_eq!(output.status.code(), Some(1), "{args:?}");
        assert_eq!(stderr(&output), *expected, "{args:?}");
    }

    // The debug options are checked after the sources are opened, but
    // before they are read.
    let output = quicktype(&[
        "--lang",
        "rust",
        "--debug",
        "bad",
        &sample("kitchen-sink.json"),
    ]);
    assert_eq!(stderr(&output), "Error: Unknown debug option bad.\n");
    // Renderer options are checked when rendering.
    let output = quicktype(&[
        "--lang",
        "rust",
        "--density",
        "sparse",
        &sample("kitchen-sink.json"),
    ]);
    assert_eq!(
        stderr(&output),
        "Error: Unknown value sparse for option density.\n"
    );
}

#[test]
fn an_invalid_telemetry_value_generates_nothing() {
    let output = quicktype(&[
        "--lang",
        "rust",
        "--telemetry",
        "maybe",
        &sample("kitchen-sink.json"),
    ]);
    assert_eq!(output.status.code(), Some(0));
    assert_eq!(stdout(&output), "");
    assert_eq!(stderr(&output), "telemetry must be 'enable' or 'disable'\n");
}

#[test]
fn debug_output_comes_before_the_code() {
    let output = quicktype(&[
        "--lang",
        "rust",
        "--debug",
        "print-graph",
        &sample("simple-object.json"),
    ]);
    assert_eq!(output.status.code(), Some(0), "{}", stderr(&output));
    let text = stdout(&output);
    let gather = text.find("\n# gather names\n").unwrap();
    let code = text.find("pub struct SimpleObject").unwrap();
    assert!(text.starts_with("0: "), "{text}");
    assert!(gather < code);
}

#[test]
fn deep_inputs_do_not_overflow_the_stack() {
    // Inference recurses once per nesting level, as in TypeScript; the
    // generation thread's large stack takes what Node takes.
    let dir = work_dir("deep");
    let depth = 300;
    let json = format!("{}1{}", "[".repeat(depth), "]".repeat(depth));
    fs::write(dir.join("deep.json"), json).unwrap();
    let output = quicktype_in(&dir, &["--lang", "rust", "deep.json"], None);
    assert_eq!(output.status.code(), Some(0), "{}", stderr(&output));
    assert!(stdout(&output).contains("pub type Deep = Vec<Vec<"));
}

/// Runs `args` on TypeScript sources written to a fresh directory (the
/// TypeScript input only accepts files below the working directory).
/// `None` (with a note) without the TypeScript 7 compiler, or while the
/// target language's renderer is not ported yet.
fn typescript_input(name: &str, source: &str, args: &[&str]) -> Option<Output> {
    let dir = work_dir(name);
    fs::write(dir.join("input.ts"), source).unwrap();
    let mut all_args = args.to_vec();
    all_args.push("input.ts");
    let output = quicktype_in(&dir, &all_args, None);
    let error = stderr(&output);
    if error.contains("requires the TypeScript 7.0.2 compiler")
        || error.contains("renderer is not ported yet")
    {
        eprintln!("skipped: {error}");
        return None;
    }
    Some(output)
}

#[test]
fn typescript_sources_become_a_json_schema_input() {
    let source = "/** A person. */\nexport interface Person { name: string; age?: number }\n";
    let Some(output) = typescript_input("typescript-rust", source, &["--lang", "rust"]) else {
        return;
    };
    assert_eq!(output.status.code(), Some(0), "{}", stderr(&output));
    let code = stdout(&output);
    assert!(code.contains("/// A person.\n"), "{code}");
    assert!(code.contains("pub struct Person {"), "{code}");
    assert!(code.contains("pub age: Option<f64>,"), "{code}");

    // To JSON Schema, the converted schema passes through unchanged.
    let Some(output) = typescript_input("typescript-schema", source, &["--lang", "schema"]) else {
        return;
    };
    assert!(
        stdout(&output).starts_with("{\n    \"$schema\": "),
        "{}",
        stdout(&output)
    );
}

/// Port of `just-types-option.test.ts`: "Kotlin: enum cases retain their
/// TypeScript string values".
#[test]
fn kotlin_enum_cases_retain_their_typescript_string_values() {
    let source = r#"
            export enum CanvasAction {
                ADD = "add",
                BRING_TO_FRONT = "bringtofront",
                DELETE = "delete",
                FLIP = "flip",
                INVERT = "invert",
                UNDO = "undo",
                REDO = "redo",
            }

            export interface Canvas {
                action: CanvasAction;
            }
        "#;
    let Some(output) = typescript_input(
        "typescript-kotlin",
        source,
        &["--lang", "kotlin", "--just-types"],
    ) else {
        return;
    };
    let code = stdout(&output);
    assert!(
        code.contains("enum class CanvasAction(val value: String)"),
        "{code}"
    );
    assert!(code.contains(r#"Add("add")"#), "{code}");
    assert!(code.contains(r#"BringToFront("bringtofront")"#), "{code}");
    assert!(code.contains("fun fromValue(value: String): CanvasAction = when (value)"));
}

/// TypeScript reads and parses the samples of a top-level one after the
/// other and stops at the first error, so a sample that fails to parse is
/// reported without reading standard input, which stays open here.
#[test]
fn a_bad_sample_is_reported_before_stdin_is_read() {
    let dir = work_dir("bad-then-stdin");
    fs::write(dir.join("bad.json"), r#"{"a":"#).unwrap();
    let mut child = Command::new(BIN)
        .args(["--lang", "rust", "bad.json", "-"])
        .current_dir(&dir)
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    let stdin = child.stdin.take();
    let deadline = std::time::Instant::now() + std::time::Duration::from_secs(20);
    while child.try_wait().unwrap().is_none() {
        if std::time::Instant::now() > deadline {
            let _ = child.kill();
            panic!("quicktype waited for standard input");
        }
        std::thread::sleep(std::time::Duration::from_millis(20));
    }
    drop(stdin);
    let output = child.wait_with_output().unwrap();
    assert_eq!(output.status.code(), Some(1));
    assert_eq!(
        stderr(&output),
        "Error: Syntax error in input JSON TopLevel: Parser has expected a value.\n"
    );
}

/// A JSON array whose last element's string has `probe` starting `split`
/// bytes before offset 65536, where Node's file stream (and ours) starts a
/// new chunk.
fn document_with_probe_at_chunk_boundary(probe: &[u8], split: usize) -> Vec<u8> {
    const BOUNDARY: usize = 64 * 1024;
    let pad = br#"{"v":"x"},"#;
    let lead = br#"[{"v":"q"#;
    let before = BOUNDARY - split - lead.len();
    let mut doc = b"[".to_vec();
    doc.extend(pad.repeat(before / pad.len()));
    doc.extend_from_slice(br#"{"v":"q"#);
    doc.extend(b"q".repeat(before % pad.len()));
    doc.extend_from_slice(probe);
    doc.extend_from_slice(br#"z"}]"#);
    assert_eq!(doc.len() - probe.len() - 4, BOUNDARY - split);
    doc
}

/// The sample is read chunk by chunk, so a UTF-8 sequence split between
/// chunks, an invalid byte there, or a sequence cut off at the end, must
/// decode as Node decodes the whole stream (expectations from the
/// reference CLI, also via standard input).
#[test]
fn utf8_split_between_stream_chunks_decodes_like_node() {
    let dir = work_dir("utf8-chunks");
    let cases: [(&[u8], usize, &str); 4] = [
        (b"\xF0\x9F\x98\x80", 2, r#"\ud83d\ude00z""#),
        (b"\xC3\xA9", 1, "\u{e9}z\""),
        (b"\xE2\x82A", 1, "\u{FFFD}Az\""),
        (b"\xFF", 0, "\u{FFFD}z\""),
    ];
    for (i, (probe, split, expected)) in cases.into_iter().enumerate() {
        let doc = document_with_probe_at_chunk_boundary(probe, split);
        let file = format!("sample{i}.json");
        fs::write(dir.join(&file), &doc).unwrap();
        for output in [
            quicktype_in(&dir, &["--lang", "ts", "--just-types", &file], None),
            quicktype_in(&dir, &["--lang", "ts", "--just-types"], Some(&doc)),
        ] {
            assert_eq!(output.status.code(), Some(0), "{}", stderr(&output));
            let out = stdout(&output);
            let line = out
                .lines()
                .find(|l| l.starts_with("export type V"))
                .unwrap();
            assert!(
                line.ends_with(&format!("{expected};")),
                "{probe:02X?}: {line}"
            );
        }
    }
    // Cut off inside the sequence at the boundary: the string never ends.
    let doc = document_with_probe_at_chunk_boundary(b"\xF0\x9F\x98\x80", 1);
    let cut = &doc[..64 * 1024];
    fs::write(dir.join("cut.json"), cut).unwrap();
    let output = quicktype_in(&dir, &["--lang", "ts", "cut.json"], None);
    assert_eq!(output.status.code(), Some(1));
    assert_eq!(
        stderr(&output),
        "Error: Syntax error in input JSON cut: Parser has expected a string value.\n"
    );
}
