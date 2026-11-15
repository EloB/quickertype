//! Bugs in the code quicktype generates, which quickertype fixes
//! (docs/PARITY.md, "Bugs fixed in quickertype"; the golden cases they
//! change are intended differences, tests/intended-differences.txt). Each
//! test generates code for an input that hits a bug and compiles and runs
//! it where the toolchain is installed. Without the toolchain, a test
//! prints `SKIPPED` and passes.
//!
//! - C (cJSON): `cc` with AddressSanitizer and UndefinedBehaviorSanitizer,
//!   and the libraries quicktype's fixture uses (cJSON 1.7.15, c-list and
//!   c-hashtable): `$QUICKTYPE_CJSON_DEPS`, a directory with their six
//!   files, or downloaded with `curl` into the target directory.
//! - Ruby: `ruby` with the `dry-struct` gem, run with `bundle exec` when
//!   `BUNDLE_GEMFILE` is set.
//! - Java: `javac` and `java` with Jackson: `$QUICKTYPE_JACKSON_CLASSPATH`,
//!   or jackson-core, -databind and -annotations from the local Maven
//!   repository.
//! - Python: `python3`, and `mypy` if it is installed.
//! - TypeScript input: the TypeScript 7.0.2 compiler (as in cli.rs); the
//!   JSON Schema it becomes is tested without it.

use std::fs;
use std::path::{Path, PathBuf};
use std::process::{Command, Output};

use serde_json::{Value, json};

const BIN: &str = env!("CARGO_BIN_EXE_quickertype");

/// A fresh, empty directory for one test.
fn work_dir(name: &str) -> PathBuf {
    let dir = Path::new(env!("CARGO_TARGET_TMPDIR"))
        .join("fixed-quicktype-bugs")
        .join(name);
    let _ = fs::remove_dir_all(&dir);
    fs::create_dir_all(&dir).unwrap();
    dir
}

/// Runs quickertype with `args` in `dir`; it must succeed.
fn generate(dir: &Path, args: &[&str]) {
    let output = Command::new(BIN)
        .args(args)
        .current_dir(dir)
        .output()
        .unwrap();
    assert!(
        output.status.success(),
        "quickertype {args:?}: {}",
        String::from_utf8_lossy(&output.stderr)
    );
}

/// Whether `program args` runs and exits 0.
fn runs(program: &str, args: &[&str]) -> bool {
    Command::new(program)
        .args(args)
        .output()
        .is_ok_and(|o| o.status.success())
}

fn skipped(test: &str, why: &str) {
    eprintln!("SKIPPED {test}: {why}");
}

fn text(output: &Output) -> String {
    format!(
        "status {:?}\nstdout: {}\nstderr: {}",
        output.status.code(),
        String::from_utf8_lossy(&output.stdout),
        String::from_utf8_lossy(&output.stderr)
    )
}

// ---- C (cJSON) ----------------------------------------------------------

/// The libraries, as quicktype's cjson fixture downloads them (its
/// `cJSONSetupCommand`), at the commits it got.
const CJSON_DEPS: [(&str, &str); 6] = [
    (
        "cJSON.c",
        "https://raw.githubusercontent.com/DaveGamble/cJSON/v1.7.15/cJSON.c",
    ),
    (
        "cJSON.h",
        "https://raw.githubusercontent.com/DaveGamble/cJSON/v1.7.15/cJSON.h",
    ),
    (
        "list.c",
        "https://raw.githubusercontent.com/joelguittet/c-list/b84ac6cdb4c0629d9c85f485b04d1de5d4085700/src/list.c",
    ),
    (
        "list.h",
        "https://raw.githubusercontent.com/joelguittet/c-list/b84ac6cdb4c0629d9c85f485b04d1de5d4085700/include/list.h",
    ),
    (
        "hashtable.c",
        "https://raw.githubusercontent.com/joelguittet/c-hashtable/05d5d7414ddf5e7f7bc23aceb76cb6f9b435cd57/src/hashtable.c",
    ),
    (
        "hashtable.h",
        "https://raw.githubusercontent.com/joelguittet/c-hashtable/05d5d7414ddf5e7f7bc23aceb76cb6f9b435cd57/include/hashtable.h",
    ),
];

