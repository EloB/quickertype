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

use quicktype_core::{Readable, StdIo};

use crate::messages::CliError;

/// libuv's error code and description for an I/O error, as Node prints
/// them (`ENOENT`, `no such file or directory`).
fn errno_text(e: &io::Error) -> (&'static str, &'static str) {
    use io::ErrorKind as K;
    match e.kind() {
        K::NotFound => ("ENOENT", "no such file or directory"),
        K::PermissionDenied => ("EACCES", "permission denied"),
        K::AlreadyExists => ("EEXIST", "file already exists"),
        K::NotADirectory => ("ENOTDIR", "not a directory"),
        K::IsADirectory => ("EISDIR", "illegal operation on a directory"),
        K::InvalidFilename => ("ENAMETOOLONG", "name too long"),
        K::ReadOnlyFilesystem => ("EROFS", "read-only file system"),
        K::StorageFull => ("ENOSPC", "no space left on device"),
        K::InvalidInput => ("EINVAL", "invalid argument"),
        _ => ("EIO", "i/o error"),
    }
}

/// The `message` of the error Node's `fs` throws for a failed `syscall` on
/// `path`: `ENOENT: no such file or directory, lstat 'x.json'`.
pub fn fs_error_message(e: &io::Error, syscall: &str, path: &str) -> String {
    let (code, description) = errno_text(e);
    format!("{code}: {description}, {syscall} '{path}'")
}

/// The `message` of the error Node throws when reading a directory as a
/// file: the open succeeds, the read fails, and the error names no path.
fn read_error_message(e: &io::Error, path: &str) -> String {
    if e.kind() == io::ErrorKind::IsADirectory {
        let (code, description) = errno_text(e);
        return format!("{code}: {description}, read");
    }
    fs_error_message(e, "open", path)
}

/// `fs.readFileSync(path)`, failing like Node does.
pub fn read_file_sync(path: &str) -> Result<Vec<u8>, CliError> {
    std::fs::read(path).map_err(|e| CliError::Thrown(read_error_message(&e, path)))
}

/// `fs.readFileSync(path, "utf8")`: invalid UTF-8 is replaced.
pub fn read_file_sync_utf8(path: &str) -> Result<String, CliError> {
    read_file_sync(path).map(|bytes| String::from_utf8_lossy(&bytes).into_owned())
}

/// `fs.writeFileSync(path, data)`.
pub fn write_file_sync(path: &str, data: &str) -> Result<(), CliError> {
    std::fs::write(path, data).map_err(|e| CliError::Thrown(fs_error_message(&e, "open", path)))
}

/// `fs.existsSync(path)`: follows symbolic links and never fails.
pub fn exists_sync(path: &str) -> bool {
    !path.is_empty() && Path::new(path).exists()
}

/// `fs.lstatSync(path)`.
fn lstat_sync(path: &str) -> Result<std::fs::Metadata, String> {
    std::fs::symlink_metadata(path).map_err(|e| fs_error_message(&e, "lstat", path))
}

/// `fs.lstatSync(path).isDirectory()`.
pub fn is_directory(path: &str) -> Result<bool, CliError> {
    lstat_sync(path)
        .map(|m| m.is_dir())
        .map_err(CliError::Thrown)
}

/// `fs.lstatSync(path).isFile()`.
pub fn is_file(path: &str) -> Result<bool, CliError> {
    lstat_sync(path)
        .map(|m| m.is_file())
        .map_err(CliError::Thrown)
}

/// `fs.readdirSync(dir)`: the entry names, sorted by bytes like libuv's
/// `scandir`.
pub fn readdir_sync(dir: &str) -> Result<Vec<String>, CliError> {
    let entries = std::fs::read_dir(dir)
        .map_err(|e| CliError::Thrown(fs_error_message(&e, "scandir", dir)))?;
    let mut names = Vec::new();
    for entry in entries {
        let entry = entry.map_err(|e| CliError::Thrown(fs_error_message(&e, "scandir", dir)))?;
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
    readable
        .read(&StdIo)
        .await
        .map_err(|e| CliError::Thrown(e.strip_prefix("Error: ").unwrap_or(&e).to_owned()))
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
            fs_error_message(&e, "lstat", "x.json"),
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
        let e = quicktype_core::block_on(readable_from_file_or_url("nonexistent.json", &[]))
            .unwrap_err();
        assert_eq!(
            e.to_string(),
            "Cannot read from file or URL nonexistent.json: Error: ENOENT: no such file or directory, lstat 'nonexistent.json'"
        );
        assert_eq!(
            quicktype_core::block_on(readable_from_file_or_url("-", &[])).unwrap(),
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
