//! Finding the TypeScript 7 native compiler.
//!
//! [`locate`] looks, in this order, at:
//!
//! 1. `$QUICKTYPE_TSC` ([`TSC_ENV`]), and at nothing else when it is set;
//! 2. the compiler a release bundles with quickertype
//!    ([`bundled_candidates`]): the npm platform package, unmodified, in a
//!    `typescript` directory next to the executable (the release archives,
//!    the MSI, the npm package) or in `../share/quickertype` (Homebrew),
//!    found from the executable's real path;
//! 3. the npm platform package in `node_modules` of the working directory
//!    or any ancestor (a port of the lookup in `typescript/lib/getExePath.js`),
//!    then `tsgo`/`tsc` on `PATH`.
//!
//! Without one, [`Error::TscNotFound`] names the npm package to install for
//! this platform. Only the exact pinned release ([`TSC_VERSION`]) is
//! accepted: the `--api` protocol is unversioned, and the enum values in
//! [`super::generated`] change between releases.

use std::ffi::OsString;
use std::path::{Path, PathBuf};
use std::process::{Command, Stdio};

use super::generated::TSC_VERSION;
use crate::error::{Error, Result};

/// The environment variable that names the compiler binary explicitly.
pub const TSC_ENV: &str = "QUICKTYPE_TSC";

/// The directory that a release puts the compiler in, next to quickertype:
/// the npm platform package (`@typescript/typescript-<os>-<arch>`, pinned
/// in `release/typescript/pins.json`), unmodified.
pub const BUNDLED_DIR: &str = "typescript";

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

/// The compiler in a platform package's directory: `<package>/lib/tsc`.
fn package_exe(package: &Path) -> PathBuf {
    package.join("lib").join(exe_name("tsc"))
}

/// `<dir>/node_modules/@typescript/typescript-<os>-<arch>/lib/tsc`.
pub fn platform_package_exe(node_modules: &Path) -> PathBuf {
    package_exe(
        &node_modules
            .join("@typescript")
            .join(format!("typescript-{}", platform_suffix())),
    )
}

/// Where a release install keeps the bundled compiler of the executable
/// `exe` (quickertype): `typescript/lib/tsc` in the directory of `exe`'s
/// real path (the release archives, the MSI's `bin`, the npm package's
/// unpacked archive), then `../share/quickertype/typescript/lib/tsc` from
/// it (Homebrew's `pkgshare`, which its `bin` links point into). The real
/// path resolves symbolic links, and on Windows is in the form users write
/// (no `\\?\` prefix).
pub fn bundled_candidates(exe: &Path) -> Vec<PathBuf> {
    let real = simplified(std::fs::canonicalize(exe).unwrap_or_else(|_| exe.to_path_buf()));
    let Some(dir) = real.parent() else {
        return Vec::new();
    };
    let mut packages = vec![dir.join(BUNDLED_DIR)];
    if let Some(prefix) = dir.parent() {
        packages.push(prefix.join("share").join("quickertype").join(BUNDLED_DIR));
    }
    packages.iter().map(|p| package_exe(p)).collect()
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

/// Whether `path` is a script (`#!…`) rather than a native executable.
fn is_script(path: &Path) -> bool {
    use std::io::Read;
    let mut head = [0u8; 2];
    std::fs::File::open(path)
        .and_then(|mut f| f.read_exact(&mut head))
        .is_ok()
        && head == *b"#!"
}

/// `path` without the `\\?\` prefix that `fs::canonicalize` adds on Windows
/// (`\\?\C:\x` → `C:\x`, `\\?\UNC\server\share\x` → `\\server\share\x`), when
/// the plain form names the same file
/// ([`quicktype_js_compat::verbatim_path::to_plain`], the rule Rust's
/// `fs::read_link` uses). It is only used to find and run the compiler, so
/// unlike `fs.readlink` in quicktype-core's `node_io` it need not match
/// Node. Elsewhere, `path` itself.
fn simplified(path: PathBuf) -> PathBuf {
    match path
        .to_str()
        .and_then(quicktype_js_compat::verbatim_path::to_plain)
    {
        Some(plain) => PathBuf::from(plain),
        None => path,
    }
}

/// Where an npm bin shim (`tsc.cmd`, what npm installs on Windows) in `dir`
/// has its package's compiler: npm puts the shims of global packages next to
/// the prefix's `node_modules`, and those of a project in
/// `node_modules/.bin`.
fn shim_candidates(dir: &Path) -> Vec<PathBuf> {
    let node_modules = if dir.file_name().is_some_and(|n| n == ".bin") {
        dir.parent().unwrap_or(dir).to_path_buf()
    } else {
        dir.join("node_modules")
    };
    vec![
        platform_package_exe(&node_modules.join("typescript").join("node_modules")),
        platform_package_exe(&node_modules),
    ]
}

/// Native-binary candidates for a `tsc`/`tsgo` found on `PATH` or named by
/// `$QUICKTYPE_TSC`. When it is npm's JavaScript launcher
/// (`…/typescript/bin/tsc`), that would need Node and spawn the compiler as
/// a grandchild, so the launcher's package is searched for the native
/// binary (nested, then hoisted) and the launcher itself is not a candidate.
/// An npm shim (`tsc.cmd`) is looked up the same way through its package.
fn native_candidates(found: &Path) -> Vec<PathBuf> {
    if found
        .extension()
        .is_some_and(|e| e.eq_ignore_ascii_case("cmd"))
    {
        return shim_candidates(found.parent().unwrap_or(Path::new(".")));
    }
    let mut out = Vec::new();
    let real = simplified(std::fs::canonicalize(found).unwrap_or_else(|_| found.to_path_buf()));
    if let Some(pkg) = real.parent().and_then(Path::parent) {
        out.push(platform_package_exe(&pkg.join("node_modules")));
        if let Some(node_modules) = pkg.parent() {
            out.push(platform_package_exe(node_modules));
        }
    }
    if !is_script(&real) {
        out.push(real);
    }
    out
}

/// What [`locate`] reads from the process, passed in so that the tests can
/// give each lookup step its own inputs.
struct Environment<'a> {
    /// `$QUICKTYPE_TSC`.
    explicit: Option<OsString>,
    /// The running executable ([`std::env::current_exe`]).
    exe: Option<PathBuf>,
    /// `$PATH`.
    path: Option<OsString>,
    /// Whether an existing file is the pinned compiler
    /// ([`has_pinned_version`]).
    is_pinned: &'a dyn Fn(&Path) -> bool,
}

