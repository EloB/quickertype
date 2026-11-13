//! `cargo xtask diff`: run the TypeScript quicktype CLI and ours side by side
//! on the same arguments and compare exit code, stdout, stderr and every
//! written file.
//!
//! Unlike `parity` (which replays recorded reference runs), this executes the
//! reference live, so it works for any input or flag combination, e.g. your
//! own JSON files or generated inputs.

use std::fs;
use std::path::{Component, Path, PathBuf};
use std::process::{Command, Stdio};
use std::sync::atomic::{AtomicUsize, Ordering};
use std::sync::{Mutex, Once};

use crate::parity::{build_cli, first_difference, snapshot};

pub const USAGE: &str = "\
cargo xtask diff [options] -- <quicktype args...>

Runs the reference (TypeScript) quicktype and ours with the same arguments,
each in its own temp dir, and compares exit code, stdout, stderr and files.

  --ref \"<cmd ...>\"   reference command (default: node <checkout>/dist/index.js, where
                      <checkout> is $QUICKTYPE_REFERENCE, else the first built
                      ../quicktype or ../../quicktype beside the workspace)
  --bin \"<cmd ...>\"   our command (default: builds target/release/quicktype)
  --each <path>       run once per input file under <path> (file or directory,
                      recursive), appending the file to the quicktype args
  --ext <ext>         file extensions for --each (repeatable; default: json)
  --stdin <file>      feed <file> to stdin of both runs
  -j <n>              parallel jobs for --each (default: number of cores)
  --show <n>          print details for the first n mismatches (default 10)

Input paths in the quicktype args are resolved against the current directory;
the value of -o/--out stays relative, so outputs land in the temp dirs.

examples:
  cargo xtask diff -- my.json --lang go
  cargo xtask diff --each tests/inputs/json/samples -- --lang rust --just-types
";

struct Options {
    reference: Option<Vec<String>>,
    ours: Option<Vec<String>>,
    each: Option<PathBuf>,
    exts: Vec<String>,
    stdin: Option<PathBuf>,
    jobs: usize,
    show: usize,
    args: Vec<String>,
}

fn parse_options(args: Vec<String>) -> Result<Options, String> {
    let mut o = Options {
        reference: None,
        ours: None,
        each: None,
        exts: vec![],
        stdin: None,
        jobs: std::thread::available_parallelism().map_or(4, |n| n.get()),
        show: 10,
        args: vec![],
    };
    let mut args = args.into_iter();
    while let Some(a) = args.next() {
        let mut value = || args.next().ok_or_else(|| format!("missing value for {a}"));
        match a.as_str() {
            "--" => {
                o.args = args.collect();
                break;
            }
            "--ref" => o.reference = Some(split_command(&value()?)),
            "--bin" => o.ours = Some(split_command(&value()?)),
            "--each" => o.each = Some(PathBuf::from(value()?)),
            "--ext" => o.exts.push(value()?.trim_start_matches('.').to_owned()),
            "--stdin" => o.stdin = Some(PathBuf::from(value()?)),
            "-j" | "--jobs" => o.jobs = value()?.parse().map_err(|_| "bad -j")?,
            "--show" => o.show = value()?.parse().map_err(|_| "bad --show")?,
            _ => {
                return Err(format!(
                    "unknown argument {a} (quicktype args go after --)\n\n{USAGE}"
                ));
            }
        }
    }
    if o.exts.is_empty() {
        o.exts.push("json".into());
    }
    Ok(o)
}

fn split_command(s: &str) -> Vec<String> {
    s.split_whitespace().map(String::from).collect()
}

/// Options whose value is never a path (so it is never absolutized, even if
/// a file of that name happens to exist in the current directory).
const NON_PATH_VALUE_OPTIONS: &[&str] = &[
    "-l",
    "--lang",
    "-s",
    "--src-lang",
    "-t",
    "--top-level",
    "--debug",
    "--telemetry",
    "--http-method",
    "--http-header",
    "--graphql-introspect",
];

