//! Port of `packages/quicktype-core/src/input/io/NodeIO.ts`.
//!
//! [`read_from_file_or_url`] reads a schema (or any input) from a file, a
//! `file://` URI, stdin (`-`) or an HTTP(S) URL, with NodeIO's decisions and
//! error messages. The platform services it needs (the file system, stdin,
//! `fetch`) are behind the [`Io`] trait so that each front end can supply
//! its own:
//!
//! - [`StdIo`] (cargo feature `fs`, on by default) uses `std::fs` and stdin,
//!   and with the `http` feature fetches URLs with `ureq` (rustls). The
//!   native CLI and Rust programs use it.
//! - The WebAssembly build implements [`Io`] with the JavaScript host's
//!   `fs` and `fetch`.
//!
//! Errors are reported as Node formats them, because quicktype puts
//! `exceptionToString(e)` into its messages: `Error: ENOENT: no such file or
//! directory, lstat 'x.json'`, `TypeError: fetch failed`,
//! `Error: HTTP 404 Not Found`.

use indexmap::IndexMap;
use quicktype_js_compat::json::insert_js_property;
use quicktype_js_compat::whitespace;

use crate::input::io::LocalBoxFuture;
use crate::messages::{ErrorKind, QuickTypeError, Result, message_error};
use crate::support::windows_paths::file_path_from_file_uri;

/// An HTTP response, as much of it as NodeIO looks at.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct HttpResponse {
    /// `response.status`.
    pub status: u16,
    /// `response.statusText`: the reason phrase the server sent.
    pub status_text: String,
    /// The body bytes.
    pub body: Vec<u8>,
}

/// A JavaScript exception from a platform service, carried as its
/// `toString()` (`Error: ENOENT: …`, `TypeError: fetch failed`), which is
/// what quicktype's messages quote.
pub type IoError = String;

/// The platform services NodeIO uses: Node's `fs`, `process.stdin` and the
/// global `fetch`. Implementations report failures with Node's error text
/// ([`IoError`]).
pub trait Io {
    /// `fs.lstatSync(path).isSymbolicLink()`.
    fn is_symbolic_link(&self, path: &str) -> std::result::Result<bool, IoError>;

    /// `fs.readlinkSync(path)`.
    fn read_link(&self, path: &str) -> std::result::Result<String, IoError>;

    /// `fs.existsSync(path)`.
    fn exists(&self, path: &str) -> bool;

    /// The whole file as UTF-8 text, invalid sequences replaced
    /// (`fs.createReadStream(path, "utf8")` read to the end).
    fn read_file<'a>(
        &'a self,
        path: &'a str,
    ) -> LocalBoxFuture<'a, std::result::Result<String, IoError>>;

    /// All of standard input as UTF-8 text, invalid sequences replaced.
    fn read_stdin(&self) -> LocalBoxFuture<'_, std::result::Result<String, IoError>>;

    /// `fetch(url, { headers })`, following redirects. An error is a
    /// network failure (Node: `TypeError: fetch failed`); any HTTP status is
    /// a response.
    fn fetch<'a>(
        &'a self,
        url: &'a str,
        headers: &'a [(String, String)],
    ) -> LocalBoxFuture<'a, std::result::Result<HttpResponse, IoError>>;

    /// `isNode` (`browser-or-node`): whether files and stdin exist at all.
    /// Without them, everything but URLs is "Input file … does not exist".
    fn is_node(&self) -> bool {
        true
    }
}

