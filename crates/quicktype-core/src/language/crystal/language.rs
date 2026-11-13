//! Port of `packages/quicktype-core/src/language/Crystal/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::RendererOption;
use crate::target_language::{LanguageConfig, TargetLanguage};

/// TS `crystalLanguageConfig`.
pub const CRYSTAL_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "Crystal",
    names: &["crystal", "cr", "crystallang"],
    extension: "cr",
};

/// The Crystal target language (TS `CrystalTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct CrystalTargetLanguage;

// TODO(renderer): port the hooks CrystalTargetLanguage overrides:
// - makeRenderer
// - defaultIndentation: "  "
// - getSupportedIntegerRange: INT64_RANGE (default)
impl TargetLanguage for CrystalTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &CRYSTAL_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        &[]
    }
}
