//! Finding the TypeScript 7 native compiler.
//!
//! Port of the lookup in `typescript/lib/getExePath.js`, extended with an
//! environment override and a `PATH` search. Only the exact pinned release
//! ([`TSC_VERSION`]) is accepted: the `--api` protocol is unversioned, and
//! the enum values in [`super::generated`] change between releases.

use std::path::{Path, PathBuf};
use std::process::{Command, Stdio};

use super::generated::TSC_VERSION;
use crate::error::{Error, Result};

/// The environment variable that names the compiler binary explicitly.
pub const TSC_ENV: &str = "QUICKTYPE_TSC";

/// Node's `process.platform-process.arch` suffix of the npm package that
/// ships the native compiler, e.g. `darwin-arm64`.
fn platform_suffix() -> String {
    let os = match std::env::consts::OS {
        "macos" => "darwin",
        "windows" => "win32",
        other => other,
    };
    let arch = match std::env::consts::ARCH {
        "aarch64" => "arm64",
        "x86_64" => "x64",
        "x86" => "ia32",
        other => other,
    };
    format!("{os}-{arch}")
}

fn exe_name(base: &str) -> String {
    if cfg!(windows) {
        format!("{base}.exe")
    } else {
        base.to_owned()
    }
}

/// `<dir>/node_modules/@typescript/typescript-<os>-<arch>/lib/tsc`.
pub fn platform_package_exe(node_modules: &Path) -> PathBuf {
    node_modules
        .join("@typescript")
        .join(format!("typescript-{}", platform_suffix()))
        .join("lib")
        .join(exe_name("tsc"))
}

/// Whether `exe` runs and reports exactly the pinned version.
pub fn has_pinned_version(exe: &Path) -> bool {
    Command::new(exe)
        .arg("--version")
        .stdin(Stdio::null())
        .stderr(Stdio::null())
        .output()
        .is_ok_and(|out| {
            out.status.success()
                && String::from_utf8_lossy(&out.stdout).trim() == format!("Version {TSC_VERSION}")
        })
}

/// Candidates for a `tsc`/`tsgo` found on `PATH`: the binary itself, and,
/// when it is npm's JavaScript launcher (`…/typescript/bin/tsc`), the native
/// binary of that package (nested or hoisted).
fn path_candidates(found: &Path) -> Vec<PathBuf> {
    let mut out = vec![found.to_path_buf()];
    if let Ok(real) = std::fs::canonicalize(found) {
        if let Some(pkg) = real.parent().and_then(Path::parent) {
            out.push(platform_package_exe(&pkg.join("node_modules")));
            if let Some(node_modules) = pkg.parent() {
                out.push(platform_package_exe(node_modules));
            }
        }
        out.insert(0, real);
    }
    out
}

/// Finds the compiler: `$QUICKTYPE_TSC`, then the npm platform package in
/// `node_modules` of `cwd` or any ancestor, then `tsgo`/`tsc` on `PATH`.
pub fn locate(cwd: &Path) -> Result<PathBuf> {
    if let Some(explicit) = std::env::var_os(TSC_ENV) {
        let exe = PathBuf::from(explicit);
        if has_pinned_version(&exe) {
            return Ok(exe);
        }
        return Err(not_found(&format!(
            "{TSC_ENV} is set to {}, which is not the TypeScript {TSC_VERSION} compiler",
            exe.display()
        )));
    }
    for dir in cwd.ancestors() {
        let exe = platform_package_exe(&dir.join("node_modules"));
        if exe.is_file() && has_pinned_version(&exe) {
            return Ok(exe);
        }
    }
    if let Some(path) = std::env::var_os("PATH") {
        for dir in std::env::split_paths(&path) {
            for name in ["tsgo", "tsc"] {
                let found = dir.join(exe_name(name));
                if !found.is_file() {
                    continue;
                }
                for exe in path_candidates(&found) {
                    if exe.is_file() && has_pinned_version(&exe) {
                        return Ok(exe);
                    }
                }
            }
        }
    }
    Err(not_found("it was not found"))
}

fn not_found(why: &str) -> Error {
    Error::TscNotFound(format!(
        "TypeScript input requires the TypeScript {TSC_VERSION} compiler (tsc), but {why}. \
         Install it with \"npm install -g typescript@{TSC_VERSION}\" or set {TSC_ENV} to its path."
    ))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn platform_package_path() {
        let exe = platform_package_exe(Path::new("/x/node_modules"));
        let s = exe.to_string_lossy();
        assert!(s.starts_with("/x/node_modules/@typescript/typescript-"));
        assert!(s.contains("/lib/tsc"));
    }

    #[test]
    fn not_found_message() {
        let e = not_found("it was not found");
        assert_eq!(
            e.message(),
            "TypeScript input requires the TypeScript 7.0.2 compiler (tsc), but it was not found. \
             Install it with \"npm install -g typescript@7.0.2\" or set QUICKTYPE_TSC to its path."
        );
    }

    #[test]
    fn missing_binary_is_rejected() {
        assert!(!has_pinned_version(Path::new("/nonexistent/tsc")));
    }
}
