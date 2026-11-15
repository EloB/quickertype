//! The intended differences from quicktype: golden cases whose output
//! differs from the recorded reference on purpose, because quickertype fixes
//! a bug in the code quicktype generates (docs/PARITY.md, "Bugs fixed in
//! quickertype").
//!
//! [`LIST`] declares the bugs (`bug <id> <upstream report>`) and names each
//! case with the bugs that change it (`<case id> <bug id>...`). The
//! corrected output is stored next to the recorded one, in a file of the
//! same name with [`SUFFIX`] appended (`step0/TopLevel.c.intended` beside
//! `step0/TopLevel.c`, `step0.stdout.intended` beside `step0.stdout`); the
//! recording itself is never changed. A file without an `.intended` copy
//! must still match the recording.
//!
//! [`IntendedDifferences::load`] checks the list against the corpus: every
//! listed golden case exists and has an `.intended` file, every `.intended` file
//! belongs to a listed case and differs from the recording, and every bug a
//! case names is declared. The npm differential suite
//! (`npm/quicktype-core/test/differential`) and the renderer tests
//! (`crates/quicktype-core/tests/render_cases.rs`) read the same files.

use std::collections::{BTreeMap, BTreeSet};
use std::fs;
use std::path::{Path, PathBuf};

/// The list, relative to the workspace root.
pub(crate) const LIST: &str = "tests/intended-differences.txt";

/// The suffix of a corrected output file.
pub(crate) const SUFFIX: &str = ".intended";

pub(crate) struct IntendedDifferences {
    /// The bugs each listed case is changed by, by case id.
    cases: BTreeMap<String, Vec<String>>,
}

impl IntendedDifferences {
    /// Reads [`LIST`] and checks it against the `.intended` files below
    /// `golden`. With `recording` (`parity --record-intended`, which writes
    /// them), a listed case may have none yet.
    pub(crate) fn load(root: &Path, golden: &Path, recording: bool) -> Result<Self, String> {
        let path = root.join(LIST);
        let text = fs::read_to_string(&path).map_err(|e| format!("{}: {e}", path.display()))?;
        let list = parse(&text).map_err(|e| format!("{LIST}: {e}"))?;
        let mut problems = vec![];
        let mut files: BTreeMap<String, Vec<PathBuf>> = BTreeMap::new();
        walk_intended(golden, &mut |file| {
            let case = file
                .ancestors()
                .find(|dir| dir.join("case.json").is_file())
                .and_then(|dir| dir.strip_prefix(golden).ok())
                .map(|id| id.to_string_lossy().replace('\\', "/"));
            match case {
                Some(case) => files.entry(case).or_default().push(file.to_path_buf()),
                None => problems.push(format!("{}: not in a golden case", file.display())),
            }
        });
        for (case, paths) in &files {
            for intended in paths {
                let recorded = intended.with_file_name(
                    intended
                        .file_name()
                        .and_then(|n| n.to_str())
                        .and_then(|n| n.strip_suffix(SUFFIX))
                        .unwrap_or_default(),
                );
                let is_stream = recorded
                    .extension()
                    .is_some_and(|e| e == "stdout" || e == "stderr");
                // A missing stream file is an empty stream.
                let reference = match fs::read(&recorded) {
                    Ok(bytes) => Some(bytes),
                    Err(_) if is_stream => Some(vec![]),
                    Err(_) => None,
                };
                match reference {
                    None => problems.push(format!(
                        "{}: no recorded {} beside it",
                        intended.display(),
                        recorded.display()
                    )),
                    Some(reference) if fs::read(intended).ok().as_ref() == Some(&reference) => {
                        problems.push(format!(
                            "{}: identical to the recording; delete it",
                            intended.display()
                        ))
                    }
                    Some(_) => {}
                }
            }
            if !list.cases.contains_key(case) {
                problems.push(format!(
                    "{case}: has {SUFFIX} files but is not listed in {LIST}"
                ));
            }
        }
        for case in list.cases.keys().filter(|case| is_golden(case)) {
            if !golden.join(case).join("case.json").is_file() {
                problems.push(format!("{case}: listed in {LIST}, but no such golden case"));
            } else if !files.contains_key(case) && !recording {
                problems.push(format!(
                    "{case}: listed in {LIST}, but has no {SUFFIX} file"
                ));
            }
        }
        if problems.is_empty() {
            Ok(list)
        } else {
            Err(format!(
                "{LIST} does not match the {SUFFIX} files in tests/golden:\n  {}",
                problems.join("\n  ")
            ))
        }
    }

