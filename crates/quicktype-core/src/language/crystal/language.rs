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
///
/// `getSupportedIntegerRange` is the default `INT64_RANGE`: the renderer
/// emits `Int64` for inferred integers.
#[derive(Clone, Copy, Debug, Default)]
pub struct CrystalTargetLanguage;

impl TargetLanguage for CrystalTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &CRYSTAL_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        &[]
    }

    // Renderer hooks.

    fn default_indentation(&self) -> &'static str {
        "  "
    }

    fn render(
        &self,
        render_context: crate::renderer::RenderContext<'_>,
        _renderer_options: &crate::renderer_options::RendererOptions,
        given_output_filename: &str,
        alphabetize_properties: bool,
    ) -> crate::messages::Result<crate::renderer::RenderResult> {
        let renderer = super::crystal_renderer::CrystalRenderer::new(self, render_context);
        crate::convenience_renderer::render_with(
            renderer,
            given_output_filename,
            alphabetize_properties,
        )
    }
}
