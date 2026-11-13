//! Node's `path.win32` (Node 24.16, `lib/path.js`): the `path` module that
//! quicktype's CLI and `NodeIO` get when Node runs on Windows. Both `/` and
//! `\` separate components, a drive letter (`C:`) or UNC root
//! (`\\server\share`) starts a path, and results use `\`.
//!
//! Only the functions quicktype calls are ported: `isAbsolute`, `dirname`,
//! `basename` (without a suffix), `extname`, `normalize` and `join`. All
//! indices are byte offsets; every character the algorithms compare is
//! ASCII, so they find the same positions as Node's UTF-16 indices.
//! `tests/path_win32.rs` replays vectors recorded from Node
//! (`xtask/js-compat/gen-path-win32-vectors.mjs`).

const RESERVED_NAMES: [&str; 28] = [
    "CON",
    "PRN",
    "AUX",
    "NUL",
    "COM1",
    "COM2",
    "COM3",
    "COM4",
    "COM5",
    "COM6",
    "COM7",
    "COM8",
    "COM9",
    "LPT1",
    "LPT2",
    "LPT3",
    "LPT4",
    "LPT5",
    "LPT6",
    "LPT7",
    "LPT8",
    "LPT9",
    "COM\u{b9}",
    "COM\u{b2}",
    "COM\u{b3}",
    "LPT\u{b9}",
    "LPT\u{b2}",
    "LPT\u{b3}",
];

fn is_sep(b: u8) -> bool {
    b == b'/' || b == b'\\'
}

fn is_device_root(b: u8) -> bool {
    b.is_ascii_alphabetic()
}

/// `isWindowsReservedName(path, colonIndex)`:
/// `WINDOWS_RESERVED_NAMES.includes(path.slice(0, colonIndex).toUpperCase())`.
/// A `colonIndex` of -1 (`None`) slices off the last UTF-16 code unit.
fn is_reserved_name(path: &str, colon_index: Option<usize>) -> bool {
    let device = match colon_index {
        Some(i) => &path[..i],
        None => match path.chars().next_back() {
            None => "",
            // Half a surrogate pair would remain: never a reserved name.
            Some(c) if c.len_utf16() == 2 => return false,
            Some(c) => &path[..path.len() - c.len_utf8()],
        },
    };
    let upper = device.to_uppercase();
    RESERVED_NAMES.contains(&upper.as_str())
}

/// `path.win32.isAbsolute(path)`.
pub fn is_absolute(path: &str) -> bool {
    let b = path.as_bytes();
    if b.is_empty() {
        return false;
    }
    is_sep(b[0]) || (b.len() > 2 && is_device_root(b[0]) && b[1] == b':' && is_sep(b[2]))
}

/// Matches `\\server\share` at the start of `b` (whose first two bytes are
/// separators): the index after the server, the index where the share
/// starts and the index after it, or `None` when there is no share.
fn unc_root(b: &[u8]) -> Option<(usize, usize, usize)> {
    let len = b.len();
    let mut j = 2;
    while j < len && !is_sep(b[j]) {
        j += 1;
    }
    if !(j < len && j != 2) {
        return None;
    }
    let server_end = j;
    while j < len && is_sep(b[j]) {
        j += 1;
    }
    if !(j < len && j != server_end) {
        return None;
    }
    let share_start = j;
    while j < len && !is_sep(b[j]) {
        j += 1;
    }
    Some((server_end, share_start, j))
}

/// `path.win32.dirname(path)`.
pub fn dirname(path: &str) -> &str {
    let b = path.as_bytes();
    let len = b.len();
    if len == 0 {
        return ".";
    }
    if len == 1 {
        return if is_sep(b[0]) { path } else { "." };
    }
    let mut root_end: Option<usize> = None;
    let mut offset = 0;
    if is_sep(b[0]) {
        root_end = Some(1);
        offset = 1;
        if is_sep(b[1])
            && let Some((_, share_start, j)) = unc_root(b)
        {
            if j == len {
                // A UNC root only.
                return path;
            }
            if j != share_start {
                root_end = Some(j + 1);
                offset = j + 1;
            }
        }
    } else if is_device_root(b[0]) && b[1] == b':' {
        let end = if len > 2 && is_sep(b[2]) { 3 } else { 2 };
        root_end = Some(end);
        offset = end;
    }

    let mut end = None;
    let mut matched_slash = true;
    for i in (offset..len).rev() {
        if is_sep(b[i]) {
            if !matched_slash {
                end = Some(i);
                break;
            }
        } else {
            matched_slash = false;
        }
    }
    match end.or(root_end) {
        None => ".",
        // `slice(0, rootEnd)` past the end is the whole path.
        Some(end) => &path[..end.min(len)],
    }
}

