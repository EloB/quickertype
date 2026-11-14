//! JSON Lines input (not in quicktype): files and URLs named `*.jsonl` or
//! `*.ndjson`, in directories too, and every input named on the command
//! line with `--src-lang jsonl`, are read as the JSON array of their
//! values. Each run here is compared with the run
//! on that array, whose output parity with quicktype is the golden
//! corpus's business (`node xtask/fuzz/fuzz.mjs --modes jsonl` compares
//! with quicktype itself).

use std::fs;
use std::io::Write;
use std::path::{Path, PathBuf};
use std::process::{Command, Output, Stdio};

const BIN: &str = env!("CARGO_BIN_EXE_quickertype");

/// Three records, as JSON Lines (CRLF, a blank line, no final line feed)
/// and as the array of them.
const LINES: &str =
    "{\"id\": 1, \"name\": \"a\"}\r\n{\"id\": 2.5}\n\n{\"id\": 3, \"tags\": [\"x\"]}";
const ARRAY: &str = r#"[{"id": 1, "name": "a"},{"id": 2.5},{"id": 3, "tags": ["x"]}]"#;

/// A fresh, empty directory for one test.
fn work_dir(name: &str) -> PathBuf {
    let dir = Path::new(env!("CARGO_TARGET_TMPDIR"))
        .join("json-lines-tests")
        .join(name);
    let _ = fs::remove_dir_all(&dir);
    fs::create_dir_all(&dir).unwrap();
    dir
}

fn write(dir: &Path, files: &[(&str, &str)]) {
    for (name, text) in files {
        let path = dir.join(name);
        fs::create_dir_all(path.parent().unwrap()).unwrap();
        fs::write(path, text).unwrap();
    }
}

fn run(dir: &Path, args: &[&str], stdin: &[u8]) -> Output {
    let mut child = Command::new(BIN)
        .args(args)
        .current_dir(dir)
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    let mut child_stdin = child.stdin.take().unwrap();
    child_stdin.write_all(stdin).unwrap();
    drop(child_stdin);
    child.wait_with_output().unwrap()
}

/// Exit code, stdout and stderr.
fn outcome(output: &Output) -> (Option<i32>, String, String) {
    (
        output.status.code(),
        String::from_utf8_lossy(&output.stdout).into_owned(),
        String::from_utf8_lossy(&output.stderr).into_owned(),
    )
}

/// The run of `args` gives what the run of `same_as` gives (both in `dir`).
fn same(dir: &Path, args: &[&str], same_as: &[&str]) -> String {
    let ours = outcome(&run(dir, args, b""));
    let expected = outcome(&run(dir, same_as, b""));
    assert_eq!(ours, expected, "{args:?} against {same_as:?}");
    assert_eq!(ours.0, Some(0), "{}", ours.2);
    ours.1
}

#[test]
fn jsonl_and_ndjson_files_are_the_array_of_their_values() {
    let dir = work_dir("by-name");
    write(
        &dir,
        &[
            ("cards.jsonl", LINES),
            ("cards.json", ARRAY),
            ("upper/cards.JSONL", LINES),
            ("nd/cards.ndjson", LINES),
        ],
    );
    for lang in ["typescript", "rust", "go", "kotlin", "schema"] {
        // The top-level is named after the file, as for `cards.json`.
        let code = same(
            &dir,
            &["-l", lang, "cards.jsonl"],
            &["-l", lang, "cards.json"],
        );
        assert!(code.contains("Card"), "{code}");
        same(
            &dir,
            &["-l", lang, "upper/cards.JSONL"],
            &["-l", lang, "cards.json"],
        );
        same(
            &dir,
            &["-l", lang, "nd/cards.ndjson"],
            &["-l", lang, "cards.json"],
        );
    }
    // Options, `--out` and the top-level's name.
    same(
        &dir,
        &[
            "-l",
            "csharp",
            "--no-maps",
            "--density",
            "dense",
            "-t",
            "Deck",
            "cards.jsonl",
        ],
        &[
            "-l",
            "csharp",
            "--no-maps",
            "--density",
            "dense",
            "-t",
            "Deck",
            "cards.json",
        ],
    );
    fs::create_dir_all(dir.join("out")).unwrap();
    let mut written = Vec::new();
    for file in ["cards.jsonl", "cards.json"] {
        let output = run(&dir, &["-o", "out/Lines.ts", file], b"");
        assert_eq!(outcome(&output), (Some(0), String::new(), String::new()));
        written.push(fs::read_to_string(dir.join("out/Lines.ts")).unwrap());
    }
    assert_eq!(written[0], written[1]);
}

