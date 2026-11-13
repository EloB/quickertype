//! Node's `path.posix` (Node 24.16, `lib/path.js`): the `path` module that
//! quicktype's CLI and `NodeIO` get when Node runs on macOS or Linux. Only
//! `/` separates components and an absolute path starts with `/`.
//!
//! Only the functions quicktype calls are ported: `isAbsolute`, `dirname`,
//! `basename` (without a suffix), `extname`, `normalize` and `join`, with
//! the same signatures as [`path_win32`](crate::path_win32)'s. All indices
//! are byte offsets; the algorithms compare only `/` and `.`, so they find
//! the same positions as Node's UTF-16 indices. `tests/path.rs` replays
//! vectors recorded from Node (`xtask/js-compat/gen-path-vectors.mjs`).

/// `path.posix.isAbsolute(path)`.
pub fn is_absolute(path: &str) -> bool {
    path.starts_with('/')
}

/// `path.posix.basename(path)` (no suffix).
pub fn basename(path: &str) -> &str {
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

/// `path.posix.extname(path)`: the extension including the dot, or `""`
/// (also for dot files like `.ts`).
pub fn extname(path: &str) -> &str {
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

/// `path.posix.dirname(path)`.
pub fn dirname(path: &str) -> &str {
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

/// `normalizeString(path, allowAboveRoot, "/", isPosixPathSeparator)`:
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

/// `path.posix.normalize(path)`.
pub fn normalize(path: &str) -> String {
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

/// `path.posix.join(...paths)`.
pub fn join(paths: &[&str]) -> String {
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
    fn basics() {
        assert!(is_absolute("/a"));
        assert!(!is_absolute("C:\\a"));
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
        assert_eq!(join(&["dir", "x.json"]), "dir/x.json");
        assert_eq!(join(&["dir/", "x.json"]), "dir/x.json");
        assert_eq!(join(&["./dir//sub/", "../x"]), "dir/x");
        assert_eq!(join(&[".", "x.ts"]), "x.ts");
        assert_eq!(join(&["/a/b", "../../../c"]), "/c");
        assert_eq!(join(&["..", "a"]), "../a");
        assert_eq!(join(&["a/b/..", "..", ".."]), "..");
        assert_eq!(join(&["", ""]), ".");
        assert_eq!(join(&["a", "b/"]), "a/b/");
        assert_eq!(normalize("./"), "./");
        assert_eq!(normalize("abc/../../x"), "../x");
    }
}
