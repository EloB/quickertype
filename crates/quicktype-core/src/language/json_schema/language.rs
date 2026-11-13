//! Port of `packages/quicktype-core/src/language/JSONSchema/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::RendererOption;
use crate::target_language::{LanguageConfig, TargetLanguage};

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
// - stringTypeMapping: date -> date, time -> time, date-time -> date-time, uuid -> uuid, uri -> uri, integer-string -> integer-string, bool-string -> bool-string
// - supportsOptionalClassProperties: true
// - supportsFullObjectType: true
// - getSupportedIntegerRange: null
impl TargetLanguage for JsonSchemaTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &JSON_SCHEMA_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        &[]
    }
}
