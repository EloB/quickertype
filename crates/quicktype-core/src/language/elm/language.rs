//! Port of `packages/quicktype-core/src/language/Elm/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{
    BooleanOption, EnumOption, OptionKind, RendererOption, RendererOptions, StringOption,
};
use crate::support::integer_range::{IntegerRange, JS_SAFE_INTEGER_RANGE};
use crate::target_language::{LanguageConfig, TargetLanguage};

/// TS `elmOptions.justTypes`.
pub const JUST_TYPES: BooleanOption =
    BooleanOption::new("just-types", "Plain types only", false, OptionKind::Primary);

/// TS `elmOptions.useList`.
pub const USE_LIST: EnumOption = EnumOption::new(
    "array-type",
    "Use Array or List",
    &["array", "list"],
    "list",
    OptionKind::Primary,
);

/// TS `elmOptions.moduleName`.
pub const MODULE_NAME: StringOption = StringOption::new(
    "module",
    "Generated module name",
    "NAME",
    "QuickType",
    OptionKind::Primary,
);

/// TS `elmOptions`, in declaration order.
pub static ELM_OPTIONS: &[RendererOption] = &[
    RendererOption::Boolean(JUST_TYPES),
    RendererOption::Enum(USE_LIST),
    RendererOption::String(MODULE_NAME),
];

/// TS `elmLanguageConfig`.
pub const ELM_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "Elm",
    names: &["elm"],
    extension: "elm",
};

/// The Elm target language (TS `ElmTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct ElmTargetLanguage;

impl TargetLanguage for ElmTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &ELM_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        ELM_OPTIONS
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

    /// TS `getSupportedIntegerRange`: JavaScript numbers are exact within ±(2^53 − 1).
    fn get_supported_integer_range(
        &self,
        _renderer_options: &RendererOptions,
    ) -> Option<IntegerRange> {
        Some(JS_SAFE_INTEGER_RANGE.clone())
    }

    // End of inference hooks.

    // Renderer hooks.

    /// TS `makeRenderer`: an `ElmRenderer`.
    fn render(
        &self,
        render_context: crate::renderer::RenderContext<'_>,
        renderer_options: &RendererOptions,
        given_output_filename: &str,
        alphabetize_properties: bool,
    ) -> crate::messages::Result<crate::renderer::RenderResult> {
        let options = super::elm_renderer::ElmOptions::parse(renderer_options)?;
        let renderer = super::elm_renderer::ElmRenderer::new(self, render_context, options);
        crate::convenience_renderer::render_with(
            renderer,
            given_output_filename,
            alphabetize_properties,
        )
    }
}
