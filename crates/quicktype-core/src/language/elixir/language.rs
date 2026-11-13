//! Port of `packages/quicktype-core/src/language/Elixir/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{
    BooleanOption, OptionKind, RendererOption, RendererOptions, StringOption,
};
use crate::support::integer_range::IntegerRange;
use crate::target_language::{LanguageConfig, TargetLanguage};

/// TS `elixirOptions.justTypes`.
pub const JUST_TYPES: BooleanOption =
    BooleanOption::new("just-types", "Plain types only", false, OptionKind::Primary);

/// TS `elixirOptions.namespace`.
pub const NAMESPACE: StringOption = StringOption::new(
    "namespace",
    "Specify a module namespace",
    "NAME",
    "",
    OptionKind::Primary,
);

/// TS `elixirOptions`, in declaration order.
pub static ELIXIR_OPTIONS: &[RendererOption] = &[
    RendererOption::Boolean(JUST_TYPES),
    RendererOption::String(NAMESPACE),
];

/// TS `elixirLanguageConfig`.
pub const ELIXIR_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "Elixir",
    names: &["elixir"],
    extension: "ex",
};

/// The Elixir target language (TS `ElixirTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct ElixirTargetLanguage;

impl TargetLanguage for ElixirTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &ELIXIR_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        ELIXIR_OPTIONS
    }

    // Inference hooks.

    /// TS `getSupportedIntegerRange`: arbitrary-precision integers.
    fn get_supported_integer_range(
        &self,
        _renderer_options: &RendererOptions,
    ) -> Option<IntegerRange> {
        None
    }

    /// TS `supportsOptionalClassProperties`.
    fn supports_optional_class_properties(&self) -> bool {
        true
    }

    // End of inference hooks.

    // Renderer hooks.

    /// TS `defaultIndentation`.
    fn default_indentation(&self) -> &'static str {
        "  "
    }

    /// TS `makeRenderer`: an [`ElixirRenderer`](super::elixir_renderer::ElixirRenderer).
    fn render(
        &self,
        render_context: crate::renderer::RenderContext<'_>,
        renderer_options: &RendererOptions,
        given_output_filename: &str,
        alphabetize_properties: bool,
    ) -> crate::messages::Result<crate::renderer::RenderResult> {
        let options = super::elixir_renderer::ElixirOptions::parse(renderer_options)?;
        let renderer = super::elixir_renderer::ElixirRenderer::new(self, render_context, options);
        crate::convenience_renderer::render_with(
            renderer,
            given_output_filename,
            alphabetize_properties,
        )
    }
}