#[test]
fn edge_cases_are_arrays_too() {
    let dir = work_dir("edges");
    write(
        &dir,
        &[
            ("empty.jsonl", ""),
            ("blank.jsonl", "\n \r\n\t\n"),
            ("empty.json", "[]"),
            ("one.jsonl", "{\"a\": 1}\n"),
            ("one.json", "[{\"a\": 1}]"),
            (
                "pretty.jsonl",
                "{\n  \"a\": [\n    1\n  ]\n}\n{\"a\": []}\n",
            ),
            ("pretty.json", "[{\"a\": [1]}, {\"a\": []}]"),
            ("bom.jsonl", "\u{feff}{\"a\": 1}\r\n"),
            ("bom.json", "\u{feff}{\"a\": 1}"),
        ],
    );
    // No values: `[]`, as quicktype gives for `[]`.
    same(
        &dir,
        &["-l", "ts", "empty.jsonl"],
        &["-l", "ts", "empty.json"],
    );
    same(
        &dir,
        &["-l", "ts", "-t", "Empty", "blank.jsonl"],
        &["-l", "ts", "empty.json"],
    );
    // One line is an array of one, not the value.
    let code = same(&dir, &["-l", "ts", "one.jsonl"], &["-l", "ts", "one.json"]);
    assert!(code.contains("export type One = OneElement[];"), "{code}");
    // A value may span lines.
    same(
        &dir,
        &["-l", "ts", "pretty.jsonl"],
        &["-l", "ts", "pretty.json"],
    );
    // A byte order mark may come first (Windows tools write one); in a
    // JSON file, it stays the error it is in quicktype.
    same(
        &dir,
        &["-l", "ts", "-t", "One", "bom.jsonl"],
        &["-l", "ts", "one.json"],
    );
    let (code, _, err) = outcome(&run(&dir, &["-l", "ts", "bom.json"], b""));
    assert_eq!(code, Some(1));
    assert_eq!(
        err,
        "Error: Syntax error in input JSON bom: Parser cannot parse input: expected a value.\n"
    );
}

