//! JavaScript string and `node:path` semantics the CLI front end depends on.
//!
//! Lengths, padding and wrapping in the help output count UTF-16 code units,
//! whitespace follows the JS definition (`\s`, `trim()`), and file names go
//! through Node's POSIX `path.basename`/`path.extname`.
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

/// JS `haystack.replace(pattern, replacement)` for a string `pattern`: only
/// the first occurrence is replaced, and `$$`, `$&`, `` $` `` and `$'` in
/// `replacement` are expanded (there are no capture groups).
pub fn replace_first(haystack: &str, pattern: &str, replacement: &str) -> String {
    let Some(start) = haystack.find(pattern) else {
        return haystack.to_owned();
    };
    let end = start + pattern.len();
    let mut expanded = String::with_capacity(replacement.len());
    let mut chars = replacement.chars().peekable();
    while let Some(c) = chars.next() {
        if c != '$' {
            expanded.push(c);
            continue;
        }
        match chars.peek() {
            Some('$') => expanded.push('$'),
            Some('&') => expanded.push_str(pattern),
            Some('`') => expanded.push_str(&haystack[..start]),
            Some('\'') => expanded.push_str(&haystack[end..]),
            _ => {
                expanded.push('$');
                continue;
            }
        }
        chars.next();
    }
    format!("{}{expanded}{}", &haystack[..start], &haystack[end..])
}

/// Node's POSIX `path.basename(path)`.
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

/// Node's POSIX `path.extname(path)`: the extension including the dot, or
/// `""` (also for dot files like `.ts`).
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

    #[test]
    fn replace_first_expands_dollar_patterns() {
        assert_eq!(replace_first("a ${x} b", "${x}", "y"), "a y b");
        assert_eq!(replace_first("a ${x} b", "${x}", "$&"), "a ${x} b");
        assert_eq!(replace_first("a ${x} b", "${x}", "$$"), "a $ b");
        assert_eq!(replace_first("a ${x} b", "${x}", "$`|$'"), "a a | b b");
        assert_eq!(replace_first("a ${x} b", "${x}", "$1$"), "a $1$ b");
        assert_eq!(replace_first("${x}${x}", "${x}", "1"), "1${x}");
    }

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
    }
}
