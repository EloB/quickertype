//! Node's `path` module: [`path_win32`](crate::path_win32) when compiled
//! for Windows, [`path_posix`](crate::path_posix) everywhere else, as
//! `require("path")` is `path.win32` or `path.posix` by the platform Node
//! runs on. quicktype's CLI and `NodeIO` use `path`, so their file names
//! follow the platform; code that needs one flavor on every platform uses
//! that module directly.

#[cfg(windows)]
pub use crate::path_win32::{basename, dirname, extname, is_absolute, join, normalize};

#[cfg(not(windows))]
pub use crate::path_posix::{basename, dirname, extname, is_absolute, join, normalize};

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn is_the_platforms_path() {
        if cfg!(windows) {
            assert!(is_absolute("C:\\a"));
            assert_eq!(basename("C:\\a/b\\Foo.ts"), "Foo.ts");
            assert_eq!(extname("C:\\a\\Foo.bar.ts"), ".ts");
            assert_eq!(dirname("C:\\a\\b.ts"), "C:\\a");
            assert_eq!(join(&["dir", "x.json"]), "dir\\x.json");
            assert_eq!(normalize("a/b/../c"), "a\\c");
        } else {
            assert!(!is_absolute("C:\\a"));
            assert_eq!(basename("C:\\a/b\\Foo.ts"), "b\\Foo.ts");
            assert_eq!(extname("C:\\a\\Foo.bar.ts"), ".ts");
            assert_eq!(dirname("C:\\a\\b.ts"), ".");
            assert_eq!(join(&["dir", "x.json"]), "dir/x.json");
            assert_eq!(normalize("a/b/../c"), "a/c");
        }
    }
}