    /// The bugs that change case `id`, or `None` if it is not listed.
    pub(crate) fn bugs(&self, id: &str) -> Option<&[String]> {
        self.cases.get(id).map(Vec::as_slice)
    }

    /// The number of golden cases listed.
    pub(crate) fn len(&self) -> usize {
        self.cases.keys().filter(|case| is_golden(case)).count()
    }
}

/// The list's cases, after checking that every bug they name is declared.
fn parse(text: &str) -> Result<IntendedDifferences, String> {
    let mut declared = BTreeSet::new();
    let mut cases = BTreeMap::new();
    for (i, line) in text.lines().enumerate() {
        let line = line.trim();
        if line.is_empty() || line.starts_with('#') {
            continue;
        }
        let mut words = line.split_whitespace();
        let first = words.next().unwrap_or_default();
        if first == "bug" {
            let id = words
                .next()
                .ok_or_else(|| format!("line {}: `bug` without an id", i + 1))?;
            if words.next().is_none() {
                return Err(format!(
                    "line {}: bug {id} without its upstream report (a link, or `(link pending)`)",
                    i + 1
                ));
            }
            declared.insert(id.to_owned());
            continue;
        }
        let bugs: Vec<String> = words.map(str::to_owned).collect();
        if bugs.is_empty() {
            return Err(format!(
                "line {}: {first} without the bugs that change it",
                i + 1
            ));
        }
        if cases.insert(first.to_owned(), bugs).is_some() {
            return Err(format!("line {}: {first} is listed twice", i + 1));
        }
    }
    for (case, bugs) in &cases {
        if let Some(bug) = bugs.iter().find(|b| !declared.contains(*b)) {
            return Err(format!(
                "{case}: bug {bug} is not declared (`bug {bug} ...`)"
            ));
        }
    }
    Ok(IntendedDifferences { cases })
}

/// Whether a listed id is a golden case's: the other suites' entries start
/// with `render-scenarios/` (render_scenarios.rs) or `npm/` (the npm
/// differential suite), and those suites check them.
fn is_golden(id: &str) -> bool {
    !id.starts_with("render-scenarios/") && !id.starts_with("npm/")
}

/// Calls `f` with every file below `dir` whose name ends with [`SUFFIX`].
fn walk_intended(dir: &Path, f: &mut dyn FnMut(&Path)) {
    let Ok(entries) = fs::read_dir(dir) else {
        return;
    };
    for entry in entries.flatten() {
        let path = entry.path();
        if path.is_dir() {
            walk_intended(&path, f);
        } else if path
            .file_name()
            .and_then(|n| n.to_str())
            .is_some_and(|n| n.ends_with(SUFFIX))
        {
            f(&path);
        }
    }
}

/// The `.intended` file of `recorded`, if there is one.
pub(crate) fn intended_path(recorded: &Path) -> PathBuf {
    let mut name = recorded.as_os_str().to_owned();
    name.push(SUFFIX);
    PathBuf::from(name)
}

#[cfg(test)]
mod tests {
    use super::parse;

    #[test]
    fn the_list_declares_its_bugs() {
        let list = parse("# x\nbug a (link pending)\nbug b https://x\n\nc/1 a\nc/2 a b\n").unwrap();
        assert_eq!(list.bugs("c/2").unwrap(), ["a", "b"]);
        assert!(list.bugs("c/3").is_none());
        for (text, error) in [
            ("c/1 a\n", "bug a is not declared"),
            ("bug a\n", "without its upstream report"),
            ("bug a x\nc/1\n", "without the bugs"),
            ("bug a x\nc/1 a\nc/1 a\n", "listed twice"),
        ] {
            let e = parse(text).err().unwrap();
            assert!(e.contains(error), "{text:?}: {e}");
        }
    }
}
