//! Finding the TypeScript 7 native compiler.
//!
//! [`locate`] looks, in this order, at:
//!
//! 1. `$QUICKTYPE_TSC` ([`TSC_ENV`]), and at nothing else when it is set;
//! 2. the compiler a release bundles with quickertype
//!    ([`bundled_packages`]): the npm platform package, unmodified, in a
//!    `typescript` directory next to the executable (the release archives,
//!    the MSI, the npm package) or in `../share/quickertype` (Homebrew),
//!    found from the executable's real path, and used only when that
//!    directory is a release's ([`is_bundled_package`]);
//! 3. the npm platform package in `node_modules` of the working directory
//!    or any ancestor (a port of the lookup in `typescript/lib/getExePath.js`),
//!    then `tsgo`/`tsc` on `PATH`.
//!
//! Without one, [`Error::TscNotFound`] names the npm package to install for
//! this platform. Only the exact pinned release ([`TSC_VERSION`]) is
//! accepted: the `--api` protocol is unversioned, and the enum values in
//! [`super::generated`] change between releases. The bundled compiler's
//! version is read from its `package.json`; the others are asked with
//! `--version`.

use std::ffi::OsString;
use std::path::{Path, PathBuf};
use std::process::{Command, Stdio};

use super::generated::TSC_VERSION;
use crate::error::{Error, Result};

/// The environment variable that names the compiler binary explicitly.
pub const TSC_ENV: &str = "QUICKTYPE_TSC";

/// The directory that a release puts the compiler in, next to quickertype:
/// the npm platform package (`@typescript/typescript-<os>-<arch>`),
/// unmodified, with the release's [`BUNDLED_PINS`] beside its files.
pub const BUNDLED_DIR: &str = "typescript";

/// The file of a release's [`BUNDLED_DIR`] that pins its package
/// (`release/typescript/pins.json` in the repository).
pub const BUNDLED_PINS: &str = "pins.json";

/// The npm platform package of this platform's compiler,
/// `@typescript/typescript-<os>-<arch>`.
fn platform_package_name() -> String {
    format!("@typescript/typescript-{}", platform_suffix())
}

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
/// `exe` (quickertype), as platform package directories: `typescript` in
/// the directory of `exe`'s real path (the release archives, the MSI's
/// `bin`, the npm package's unpacked archive), then
/// `../share/quickertype/typescript` from it (Homebrew's `pkgshare`, which
/// its `bin` links point into). The real path resolves symbolic links, and
/// on Windows is in the form users write (no `\\?\` prefix). The compiler is
/// [`package_exe`] of one for which [`is_bundled_package`] holds.
pub fn bundled_packages(exe: &Path) -> Vec<PathBuf> {
    let real = simplified(std::fs::canonicalize(exe).unwrap_or_else(|_| exe.to_path_buf()));
    let Some(dir) = real.parent() else {
        return Vec::new();
    };
    let mut packages = vec![dir.join(BUNDLED_DIR)];
    if let Some(prefix) = dir.parent() {
        packages.push(prefix.join("share").join("quickertype").join(BUNDLED_DIR));
    }
    packages
}

/// Whether `package` is the compiler a release bundles: its compiler is a
/// file (executable, but on Windows), the release's [`BUNDLED_PINS`] is in
/// it, and its `package.json` names this platform's package at
/// [`TSC_VERSION`]. Anything else at `typescript/lib/tsc` next to an
/// executable (a binary downloaded beside `quickertype`, say, or a compiler
/// unpacked without its execute bits) is passed over for the next
/// candidates. The version comes from `package.json`, so the compiler is not
/// started to ask it, as the other candidates are ([`has_pinned_version`]):
/// the release checked it against the pinned package's hash.
pub fn is_bundled_package(package: &Path) -> bool {
    if !is_executable_file(&package_exe(package)) || !package.join(BUNDLED_PINS).is_file() {
        return false;
    }
    let Ok(text) = std::fs::read_to_string(package.join("package.json")) else {
        return false;
    };
    let Ok(manifest) = serde_json::from_str::<serde_json::Value>(&text) else {
        return false;
    };
    manifest["name"] == platform_package_name().as_str() && manifest["version"] == TSC_VERSION
}

