//! JavaScript-exact helpers for the quicktype Rust port.
//!
//! quicktype is written in TypeScript, and much of its output depends on
//! JavaScript semantics that Rust does not share: UTF-16 string lengths and
//! ordering, `Number#toString`, V8's sort algorithm, `JSON.stringify`
//! escaping, JavaScript's whitespace, and the behaviour of a few npm
//! packages. Each module here reproduces one of those exactly and documents
//! the JavaScript behaviour it stands for; `docs/PARITY.md` says when to use
//! which.
//!
//! Every module is tested differentially: `xtask/js-compat/gen-vectors.mjs`
//! runs the JavaScript originals in Node and records test vectors under
//! `tests/vectors/`, which the integration tests replay without Node.
//! `verbatim_path` is the exception: it undoes what Rust's standard library
//! does to Windows paths (`\\?\`), with the standard library's own rule.

pub mod json;
pub mod number;
pub mod path;
pub mod path_posix;
pub mod path_win32;
pub mod pluralize;
pub mod sort;
pub mod unicode;
mod unicode_table;
pub mod uri;
pub mod utf16;
pub mod utf8;
pub mod verbatim_path;
pub mod whitespace;
pub mod wordwrap;
pub mod yaml;