/// is-url 1.2.4: `/^(?:\w+:)?\/\/(\S+)$/`, then the part after `//` must be
/// `localhost[:?\d]*` (optionally followed by a non-`:?\d` and anything
/// non-space) or `[^\s.]+\.\S{2,}`. `\w` is ASCII, `\s`/`\S` are
/// JavaScript whitespace.
pub fn is_url(s: &str) -> bool {
    let non_space = |c: char| !whitespace::is_whitespace(c);
    let after_protocol = match s.find("//") {
        Some(0) => &s[2..],
        Some(i) => {
            let (protocol, colon) = s[..i].split_at(i - 1);
            if colon != ":"
                || protocol.is_empty()
                || !protocol
                    .bytes()
                    .all(|b| b.is_ascii_alphanumeric() || b == b'_')
            {
                return false;
            }
            &s[i + 2..]
        }
        None => return false,
    };
    if after_protocol.is_empty() || !after_protocol.chars().all(non_space) {
        return false;
    }
    // `/^localhost[\:?\d]*(?:[^\:?\d]\S*)?$/` matches every non-space
    // string that starts with `localhost`.
    if after_protocol.starts_with("localhost") {
        return true;
    }
    // `/^[^\s\.]+\.\S{2,}$/`: non-dots up to the first dot, then at least
    // two UTF-16 code units.
    match after_protocol.find('.') {
        Some(dot) if dot > 0 => after_protocol[dot + 1..].encode_utf16().count() >= 2,
        _ => false,
    }
}

/// `parseHeaders(httpHeaders)`: `name: value` strings into an object (JS
/// property order; a later header with the same name wins). A non-empty
/// header without a `:` is an internal error.
fn parse_headers(http_headers: &[String]) -> Result<Vec<(String, String)>> {
    let mut result: IndexMap<String, String> = IndexMap::new();
    for header in http_headers {
        if header.is_empty() {
            continue;
        }
        let Some(split) = header.find(':') else {
            return crate::support::support::panic(format!(
                "Could not parse HTTP header \"{header}\"."
            ));
        };
        let key = whitespace::trim(&header[..split]).to_owned();
        let value = whitespace::trim(&header[split + 1..]).to_owned();
        if key == "__proto__" {
            // Assigning `result["__proto__"]` sets the prototype instead.
            continue;
        }
        insert_js_property(&mut result, key, value);
    }
    Ok(result.into_iter().collect())
}

/// `exceptionToString(e)` of a `QuickTypeError`: `Error: <message>`.
fn quicktype_error_to_string(e: &QuickTypeError) -> String {
    format!("Error: {}", e.user_message())
}

fn misc_read_error<T>(file_or_url: &str, message: String) -> Result<T> {
    message_error(
        ErrorKind::MiscReadError,
        vec![
            ("fileOrURL", file_or_url.into()),
            ("message", message.into()),
        ],
    )
}

/// Node's `path.dirname` (POSIX).
fn posix_dirname(path: &str) -> String {
    if path.is_empty() {
        return ".".to_owned();
    }
    let has_root = path.starts_with('/');
    let trimmed = path.trim_end_matches('/');
    if trimmed.is_empty() {
        return "/".to_owned();
    }
    match trimmed.rfind('/') {
        None => ".".to_owned(),
        Some(i) => {
            let dir = trimmed[..i].trim_end_matches('/');
            if dir.is_empty() && has_root {
                "/".to_owned()
            } else {
                dir.to_owned()
            }
        }
    }
}

/// Node's `path.join(a, b)` (POSIX): joined with `/` and normalized.
fn posix_join(a: &str, b: &str) -> String {
    let joined = match (a.is_empty(), b.is_empty()) {
        (true, true) => return ".".to_owned(),
        (true, false) => b.to_owned(),
        (false, true) => a.to_owned(),
        (false, false) => format!("{a}/{b}"),
    };
    let absolute = joined.starts_with('/');
    let trailing = joined.ends_with('/');
    let mut parts: Vec<&str> = Vec::new();
    for segment in joined.split('/') {
        match segment {
            "" | "." => {}
            ".." => {
                if parts.last().is_some_and(|p| *p != "..") {
                    parts.pop();
                } else if !absolute {
                    parts.push("..");
                }
            }
            s => parts.push(s),
        }
    }
    let mut result = parts.join("/");
    if result.is_empty() && !absolute {
        result.push('.');
    }
    if trailing && !result.is_empty() {
        result.push('/');
    }
    if absolute {
        result.insert(0, '/');
    }
    result
}

