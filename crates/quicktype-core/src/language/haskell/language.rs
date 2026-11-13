//! Port of `packages/quicktype-core/src/language/Haskell/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{
    BooleanOption, EnumOption, OptionKind, RendererOption, StringOption,
};
use crate::target_language::{LanguageConfig, TargetLanguage};

/// TS `haskellOptions.justTypes`.
pub const JUST_TYPES: BooleanOption =
    BooleanOption::new("just-types", "Plain types only", false, OptionKind::Primary);

/// TS `haskellOptions.useList`.
pub const USE_LIST: EnumOption = EnumOption::new(
    "array-type",
    "Use Array or List",
    &["array", "list"],
    "list",
    OptionKind::Primary,
);

/// TS `haskellOptions.moduleName`.
pub const MODULE_NAME: StringOption = StringOption::new(
    "module",
    "Generated module name",
    "NAME",
    "QuickType",
    OptionKind::Primary,
);

/// TS `haskellOptions`, in declaration order.
pub static HASKELL_OPTIONS: &[RendererOption] = &[
    RendererOption::Boolean(JUST_TYPES),
    RendererOption::Enum(USE_LIST),
    RendererOption::String(MODULE_NAME),
];

/// TS `haskellLanguageConfig`.
pub const HASKELL_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "Haskell",
    names: &["haskell"],
    extension: "haskell",
};

/// The Haskell target language (TS `HaskellTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct HaskellTargetLanguage;

impl TargetLanguage for HaskellTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &HASKELL_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        HASKELL_OPTIONS
    }

    // Inference hooks.

    /// TS `supportsOptionalClassProperties`.
    fn supports_optional_class_properties(&self) -> bool {
        true
    }

    /// TS `supportsUnionsWithBothNumberTypes`.
    fn supports_unions_with_both_number_types(&self) -> bool {
        true
    }

    // End of inference hooks.

    // Renderer hooks.

    fn render(
        &self,
        render_context: crate::renderer::RenderContext<'_>,
        renderer_options: &crate::renderer_options::RendererOptions,
        given_output_filename: &str,
        alphabetize_properties: bool,
    ) -> crate::messages::Result<crate::renderer::RenderResult> {
        let options = super::haskell_renderer::HaskellOptions::parse(renderer_options)?;
        let renderer = super::haskell_renderer::HaskellRenderer::new(self, render_context, options);
        crate::convenience_renderer::render_with(
            renderer,
            given_output_filename,
            alphabetize_properties,
        )
    }
}
