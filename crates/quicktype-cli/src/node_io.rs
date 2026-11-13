//! The Node.js file system calls the CLI makes, with Node's error texts,
//! and `readableFromFileOrURL` from
//! `packages/quicktype-core/src/input/io/NodeIO.ts`.
//!
//! quicktype reports Node's errors verbatim: a failed `fs.readFileSync` in
//! `src/index.ts` rejects `main` with `ENOENT: no such file or directory,
//! open 'x'`, and `readableFromFileOrURL` wraps its failures in
//! `MiscReadError` with the error's `toString()`.
//!
//! A source is resolved ("opened") when the CLI collects its sources and
//! read only when the JSON input parses it, as TypeScript reads its Node
//! streams lazily: standard input is not touched before errors that
//! TypeScript reports first (e.g. an unknown `--debug` option).
// TODO(json-schema-input): URLs and `file://` URIs go through the core's
// `Io` trait once the JSON Schema input (which ports NodeIO) is on main.

use std::io::{self, Read};
use std::path::Path;

use quicktype_core::ErrorKind;

use crate::js;
use crate::messages::{CliError, message_error};

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

/// `resolveSymbolicLink(filePath)`: the target of a symbolic link (one
/// level; a relative target is resolved against the link's directory), or
/// the path itself.
fn resolve_symbolic_link(file_path: &str) -> Result<String, String> {
    if !lstat_sync(file_path)?.file_type().is_symlink() {
        return Ok(file_path.to_owned());
    }
    let link =
        std::fs::read_link(file_path).map_err(|e| fs_error_message(&e, "readlink", file_path))?;
    let link = link.to_string_lossy().into_owned();
    if link.starts_with('/') {
        return Ok(link);
    }
    Ok(js::path_join(&[js::dirname(file_path), &link]))
}

/// A source that has been opened but not read (TS: a Node `Readable`).
#[derive(Clone, Debug, PartialEq, Eq)]
pub enum Readable {
    /// Standard input (`-`).
    Stdin,
    /// A file, after symbolic links were resolved.
    File(String),
    /// Text already in memory (a Postman response, a URL's body).
    Text(String),
}

impl Readable {
    /// Reads the whole source (TS: consuming the stream). A failed read
    /// makes Node emit an `error` event that nothing handles, so the
    /// reference crashes with a stack trace; we report the error's message
    /// instead (a known gap, see docs/PARITY.md).
    pub fn read(self) -> Result<Vec<u8>, CliError> {
        match self {
            Readable::Text(text) => Ok(text.into_bytes()),
            Readable::File(path) => read_file_sync(&path),
            Readable::Stdin => {
                let mut bytes = Vec::new();
                io::stdin()
                    .lock()
                    .read_to_end(&mut bytes)
                    .map_err(|e| CliError::Thrown(fs_error_message(&e, "read", "-")))?;
                Ok(bytes)
            }
        }
    }

    /// Reads the whole source as UTF-8 text (TS `getStream`), replacing
    /// invalid sequences.
    pub fn read_to_string(self) -> Result<String, CliError> {
        self.read()
            .map(|bytes| String::from_utf8_lossy(&bytes).into_owned())
    }
}

/// `readableFromFileOrURL(fileOrURL, httpHeaders)`: opens a file, or
/// standard input for `-`.
pub fn readable_from_file_or_url(
    file_or_url: &str,
    _http_headers: &[String],
) -> Result<Readable, CliError> {
    if file_or_url.starts_with("file://") || looks_like_url(file_or_url) {
        return Err(CliError::NotImplemented(format!(
            "reading from URLs ({file_or_url})"
        )));
    }
    if file_or_url == "-" {
        return Ok(Readable::Stdin);
    }
    let file_path = resolve_symbolic_link(file_or_url).map_err(|message| {
        message_error(
            ErrorKind::MiscReadError,
            vec![
                ("fileOrURL", file_or_url.into()),
                ("message", format!("Error: {message}").into()),
            ],
        )
    })?;
    if exists_sync(&file_path) {
        return Ok(Readable::File(file_path));
    }
    Err(message_error(
        ErrorKind::DriverInputFileDoesNotExist,
        vec![("filename", file_or_url.into())],
    ))
}

/// `readFromFileOrURL(fileOrURL, httpHeaders)`: the whole text.
pub fn read_from_file_or_url(
    file_or_url: &str,
    http_headers: &[String],
) -> Result<String, CliError> {
    readable_from_file_or_url(file_or_url, http_headers)?.read_to_string()
}

/// The first test of is-url 1.2.4 (`/^(?:\w+:)?\/\/(\S+)$/`), which every
/// URL passes; enough to tell URLs, which need the core's `Io`, from paths.
fn looks_like_url(s: &str) -> bool {
    let rest = match s.find("//") {
        Some(i) => {
            let scheme = &s[..i];
            let valid_scheme = scheme.is_empty()
                || scheme
                    .strip_suffix(':')
                    .is_some_and(|w| !w.is_empty() && w.chars().all(js::is_word_char));
            if !valid_scheme {
                return false;
            }
            &s[i + 2..]
        }
        None => return false,
    };
    !rest.is_empty() && !rest.chars().any(js::is_whitespace)
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
        let e = readable_from_file_or_url("nonexistent.json", &[]).unwrap_err();
        assert_eq!(
            e.to_string(),
            "Cannot read from file or URL nonexistent.json: Error: ENOENT: no such file or directory, lstat 'nonexistent.json'"
        );
        assert_eq!(
            readable_from_file_or_url("-", &[]).unwrap(),
            Readable::Stdin
        );
    }

    #[test]
    fn urls() {
        assert!(looks_like_url("https://example.com/a.json"));
        assert!(looks_like_url("//example.com"));
        assert!(!looks_like_url("a/b.json"));
        assert!(!looks_like_url("a b://x"));
        assert!(!looks_like_url("https://exa mple"));
    }
}