/// Prepares quicktype args so both runs can execute in their own temp dirs:
/// input paths (`x.json`, `--src x.json`, `--src=x.json`) become absolute.
/// The `-o`/`--out` value must be relative, so outputs land in the temp dirs;
/// an absolute one is rejected because both runs would write the same real file.
fn prepare_args(args: &[String], cwd: &Path) -> Result<Vec<String>, String> {
    let absolutize = |value: &str| -> String {
        let candidate = cwd.join(value);
        if !Path::new(value).is_absolute() && candidate.exists() {
            candidate.to_string_lossy().into_owned()
        } else {
            value.to_owned()
        }
    };
    // An output path escapes the run dir when it has a root (`/x`, `\x`), a
    // drive or UNC prefix (`C:\x`, `C:x`) or a `..` component.
    let check_out = |value: &str| -> Result<(), String> {
        let escapes = Path::new(value).components().any(|c| {
            matches!(
                c,
                Component::Prefix(_) | Component::RootDir | Component::ParentDir
            )
        });
        if escapes {
            return Err(format!(
                "--out {value}: use a relative path inside the run dir; both CLIs would \
                 otherwise write the same real file"
            ));
        }
        Ok(())
    };

    let mut out = Vec::with_capacity(args.len());
    let mut iter = args.iter().peekable();
    while let Some(a) = iter.next() {
        if let Some((flag, value)) = a.split_once('=').filter(|(f, _)| f.starts_with("--")) {
            if flag == "--out" {
                check_out(value)?;
                out.push(a.clone());
            } else if NON_PATH_VALUE_OPTIONS.contains(&flag) {
                out.push(a.clone());
            } else {
                out.push(format!("{flag}={}", absolutize(value)));
            }
        } else if a == "-o" || a == "--out" {
            out.push(a.clone());
            if let Some(value) = iter.next() {
                check_out(value)?;
                out.push(value.clone());
            }
        } else if NON_PATH_VALUE_OPTIONS.contains(&a.as_str()) {
            out.push(a.clone());
            if let Some(value) = iter.next() {
                out.push(value.clone());
            }
        } else if a.starts_with('-') {
            out.push(a.clone());
        } else {
            out.push(absolutize(a));
        }
    }
    Ok(out)
}

struct RunResult {
    code: Option<i32>,
    stdout: Vec<u8>,
    stderr: Vec<u8>,
    files: std::collections::BTreeMap<String, Vec<u8>>,
}

fn run_one(
    cmd: &[String],
    args: &[String],
    stdin: Option<&Path>,
    dir: &Path,
) -> Result<RunResult, String> {
    let _ = fs::remove_dir_all(dir);
    fs::create_dir_all(dir).map_err(|e| e.to_string())?;
    let stdin = match stdin {
        Some(p) => Stdio::from(fs::File::open(p).map_err(|e| format!("{}: {e}", p.display()))?),
        None => Stdio::null(),
    };
    let out = Command::new(&cmd[0])
        .args(&cmd[1..])
        .args(args)
        .current_dir(dir)
        .env("TZ", "UTC")
        .stdin(stdin)
        .output()
        .map_err(|e| format!("cannot spawn {}: {e}", cmd[0]))?;
    // Each run has its own temp dir; normalize it so messages compare equal.
    // Children see the resolved path (getcwd), so replace that form too.
    let given = dir.to_string_lossy().into_owned();
    let resolved = dir
        .canonicalize()
        .map_or_else(|_| given.clone(), |p| p.to_string_lossy().into_owned());
    let normalize = |b: Vec<u8>| -> Vec<u8> {
        String::from_utf8(b)
            .map(|s| {
                s.replace(&resolved, "{CWD}")
                    .replace(&given, "{CWD}")
                    .into_bytes()
            })
            .unwrap_or_else(|e| e.into_bytes())
    };
    Ok(RunResult {
        code: out.status.code(),
        stdout: normalize(out.stdout),
        stderr: normalize(out.stderr),
        files: snapshot(dir),
    })
}

/// Returns `None` when both runs behaved identically, else a description.
fn compare(reference: &RunResult, ours: &RunResult) -> Option<String> {
    let mut problems = vec![];
    if reference.code != ours.code {
        problems.push(format!(
            "exit code: reference {:?}, ours {:?}",
            reference.code, ours.code
        ));
    }
    if reference.stdout != ours.stdout {
        problems.push(format!(
            "stdout differs at {}",
            first_difference(&reference.stdout, &ours.stdout)
        ));
    }
    if reference.stderr != ours.stderr {
        problems.push(format!(
            "stderr differs at {}",
            first_difference(&reference.stderr, &ours.stderr)
        ));
    }
    for (path, bytes) in &reference.files {
        match ours.files.get(path) {
            None => problems.push(format!("file {path}: missing in ours")),
            Some(b) if b != bytes => {
                problems.push(format!(
                    "file {path} differs at {}",
                    first_difference(bytes, b)
                ));
            }
            Some(_) => {}
        }
    }
    for path in ours
        .files
        .keys()
        .filter(|p| !reference.files.contains_key(*p))
    {
        problems.push(format!("file {path}: only in ours"));
    }
    (!problems.is_empty()).then(|| problems.join("\n    "))
}