#[test]
fn several_files_are_samples_of_one_top_level() {
    let dir = work_dir("several");
    write(
        &dir,
        &[
            ("a.json", r#"{"id": "x", "extra": true}"#),
            ("b.jsonl", LINES),
            ("b.json", ARRAY),
            ("c.ndjson", "[1]\n[2]\n"),
            ("c.json", "[[1], [2]]"),
        ],
    );
    same(
        &dir,
        &["-l", "rust", "a.json", "b.jsonl", "c.ndjson"],
        &["-l", "rust", "a.json", "b.json", "c.json"],
    );
    same(
        &dir,
        &["-l", "rust", "b.jsonl", "b.jsonl"],
        &["-l", "rust", "b.json", "b.json"],
    );
}

#[test]
fn src_lang_decides() {
    let dir = work_dir("src-lang");
    write(
        &dir,
        &[
            ("cards.jsonl", LINES),
            ("cards.json", ARRAY),
            ("cards.txt", LINES),
            ("object.jsonl", r#"{"a": 1}"#),
            ("object.json", r#"{"a": 1}"#),
        ],
    );
    // `--src-lang json` reads a `.jsonl` file as JSON, as quicktype does.
    same(
        &dir,
        &["-l", "ts", "--src-lang", "json", "object.jsonl"],
        &["-l", "ts", "-t", "Object", "object.json"],
    );
    let (code, _, err) = outcome(&run(&dir, &["-l", "ts", "-s", "json", "cards.jsonl"], b""));
    assert_eq!(code, Some(1));
    assert_eq!(
        err,
        "Error: Syntax error in input JSON cards: Parser cannot parse input: unexpected characters.\n"
    );
    // `--src-lang jsonl` reads any file, and standard input, as JSON Lines.
    same(
        &dir,
        &["-l", "ts", "--src-lang", "jsonl", "cards.txt"],
        &["-l", "ts", "cards.json"],
    );
    same(
        &dir,
        &[
            "-l",
            "ts",
            "--src-lang",
            "jsonl",
            "-t",
            "Cards",
            "object.json",
        ],
        &[
            "-l",
            "ts",
            "-t",
            "Cards",
            "--src-lang",
            "jsonl",
            "object.jsonl",
        ],
    );
    let ours = outcome(&run(
        &dir,
        &["-l", "go", "-t", "Cards", "-s", "jsonl"],
        LINES.as_bytes(),
    ));
    let expected = outcome(&run(&dir, &["-l", "go", "-t", "Cards"], ARRAY.as_bytes()));
    assert_eq!(ours, expected);
    let ours = outcome(&run(
        &dir,
        &["-l", "go", "-s", "jsonl", "-"],
        LINES.as_bytes(),
    ));
    let expected = outcome(&run(&dir, &["-l", "go", "-"], ARRAY.as_bytes()));
    assert_eq!(ours, expected);
    // Without `--src-lang`, standard input is JSON.
    let (code, _, _) = outcome(&run(&dir, &["-l", "go"], LINES.as_bytes()));
    assert_eq!(code, Some(1));
}

/// In a directory, each file's name says what it holds, whatever
/// `--src-lang` says: `.jsonl` and `.ndjson` files are JSON Lines, `.json`
/// files JSON, so a directory that mixes them gives the same types every
/// way. `arrays` holds the same samples as `.json` files of the arrays.
#[test]
fn directories_frame_each_file_by_its_name() {
    let dir = work_dir("directories");
    write(
        &dir,
        &[
            ("data/Alpha.json", r#"{"a": "x"}"#),
            ("data/Bar.json", r#"{"y": 1}"#),
            ("data/List.json", "[1, 2]"),
            ("data/Cards.jsonl", LINES),
            ("data/More.NDJSON", LINES),
            ("data/Sub/one.jsonl", LINES),
            ("data/Sub/two.json", r#"{"id": 9}"#),
            ("arrays/Alpha.json", r#"{"a": "x"}"#),
            ("arrays/Bar.json", r#"{"y": 1}"#),
            ("arrays/List.json", "[1, 2]"),
            ("arrays/Cards.json", ARRAY),
            ("arrays/More.json", ARRAY),
            ("arrays/Sub/one.json", ARRAY),
            ("arrays/Sub/two.json", r#"{"id": 9}"#),
        ],
    );
    for src_lang in [&[][..], &["--src-lang", "json"], &["--src-lang", "jsonl"]] {
        let mut ours = vec!["-l", "rust"];
        ours.extend_from_slice(src_lang);
        ours.push("data");
        let code = same(&dir, &ours, &["-l", "rust", "arrays"]);
        // `Bar` stays an object and `List` an array of integers.
        assert!(code.contains("pub struct Bar {"), "{src_lang:?}: {code}");
        assert!(
            code.contains("pub type List = Vec<i64>;"),
            "{src_lang:?}: {code}"
        );
        assert!(
            code.contains("pub type Cards = Vec<Card>;"),
            "{src_lang:?}: {code}"
        );
    }
}

#[test]
fn errors_name_the_line_of_the_bad_value() {
    let dir = work_dir("errors");
    write(
        &dir,
        &[
            ("two.jsonl", "{\"a\": 1}\n{\"a\": 2} {\"a\": 3}\n"),
            ("open.jsonl", "{\"a\": 1}\n\n{\"a\": [1, 2\n{\"a\": 4}\n"),
            ("cut.jsonl", "{\"a\": 1}\n{\"a\": \"x"),
            ("bom.jsonl", "{\"a\": 1}\n\u{feff}{\"a\": 2}\n"),
            ("crlf.jsonl", "1\r\n2\r\n3 4\r\n"),
        ],
    );
    for (file, message) in [
        (
            "two.jsonl",
            "two: line 2: Parser cannot parse input: unexpected characters",
        ),
        (
            "open.jsonl",
            "open: line 3: Parser cannot parse input: expected ','",
        ),
        (
            "cut.jsonl",
            "cut: line 2: Parser has expected a string value",
        ),
        // A byte order mark is an error but at the start.
        (
            "bom.jsonl",
            "bom: line 2: Parser cannot parse input: expected a value",
        ),
        (
            "crlf.jsonl",
            "crlf: line 3: Parser cannot parse input: unexpected characters",
        ),
    ] {
        let (code, out, err) = outcome(&run(&dir, &["-l", "ts", file], b""));
        assert_eq!(code, Some(1), "{file}");
        assert_eq!(out, "");
        assert_eq!(
            err,
            format!("Error: Syntax error in input JSON {message}.\n")
        );
    }
}

#[test]
fn help_lists_jsonl_among_the_source_languages() {
    let (code, out, _) = outcome(&run(&work_dir("help"), &["--help"], b""));
    assert_eq!(code, Some(0));
    assert!(
        out.contains("SRC_LANG ... json|jsonl|schema|graphql|postman|typescript"),
        "{out}"
    );
}