/// Finds the compiler: `$QUICKTYPE_TSC`, then the compiler bundled next to
/// the running executable, then the npm platform package in `node_modules`
/// of `cwd` or any ancestor, then `tsgo`/`tsc` on `PATH` (the module
/// documentation has the details).
pub fn locate(cwd: &Path) -> Result<PathBuf> {
    find(
        cwd,
        &Environment {
            explicit: std::env::var_os(TSC_ENV),
            exe: std::env::current_exe().ok(),
            path: std::env::var_os("PATH"),
            is_pinned: &has_pinned_version,
        },
    )
}

fn find(cwd: &Path, env: &Environment<'_>) -> Result<PathBuf> {
    let pinned = |exe: &Path| exe.is_file() && (env.is_pinned)(exe);
    if let Some(explicit) = &env.explicit {
        let exe = PathBuf::from(explicit);
        if let Some(native) = native_candidates(&exe).into_iter().find(|c| pinned(c)) {
            return Ok(native);
        }
        return Err(not_found(&format!(
            "{TSC_ENV} is set to {}, which is not the TypeScript {TSC_VERSION} compiler",
            exe.display()
        )));
    }
    if let Some(bundled) = env
        .exe
        .iter()
        .flat_map(|exe| bundled_candidates(exe))
        .find(|c| pinned(c))
    {
        return Ok(bundled);
    }
    for dir in cwd.ancestors() {
        let exe = platform_package_exe(&dir.join("node_modules"));
        if pinned(&exe) {
            return Ok(exe);
        }
    }
    if let Some(path) = &env.path {
        for dir in std::env::split_paths(path) {
            for name in ["tsgo", "tsc"] {
                // On Windows, `npm install -g` makes `tsc.cmd`, not `tsc.exe`.
                let shim = cfg!(windows).then(|| dir.join(format!("{name}.cmd")));
                for found in std::iter::once(dir.join(exe_name(name))).chain(shim) {
                    if !found.is_file() {
                        continue;
                    }
                    if let Some(exe) = native_candidates(&found).into_iter().find(|c| pinned(c)) {
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
         Install it with \"npm install -g typescript@{TSC_VERSION}\" (for this platform, that \
         installs @typescript/typescript-{}@{TSC_VERSION}), or set {TSC_ENV} to its path",
        platform_suffix()
    ))
}

/// The compiler for this crate's tests: `$QUICKTYPE_TSC` (and nothing
/// else when it is set), the usual lookup from `crate_dir`, or the
/// `node_modules` of a sibling `quicktype` checkout (the layout `cargo
/// xtask golden` uses). `None` makes a test skip itself.
#[doc(hidden)]
pub fn for_tests(crate_dir: &Path) -> Option<PathBuf> {
    if std::env::var_os(TSC_ENV).is_some() {
        return locate(crate_dir).ok();
    }
    if let Ok(exe) = locate(crate_dir) {
        return Some(exe);
    }
    crate_dir.ancestors().find_map(|dir| {
        let exe = platform_package_exe(&dir.join("quicktype").join("node_modules"));
        (exe.is_file() && has_pinned_version(&exe)).then_some(exe)
    })
}

#[cfg(test)]
mod tests {
    use super::*;

    /// What the fake compilers of these tests contain; [`fake_check`]
    /// accepts exactly that, as [`has_pinned_version`] accepts the pinned
    /// release (the lookup runs on every platform without running one).
    const FAKE_TSC: &str = "fake tsc 7.0.2";

    fn fake_check(exe: &Path) -> bool {
        std::fs::read_to_string(exe).is_ok_and(|text| text == FAKE_TSC)
    }

    /// A fresh directory under the system's temporary directory, removed
    /// when dropped.
    struct Scratch(PathBuf);

    impl Scratch {
        fn new(name: &str) -> Self {
            let dir = std::env::temp_dir().join(format!("qt-tsc-{name}-{}", std::process::id()));
            let _ = std::fs::remove_dir_all(&dir);
            std::fs::create_dir_all(&dir).unwrap();
            Scratch(dir)
        }

        /// Writes `contents` to `relative` (creating its directories) and
        /// returns its path.
        fn file(&self, relative: &Path, contents: &str) -> PathBuf {
            let path = self.0.join(relative);
            std::fs::create_dir_all(path.parent().unwrap()).unwrap();
            std::fs::write(&path, contents).unwrap();
            path
        }

        /// `relative`'s real path, as the lookup reports it.
        fn real(&self, relative: &Path) -> PathBuf {
            simplified(std::fs::canonicalize(self.0.join(relative)).unwrap())
        }
    }

    impl Drop for Scratch {
        fn drop(&mut self) {
            let _ = std::fs::remove_dir_all(&self.0);
        }
    }

    /// `<root>/install/quickertype` with the compiler next to it, a project
    /// at `<root>/project` with the platform package in its `node_modules`,
    /// and `tsc` in `<root>/path`: a candidate for every step.
    fn every_step(scratch: &Scratch) -> Environment<'static> {
        let exe = scratch.file(&Path::new("install").join(exe_name("quickertype")), "");
        scratch.file(
            &package_exe(&Path::new("install").join(BUNDLED_DIR)),
            FAKE_TSC,
        );
        scratch.file(
            &platform_package_exe(&Path::new("project").join("node_modules")),
            FAKE_TSC,
        );
        scratch.file(&Path::new("path").join(exe_name("tsc")), FAKE_TSC);
        Environment {
            explicit: None,
            exe: Some(exe),
            path: Some(scratch.0.join("path").into_os_string()),
            is_pinned: &fake_check,
        }
    }

    #[test]
    fn platform_package_path() {
        let exe = platform_package_exe(Path::new("/x/node_modules"));
        let package = Path::new("/x/node_modules")
            .join("@typescript")
            .join(format!("typescript-{}", platform_suffix()));
        assert_eq!(exe, package.join("lib").join(exe_name("tsc")));
    }

    #[test]
    fn explicit_compiler_comes_first() {
        let scratch = Scratch::new("explicit");
        let explicit = scratch.file(&Path::new("elsewhere").join(exe_name("tsc")), FAKE_TSC);
        let env = Environment {
            explicit: Some(explicit.clone().into_os_string()),
            ..every_step(&scratch)
        };
        let found = find(&scratch.0.join("project"), &env).unwrap();
        assert_eq!(
            found,
            scratch.real(&Path::new("elsewhere").join(exe_name("tsc")))
        );
    }

    #[test]
    fn explicit_compiler_of_another_version_is_an_error() {
        let scratch = Scratch::new("explicit-other");
        let explicit = scratch.file(&Path::new("elsewhere").join(exe_name("tsc")), "tsc 7.0.1");
        let env = Environment {
            explicit: Some(explicit.clone().into_os_string()),
            ..every_step(&scratch)
        };
        let error = find(&scratch.0.join("project"), &env).unwrap_err();
        assert!(
            error.message().starts_with(&format!(
                "TypeScript input requires the TypeScript 7.0.2 compiler (tsc), but \
                 QUICKTYPE_TSC is set to {}, which is not the TypeScript 7.0.2 compiler. ",
                explicit.display()
            )),
            "{}",
            error.message()
        );
    }

    #[test]
    fn bundled_compiler_comes_before_node_modules_and_path() {
        let scratch = Scratch::new("bundled");
        let env = every_step(&scratch);
        let found = find(&scratch.0.join("project"), &env).unwrap();
        assert_eq!(
            found,
            scratch.real(&package_exe(&Path::new("install").join(BUNDLED_DIR)))
        );
        // In the form users write: no `\\?\` prefix on Windows.
        assert!(!found.to_string_lossy().starts_with("\\\\?\\"));
    }

    #[test]
    fn bundled_compiler_in_share_quickertype() {
        // Homebrew's layout: the formula installs the archive's binary into
        // `<prefix>/bin` and the rest into `<prefix>/share/quickertype`.
        let scratch = Scratch::new("bundled-share");
        let prefix = Path::new("Cellar").join("quickertype").join("1.0");
        let exe = scratch.file(&prefix.join("bin").join(exe_name("quickertype")), "");
        let bundled = package_exe(&prefix.join("share").join("quickertype").join(BUNDLED_DIR));
        scratch.file(&bundled, FAKE_TSC);
        let env = Environment {
            exe: Some(exe),
            ..every_step(&scratch)
        };
        // `every_step` put a compiler next to its own executable, not this one.
        assert_eq!(
            find(&scratch.0.join("project"), &env).unwrap(),
            scratch.real(&bundled)
        );
    }

    #[cfg(unix)]
    #[test]
    fn bundled_compiler_through_a_symbolic_link() {
        // `brew install` links `<HOMEBREW_PREFIX>/bin/quickertype` to
        // `../Cellar/quickertype/<version>/bin/quickertype`; a user's own
        // link to an unpacked archive works the same way.
        let scratch = Scratch::new("bundled-link");
        let prefix = Path::new("Cellar").join("quickertype").join("1.0");
        let real_exe = scratch.file(&prefix.join("bin").join("quickertype"), "");
        let bundled = package_exe(&prefix.join("share").join("quickertype").join(BUNDLED_DIR));
        scratch.file(&bundled, FAKE_TSC);
        let link = scratch.0.join("bin").join("quickertype");
        std::fs::create_dir_all(link.parent().unwrap()).unwrap();
        std::os::unix::fs::symlink(&real_exe, &link).unwrap();
        let env = Environment {
            exe: Some(link),
            path: None,
            ..every_step(&scratch)
        };
        assert_eq!(
            find(&scratch.0.join("project"), &env).unwrap(),
            scratch.real(&bundled)
        );
    }

    #[test]
    fn bundled_compiler_of_another_version_is_skipped() {
        let scratch = Scratch::new("bundled-other");
        let env = every_step(&scratch);
        scratch.file(
            &package_exe(&Path::new("install").join(BUNDLED_DIR)),
            "tsc 7.0.1",
        );
        let cwd = scratch.0.join("project").join("src");
        assert_eq!(
            find(&cwd, &env).unwrap(),
            platform_package_exe(&scratch.0.join("project").join("node_modules"))
        );
    }

    #[test]
    fn node_modules_of_the_working_directory_or_an_ancestor() {
        let scratch = Scratch::new("node-modules");
        let env = Environment {
            exe: None,
            ..every_step(&scratch)
        };
        let cwd = scratch.0.join("project").join("src").join("models");
        assert_eq!(
            find(&cwd, &env).unwrap(),
            platform_package_exe(&scratch.0.join("project").join("node_modules"))
        );
    }

    #[test]
    fn compiler_on_path() {
        let scratch = Scratch::new("path");
        let env = Environment {
            exe: None,
            ..every_step(&scratch)
        };
        let outside = scratch.0.join("outside");
        std::fs::create_dir_all(&outside).unwrap();
        assert_eq!(
            find(&outside, &env).unwrap(),
            scratch.real(&Path::new("path").join(exe_name("tsc")))
        );
    }

    #[test]
    fn nothing_found_names_the_package_to_install() {
        let scratch = Scratch::new("nothing");
        let exe = scratch.file(&Path::new("bin").join(exe_name("quickertype")), "");
        let env = Environment {
            explicit: None,
            exe: Some(exe),
            path: Some(scratch.0.join("bin").into_os_string()),
            is_pinned: &fake_check,
        };
        let error = find(&scratch.0, &env).unwrap_err();
        assert!(matches!(error, Error::TscNotFound(_)));
        assert_eq!(error.message(), not_found("it was not found").message());
    }

    #[test]
    fn npm_shims_resolve_through_their_package() {
        let global = Path::new("/prefix");
        assert_eq!(
            native_candidates(&global.join("tsc.cmd")),
            [
                platform_package_exe(
                    &global
                        .join("node_modules")
                        .join("typescript")
                        .join("node_modules")
                ),
                platform_package_exe(&global.join("node_modules")),
            ]
        );
        let bin = Path::new("/project").join("node_modules").join(".bin");
        assert_eq!(
            native_candidates(&bin.join("tsc.cmd")),
            [
                platform_package_exe(
                    &Path::new("/project")
                        .join("node_modules")
                        .join("typescript")
                        .join("node_modules")
                ),
                platform_package_exe(&Path::new("/project").join("node_modules")),
            ]
        );
    }

    #[test]
    fn not_found_message() {
        let e = not_found("it was not found");
        assert_eq!(
            e.message(),
            format!(
                "TypeScript input requires the TypeScript 7.0.2 compiler (tsc), but it was not \
                 found. Install it with \"npm install -g typescript@7.0.2\" (for this platform, \
                 that installs @typescript/typescript-{}@7.0.2), or set QUICKTYPE_TSC to its path",
                platform_suffix()
            )
        );
    }

    #[test]
    fn npm_launcher_resolves_to_the_native_binary() {
        let scratch = Scratch::new("launcher");
        let launcher = scratch.file(
            &Path::new("node_modules")
                .join("typescript")
                .join("bin")
                .join("tsc"),
            "#!/usr/bin/env node\n",
        );
        // The candidates are under the launcher's real path (symbolic links,
        // 8.3 short names and macOS's /private resolved), in the form users
        // write: no `\\?\` prefix on Windows.
        let node_modules = scratch.real(Path::new("node_modules"));
        let candidates = native_candidates(&launcher);
        assert_eq!(
            candidates,
            [
                platform_package_exe(&node_modules.join("typescript").join("node_modules")),
                platform_package_exe(&node_modules),
            ]
        );
        assert!(!candidates[0].to_string_lossy().starts_with("\\\\?\\"));
    }

    #[test]
    fn missing_binary_is_rejected() {
        assert!(!has_pinned_version(Path::new("/nonexistent/tsc")));
    }

    /// `release/typescript/pins.json`, the compiler the release bundles, pins
    /// [`TSC_VERSION`], the release these tables and the lookup accept. It
    /// is in the repository, not in the published crate.
    #[test]
    fn release_bundles_the_pinned_version() {
        let Some(pins) = Path::new(env!("CARGO_MANIFEST_DIR"))
            .ancestors()
            .map(|dir| dir.join("release").join("typescript").join("pins.json"))
            .find(|file| file.is_file())
        else {
            eprintln!("skipped: no release/typescript/pins.json above this crate");
            return;
        };
        let pins: serde_json::Value =
            serde_json::from_str(&std::fs::read_to_string(pins).unwrap()).unwrap();
        assert_eq!(pins["version"], TSC_VERSION);
        let packages = pins["packages"].as_object().unwrap();
        assert!(!packages.is_empty());
        for (suffix, package) in packages {
            let name = format!("@typescript/typescript-{suffix}");
            assert_eq!(package["name"], name.as_str());
            assert_eq!(
                package["tarball"],
                format!(
                    "https://registry.npmjs.org/{name}/-/typescript-{suffix}-{TSC_VERSION}.tgz"
                )
                .as_str()
            );
            assert!(
                package["integrity"]
                    .as_str()
                    .is_some_and(|i| i.starts_with("sha512-")),
                "{suffix}"
            );
        }
    }
}