/// `resolveSymbolicLink(filePath)`: the target of a symbolic link (one
/// level, relative targets resolved against the link's directory), or the
/// path itself.
fn resolve_symbolic_link(io: &dyn Io, file_path: &str) -> std::result::Result<String, IoError> {
    if !io.is_symbolic_link(file_path)? {
        return Ok(file_path.to_owned());
    }
    let link_path = io.read_link(file_path)?;
    if link_path.starts_with('/') {
        return Ok(link_path);
    }
    Ok(posix_join(&posix_dirname(file_path), &link_path))
}

/// Where `readableFromFileOrURL` found the data.
enum Source {
    Text(String),
    Stdin,
    File(String),
}

/// `readableFromFileOrURL(fileOrURL, httpHeaders)`.
async fn readable_from_file_or_url(
    io: &dyn Io,
    file_or_url: &str,
    http_headers: &[String],
) -> Result<Source> {
    let mut file_or_url = file_or_url.to_owned();
    let attempt: std::result::Result<Option<Source>, String> = async {
        if file_or_url.starts_with("file://") {
            file_or_url = file_path_from_file_uri(&file_or_url);
        } else if is_url(&file_or_url) {
            let headers = parse_headers(http_headers).map_err(|e| quicktype_error_to_string(&e))?;
            let response = io.fetch(&file_or_url, &headers).await?;
            if !(200..=299).contains(&response.status) {
                return Err(format!(
                    "Error: HTTP {} {}",
                    response.status, response.status_text
                ));
            }
            return Ok(Some(Source::Text(
                String::from_utf8_lossy(&response.body).into_owned(),
            )));
        }
        if io.is_node() {
            if file_or_url == "-" {
                return Ok(Some(Source::Stdin));
            }
            let file_path = resolve_symbolic_link(io, &file_or_url)?;
            if io.exists(&file_path) {
                return Ok(Some(Source::File(file_path)));
            }
        }
        Ok(None)
    }
    .await;
    match attempt {
        Ok(Some(source)) => Ok(source),
        Ok(None) => message_error(
            ErrorKind::DriverInputFileDoesNotExist,
            vec![("filename", file_or_url.into())],
        ),
        Err(message) => misc_read_error(&file_or_url, message),
    }
}

/// `readFromFileOrURL(fileOrURL, httpHeaders)`: the whole text of a file,
/// `file://` URI, URL, or stdin for `-`.
///
/// Errors: `MiscReadError` (`Cannot read from file or URL x: <Node error>`)
/// for failures, `DriverInputFileDoesNotExist` if the path does not exist
/// after symbolic links are resolved (a missing path itself fails `lstat`
/// first, with `ENOENT`).
pub async fn read_from_file_or_url(
    io: &dyn Io,
    file_or_url: &str,
    http_headers: &[String],
) -> Result<String> {
    let read = match readable_from_file_or_url(io, file_or_url, http_headers).await? {
        Source::Text(text) => return Ok(text),
        Source::Stdin => io.read_stdin().await,
        Source::File(path) => io.read_file(&path).await,
    };
    match read {
        Ok(text) => Ok(text),
        Err(message) => misc_read_error(file_or_url, message),
    }
}

/// [`Io`] on the standard library: files and stdin through `std`, URLs
/// through `ureq` with the `http` feature.
#[cfg(feature = "fs")]
#[derive(Clone, Copy, Debug, Default)]
pub struct StdIo;

#[cfg(feature = "fs")]
mod std_io {
    use std::io::Read;

    use super::{HttpResponse, Io, IoError, StdIo};
    use crate::input::io::LocalBoxFuture;

    /// Node's text for a failed file system call:
    /// `Error: ENOENT: no such file or directory, lstat 'x'`.
    fn node_error(e: &std::io::Error, syscall: &str, path: &str) -> IoError {
        let (code, description) = errno_text(e);
        format!("Error: {code}: {description}, {syscall} '{path}'")
    }