/// `path.win32.basename(path)` (no suffix).
pub fn basename(path: &str) -> &str {
    let b = path.as_bytes();
    let mut start = 0;
    if b.len() >= 2 && is_device_root(b[0]) && b[1] == b':' {
        start = 2;
    }
    let mut end = None;
    let mut matched_slash = true;
    for i in (start..b.len()).rev() {
        if is_sep(b[i]) {
            if !matched_slash {
                start = i + 1;
                break;
            }
        } else if end.is_none() {
            matched_slash = false;
            end = Some(i + 1);
        }
    }
    match end {
        None => "",
        Some(end) => &path[start..end],
    }
}

/// `path.win32.extname(path)`: the extension including the dot, or `""`.
pub fn extname(path: &str) -> &str {
    let b = path.as_bytes();
    let mut start = 0;
    let mut start_dot: Option<usize> = None;
    let mut start_part = 0;
    let mut end: Option<usize> = None;
    let mut matched_slash = true;
    // 0: nothing before the first dot yet; 1: a dot; -1: another character.
    let mut pre_dot_state = 0;
    if b.len() >= 2 && b[1] == b':' && is_device_root(b[0]) {
        start = 2;
        start_part = 2;
    }
    for i in (start..b.len()).rev() {
        let code = b[i];
        if is_sep(code) {
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
    let (Some(start_dot), Some(end)) = (start_dot, end) else {
        return "";
    };
    if pre_dot_state == 0
        || (pre_dot_state == 1 && start_dot == end - 1 && start_dot == start_part + 1)
    {
        return "";
    }
    &path[start_dot..end]
}

/// `normalizeString(path, allowAboveRoot, "\\", isPathSeparator)`: resolves
/// `.` and `..` and collapses separators, joining with `\`.
fn normalize_string(path: &str, allow_above_root: bool) -> String {
    let b = path.as_bytes();
    let mut res = String::new();
    let mut last_segment_length = 0usize;
    let mut last_slash: isize = -1;
    let mut dots = 0i32;
    let mut code = 0u8;
    for i in 0..=b.len() {
        if i < b.len() {
            code = b[i];
        } else if is_sep(code) {
            break;
        } else {
            code = b'/';
        }
        let i = i as isize;
        if is_sep(code) {
            if last_slash == i - 1 || dots == 1 {
                // Nothing to do.
            } else if dots == 2 {
                if res.len() < 2 || last_segment_length != 2 || !res.ends_with("..") {
                    if res.len() > 2 {
                        match res.rfind('\\') {
                            None => {
                                res.clear();
                                last_segment_length = 0;
                            }
                            Some(index) => {
                                res.truncate(index);
                                last_segment_length = match res.rfind('\\') {
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
                    res.push_str(if res.is_empty() { ".." } else { "\\.." });
                    last_segment_length = 2;
                }
            } else {
                let segment = &path[(last_slash + 1) as usize..i as usize];
                if !res.is_empty() {
                    res.push('\\');
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

/// `path.win32.normalize(path)`.
pub fn normalize(path: &str) -> String {
    let b = path.as_bytes();
    let len = b.len();
    if len == 0 {
        return ".".to_owned();
    }
    let mut root_end = 0;
    let mut device: Option<String> = None;
    let mut is_absolute = false;
    let code = b[0];
    if len == 1 {
        return if code == b'/' {
            "\\".to_owned()
        } else {
            path.to_owned()
        };
    }
    if is_sep(code) {
        is_absolute = true;
        if is_sep(b[1]) {
            if let Some((server_end, share_start, j)) = unc_root(b) {
                if j == len || j != share_start {
                    let first_part = &path[2..server_end];
                    if first_part == "." || first_part == "?" {
                        // A device root (`\\.\PHYSICALDRIVE0`, `\\?\C:\x`).
                        device = Some(format!("\\\\{first_part}"));
                        root_end = 4;
                        let possible = match path.find(':') {
                            Some(colon) if colon + 1 >= 4 => &path[4..colon + 1],
                            _ => "",
                        };
                        if is_reserved_name(possible, possible.len().checked_sub(1)) {
                            device = Some(format!("\\\\?\\{possible}"));
                            root_end = 4 + possible.len();
                        }
                    } else if j == len {
                        // A UNC root only.
                        return format!("\\\\{first_part}\\{}\\", &path[share_start..]);
                    } else {
                        device = Some(format!("\\\\{first_part}\\{}", &path[share_start..j]));
                        root_end = j;
                    }
                }
            }
        } else {
            root_end = 1;
        }
    } else if let Some(colon_index) = path.find(':').filter(|&i| i > 0) {
        if is_device_root(code) && colon_index == 1 {
            device = Some(path[..2].to_owned());
            root_end = 2;
            if len > 2 && is_sep(b[2]) {
                is_absolute = true;
                root_end = 3;
            }
        } else if is_reserved_name(path, Some(colon_index)) {
            device = Some(path[..colon_index + 1].to_owned());
            root_end = colon_index + 1;
        }
    }

    let mut tail = if root_end < len {
        normalize_string(&path[root_end..], !is_absolute)
    } else {
        String::new()
    };
    if tail.is_empty() && !is_absolute {
        tail.push('.');
    }
    if !tail.is_empty() && is_sep(b[len - 1]) {
        tail.push('\\');
    }
    if !is_absolute && device.is_none() && path.contains(':') {
        // CVE-2024-36139: a relative tail must not turn into a drive path.
        let t = tail.as_bytes();
        if t.len() >= 2 && is_device_root(t[0]) && t[1] == b':' {
            return format!(".\\{tail}");
        }
        for (index, _) in path.match_indices(':') {
            if index == len - 1 || is_sep(b[index + 1]) {
                return format!(".\\{tail}");
            }
        }
    }
    if is_reserved_name(path, path.find(':')) {
        return format!(".\\{}{tail}", device.as_deref().unwrap_or(""));
    }
    match device {
        None if is_absolute => format!("\\{tail}"),
        None => tail,
        Some(device) if is_absolute => format!("{device}\\{tail}"),
        Some(device) => format!("{device}{tail}"),
    }
}

/// `path.win32.join(...paths)`.
pub fn join(paths: &[&str]) -> String {
    let parts: Vec<&str> = paths.iter().copied().filter(|p| !p.is_empty()).collect();
    let Some(first_part) = parts.first().map(|p| p.as_bytes()) else {
        return ".".to_owned();
    };
    let mut joined = parts.join("\\");

    // A joined path must not start with two separators (normalize would take
    // it for a UNC root) unless the first part clearly is one.
    let mut needs_replace = true;
    let mut slash_count = 0;
    if is_sep(first_part[0]) {
        slash_count += 1;
        if first_part.len() > 1 && is_sep(first_part[1]) {
            slash_count += 1;
            if first_part.len() > 2 {
                if is_sep(first_part[2]) {
                    slash_count += 1;
                } else {
                    needs_replace = false;
                }
            }
        }
    }
    if needs_replace {
        let jb = joined.as_bytes();
        while slash_count < jb.len() && is_sep(jb[slash_count]) {
            slash_count += 1;
        }
        if slash_count >= 2 {
            joined = format!("\\{}", &joined[slash_count..]);
        }
    }

    // A component with a reserved device name (`CON:`) is not normalized.
    let has_reserved = joined
        .split('\\')
        .filter(|p| !p.is_empty())
        .any(|p| p.find(':').is_some_and(|i| is_reserved_name(p, Some(i))));
    if has_reserved {
        return joined.replace('/', "\\");
    }
    normalize(&joined)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn basics() {
        assert!(is_absolute("C:\\x"));
        assert!(is_absolute("\\x"));
        assert!(!is_absolute("C:x"));
        assert_eq!(basename("C:\\a/b\\c.json"), "c.json");
        assert_eq!(extname("C:\\a\\b.c.json"), ".json");
        assert_eq!(dirname("C:\\a\\b.json"), "C:\\a");
        assert_eq!(join(&["C:\\a", "..\\b/c.json"]), "C:\\b\\c.json");
        assert_eq!(normalize("//server/share/x/../y"), "\\\\server\\share\\y");
    }
}
