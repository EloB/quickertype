//! Port of `packages/quicktype-core/src/language/JavaScriptPropTypes/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{EnumOption, OptionKind, RendererOption, RendererOptions};
use crate::support::acronyms::acronym_option;
use crate::support::converters::converters_option;
use crate::support::integer_range::{IntegerRange, JS_SAFE_INTEGER_RANGE};
use crate::target_language::{LanguageConfig, TargetLanguage};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_builder_utils::StringTypeMapping;

/// TS `javaScriptPropTypesOptions.acronymStyle`.
pub const ACRONYM_STYLE: EnumOption = acronym_option("pascal");

/// TS `javaScriptPropTypesOptions.converters`.
pub const CONVERTERS: EnumOption = converters_option();

/// TS `javaScriptPropTypesOptions.moduleSystem`.
pub const MODULE_SYSTEM: EnumOption = EnumOption::new(
    "module-system",
    "Which module system to use",
    &["common-js", "es6"],
    "es6",
    OptionKind::Primary,
);

/// TS `javaScriptPropTypesOptions`, in declaration order.
pub static JAVA_SCRIPT_PROP_TYPES_OPTIONS: &[RendererOption] = &[
    RendererOption::Enum(ACRONYM_STYLE),
    RendererOption::Enum(CONVERTERS),
    RendererOption::Enum(MODULE_SYSTEM),
];

/// TS `javaScriptPropTypesLanguageConfig`.
pub const JAVA_SCRIPT_PROP_TYPES_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "JavaScript PropTypes",
    names: &["javascript-prop-types"],
    extension: "js",
};

/// The JavaScript PropTypes target language (TS `JavaScriptPropTypesTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct JavaScriptPropTypesTargetLanguage;

impl TargetLanguage for JavaScriptPropTypesTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &JAVA_SCRIPT_PROP_TYPES_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        JAVA_SCRIPT_PROP_TYPES_OPTIONS
    }

    // Inference hooks.

    /// TS `getSupportedIntegerRange`: JavaScript numbers are exact within ±(2^53 − 1).
    fn get_supported_integer_range(
        &self,
        _renderer_options: &RendererOptions,
    ) -> Option<IntegerRange> {
        Some(JS_SAFE_INTEGER_RANGE.clone())
    }

    /// TS `stringTypeMapping`.
    fn string_type_mapping(&self) -> StringTypeMapping {
        [
            (TypeKind::Uuid, TypeKind::Uuid),
            (TypeKind::Date, TypeKind::DateTime),
            (TypeKind::DateTime, TypeKind::DateTime),
        ]
        .into_iter()
        .collect()
    }

    // End of inference hooks.

    // Renderer hooks.

    /// TS `makeRenderer`: a `JavaScriptPropTypesRenderer`.
    fn render(
        &self,
        render_context: crate::renderer::RenderContext<'_>,
        renderer_options: &RendererOptions,
        given_output_filename: &str,
        alphabetize_properties: bool,
    ) -> crate::messages::Result<crate::renderer::RenderResult> {
        let options = super::java_script_prop_types_renderer::JavaScriptPropTypesOptions::parse(
            renderer_options,
        )?;
        let renderer = super::java_script_prop_types_renderer::JavaScriptPropTypesRenderer::new(
            self,
            render_context,
            options,
        );
        crate::convenience_renderer::render_with(
            renderer,
            given_output_filename,
            alphabetize_properties,
        )
    }
}
