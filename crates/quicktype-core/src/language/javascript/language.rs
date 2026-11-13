//! Port of `packages/quicktype-core/src/language/JavaScript/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{
    BooleanOption, EnumOption, OptionKind, RendererOption, RendererOptions,
};
use crate::support::acronyms::acronym_option;
use crate::support::converters::converters_option;
use crate::support::integer_range::{IntegerRange, JS_SAFE_INTEGER_RANGE};
use crate::target_language::{LanguageConfig, TargetLanguage};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_builder_utils::StringTypeMapping;

/// TS `javaScriptOptions.acronymStyle`.
pub const ACRONYM_STYLE: EnumOption = acronym_option("pascal");

/// TS `javaScriptOptions.runtimeTypecheck`.
pub const RUNTIME_TYPECHECK: BooleanOption = BooleanOption::new(
    "runtime-typecheck",
    "Verify JSON.parse results at runtime",
    true,
    OptionKind::Primary,
);

/// TS `javaScriptOptions.runtimeTypecheckIgnoreUnknownProperties`.
pub const RUNTIME_TYPECHECK_IGNORE_UNKNOWN_PROPERTIES: BooleanOption = BooleanOption::new(
    "runtime-typecheck-ignore-unknown-properties",
    "Ignore unknown properties when verifying at runtime",
    false,
    OptionKind::Secondary,
);

/// TS `javaScriptOptions.converters`.
pub const CONVERTERS: EnumOption = converters_option();

/// TS `javaScriptOptions.rawType`.
pub const RAW_TYPE: EnumOption = EnumOption::new(
    "raw-type",
    "Type of raw input (json by default)",
    &["json", "any"],
    "json",
    OptionKind::Secondary,
);

/// TS `javaScriptOptions`, in declaration order.
pub static JAVA_SCRIPT_OPTIONS: &[RendererOption] = &[
    RendererOption::Enum(ACRONYM_STYLE),
    RendererOption::Boolean(RUNTIME_TYPECHECK),
    RendererOption::Boolean(RUNTIME_TYPECHECK_IGNORE_UNKNOWN_PROPERTIES),
    RendererOption::Enum(CONVERTERS),
    RendererOption::Enum(RAW_TYPE),
];

/// TS `javaScriptLanguageConfig`.
pub const JAVA_SCRIPT_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "JavaScript",
    names: &["javascript", "js", "jsx"],
    extension: "js",
};

/// The JavaScript target language (TS `JavaScriptTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct JavaScriptTargetLanguage;

impl TargetLanguage for JavaScriptTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &JAVA_SCRIPT_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        JAVA_SCRIPT_OPTIONS
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
            (TypeKind::Date, TypeKind::DateTime),
            (TypeKind::DateTime, TypeKind::DateTime),
            (TypeKind::Uuid, TypeKind::Uuid),
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

    /// TS `supportsFullObjectType`.
    fn supports_full_object_type(&self) -> bool {
        true
    }

    /// TS `makeRenderer`: a `JavaScriptRenderer`.
    fn render(
        &self,
        render_context: crate::renderer::RenderContext<'_>,
        renderer_options: &RendererOptions,
        given_output_filename: &str,
        alphabetize_properties: bool,
    ) -> crate::messages::Result<crate::renderer::RenderResult> {
        let options = super::java_script_renderer::JavaScriptOptions::parse(renderer_options)?;
        let renderer = super::java_script_renderer::PlainJavaScriptRenderer::new(
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

/// TS `javaScriptOptions.rawType`'s values: what the converters take and
/// return.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum RawType {
    /// `"json"`: JSON strings.
    Json,
    /// `"any"`: already parsed values.
    Any,
}
