//! JavaScript string and `node:path` semantics the CLI front end depends on.
//!
//! Lengths, padding and wrapping in the help output count UTF-16 code units,
//! whitespace follows the JS definition (`\s`, `trim()`), and file names go
//! through Node's `path`: POSIX semantics, or `path.win32`'s on Windows
//! ([`quicktype_js_compat::path_win32`]), as Node picks by platform.

use quicktype_js_compat::path_win32;

// TODO(js_compat): switch to the shared js_compat helpers once they land in
// quicktype-core's support module.

/// JS `WhiteSpace` and `LineTerminator` (what `\s` and `trim()` match).
pub fn is_whitespace(c: char) -> bool {
    matches!(
        c,
        '\t' | '\n' | '\u{0B}' | '\u{0C}' | '\r' | ' ' | '\u{A0}' | '\u{1680}' | '\u{2000}'
            ..='\u{200A}'
                | '\u{2028}'
                | '\u{2029}'
                | '\u{202F}'
                | '\u{205F}'
                | '\u{3000}'
                | '\u{FEFF}'
    )
}

/// JS line terminators (what `.` does not match).
pub fn is_line_terminator(c: char) -> bool {
    matches!(c, '\n' | '\r' | '\u{2028}' | '\u{2029}')
}

/// JS `\w` without the `u` flag: `[A-Za-z0-9_]`.
pub fn is_word_char(c: char) -> bool {
    c.is_ascii_alphanumeric() || c == '_'
}

/// JS `String.prototype.trim`.
pub fn trim(s: &str) -> &str {
    s.trim_matches(is_whitespace)
}

/// JS `.length`: the number of UTF-16 code units.
pub fn len(s: &str) -> usize {
    s.chars().map(char::len_utf16).sum()
}

/// JS `String.prototype.padEnd(width)` with spaces, counting UTF-16 units.
pub fn pad_end(s: &str, width: usize) -> String {
    let mut out = s.to_owned();
    for _ in len(s)..width {
        out.push(' ');
    }
    out
}

/// Node's `path.basename(path)`.
pub fn basename(path: &str) -> &str {
    if cfg!(windows) {
        return path_win32::basename(path);
    }
    let bytes = path.as_bytes();
    let mut start = 0;
    let mut end = None;
    let mut matched_slash = true;
    for i in (0..bytes.len()).rev() {
        if bytes[i] == b'/' {
            if !matched_slash {
                start = i + 1;
                break;
            }
        } else if end.is_none() {
            matched_slash = false;
            end = Some(i + 1);
        }
    }
    end.map_or("", |end| &path[start..end])
}

/// Node's `path.extname(path)`: the extension including the dot, or `""`
/// (also for dot files like `.ts`).
pub fn extname(path: &str) -> &str {
    if cfg!(windows) {
        return path_win32::extname(path);
    }
    let bytes = path.as_bytes();
    let mut start_dot: Option<usize> = None;
    let mut start_part = 0;
    let mut end: Option<usize> = None;
    let mut matched_slash = true;
    // 0: no dot seen after a non-dot; 1: a dot run; -1: a non-dot before the last dot.
    let mut pre_dot_state = 0;
    for i in (0..bytes.len()).rev() {
        let code = bytes[i];
        if code == b'/' {
            if !matched_slash {
                start_part = i + 1;
                break;
            }
            continue;
        }
        if end.is_none() {
            matched_slash = false;
            end = Some(i + 1);
        }
        if code == b'.' {
            if start_dot.is_none() {
                start_dot = Some(i);
            } else if pre_dot_state != 1 {
                pre_dot_state = 1;
            }
        } else if start_dot.is_some() {
            pre_dot_state = -1;
        }
    }
    match (start_dot, end) {
        (Some(dot), Some(end))
            if pre_dot_state != 0
                && !(pre_dot_state == 1 && dot == end - 1 && dot == start_part + 1) =>
        {
            &path[dot..end]
        }
        _ => "",
    }
}

/// Node's `path.dirname(path)`.
pub fn dirname(path: &str) -> &str {
    if cfg!(windows) {
        return path_win32::dirname(path);
    }
    let bytes = path.as_bytes();
    if bytes.is_empty() {
        return ".";
    }
    let has_root = bytes[0] == b'/';
    let mut end = None;
    let mut matched_slash = true;
    for i in (1..bytes.len()).rev() {
        if bytes[i] == b'/' {
            if !matched_slash {
                end = Some(i);
                break;
            }
        } else {
            matched_slash = false;
        }
    }
    match end {
        None if has_root => "/",
        None => ".",
        Some(1) if has_root => "//",
        Some(end) => &path[..end],
    }
}

