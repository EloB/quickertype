//! Port of `packages/quicktype-core/src/language/Pike/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{RendererOption, RendererOptions};
use crate::support::integer_range::IntegerRange;
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

impl TargetLanguage for PikeTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &PIKE_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        PIKE_OPTIONS
    }

    // Inference hooks.

    /// TS `getSupportedIntegerRange`: arbitrary-precision integers.
    fn get_supported_integer_range(
        &self,
        _renderer_options: &RendererOptions,
    ) -> Option<IntegerRange> {
        None
    }

    // End of inference hooks.

    // Renderer hooks.

    fn render(
        &self,
        render_context: crate::renderer::RenderContext<'_>,
        _renderer_options: &RendererOptions,
        given_output_filename: &str,
        alphabetize_properties: bool,
    ) -> crate::messages::Result<crate::renderer::RenderResult> {
        let renderer = super::pike_renderer::PikeRenderer::new(self, render_context);
        crate::convenience_renderer::render_with(
            renderer,
            given_output_filename,
            alphabetize_properties,
        )
    }
}
