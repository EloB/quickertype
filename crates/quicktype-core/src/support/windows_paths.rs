//! Port of `packages/quicktype-core/src/support/WindowsPaths.ts`.
//!
//! Windows absolute paths given as schema addresses are carried through the
//! address machinery as `file:` URIs (quicktype issue #2869): urijs would
//! otherwise parse the drive letter of `C:\dir\x.json` as a URI scheme.
//! [`fix_windows_path`] converts such paths before urijs sees them, and
//! [`file_path_from_file_uri`] converts `file:` URIs back to paths when they
//! are read from disk. Both are pure string functions and behave the same on
//! every platform.

/// `fixWindowsPath(pathOrURI)`: a drive-letter path (`C:\dir\x.json`,
/// `C:/dir/x.json`) becomes `file:///C:/dir/x.json`, a UNC path
/// (`\\server\share\x.json`) becomes `file://server/share/x.json`, with all
/// backslashes turned into slashes. Anything else is returned unchanged.
pub fn fix_windows_path(path_or_uri: &str) -> String {
    let bytes = path_or_uri.as_bytes();
    // `/^[A-Za-z]:[/\\]/`
    if bytes.len() >= 3
        && bytes[0].is_ascii_alphabetic()
        && bytes[1] == b':'
        && (bytes[2] == b'/' || bytes[2] == b'\\')
    {
        return format!("file:///{}", path_or_uri.replace('\\', "/"));
    }
    if path_or_uri.starts_with("\\\\") {
        return format!("file:{}", path_or_uri.replace('\\', "/"));
    }
    path_or_uri.to_owned()
}

/// `filePathFromFileURI(fileURI)`: the file path of a `file://` URI. A
/// drive-letter URI loses its leading slash (`file:///C:/x` → `C:/x`), a
/// UNC URI gets its host back as `//server/...`, and a POSIX URI keeps its
/// absolute path. No percent-decoding is done: addresses are already
/// decoded when they are normalized.
pub fn file_path_from_file_uri(file_uri: &str) -> String {
    let path = file_uri.get("file://".len()..).unwrap_or("");
    let bytes = path.as_bytes();
    // `/^\/[A-Za-z]:\//`
    if bytes.len() >= 4
        && bytes[0] == b'/'
        && bytes[1].is_ascii_alphabetic()
        && bytes[2] == b':'
        && bytes[3] == b'/'
    {
        return path[1..].to_owned();
    }
    if !path.starts_with('/') {
        return format!("//{path}");
    }
    path.to_owned()
}

#[cfg(test)]
mod tests {
    //! Port of `test/unit/windows-paths.test.ts`.

    use super::*;

    #[test]
    fn fix_windows_path_converts() {
        for (input, expected) in [
            (
                "C:\\Users\\me\\top.schema.json",
                "file:///C:/Users/me/top.schema.json",
            ),
            (
                "C:/Users/me/top.schema.json",
                "file:///C:/Users/me/top.schema.json",
            ),
            ("c:\\dir\\x.json", "file:///c:/dir/x.json"),
            ("Z:/x.json", "file:///Z:/x.json"),
            ("C:\\dir/sub\\x.json", "file:///C:/dir/sub/x.json"),
            ("C:\\My Dir\\x.json", "file:///C:/My Dir/x.json"),
            ("\\\\server\\share\\x.json", "file://server/share/x.json"),
            (
                "\\\\server\\share\\dir\\x.json",
                "file://server/share/dir/x.json",
            ),
        ] {
            assert_eq!(fix_windows_path(input), expected, "{input:?}");
        }
    }

    #[test]
    fn fix_windows_path_passes_through() {
        for input in [
            "/home/me/top.schema.json",
            "dir/top.schema.json",
            "./top.schema.json",
            "../top.schema.json",
            "top.schema.json",
            "",
            "http://example.com/x.schema.json",
            "https://example.com/x.schema.json",
            "file:///C:/dir/x.json",
            "file://server/share/x.json",
            "CC:\\x.json",
            "1:\\x.json",
            "C:",
            "C:x.json",
            "\\dir\\x.json",
        ] {
            assert_eq!(fix_windows_path(input), input, "{input:?}");
        }
    }

    #[test]
    fn file_path_from_file_uri_converts() {
        for (input, expected) in [
            ("file:///C:/dir/x.json", "C:/dir/x.json"),
            ("file:///c:/dir/x.json", "c:/dir/x.json"),
            ("file:///C:/My Dir/x.json", "C:/My Dir/x.json"),
            ("file://server/share/x.json", "//server/share/x.json"),
            ("file:///home/me/x.json", "/home/me/x.json"),
            ("file:///x.json", "/x.json"),
        ] {
            assert_eq!(file_path_from_file_uri(input), expected, "{input:?}");
        }
    }

    #[test]
    fn round_trip() {
        for (input, expected) in [
            (
                "C:\\Users\\me\\top.schema.json",
                "C:/Users/me/top.schema.json",
            ),
            ("C:/Users/me/top.schema.json", "C:/Users/me/top.schema.json"),
            ("\\\\server\\share\\x.json", "//server/share/x.json"),
        ] {
            assert_eq!(
                file_path_from_file_uri(&fix_windows_path(input)),
                expected,
                "{input:?}"
            );
        }
    }
}
