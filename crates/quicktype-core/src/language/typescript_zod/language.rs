//! Port of `packages/quicktype-core/src/language/TypeScriptZod/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{BooleanOption, OptionKind, RendererOption, RendererOptions};
use crate::support::integer_range::{IntegerRange, JS_SAFE_INTEGER_RANGE};
use crate::target_language::{LanguageConfig, TargetLanguage};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_builder_utils::StringTypeMapping;

/// TS `typeScriptZodOptions.justSchema`.
pub const JUST_SCHEMA: BooleanOption =
    BooleanOption::new("just-schema", "Schema only", false, OptionKind::Primary);

/// TS `typeScriptZodOptions`, in declaration order.
pub static TYPE_SCRIPT_ZOD_OPTIONS: &[RendererOption] = &[RendererOption::Boolean(JUST_SCHEMA)];

/// TS `typeScriptZodLanguageConfig`.
pub const TYPE_SCRIPT_ZOD_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "TypeScript Zod",
    names: &["typescript-zod"],
    extension: "ts",
};

/// The TypeScript Zod target language (TS `TypeScriptZodTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct TypeScriptZodTargetLanguage;

impl TargetLanguage for TypeScriptZodTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &TYPE_SCRIPT_ZOD_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        TYPE_SCRIPT_ZOD_OPTIONS
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
            (TypeKind::DateTime, TypeKind::DateTime),
            (TypeKind::Uuid, TypeKind::Uuid),
            (TypeKind::BoolString, TypeKind::BoolString),
            (TypeKind::IntegerString, TypeKind::IntegerString),
        ]
        .into_iter()
        .collect()
    }

    /// TS `supportsOptionalClassProperties`.
    fn supports_optional_class_properties(&self) -> bool {
        true
    }

    // End of inference hooks.

    // Renderer hooks.

    /// TS `makeRenderer`: a `TypeScriptZodRenderer`.
    fn render(
        &self,
        render_context: crate::renderer::RenderContext<'_>,
        renderer_options: &RendererOptions,
        given_output_filename: &str,
        alphabetize_properties: bool,
    ) -> crate::messages::Result<crate::renderer::RenderResult> {
        let options =
            super::type_script_zod_renderer::TypeScriptZodOptions::parse(renderer_options)?;
        let renderer = super::type_script_zod_renderer::TypeScriptZodRenderer::new(
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