/// The reference checkout named by the environment: `$QUICKTYPE_REFERENCE`,
/// else `$QUICKTYPE_REF` or `$QUICKTYPE_DIR`, its deprecated names (with a
/// one-line warning on stderr, once), as `xtask/reference.mjs` and
/// `xtask/golden/record.sh` read them. `QUICKTYPE_REFERENCE=self` (the npm
/// differential suite's comparison with its own TypeScript engine) is an
/// error.
fn reference_from_env() -> Result<Option<PathBuf>, String> {
    let set = |name: &str| std::env::var_os(name).filter(|v| !v.is_empty());
    if let Some(dir) = set("QUICKTYPE_REFERENCE") {
        if dir == "self" {
            return Err(
                "QUICKTYPE_REFERENCE=self only applies to the npm differential suite; \
                 set it to a quicktype checkout"
                    .into(),
            );
        }
        return Ok(Some(dir.into()));
    }
    for name in ["QUICKTYPE_REF", "QUICKTYPE_DIR"] {
        if let Some(dir) = set(name) {
            static WARNING: Once = Once::new();
            WARNING.call_once(|| {
                eprintln!("warning: {name} is deprecated; set QUICKTYPE_REFERENCE instead");
            });
            return Ok(Some(dir.into()));
        }
    }
    Ok(None)
}

/// Locates the built TypeScript CLI: `dist/index.js` of
/// [`reference_from_env`]'s checkout, else of the first of `../quicktype`
/// and `../../quicktype` beside the workspace that has one (the second
/// finds it from a git worktree). `None` if there is none.
pub(crate) fn find_reference(root: &Path) -> Result<Option<PathBuf>, String> {
    if let Some(dir) = reference_from_env()? {
        let script = dir.join("dist/index.js");
        return Ok(script.is_file().then_some(script));
    }
    Ok(root
        .ancestors()
        .skip(1)
        .take(2)
        .map(|a| a.join("quicktype/dist/index.js"))
        .find(|p| p.is_file()))
}

/// Collects the inputs for `--each`: a single file is always used as is; a
/// directory is walked recursively (sorted) for files with one of `exts`.
fn collect_inputs(path: &Path, exts: &[String], out: &mut Vec<PathBuf>) {
    if path.is_file() {
        out.push(path.to_path_buf());
    } else {
        collect_dir(path, exts, out);
    }
}

fn collect_dir(path: &Path, exts: &[String], out: &mut Vec<PathBuf>) {
    if path.is_dir() {
        let mut entries: Vec<PathBuf> = fs::read_dir(path)
            .map(|rd| rd.flatten().map(|e| e.path()).collect())
            .unwrap_or_default();
        entries.sort();
        for entry in entries {
            collect_dir(&entry, exts, out);
        }
    } else if path.extension().is_some_and(|e| {
        exts.iter()
            .any(|x| e.to_string_lossy().eq_ignore_ascii_case(x))
    }) {
        out.push(path.to_path_buf());
    }
}

pub fn run(root: &Path, args: Vec<String>) -> Result<bool, String> {
    let o = parse_options(args)?;
    let cwd = std::env::current_dir().map_err(|e| e.to_string())?;

    let reference = match &o.reference {
        Some(cmd) if !cmd.is_empty() => cmd.clone(),
        _ => {
            let script = find_reference(root)?.ok_or(
                "reference quicktype not found: set QUICKTYPE_REFERENCE to a built checkout \
                 or pass --ref \"<cmd>\"",
            )?;
            vec!["node".into(), script.to_string_lossy().into_owned()]
        }
    };
    let ours = match &o.ours {
        Some(cmd) if !cmd.is_empty() => cmd.clone(),
        _ => build_cli(root)?,
    };

    let base_args = prepare_args(&o.args, &cwd)?;
    let runs: Vec<(String, Vec<String>)> = match &o.each {
        None => vec![(base_args.join(" "), base_args.clone())],
        Some(path) => {
            let mut inputs = vec![];
            collect_inputs(&cwd.join(path), &o.exts, &mut inputs);
            if inputs.is_empty() {
                return Err(format!(
                    "no .{} files under {}",
                    o.exts.join("/."),
                    path.display()
                ));
            }
            inputs
                .into_iter()
                .map(|input| {
                    let label = input
                        .strip_prefix(&cwd)
                        .unwrap_or(&input)
                        .display()
                        .to_string();
                    let mut args = base_args.clone();
                    args.push(input.to_string_lossy().into_owned());
                    (label, args)
                })
                .collect()
        }
    };

    // Per-invocation dir so concurrent `cargo xtask diff` runs don't collide.
    let work = root
        .join("target/diff")
        .join(std::process::id().to_string());
    let stdin = o.stdin.as_ref().map(|p| cwd.join(p));
    let next = AtomicUsize::new(0);
    let mismatches = Mutex::new(Vec::new());
    let errors = Mutex::new(Vec::new());
    let both_failed = Mutex::new(Vec::new());
    std::thread::scope(|s| {
        for _ in 0..o.jobs.max(1).min(runs.len()) {
            s.spawn(|| {
                loop {
                    let i = next.fetch_add(1, Ordering::Relaxed);
                    let Some((label, args)) = runs.get(i) else {
                        break;
                    };
                    let result = run_one(
                        &reference,
                        args,
                        stdin.as_deref(),
                        &work.join(format!("r{i}")),
                    )
                    .and_then(|r| {
                        run_one(&ours, args, stdin.as_deref(), &work.join(format!("o{i}")))
                            .map(|o| (r, o))
                    });
                    match result {
                        Ok((r, ours_result)) => {
                            if let Some(problem) = compare(&r, &ours_result) {
                                mismatches
                                    .lock()
                                    .expect("lock")
                                    .push((label.clone(), problem));
                            } else if r.code != Some(0) {
                                both_failed.lock().expect("lock").push(label.clone());
                            }
                        }
                        Err(e) => errors.lock().expect("lock").push((label.clone(), e)),
                    }
                    let _ = fs::remove_dir_all(work.join(format!("r{i}")));
                    let _ = fs::remove_dir_all(work.join(format!("o{i}")));
                }
            });
        }
    });

    let mut mismatches = mismatches.into_inner().expect("lock");
    let errors = errors.into_inner().expect("lock");
    mismatches.sort();
    for (label, problem) in mismatches.iter().take(o.show) {
        println!("MISMATCH {label}\n    {problem}\n");
    }
    if mismatches.len() > o.show {
        println!("... and {} more mismatches\n", mismatches.len() - o.show);
    }
    for (label, e) in &errors {
        println!("ERROR {label}: {e}");
    }
    let _ = fs::remove_dir_all(&work);
    // Identical failures are parity too (error paths matter), but they also
    // happen when the arguments themselves are wrong, so call them out.
    let both_failed = both_failed.into_inner().expect("lock");
    if !both_failed.is_empty() {
        println!(
            "note: {} identical run(s) failed in both CLIs (nonzero exit), e.g. {}",
            both_failed.len(),
            both_failed[0]
        );
    }
    let total = runs.len();
    let matched = total - mismatches.len() - errors.len();
    println!("diff: {matched}/{total} runs identical to the reference");
    Ok(matched == total)
}

