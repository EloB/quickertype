//! Windows' verbatim paths (`\\?\C:\x`, `\\?\UNC\server\share\x`), which
//! Rust's standard library returns where Node returns plain ones:
//! `fs::canonicalize` always gives one, `fs::read_link` for an absolute
//! link target it cannot shorten. [`to_plain`] turns them back with the
//! standard library's own rule, for every caller that wants the path a
//! user would write.
//!
//! Code that reproduces what Node returns follows Node's rule instead,
//! which differs: libuv's `readlink` drops the NT prefix `\??\` of a link
//! target without that check (`node_link_target` in quicktype-core's
//! `input/io/node_io.rs`).

/// The plain form of the verbatim path `path` (`\\?\C:\x` → `C:\x`,
/// `\\?\UNC\server\share\x` → `\\server\share\x`) when Windows reads it as
/// the same path. This is the check `std::fs::read_link` makes before it
/// returns an absolute link target in plain form (`from_wide_to_user_path`
/// in Rust's `library/std/src/sys/args/windows.rs`, the same from Rust 1.88
/// to 1.99): `path` is shorter than `MAX_PATH` (259 UTF-16 code units and
/// the terminating NUL), and `GetFullPathNameW` (`std::path::absolute`)
/// leaves the plain form as it is. So the plain form has no `.` or `..`
/// component, no `/`, no repeated `\` and no trailing dot or space.
///
/// `None` for any other path, a lowercase `\\?\unc\` included, and on every
/// platform but Windows.
pub fn to_plain(path: &str) -> Option<String> {
    if !cfg!(windows) {
        return None;
    }
    let plain = if let Some(unc) = path.strip_prefix(r"\\?\UNC\") {
        format!(r"\\{unc}")
    } else {
        // `\\?\`, one UTF-16 code unit (a drive letter), `:\`.
        let rest = path.strip_prefix(r"\\?\")?;
        let mut chars = rest.chars();
        if chars.next()?.len_utf16() != 1 || !chars.as_str().starts_with(r":\") {
            return None;
        }
        rest.to_owned()
    };
    if path.encode_utf16().count() + 1 > 260 {
        return None;
    }
    let full = std::path::absolute(&plain).ok()?;
    (full.as_os_str() == plain.as_str()).then_some(plain)
}

#[cfg(test)]
mod tests {
    use super::to_plain;

    #[cfg(windows)]
    #[test]
    fn plain_when_windows_reads_it_the_same() {
        assert_eq!(
            to_plain(r"\\?\C:\x\a.json").as_deref(),
            Some(r"C:\x\a.json")
        );
        assert_eq!(to_plain(r"\\?\C:\").as_deref(), Some(r"C:\"));
        assert_eq!(
            to_plain(r"\\?\UNC\server\share\x").as_deref(),
            Some(r"\\server\share\x")
        );
        for kept in [
            r"\\?\C:\a\..\b",
            r"\\?\C:\a\.\b",
            r"\\?\C:\a\\b",
            r"\\?\C:\a/b",
            r"\\?\C:\a.",
            r"\\?\C:\a ",
            r"\\?\C:",
            r"\\?\C:/x",
            r"\\?\unc\server\share\x",
            r"\\?\Volume{00000000-0000-0000-0000-000000000000}\x",
            r"\\?\GLOBALROOT\Device\x",
            r"C:\x",
            r"\\server\share\x",
            r"x\y",
        ] {
            assert_eq!(to_plain(kept), None, "{kept:?}");
        }
        let long = format!(r"\\?\C:\{}", "a".repeat(252));
        assert_eq!(long.len(), 259);
        assert_eq!(to_plain(&long).as_deref(), Some(&long[4..]));
        let too_long = format!(r"\\?\C:\{}", "a".repeat(253));
        assert_eq!(to_plain(&too_long), None);
    }

    #[cfg(not(windows))]
    #[test]
    fn only_on_windows() {
        assert_eq!(to_plain(r"\\?\C:\x"), None);
        assert_eq!(to_plain(r"\\?\UNC\server\share\x"), None);
    }
}