/// Whether `path` is a file that its execute bits let this process run
/// (any file on Windows, which has no such bits): one `stat`, no spawn.
fn is_executable_file(path: &Path) -> bool {
    let Ok(metadata) = std::fs::metadata(path) else {
        return false;
    };
    #[cfg(unix)]
    {
        use std::os::unix::fs::PermissionsExt;
        metadata.is_file() && metadata.permissions().mode() & 0o111 != 0
    }
    #[cfg(not(unix))]
    {
        metadata.is_file()
    }
}

/// The error for a compiler `exe` that [`locate`] chose but that could not
/// be started (`error`, from spawning it). When the system refused to run
/// it (EACCES: not executable; ENOEXEC, or Windows' "not a valid Win32
/// application": not a program for this system), the message names the
/// path and how to fix it.
pub fn start_error(exe: &Path, error: &std::io::Error) -> Error {
    const ENOEXEC: i32 = 8;
    const ERROR_BAD_EXE_FORMAT: i32 = 193;
    let code = error.raw_os_error();
    if error.kind() == std::io::ErrorKind::PermissionDenied {
        let path = exe.display();
        Error::Tsc(format!(
            "could not start the TypeScript compiler {path}: {error}. Make it executable \
             (chmod +x {path}), or set {TSC_ENV} to the TypeScript {TSC_VERSION} compiler's path"
        ))
    } else if (cfg!(unix) && code == Some(ENOEXEC))
        || (cfg!(windows) && code == Some(ERROR_BAD_EXE_FORMAT))
    {
        not_a_program_error(exe, &error.to_string())
    } else {
        Error::Tsc(format!("could not start {}: {error}", exe.display()))
    }
}