#[cfg(test)]
mod tests {
    use super::*;

    fn strings(xs: &[&str]) -> Vec<String> {
        xs.iter().map(|x| (*x).to_owned()).collect()
    }

    fn fixture_dir() -> PathBuf {
        let dir = std::env::temp_dir().join(format!("xtask-diff-test-{}", std::process::id()));
        fs::create_dir_all(dir.join("json")).unwrap();
        fs::write(dir.join("in.json"), "{}").unwrap();
        fs::write(dir.join("out.ts"), "").unwrap();
        dir
    }

    #[test]
    fn inputs_become_absolute_in_every_form() {
        let dir = fixture_dir();
        let abs = dir.join("in.json").to_string_lossy().into_owned();
        let got = prepare_args(
            &strings(&["in.json", "--src", "in.json", "--src=in.json"]),
            &dir,
        )
        .unwrap();
        assert_eq!(
            got,
            [
                abs.clone(),
                "--src".into(),
                abs.clone(),
                format!("--src={abs}")
            ]
        );
    }

    #[test]
    fn output_and_non_path_values_are_untouched() {
        let dir = fixture_dir();
        let args = strings(&[
            "-o",
            "out.ts",
            "--src-lang",
            "json",
            "--lang=json",
            "--top-level",
            "json",
        ]);
        assert_eq!(prepare_args(&args, &dir).unwrap(), args);
    }

    #[test]
    fn absolute_or_escaping_output_is_rejected() {
        let dir = fixture_dir();
        let absolute = std::env::temp_dir().join("x.ts");
        let absolute = absolute.to_str().unwrap();
        let mut escaping = vec!["/tmp/x.ts", "../x.ts", "a/../../x.ts", absolute];
        if cfg!(windows) {
            escaping.extend([
                "C:\\x.ts",
                "\\x.ts",
                "C:x.ts",
                "..\\x.ts",
                "\\\\server\\share\\x.ts",
            ]);
        }
        for value in escaping {
            for out in [["-o", value], ["--out", value]] {
                assert!(prepare_args(&strings(&out), &dir).is_err(), "{out:?}");
            }
            let out = format!("--out={value}");
            assert!(prepare_args(&strings(&[&out]), &dir).is_err(), "{out}");
        }
        assert!(prepare_args(&strings(&["-o", "sub/x.ts"]), &dir).is_ok());
    }

    #[test]
    fn identical_runs_compare_equal() {
        let run = || RunResult {
            code: Some(0),
            stdout: b"x\n".to_vec(),
            stderr: vec![],
            files: Default::default(),
        };
        assert!(compare(&run(), &run()).is_none());
        let mut other = run();
        other.code = Some(1);
        assert!(compare(&run(), &other).unwrap().contains("exit code"));
    }
}
