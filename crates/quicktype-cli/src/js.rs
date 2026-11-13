//! JavaScript string and `node:path` semantics the CLI front end depends on.
//!
//! Lengths, padding and wrapping in the help output count UTF-16 code units,
//! whitespace follows the JS definition (`\s`, `trim()`), and file names go
//! through Node's `path` ([`quicktype_js_compat::path`]: `path.posix`, or
//! `path.win32` on Windows, as Node picks by platform). What other crates
//! need too comes from `quicktype-js-compat`, re-exported here.

pub use quicktype_js_compat::path::{basename, dirname, extname, join as path_join};
pub use quicktype_js_compat::utf16::len;
pub use quicktype_js_compat::whitespace::{is_line_terminator, is_whitespace, trim};

/// JS `\w` without the `u` flag: `[A-Za-z0-9_]`.
pub fn is_word_char(c: char) -> bool {
    c.is_ascii_alphanumeric() || c == '_'
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
    fn pad_end_counts_utf16_units() {
        assert_eq!(pad_end("😀", 4), "😀  ");
    }
}
