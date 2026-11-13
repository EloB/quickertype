//! JavaScript string and `node:path` semantics the CLI front end depends on.
//!
//! Lengths, padding and wrapping in the help output count UTF-16 code units,
//! whitespace follows the JS definition (`\s`, `trim()`), and file names go
//! through Node's `path` ([`quicktype_js_compat::path`]: `path.posix`, or
//! `path.win32` on Windows, as Node picks by platform).

pub use quicktype_js_compat::path::{basename, dirname, extname, join as path_join};

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
}
