//! The Node.js `fs` calls in `src/index.ts`, with Node's error texts, and
//! the CLI's use of quicktype-core's NodeIO port.
//!
//! quicktype reports Node's errors verbatim: a failed `fs.readFileSync`
//! rejects `main` with `ENOENT: no such file or directory, open 'x'`.
//!
//! A source is opened ([`readable_from_file_or_url`]) when the CLI collects
//! its sources and [`read`] only when the input parses it, as TypeScript
//! reads its Node streams lazily: standard input is not touched before
//! errors that TypeScript reports first (e.g. an unknown `--debug`
//! option).

use std::io;
use std::path::Path;

use quicktype_core::{IoError, Readable, StdIo};

use crate::messages::CliError;

/// The error Node's `fs` throws when `syscall` fails on `path`, e.g.
/// `ENOENT: no such file or directory, lstat 'x.json'`.
fn fs_error(e: &io::Error, syscall: &str, path: &str) -> CliError {
    CliError::Io(IoError::from_fs(e, syscall, Some(path)))
}

/// What `fs.readFileSync` throws: reading a directory opens it and fails
/// the read, an error that names no path.
fn read_error(e: &io::Error, path: &str) -> CliError {
    if e.kind() == io::ErrorKind::IsADirectory {
        return CliError::Io(IoError::from_fs(e, "read", None));
    }
    fs_error(e, "open", path)
}

/// `fs.readFileSync(path)`, failing like Node does.
pub fn read_file_sync(path: &str) -> Result<Vec<u8>, CliError> {
    std::fs::read(path).map_err(|e| read_error(&e, path))
}

/// `fs.readFileSync(path, "utf8")`: invalid UTF-8 is replaced.
pub fn read_file_sync_utf8(path: &str) -> Result<String, CliError> {
    read_file_sync(path).map(quicktype_js_compat::utf8::decode_owned)
}

/// `fs.writeFileSync(path, data)`.
pub fn write_file_sync(path: &str, data: &str) -> Result<(), CliError> {
    std::fs::write(path, data).map_err(|e| fs_error(&e, "open", path))
}

/// `fs.existsSync(path)`: follows symbolic links and never fails.
pub fn exists_sync(path: &str) -> bool {
    !path.is_empty() && Path::new(path).exists()
}

/// `fs.lstatSync(path)`.
fn lstat_sync(path: &str) -> Result<std::fs::Metadata, CliError> {
    std::fs::symlink_metadata(path).map_err(|e| fs_error(&e, "lstat", path))
}

/// `fs.lstatSync(path).isDirectory()`.
pub fn is_directory(path: &str) -> Result<bool, CliError> {
    lstat_sync(path).map(|m| m.is_dir())
}

/// `fs.lstatSync(path).isFile()`.
pub fn is_file(path: &str) -> Result<bool, CliError> {
    lstat_sync(path).map(|m| m.is_file())
}

/// `fs.readdirSync(dir)`: the entry names, sorted by bytes like libuv's
/// `scandir`.
pub fn readdir_sync(dir: &str) -> Result<Vec<String>, CliError> {
    let entries = std::fs::read_dir(dir).map_err(|e| fs_error(&e, "scandir", dir))?;
    let mut names = Vec::new();
    for entry in entries {
        let entry = entry.map_err(|e| fs_error(&e, "scandir", dir))?;
        names.push(entry.file_name().to_string_lossy().into_owned());
    }
    names.sort_unstable_by(|a, b| a.as_bytes().cmp(b.as_bytes()));
    Ok(names)
}

/// Reads an opened source to the end (TS: the JSON input consuming the
/// stream, or `getStream`). A failed read makes Node emit an `error` event
/// that nothing handles, so the reference crashes with a stack trace; we
/// report the error's message instead (a known gap, see docs/PARITY.md).
pub async fn read(readable: Readable) -> Result<String, CliError> {
    readable.read(&StdIo).await.map_err(CliError::Io)
}

/// `readableFromFileOrURL(fileOrURL, httpHeaders)` on the standard
/// library.
pub async fn readable_from_file_or_url(
    file_or_url: &str,
    http_headers: &[String],
) -> Result<Readable, CliError> {
    Ok(quicktype_core::readable_from_file_or_url(&StdIo, file_or_url, http_headers).await?)
}

/// `readFromFileOrURL(fileOrURL, httpHeaders)` on the standard library.
pub async fn read_from_file_or_url(
    file_or_url: &str,
    http_headers: &[String],
) -> Result<String, CliError> {
    Ok(quicktype_core::read_from_file_or_url(&StdIo, file_or_url, http_headers).await?)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn node_error_messages() {
        let e = io::Error::from(io::ErrorKind::NotFound);
        assert_eq!(
            fs_error(&e, "lstat", "x.json").to_string(),
            "ENOENT: no such file or directory, lstat 'x.json'"
        );
        let e = read_file_sync("/nonexistent/qt").unwrap_err();
        assert_eq!(
            e.to_string(),
            "ENOENT: no such file or directory, open '/nonexistent/qt'"
        );
    }

    #[test]
    fn missing_files_fail_lstat() {
        let e =
            quicktype_core::internal::block_on(readable_from_file_or_url("nonexistent.json", &[]))
                .unwrap_err();
        assert_eq!(
            e.to_string(),
            "Cannot read from file or URL nonexistent.json: Error: ENOENT: no such file or directory, lstat 'nonexistent.json'"
        );
        assert_eq!(
            quicktype_core::internal::block_on(readable_from_file_or_url("-", &[])).unwrap(),
            Readable::Stdin
        );
    }

    #[test]
    fn directories_are_listed_in_byte_order() {
        let dir = std::env::temp_dir().join(format!("qt-readdir-{}", std::process::id()));
        let _ = std::fs::remove_dir_all(&dir);
        std::fs::create_dir_all(&dir).unwrap();
        for name in ["b", "10", "9", "Alpha", "_x", "a", "é"] {
            std::fs::write(dir.join(name), "").unwrap();
        }
        let names = readdir_sync(&dir.to_string_lossy()).unwrap();
        let _ = std::fs::remove_dir_all(&dir);
        assert_eq!(names, ["10", "9", "Alpha", "_x", "a", "b", "é"]);
    }
}