    /// libuv's error code and message for an I/O error.
    fn errno_text(e: &std::io::Error) -> (&'static str, &'static str) {
        use std::io::ErrorKind as K;
        match e.kind() {
            K::NotFound => return ("ENOENT", "no such file or directory"),
            K::PermissionDenied => {
                // EPERM is 1 on every POSIX system.
                if e.raw_os_error() == Some(1) {
                    return ("EPERM", "operation not permitted");
                }
                return ("EACCES", "permission denied");
            }
            K::IsADirectory => return ("EISDIR", "illegal operation on a directory"),
            K::NotADirectory => return ("ENOTDIR", "not a directory"),
            K::InvalidInput => return ("EINVAL", "invalid argument"),
            _ => {}
        }
        let (eloop, enametoolong) = if cfg!(target_os = "linux") {
            (40, 36)
        } else {
            (62, 63)
        };
        match e.raw_os_error() {
            Some(n) if n == eloop => ("ELOOP", "too many symbolic links encountered"),
            Some(n) if n == enametoolong => ("ENAMETOOLONG", "name too long"),
            Some(24) => ("EMFILE", "too many open files"),
            _ => ("UNKNOWN", "unknown error"),
        }
    }

    impl Io for StdIo {
        fn is_symbolic_link(&self, path: &str) -> Result<bool, IoError> {
            std::fs::symlink_metadata(path)
                .map(|m| m.file_type().is_symlink())
                .map_err(|e| node_error(&e, "lstat", path))
        }

        fn read_link(&self, path: &str) -> Result<String, IoError> {
            std::fs::read_link(path)
                .map(|p| p.to_string_lossy().into_owned())
                .map_err(|e| node_error(&e, "readlink", path))
        }

        fn exists(&self, path: &str) -> bool {
            std::path::Path::new(path).exists()
        }

        fn read_file<'a>(&'a self, path: &'a str) -> LocalBoxFuture<'a, Result<String, IoError>> {
            Box::pin(async move {
                // Node reads a directory as empty text (macOS, as recorded).
                if std::fs::metadata(path).is_ok_and(|m| m.is_dir()) {
                    return Ok(String::new());
                }
                std::fs::read(path)
                    .map(|bytes| String::from_utf8_lossy(&bytes).into_owned())
                    .map_err(|e| node_error(&e, "open", path))
            })
        }

        fn read_stdin(&self) -> LocalBoxFuture<'_, Result<String, IoError>> {
            Box::pin(async move {
                let mut bytes = Vec::new();
                std::io::stdin()
                    .read_to_end(&mut bytes)
                    .map_err(|e| format!("Error: {e}"))?;
                Ok(String::from_utf8_lossy(&bytes).into_owned())
            })
        }

