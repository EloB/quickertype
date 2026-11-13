//! Port of `packages/quicktype-core/src/language/options.types.ts`.
//!
//! The TS file maps each language to the type of its options object
//! (`LanguageRawOptionMap`) and to the user-facing option record
//! (`LanguageOptionMap`, `RendererOptions<Lang>`). Here the raw option map is
//! a lookup and the user-facing record is the untyped [`RendererOptions`].

use crate::renderer_options::RendererOption;
pub use crate::renderer_options::RendererOptions;

use super::all::{ALL, language_named};

/// The renderer option declarations of the language called `name` (TS
/// `LanguageRawOptionMap[name]`), or `None` for an unknown name.
pub fn language_raw_options(name: &str) -> Option<&'static [RendererOption]> {
    language_named(name, &ALL).map(|language| language.options())
}