/// The directory with cJSON, c-list and c-hashtable, or why there is none.
fn cjson_deps() -> Result<PathBuf, String> {
    if let Some(dir) = std::env::var_os("QUICKTYPE_CJSON_DEPS") {
        return Ok(PathBuf::from(dir));
    }
    // The tests run in parallel: one downloads, the others wait.
    static DOWNLOAD: std::sync::Mutex<()> = std::sync::Mutex::new(());
    let _download = DOWNLOAD.lock().unwrap_or_else(|e| e.into_inner());
    let dir = Path::new(env!("CARGO_TARGET_TMPDIR")).join("cjson-deps");
    fs::create_dir_all(&dir).unwrap();
    for (name, url) in CJSON_DEPS {
        let path = dir.join(name);
        if path.is_file() {
            continue;
        }
        let partial = dir.join(format!("{name}.partial"));
        let ok = Command::new("curl")
            .args(["-fsSL", "--retry", "2", "-o"])
            .arg(&partial)
            .arg(url)
            .status()
            .is_ok_and(|s| s.success());
        if !ok || fs::rename(&partial, &path).is_err() {
            return Err(format!(
                "cannot download {url} (set QUICKTYPE_CJSON_DEPS to a directory with cJSON, c-list and c-hashtable)"
            ));
        }
    }
    Ok(dir)
}

/// A driver like quicktype's test/fixtures/cjson/main.c: parses the file
/// it is given, prints it and deletes it; exits 1 if it does not parse.
const CJSON_MAIN: &str = r#"#include <stdio.h>
#include <stdlib.h>
#include "TopLevel.h"

int main(int argc, const char * argv[]) {
    if (argc != 2) return 2;
    FILE * file = fopen(argv[1], "rb");
    if (NULL == file) return 2;
    fseek(file, 0, SEEK_END);
    long size = ftell(file);
    fseek(file, 0, SEEK_SET);
    char * buffer = malloc(size + 1);
    if (NULL == buffer || (size_t)size != fread(buffer, 1, size, file)) return 2;
    buffer[size] = '\0';
    fclose(file);
    struct TopLevel * tl = cJSON_ParseTopLevel(buffer);
    free(buffer);
    if (NULL == tl) return 1;
    char * result = cJSON_PrintTopLevel(tl);
    if (NULL == result) return 2;
    printf("%s\n", result);
    free(result);
    cJSON_DeleteTopLevel(tl);
    return 0;
}
"#;

/// Generates C for `input` (`src_lang`: json or schema), header only,
/// and builds it with the sanitizers; `None` (after a note) without a C
/// compiler that has them, or without the libraries.
fn build_cjson(test: &str, src_lang: &str, input: &str) -> Option<PathBuf> {
    if !runs("cc", &["--version"]) {
        skipped(test, "no C compiler (cc)");
        return None;
    }
    let deps = match cjson_deps() {
        Ok(deps) => deps,
        Err(why) => {
            skipped(test, &why);
            return None;
        }
    };
    let dir = work_dir(test);
    let input_file = format!("input.{src_lang}");
    fs::write(dir.join(&input_file), input).unwrap();
    generate(
        &dir,
        &[
            "--src-lang",
            src_lang,
            "--lang",
            "cjson",
            "--top-level",
            "TopLevel",
            "--src",
            &input_file,
            "--out",
            "TopLevel.h",
        ],
    );
    fs::write(dir.join("main.c"), CJSON_MAIN).unwrap();
    let sources: Vec<PathBuf> = ["cJSON.c", "list.c", "hashtable.c"]
        .iter()
        .map(|f| deps.join(f))
        .collect();
    let output = Command::new("cc")
        .args([
            "-g",
            "-O0",
            "-w",
            "-fsanitize=address,undefined",
            "-fno-sanitize-recover=undefined",
            "-fno-omit-frame-pointer",
            "-o",
            "prog",
            "-I",
        ])
        .arg(&deps)
        .args(&sources)
        .arg("main.c")
        .arg("-lpthread")
        .current_dir(&dir)
        .output()
        .unwrap();
    if !output.status.success() {
        let error = String::from_utf8_lossy(&output.stderr);
        if error.contains("sanitize") {
            skipped(test, &format!("cc has no sanitizers: {error}"));
            return None;
        }
        panic!("{test}: the generated C does not compile:\n{error}");
    }
    Some(dir)
}