/// The error for a compiler `exe` that is not a program this system runs;
/// `why` is how that showed: the error of spawning it, or, where `exec`
/// handed the file to a shell instead, the shell's exit status 126 ("cannot
/// execute").
pub fn not_a_program_error(exe: &Path, why: &str) -> Error {
    Error::Tsc(format!(
        "could not start the TypeScript compiler {}: {why}: it is not a program for this \
         system. Install the compiler for this platform ({}@{TSC_VERSION}), or set {TSC_ENV} \
         to its path",
        exe.display(),
        platform_package_name()
    ))
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
    /// ([`has_pinned_version`]); not asked of the bundled compiler.
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
        .flat_map(|exe| bundled_packages(exe))
        .find(|package| is_bundled_package(package))
    {
        return Ok(package_exe(&bundled));
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
         installs {}@{TSC_VERSION}), or set {TSC_ENV} to its path",
        platform_package_name()
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
    use crate::testing::ScratchDir;

    /// What the fake compilers of these tests contain; [`fake_check`]
    /// accepts exactly that, as [`has_pinned_version`] accepts the pinned
    /// release (the lookup runs on every platform without running one).
    const FAKE_TSC: &str = "fake tsc 7.0.2";

    fn fake_check(exe: &Path) -> bool {
        std::fs::read_to_string(exe).is_ok_and(|text| text == FAKE_TSC)
    }

    /// Writes `contents` to `relative` in `dir` (creating its directories)
    /// and returns its path.
    fn write(dir: &Path, relative: &Path, contents: &str) -> PathBuf {
        let path = dir.join(relative);
        std::fs::create_dir_all(path.parent().unwrap()).unwrap();
        std::fs::write(&path, contents).unwrap();
        path
    }

    /// `relative`'s real path in `dir`, as the lookup reports it.
    fn real(dir: &Path, relative: &Path) -> PathBuf {
        simplified(std::fs::canonicalize(dir.join(relative)).unwrap())
    }

    /// Sets `path`'s permission bits (a no-op where there are none).
    fn set_mode(path: &Path, mode: u32) {
        #[cfg(unix)]
        {
            use std::os::unix::fs::PermissionsExt;
            std::fs::set_permissions(path, std::fs::Permissions::from_mode(mode)).unwrap();
        }
        #[cfg(not(unix))]
        let _ = (path, mode);
    }

    fn manifest(name: &str, version: &str) -> String {
        format!("{{\n    \"name\": \"{name}\",\n    \"version\": \"{version}\"\n}}\n")
    }

    /// A release's `typescript` directory at `package` in `dir`: a
    /// compiler that is not [`FAKE_TSC`] (the bundled one is never asked
    /// its version), this platform's `package.json` and the pins. Returns
    /// the compiler's relative path.
    fn bundle(dir: &Path, package: &Path) -> PathBuf {
        let tsc = write(dir, &package_exe(package), "bundled tsc");
        set_mode(&tsc, 0o755);
        write(
            dir,
            &package.join("package.json"),
            &manifest(&platform_package_name(), TSC_VERSION),
        );
        write(dir, &package.join(BUNDLED_PINS), "{}\n");
        package_exe(package)
    }

    /// `<dir>/install/quickertype` with a release's compiler next to it, a
    /// project at `<dir>/project` with the platform package in its
    /// `node_modules`, and `tsc` in `<dir>/path`: a candidate for every
    /// step.
    fn every_step(dir: &Path) -> Environment<'static> {
        let exe = write(dir, &Path::new("install").join(exe_name("quickertype")), "");
        bundle(dir, &Path::new("install").join(BUNDLED_DIR));
        write(
            dir,
            &platform_package_exe(&Path::new("project").join("node_modules")),
            FAKE_TSC,
        );
        write(dir, &Path::new("path").join(exe_name("tsc")), FAKE_TSC);
        Environment {
            explicit: None,
            exe: Some(exe),
            path: Some(dir.join("path").into_os_string()),
            is_pinned: &fake_check,
        }
    }

    /// What `every_step`'s lookup finds after the bundled compiler: the
    /// project's platform package.
    fn project_package(dir: &Path) -> PathBuf {
        platform_package_exe(&dir.join("project").join("node_modules"))
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
        let dir = ScratchDir::new("locate-explicit");
        let explicit = write(
            &dir,
            &Path::new("elsewhere").join(exe_name("tsc")),
            FAKE_TSC,
        );
        let env = Environment {
            explicit: Some(explicit.clone().into_os_string()),
            ..every_step(&dir)
        };
        let found = find(&dir.join("project"), &env).unwrap();
        assert_eq!(
            found,
            real(&dir, &Path::new("elsewhere").join(exe_name("tsc")))
        );
    }

    #[test]
    fn explicit_compiler_of_another_version_is_an_error() {
        let dir = ScratchDir::new("locate-explicit-other");
        let explicit = write(
            &dir,
            &Path::new("elsewhere").join(exe_name("tsc")),
            "tsc 7.0.1",
        );
        let env = Environment {
            explicit: Some(explicit.clone().into_os_string()),
            ..every_step(&dir)
        };
        let error = find(&dir.join("project"), &env).unwrap_err();
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
        let dir = ScratchDir::new("locate-bundled");
        let env = every_step(&dir);
        let found = find(&dir.join("project"), &env).unwrap();
        assert_eq!(
            found,
            real(&dir, &package_exe(&Path::new("install").join(BUNDLED_DIR)))
        );
        // In the form users write: no `\\?\` prefix on Windows.
        assert!(!found.to_string_lossy().starts_with("\\\\?\\"));
    }

    #[test]
    fn bundled_compiler_is_not_asked_its_version() {
        // `package.json` gives the version: a lookup whose `--version`
        // check accepts nothing still finds the bundled compiler.
        let dir = ScratchDir::new("locate-bundled-no-run");
        let env = Environment {
            is_pinned: &|_: &Path| false,
            ..every_step(&dir)
        };
        assert_eq!(
            find(&dir.join("project"), &env).unwrap(),
            real(&dir, &package_exe(&Path::new("install").join(BUNDLED_DIR)))
        );
    }

    #[test]
    fn bundled_compiler_in_share_quickertype() {
        // Homebrew's layout: the formula installs the archive's binary into
        // `<prefix>/bin` and the rest into `<prefix>/share/quickertype`.
        let dir = ScratchDir::new("locate-bundled-share");
        let prefix = Path::new("Cellar").join("quickertype").join("1.0");
        let exe = write(&dir, &prefix.join("bin").join(exe_name("quickertype")), "");
        let bundled = bundle(
            &dir,
            &prefix.join("share").join("quickertype").join(BUNDLED_DIR),
        );
        let env = Environment {
            exe: Some(exe),
            ..every_step(&dir)
        };
        // `every_step` put a compiler next to its own executable, not this one.
        assert_eq!(
            find(&dir.join("project"), &env).unwrap(),
            real(&dir, &bundled)
        );
    }

    #[cfg(unix)]
    #[test]
    fn bundled_compiler_through_a_symbolic_link() {
        // `brew install` links `<HOMEBREW_PREFIX>/bin/quickertype` to
        // `../Cellar/quickertype/<version>/bin/quickertype`; a user's own
        // link to an unpacked archive works the same way.
        let dir = ScratchDir::new("locate-bundled-link");
        let prefix = Path::new("Cellar").join("quickertype").join("1.0");
        let real_exe = write(&dir, &prefix.join("bin").join("quickertype"), "");
        let bundled = bundle(
            &dir,
            &prefix.join("share").join("quickertype").join(BUNDLED_DIR),
        );
        let link = dir.join("bin").join("quickertype");
        std::fs::create_dir_all(link.parent().unwrap()).unwrap();
        std::os::unix::fs::symlink(&real_exe, &link).unwrap();
        let env = Environment {
            exe: Some(link),
            path: None,
            ..every_step(&dir)
        };
        assert_eq!(
            find(&dir.join("project"), &env).unwrap(),
            real(&dir, &bundled)
        );
    }

    /// A `typescript/lib/tsc` next to the executable that is not a
    /// release's is not run: the lookup goes on to `node_modules`.
    fn skipped(name: &str, change: impl FnOnce(&Path, &Path)) {
        let dir = ScratchDir::new(name);
        let env = every_step(&dir);
        change(&dir, &Path::new("install").join(BUNDLED_DIR));
        let cwd = dir.join("project").join("src");
        assert_eq!(find(&cwd, &env).unwrap(), project_package(&dir), "{name}");
    }

    #[test]
    fn planted_compiler_without_the_release_files_is_skipped() {
        skipped("locate-planted", |dir, package| {
            std::fs::remove_file(dir.join(package).join(BUNDLED_PINS)).unwrap();
            std::fs::remove_file(dir.join(package).join("package.json")).unwrap();
        });
        skipped("locate-no-pins", |dir, package| {
            std::fs::remove_file(dir.join(package).join(BUNDLED_PINS)).unwrap();
        });
        skipped("locate-no-manifest", |dir, package| {
            std::fs::remove_file(dir.join(package).join("package.json")).unwrap();
        });
        skipped("locate-bad-manifest", |dir, package| {
            write(dir, &package.join("package.json"), "{ not json");
        });
    }

    #[test]
    fn bundled_package_of_another_platform_or_version_is_skipped() {
        skipped("locate-other-platform", |dir, package| {
            let other = if platform_suffix() == "linux-x64" {
                "@typescript/typescript-darwin-arm64"
            } else {
                "@typescript/typescript-linux-x64"
            };
            write(
                dir,
                &package.join("package.json"),
                &manifest(other, TSC_VERSION),
            );
        });
        skipped("locate-other-version", |dir, package| {
            write(
                dir,
                &package.join("package.json"),
                &manifest(&platform_package_name(), "7.0.1"),
            );
        });
        skipped("locate-no-compiler", |dir, package| {
            std::fs::remove_file(dir.join(package_exe(package))).unwrap();
        });
    }

    #[cfg(unix)]
    #[test]
    fn bundled_compiler_that_is_not_executable_is_skipped() {
        // An archive unpacked by a tool that drops the execute bits: the
        // lookup sees it with one stat and goes on, instead of choosing a
        // compiler that cannot start.
        skipped("locate-not-executable", |dir, package| {
            set_mode(&dir.join(package_exe(package)), 0o644);
        });
    }

    #[test]
    fn start_errors_name_the_compiler_and_the_fix() {
        let exe = Path::new("/opt/quickertype/typescript/lib/tsc");
        let denied = std::io::Error::from(std::io::ErrorKind::PermissionDenied);
        let message = start_error(exe, &denied).message();
        assert!(
            message.starts_with(
                "could not start the TypeScript compiler /opt/quickertype/typescript/lib/tsc: "
            ) && message.ends_with(
                ". Make it executable (chmod +x /opt/quickertype/typescript/lib/tsc), or set \
                 QUICKTYPE_TSC to the TypeScript 7.0.2 compiler's path"
            ),
            "{message}"
        );
        let format = std::io::Error::from_raw_os_error(if cfg!(windows) { 193 } else { 8 });
        let message = start_error(exe, &format).message();
        assert!(
            message.ends_with(&format!(
                ": it is not a program for this system. Install the compiler for this platform \
                 ({}@7.0.2), or set QUICKTYPE_TSC to its path",
                platform_package_name()
            )),
            "{message}"
        );
        let other = std::io::Error::from(std::io::ErrorKind::NotFound);
        assert_eq!(
            start_error(exe, &other).message(),
            format!("could not start {}: {other}", exe.display())
        );
    }

    /// What starting a file that cannot run gives: the error of the
    /// compiler's own spawn ([`super::super::channel::Channel::spawn`]).
    #[cfg(unix)]
    #[test]
    fn starting_a_compiler_that_cannot_run_says_how_to_fix_it() {
        let dir = ScratchDir::new("locate-start");
        let not_executable = write(&dir, Path::new("not-executable/tsc"), "tsc");
        let error = Command::new(&not_executable).spawn().unwrap_err();
        let message = start_error(&not_executable, &error).message();
        assert!(
            message.contains(&format!("chmod +x {}", not_executable.display())),
            "{message}"
        );
        // Not a program at all, though executable. Some systems run such a
        // file as a shell script instead; then there is no error to check.
        let garbage = write(
            &dir,
            Path::new("garbage/tsc"),
            "\u{0}\u{1}\u{2} not a program",
        );
        set_mode(&garbage, 0o755);
        match Command::new(&garbage)
            .stdout(Stdio::null())
            .stderr(Stdio::null())
            .spawn()
        {
            Err(error) => {
                let message = start_error(&garbage, &error).message();
                assert!(
                    message.contains(&garbage.display().to_string()),
                    "{message}"
                );
                assert!(
                    message.contains("not a program for this system"),
                    "{message}"
                );
            }
            Ok(mut child) => {
                let _ = child.wait();
            }
        }
    }

    #[test]
    fn node_modules_of_the_working_directory_or_an_ancestor() {
        let dir = ScratchDir::new("locate-node-modules");
        let env = Environment {
            exe: None,
            ..every_step(&dir)
        };
        let cwd = dir.join("project").join("src").join("models");
        assert_eq!(find(&cwd, &env).unwrap(), project_package(&dir));
    }

    #[test]
    fn compiler_on_path() {
        let dir = ScratchDir::new("locate-path");
        let env = Environment {
            exe: None,
            ..every_step(&dir)
        };
        let outside = dir.join("outside");
        std::fs::create_dir_all(&outside).unwrap();
        assert_eq!(
            find(&outside, &env).unwrap(),
            real(&dir, &Path::new("path").join(exe_name("tsc")))
        );
    }

    #[test]
    fn nothing_found_names_the_package_to_install() {
        let dir = ScratchDir::new("locate-nothing");
        let exe = write(&dir, &Path::new("bin").join(exe_name("quickertype")), "");
        let env = Environment {
            explicit: None,
            exe: Some(exe),
            path: Some(dir.join("bin").into_os_string()),
            is_pinned: &fake_check,
        };
        let error = find(&dir, &env).unwrap_err();
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
        let dir = ScratchDir::new("locate-launcher");
        let launcher = write(
            &dir,
            &Path::new("node_modules")
                .join("typescript")
                .join("bin")
                .join("tsc"),
            "#!/usr/bin/env node\n",
        );
        // The candidates are under the launcher's real path (symbolic links,
        // 8.3 short names and macOS's /private resolved), in the form users
        // write: no `\\?\` prefix on Windows.
        let node_modules = real(&dir, Path::new("node_modules"));
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

    /// `release/typescript/pins.json`, the compiler the release bundles,
    /// pins [`TSC_VERSION`], the release these tables and the lookup accept,
    /// with a tarball, an integrity and the compiler's hash for each
    /// package. It is in the repository, not in the published crate.
    #[test]
    fn release_bundles_the_pinned_version() {
        let Some(pins) = Path::new(env!("CARGO_MANIFEST_DIR"))
            .ancestors()
            .map(|dir| dir.join("release").join(BUNDLED_DIR).join(BUNDLED_PINS))
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
            assert!(
                package["tscSha256"].as_str().is_some_and(|h| h.len() == 64
                    && h.bytes()
                        .all(|b| b.is_ascii_hexdigit() && !b.is_ascii_uppercase())),
                "{suffix}"
            );
        }
    }
}
