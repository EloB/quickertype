//! tests/golden: quicktype's output for every test case, generated from
//! quicktype at the commit in `tests/golden/REFERENCE` by `npm run golden`
//! (xtask/golden/generate.mjs) and not in git. `GENERATED`, written with
//! the cases, says what was generated; [`generated_cases`] checks it, as
//! xtask/golden/state.mjs does for the JavaScript tools.

use std::collections::BTreeMap;
use std::fs;
use std::path::Path;

/// The generated cases, relative to the workspace root.
pub(crate) const DIR: &str = "tests/golden";

/// How to (re)generate the corpus, for error messages.
const HOW_TO_GENERATE: &str = "run `npm run golden` (docs/ARCHITECTURE.md, \"The golden corpus\")";

/// A file's `key=value` lines.
fn key_values(path: &Path) -> Result<BTreeMap<String, String>, String> {
    let text = fs::read_to_string(path).map_err(|e| format!("{}: {e}", path.display()))?;
    Ok(text
        .lines()
        .filter_map(|line| line.split_once('='))
        .map(|(key, value)| (key.trim().to_owned(), value.trim().to_owned()))
        .collect())
}

/// The number of cases `GENERATED` says were generated, after checking that
/// they were generated from the quicktype commit `REFERENCE` pins.
pub(crate) fn generated_cases(root: &Path) -> Result<usize, String> {
    let dir = root.join(DIR);
    let generated = dir.join("GENERATED");
    if !generated.is_file() {
        return Err(format!("{DIR} is not generated: {HOW_TO_GENERATE}"));
    }
    let generated = key_values(&generated)?;
    let reference = key_values(&dir.join("REFERENCE"))?;
    let pinned = reference
        .get("quicktype_commit")
        .ok_or_else(|| format!("{DIR}/REFERENCE: no quicktype_commit"))?;
    let commit = generated.get("quicktype_commit").map_or("", String::as_str);
    if commit != pinned {
        return Err(format!(
            "{DIR} was generated from quicktype {commit}, but {DIR}/REFERENCE pins {pinned}: {HOW_TO_GENERATE}"
        ));
    }
    generated
        .get("cases")
        .and_then(|n| n.parse().ok())
        .ok_or_else(|| format!("{DIR}/GENERATED: no cases=<number>"))
}

/// Checks that `found` cases are the ones generated: no fewer (an
/// interrupted restore) and no more (leftovers of another commit).
pub(crate) fn check_case_count(root: &Path, found: usize) -> Result<(), String> {
    let generated = generated_cases(root)?;
    if found == generated {
        Ok(())
    } else {
        Err(format!(
            "{DIR} has {found} cases, but {generated} were generated: {HOW_TO_GENERATE}"
        ))
    }
}
