//! Port of `packages/quicktype-core/src/language/types.ts`.
//!
//! In TS, `LanguageName` and `LanguageDisplayName` are string-literal unions
//! derived from the registry, checked at compile time. Rust has no such
//! types; names stay `&str` and are validated against the registry at run
//! time with [`is_language_name`](super::all::is_language_name) and
//! [`is_language_display_name`](super::all::is_language_display_name).

/// A name or alias of a built-in target language, e.g. `"c++"` or `"ts"`
/// (TS `LanguageName`).
pub type LanguageName = &'static str;

/// The display name of a built-in target language, e.g. `"C++"` (TS
/// `LanguageDisplayName`).
pub type LanguageDisplayName = &'static str;