/// Runs the C driver in `dir` on `sample`: the JSON it prints, or `None`
/// if the sample was rejected (exit 1). Any memory error or undefined
/// behavior (a sanitizer report, a signal) fails the test.
fn run_cjson(dir: &Path, sample: &str) -> Option<Value> {
    fs::write(dir.join("sample.json"), sample).unwrap();
    let output = Command::new(dir.join("prog"))
        .arg("sample.json")
        .current_dir(dir)
        .output()
        .unwrap();
    match output.status.code() {
        Some(0) => Some(serde_json::from_slice(&output.stdout).unwrap()),
        Some(1) if output.stderr.is_empty() => None,
        _ => panic!("{sample}: {}", text(&output)),
    }
}

/// Builds C for `input` and checks each sample: `Some(json)` must print
/// `json`, `None` must be rejected.
fn check_cjson(test: &str, src_lang: &str, input: &str, samples: &[(&str, Option<Value>)]) {
    let Some(dir) = build_cjson(test, src_lang, input) else {
        return;
    };
    for (sample, expected) in samples {
        assert_eq!(&run_cjson(&dir, sample), expected, "{test}: {sample}");
    }
}

/// A top-level map of integers, booleans, doubles or enums: quicktype
/// stores each value itself as the pointer (`cJSON_GetNumberValue(e)` as
/// a `void *`), which does not even compile for numbers.
#[test]
fn cjson_top_level_maps_of_scalars_allocate_their_values() {
    for (name, items, sample) in [
        (
            "integers",
            r#"{"type": "integer"}"#,
            json!({"a": 1, "b": -2}),
        ),
        (
            "booleans",
            r#"{"type": "boolean"}"#,
            json!({"a": true, "b": false}),
        ),
        ("doubles", r#"{"type": "number"}"#, json!({"a": 1.5})),
        (
            "enums",
            r#"{"enum": ["x", "y"]}"#,
            json!({"a": "y", "b": "x"}),
        ),
    ] {
        let schema = format!(r#"{{"type": "object", "additionalProperties": {items}}}"#);
        check_cjson(
            &format!("cjson-top-level-map-of-{name}"),
            "schema",
            &schema,
            &[(&sample.to_string(), Some(sample.clone()))],
        );
    }
}

/// A top-level list or map of `null`: quicktype marks each value with
/// `0xDEADBEAF` in the list (`0xDEADBEEF` everywhere else) and frees the
/// marker when deleting either.
#[test]
fn cjson_top_level_lists_and_maps_of_null_keep_their_markers() {
    check_cjson(
        "cjson-top-level-list-of-null",
        "json",
        "[null, null]",
        &[("[null, null, null]", Some(json!([null, null, null])))],
    );
    check_cjson(
        "cjson-top-level-map-of-null",
        "schema",
        r#"{"type": "object", "additionalProperties": {"type": "null"}}"#,
        &[(
            r#"{"a": null, "b": null}"#,
            Some(json!({"a": null, "b": null})),
        )],
    );
}

/// An enum's getter calls `strcmp` on `cJSON_GetStringValue(j)`, `NULL`
/// for a value that is not a string; an array of enums reaches it
/// unchecked.
#[test]
fn cjson_enum_getters_compare_only_strings() {
    let schema = r#"{"type": "object", "required": ["tags"],
        "properties": {"tags": {"type": "array", "items": {"enum": ["a", "b"]}}}}"#;
    let Some(dir) = build_cjson("cjson-enum-getter", "schema", schema) else {
        return;
    };
    let good = json!({"tags": ["b", "a"]});
    assert_eq!(run_cjson(&dir, &good.to_string()), Some(good));
    // Not a string: no case (0), which the array leaves out when printed.
    assert_eq!(
        run_cjson(&dir, r#"{"tags": [1, "a"]}"#),
        Some(json!({"tags": ["a"]}))
    );
}

/// `regcomp`'s result is ignored, so `regexec` and `regfree` run on a
/// pattern that did not compile (a JSON Schema pattern is not always a
/// POSIX extended one). Such a pattern is not checked; one that compiles
/// still is.
#[test]
fn cjson_patterns_are_matched_only_when_they_compile() {
    let schema = r#"{"type": "object", "required": ["s", "t"], "properties": {
        "s": {"type": "string", "pattern": "^(?=a)a+$"},
        "t": {"type": "string", "pattern": "^b+$"}}}"#;
    check_cjson(
        "cjson-pattern",
        "schema",
        schema,
        &[
            (
                r#"{"s": "aaa", "t": "bb"}"#,
                Some(json!({"s": "aaa", "t": "bb"})),
            ),
            (r#"{"s": "aaa", "t": "c"}"#, None),
        ],
    );
}

/// A map of classes parses every value twice: once to validate it, which
/// is then deleted, and once more for the value stored.
#[test]
fn cjson_maps_of_classes_parse_each_value_once() {
    let schema = r##"{"type": "object", "required": ["m"],
        "properties": {"m": {"type": "object", "additionalProperties": {"$ref": "#/definitions/V"}}},
        "definitions": {"V": {"type": "object", "required": ["n"], "properties": {"n": {"type": "integer"}}}}}"##;
    let Some(dir) = build_cjson("cjson-map-of-classes", "schema", schema) else {
        return;
    };
    let code = fs::read_to_string(dir.join("TopLevel.h")).unwrap();
    assert_eq!(code.matches("cJSON_GetVValue(e1)").count(), 1, "{code}");
    assert!(!code.contains("cJSON_DeleteV(validated)"), "{code}");
    let sample = json!({"m": {"a": {"n": 1}, "b": {"n": 2}}});
    assert_eq!(run_cjson(&dir, &sample.to_string()), Some(sample));
    assert_eq!(run_cjson(&dir, r#"{"m": {"a": {"n": "x"}}}"#), None);
}

// ---- Ruby ---------------------------------------------------------------

/// tests/inputs, quicktype's test inputs.
fn inputs() -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("../../tests/inputs")
}

/// `ruby` with `args`, through `bundle exec` when `BUNDLE_GEMFILE` is set.
fn ruby(args: &[&str], dir: &Path) -> Command {
    let mut command = if std::env::var_os("BUNDLE_GEMFILE").is_some() {
        let mut c = Command::new("bundle");
        c.args(["exec", "ruby"]);
        c
    } else {
        Command::new("ruby")
    };
    command.args(args).current_dir(dir);
    command
}

/// recursive-union-flattening.schema: class `X` names the union class
/// `XElement` before it is defined, and quicktype forward-declares only
/// classes, so loading the file fails with `NameError`.
#[test]
fn ruby_union_classes_are_forward_declared() {
    const TEST: &str = "ruby-union-forward-declaration";
    let dir = work_dir(TEST);
    let has_gems = ruby(&["-e", "require 'dry-types'; require 'dry-struct'"], &dir)
        .output()
        .is_ok_and(|o| o.status.success());
    if !has_gems {
        skipped(TEST, "no ruby with the dry-types and dry-struct gems");
        return;
    }
    let schema = inputs().join("schema/recursive-union-flattening.schema");
    generate(
        &dir,
        &[
            "--src-lang",
            "schema",
            "--lang",
            "ruby",
            "--top-level",
            "TopLevel",
            "--src",
            schema.to_str().unwrap(),
            "--out",
            "top_level.rb",
        ],
    );
    let sample = inputs().join("schema/recursive-union-flattening.1.json");
    let output = ruby(
        &[
            "-e",
            "require './top_level.rb'; puts TopLevel.from_json!(File.read(ARGV[0])).to_json",
            sample.to_str().unwrap(),
        ],
        &dir,
    )
    .output()
    .unwrap();
    assert!(output.status.success(), "{}", text(&output));
    let expected: Value = serde_json::from_str(&fs::read_to_string(&sample).unwrap()).unwrap();
    assert_eq!(
        serde_json::from_slice::<Value>(&output.stdout).unwrap(),
        expected
    );
}

// ---- Java ---------------------------------------------------------------

/// The class path with Jackson, or `None`.
fn jackson_classpath() -> Option<String> {
    if let Ok(classpath) = std::env::var("QUICKTYPE_JACKSON_CLASSPATH") {
        return Some(classpath);
    }
    let home = std::env::var_os("HOME").or_else(|| std::env::var_os("USERPROFILE"))?;
    let repository = Path::new(&home).join(".m2/repository/com/fasterxml/jackson/core");
    let mut jars = vec![];
    for artifact in ["jackson-core", "jackson-databind", "jackson-annotations"] {
        let dir = repository.join(artifact);
        let mut versions: Vec<PathBuf> = fs::read_dir(&dir)
            .ok()?
            .flatten()
            .map(|e| e.path())
            .collect();
        versions.sort();
        let jar = versions.iter().rev().find_map(|v| {
            let version = v.file_name()?.to_str()?;
            let jar = v.join(format!("{artifact}-{version}.jar"));
            jar.is_file().then_some(jar)
        })?;
        jars.push(jar.to_string_lossy().into_owned());
    }
    Some(jars.join(if cfg!(windows) { ";" } else { ":" }))
}

/// optional-date-time.schema with `--datetime-provider legacy`:
/// `parseAllDateTimeString` returns `null` when no format matches, so an
/// invalid date-time is read as `null` instead of rejected.
#[test]
fn java_legacy_dates_that_do_not_parse_are_rejected() {
    const TEST: &str = "java-legacy-date";
    if !runs("javac", &["-version"]) || !runs("java", &["-version"]) {
        skipped(TEST, "no javac and java");
        return;
    }
    let Some(classpath) = jackson_classpath() else {
        skipped(
            TEST,
            "no Jackson (set QUICKTYPE_JACKSON_CLASSPATH, or have it in ~/.m2)",
        );
        return;
    };
    let dir = work_dir(TEST);
    let sources = dir.join("src/io/quicktype");
    fs::create_dir_all(&sources).unwrap();
    let schema = inputs().join("schema/optional-date-time.schema");
    generate(
        &sources,
        &[
            "--src-lang",
            "schema",
            "--lang",
            "java",
            "--datetime-provider",
            "legacy",
            "--package",
            "io.quicktype",
            "--top-level",
            "TopLevel",
            "--src",
            schema.to_str().unwrap(),
            "--out",
            "TopLevel.java",
        ],
    );
    fs::write(
        sources.join("App.java"),
        "package io.quicktype;\n\
         public class App {\n\
         \x20   public static void main(String[] args) throws Exception {\n\
         \x20       String input = new String(java.nio.file.Files.readAllBytes(java.nio.file.Paths.get(args[0])), \"UTF-8\");\n\
         \x20       System.out.print(Converter.toJsonString(Converter.fromJsonString(input)));\n\
         \x20   }\n\
         }\n",
    )
    .unwrap();
    let java_files: Vec<PathBuf> = fs::read_dir(&sources)
        .unwrap()
        .flatten()
        .map(|e| e.path())
        .collect();
    let output = Command::new("javac")
        .args(["-nowarn", "-d", "classes", "-cp", &classpath])
        .args(&java_files)
        .current_dir(&dir)
        .output()
        .unwrap();
    assert!(output.status.success(), "javac: {}", text(&output));
    let separator = if cfg!(windows) { ";" } else { ":" };
    let run = |sample: &str| {
        Command::new("java")
            .args([
                "-cp",
                &format!("classes{separator}{classpath}"),
                "io.quicktype.App",
            ])
            .arg(inputs().join("schema").join(sample))
            .current_dir(&dir)
            .output()
            .unwrap()
    };
    let good = run("optional-date-time.1.json");
    assert!(good.status.success(), "{}", text(&good));
    let printed: Value = serde_json::from_slice(&good.stdout).unwrap();
    assert!(printed["required-date-time"].is_string(), "{printed}");
    let bad = run("optional-date-time.1.fail.date-time.json");
    assert!(!bad.status.success(), "accepted: {}", text(&bad));
    assert!(
        String::from_utf8_lossy(&bad.stderr)
            .contains("Unparseable date: not a valid date-time at all"),
        "{}",
        text(&bad)
    );
}

// ---- Python -------------------------------------------------------------

/// misc/a0496.json: `from_dict` assigns every property to a local variable
/// of its name, so the property `from_date` shadows the converter
/// `from_date` (`UnboundLocalError`; mypy: `"date" not callable`). The
/// same goes for `obj`, `isinstance` and the other converters.
#[test]
fn python_properties_do_not_shadow_what_from_dict_uses() {
    const TEST: &str = "python-shadowed-converter";
    if !runs("python3", &["--version"]) {
        skipped(TEST, "no python3");
        return;
    }
    let dir = work_dir(TEST);
    let sample = inputs().join("json/misc/a0496.json");
    fs::write(
        dir.join("names.json"),
        r#"{"obj": "a", "isinstance": "b", "from_str": "c", "from_date": "2020-01-02", "x": "d"}"#,
    )
    .unwrap();
    for (module, input) in [("a0496", sample.to_str().unwrap()), ("names", "names.json")] {
        generate(
            &dir,
            &[
                "--lang",
                "python",
                "--top-level",
                "TopLevel",
                "--src",
                input,
                "--out",
                &format!("{module}.py"),
            ],
        );
    }
    let script = "import json, sys\n\
                  import a0496, names\n\
                  a = json.load(open(sys.argv[1]))\n\
                  b = a0496.top_level_to_dict(a0496.top_level_from_dict(a))\n\
                  assert (b['from_date'], b['to_date']) == (a['from_date'], a['to_date']), b\n\
                  n = {'obj': 'a', 'isinstance': 'b', 'from_str': 'c', 'from_date': '2020-01-02', 'x': 'd'}\n\
                  assert names.top_level_to_dict(names.top_level_from_dict(n)) == n\n\
                  print('ok')\n";
    let output = Command::new("python3")
        .args(["-c", script])
        .arg(&sample)
        .current_dir(&dir)
        .output()
        .unwrap();
    let error = String::from_utf8_lossy(&output.stderr);
    if error.contains("No module named 'dateutil'") {
        skipped(TEST, "python3 has no python-dateutil");
    } else {
        assert!(output.status.success(), "{}", text(&output));
    }
    let mypy = if runs("mypy", &["--version"]) {
        Some(Command::new("mypy"))
    } else if runs("python3", &["-m", "mypy", "--version"]) {
        let mut c = Command::new("python3");
        c.args(["-m", "mypy"]);
        Some(c)
    } else {
        None
    };
    match mypy {
        None => skipped(&format!("{TEST} (mypy)"), "no mypy"),
        Some(mut mypy) => {
            let output = mypy
                .args(["--ignore-missing-imports", "a0496.py", "names.py"])
                .current_dir(&dir)
                .output()
                .unwrap();
            assert!(output.status.success(), "mypy: {}", text(&output));
        }
    }
}
