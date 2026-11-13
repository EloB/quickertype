//! Port of `packages/quicktype-core/src/language/Pike/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::RendererOption;
use crate::target_language::{LanguageConfig, TargetLanguage};

/// TS `pikeOptions`, in declaration order.
pub static PIKE_OPTIONS: &[RendererOption] = &[];

/// TS `pikeLanguageConfig`.
pub const PIKE_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "Pike",
    names: &["pike", "pikelang"],
    extension: "pmod",
};

/// The Pike target language (TS `PikeTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct PikeTargetLanguage;

// TODO(renderer): port the hooks PikeTargetLanguage overrides:
// - makeRenderer
// - getSupportedIntegerRange: null
impl TargetLanguage for PikeTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &PIKE_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        PIKE_OPTIONS
    }
}