/// Node's `normalizeString(path, allowAboveRoot)` for POSIX separators:
/// resolves `.` and `..` segments and collapses repeated slashes.
fn normalize_string(path: &str, allow_above_root: bool) -> String {
    let bytes = path.as_bytes();
    let mut res = String::new();
    let mut last_segment_length = 0;
    let mut last_slash: isize = -1;
    let mut dots = 0;
    let mut code = 0u8;
    for i in 0..=bytes.len() {
        if i < bytes.len() {
            code = bytes[i];
        } else if code == b'/' {
            break;
        } else {
            code = b'/';
        }
        let i = i as isize;
        if code == b'/' {
            if last_slash == i - 1 || dots == 1 {
                // Nothing to do.
            } else if dots == 2 {
                if res.len() < 2 || last_segment_length != 2 || !res.ends_with("..") {
                    if res.len() > 2 {
                        match res.rfind('/') {
                            None => {
                                res.clear();
                                last_segment_length = 0;
                            }
                            Some(index) => {
                                res.truncate(index);
                                // `res.length - 1 - res.lastIndexOf("/")`
                                last_segment_length = match res.rfind('/') {
                                    Some(j) => res.len() - 1 - j,
                                    None => res.len(),
                                };
                            }
                        }
                        last_slash = i;
                        dots = 0;
                        continue;
                    } else if !res.is_empty() {
                        res.clear();
                        last_segment_length = 0;
                        last_slash = i;
                        dots = 0;
                        continue;
                    }
                }
                if allow_above_root {
                    res.push_str(if res.is_empty() { ".." } else { "/.." });
                    last_segment_length = 2;
                }
            } else {
                let segment = &path[(last_slash + 1) as usize..i as usize];
                if !res.is_empty() {
                    res.push('/');
                }
                res.push_str(segment);
                last_segment_length = (i - last_slash - 1) as usize;
            }
            last_slash = i;
            dots = 0;
        } else if code == b'.' && dots != -1 {
            dots += 1;
        } else {
            dots = -1;
        }
    }
    res
}

/// Node's `path.normalize(path)`.
pub fn normalize(path: &str) -> String {
    if cfg!(windows) {
        return path_win32::normalize(path);
    }
    if path.is_empty() {
        return ".".to_owned();
    }
    let is_absolute = path.starts_with('/');
    let trailing_separator = path.ends_with('/');
    let mut normalized = normalize_string(path, !is_absolute);
    if normalized.is_empty() {
        if is_absolute {
            return "/".to_owned();
        }
        return if trailing_separator { "./" } else { "." }.to_owned();
    }
    if trailing_separator {
        normalized.push('/');
    }
    if is_absolute {
        format!("/{normalized}")
    } else {
        normalized
    }
}

/// Node's `path.join(...paths)`.
pub fn path_join(paths: &[&str]) -> String {
    if cfg!(windows) {
        return path_win32::join(paths);
    }
    let joined: Vec<&str> = paths.iter().copied().filter(|p| !p.is_empty()).collect();
    if joined.is_empty() {
        return ".".to_owned();
    }
    normalize(&joined.join("/"))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn whitespace_and_trim() {
        assert_eq!(trim("\u{FEFF} a \u{3000}"), "a");
        assert!(!is_whitespace('\u{85}'));
        assert_eq!(len("a😀"), 3);
        assert_eq!(pad_end("😀", 4), "😀  ");
    }

    /// Node's POSIX `path`; on Windows Node (and so the CLI) uses
    /// `path.win32`, which `quicktype_js_compat::path_win32` tests against
    /// Node on every platform.
    #[cfg(not(windows))]
    #[test]
    fn node_paths() {
        assert_eq!(basename("a/b/Foo.ts"), "Foo.ts");
        assert_eq!(basename("a/b/"), "b");
        assert_eq!(basename("/"), "");
        assert_eq!(extname("Foo.bar.ts"), ".ts");
        assert_eq!(extname("foo"), "");
        assert_eq!(extname(".ts"), "");
        assert_eq!(extname("foo."), ".");
        assert_eq!(extname("a/.b.c"), ".c");
        assert_eq!(extname("..."), ".");
        assert_eq!(extname(".."), "");
        assert_eq!(extname("dir.x/foo"), "");
        assert_eq!(dirname("a/b/c.ts"), "a/b");
        assert_eq!(dirname("c.ts"), ".");
        assert_eq!(dirname("/c.ts"), "/");
        assert_eq!(dirname("//c"), "//");
        assert_eq!(dirname("a/b/"), "a");
        assert_eq!(path_join(&["dir", "x.json"]), "dir/x.json");
        assert_eq!(path_join(&["dir/", "x.json"]), "dir/x.json");
        assert_eq!(path_join(&["./dir//sub/", "../x"]), "dir/x");
        assert_eq!(path_join(&[".", "x.ts"]), "x.ts");
        assert_eq!(path_join(&["/a/b", "../../../c"]), "/c");
        assert_eq!(path_join(&["..", "a"]), "../a");
        assert_eq!(path_join(&["a/b/..", "..", ".."]), "..");
        assert_eq!(path_join(&["", ""]), ".");
        assert_eq!(path_join(&["a", "b/"]), "a/b/");
        assert_eq!(normalize("./"), "./");
        assert_eq!(normalize("abc/../../x"), "../x");
    }

    #[cfg(windows)]
    #[test]
    fn node_paths_on_windows() {
        assert_eq!(basename("C:\\a/b\\Foo.ts"), "Foo.ts");
        assert_eq!(extname("C:\\a\\Foo.bar.ts"), ".ts");
        assert_eq!(dirname("C:\\a\\b.ts"), "C:\\a");
        assert_eq!(path_join(&["dir", "x.json"]), "dir\\x.json");
        assert_eq!(normalize("a/b/../c"), "a\\c");
    }
}