        fn fetch<'a>(
            &'a self,
            url: &'a str,
            headers: &'a [(String, String)],
        ) -> LocalBoxFuture<'a, Result<HttpResponse, IoError>> {
            Box::pin(async move { http_get(url, headers) })
        }
    }

    #[cfg(feature = "http")]
    fn http_get(url: &str, headers: &[(String, String)]) -> Result<HttpResponse, IoError> {
        let mut request = ureq::get(url);
        for (name, value) in headers {
            request = request.set(name, value);
        }
        let response = match request.call() {
            Ok(response) => response,
            Err(ureq::Error::Status(_, response)) => response,
            // Node's fetch reports every network failure the same way.
            Err(ureq::Error::Transport(_)) => return Err("TypeError: fetch failed".to_owned()),
        };
        let status = response.status();
        let status_text = response.status_text().to_owned();
        let mut body = Vec::new();
        response
            .into_reader()
            .read_to_end(&mut body)
            .map_err(|_| "TypeError: terminated".to_owned())?;
        Ok(HttpResponse {
            status,
            status_text,
            body,
        })
    }

    #[cfg(not(feature = "http"))]
    fn http_get(_url: &str, _headers: &[(String, String)]) -> Result<HttpResponse, IoError> {
        Err("Error: fetching URLs needs the `http` feature of quicktype-core".to_owned())
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn url_detection_matches_is_url() {
        for (s, expected) in [
            ("http://example.com/x.json", true),
            ("https://raw.githubusercontent.com/a/b", true),
            ("//example.com/x", true),
            ("http://localhost", true),
            ("http://localhost:8080/x", true),
            ("http://127.0.0.1:1234/x.json", true),
            ("http://x", false),
            ("http://x.y", false),
            ("http://x.yz", true),
            ("ftp://a.bc", true),
            ("x.json", false),
            ("C:/x.json", false),
            ("http://exa mple.com", false),
            ("ht-tp://a.bc", false),
            // NodeIO checks for `file://` before asking is-url.
            ("file:///x.json", true),
            ("http://.ab", false),
            ("http://a.😀", true),
        ] {
            assert_eq!(is_url(s), expected, "{s:?}");
        }
    }

    #[test]
    fn posix_paths() {
        assert_eq!(posix_dirname("a/b/c.json"), "a/b");
        assert_eq!(posix_dirname("/c.json"), "/");
        assert_eq!(posix_dirname("c.json"), ".");
        assert_eq!(posix_join("a/b", "../c.json"), "a/c.json");
        assert_eq!(posix_join(".", "c.json"), "c.json");
        assert_eq!(posix_join("/a", "../../c"), "/c");
        assert_eq!(posix_join("a", "../.."), "..");
    }

    #[test]
    fn headers() {
        let parsed = parse_headers(&[
            "Authorization: Bearer x ".to_owned(),
            String::new(),
            "X-A:1".to_owned(),
            "x-a: 2".to_owned(),
            "X-A: 3".to_owned(),
        ])
        .unwrap();
        assert_eq!(
            parsed,
            vec![
                ("Authorization".to_owned(), "Bearer x".to_owned()),
                ("X-A".to_owned(), "3".to_owned()),
                ("x-a".to_owned(), "2".to_owned()),
            ]
        );
        assert_eq!(
            parse_headers(&["bad".to_owned()])
                .unwrap_err()
                .user_message(),
            "Internal error: Could not parse HTTP header \"bad\"."
        );
    }

    #[cfg(feature = "fs")]
    #[test]
    fn missing_and_symlinked_files() {
        let dir = std::env::temp_dir().join(format!("quicktype-node-io-{}", std::process::id()));
        std::fs::create_dir_all(&dir).unwrap();
        let file = dir.join("a.json");
        std::fs::write(&file, "{\"a\":1}").unwrap();
        let file_str = file.to_str().unwrap();
        let read = |p: &str| crate::input::io::block_on(read_from_file_or_url(&StdIo, p, &[]));
        assert_eq!(read(file_str).unwrap(), "{\"a\":1}");
        assert_eq!(read(&format!("file://{file_str}")).unwrap(), "{\"a\":1}");
        assert_eq!(
            read("nonexistent.json").unwrap_err().user_message(),
            "Cannot read from file or URL nonexistent.json: Error: ENOENT: no such file or directory, lstat 'nonexistent.json'"
        );
        #[cfg(unix)]
        {
            let link = dir.join("link.json");
            let dangling = dir.join("dangling.json");
            let _ = std::fs::remove_file(&link);
            let _ = std::fs::remove_file(&dangling);
            std::os::unix::fs::symlink("a.json", &link).unwrap();
            std::os::unix::fs::symlink("nowhere.json", &dangling).unwrap();
            assert_eq!(read(link.to_str().unwrap()).unwrap(), "{\"a\":1}");
            let dangling = dangling.to_str().unwrap();
            assert_eq!(
                read(dangling).unwrap_err().user_message(),
                format!("Input file {dangling} does not exist")
            );
        }
        assert_eq!(read(dir.to_str().unwrap()).unwrap(), "");
        let _ = std::fs::remove_dir_all(&dir);
    }
}
