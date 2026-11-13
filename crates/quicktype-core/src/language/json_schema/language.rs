//! Port of `packages/quicktype-core/src/language/JSONSchema/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{RendererOption, RendererOptions};
use crate::support::integer_range::IntegerRange;
use crate::target_language::{LanguageConfig, TargetLanguage};
use crate::ty::type_builder_utils::{StringTypeMapping, get_no_string_type_mapping};

/// TS `JSONSchemaLanguageConfig`.
pub const JSON_SCHEMA_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "JSON Schema",
    names: &["schema", "json-schema"],
    extension: "schema",
};

/// The JSON Schema target language (TS `JSONSchemaTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct JsonSchemaTargetLanguage;

// TODO(renderer): port the hooks JSONSchemaTargetLanguage overrides:
// - makeRenderer
// - supportsFullObjectType: true
impl TargetLanguage for JsonSchemaTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &JSON_SCHEMA_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        &[]
    }

    // Inference hooks.

    /// TS `getSupportedIntegerRange`: arbitrary-precision integers.
    fn get_supported_integer_range(
        &self,
        _renderer_options: &RendererOptions,
    ) -> Option<IntegerRange> {
        None
    }

    /// TS `stringTypeMapping`: `getNoStringTypeMapping()`.
    fn string_type_mapping(&self) -> StringTypeMapping {
        get_no_string_type_mapping()
    }

    /// TS `supportsOptionalClassProperties`.
    fn supports_optional_class_properties(&self) -> bool {
        true
    }

    // End of inference hooks.
}
