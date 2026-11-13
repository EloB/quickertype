//! Port of `packages/quicktype-core/src/language/TypeScriptEffectSchema/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{BooleanOption, OptionKind, RendererOption};
use crate::target_language::{LanguageConfig, TargetLanguage};

/// TS `typeScriptEffectSchemaOptions.justSchema`.
pub const JUST_SCHEMA: BooleanOption =
    BooleanOption::new("just-schema", "Schema only", false, OptionKind::Primary);

/// TS `typeScriptEffectSchemaOptions`, in declaration order.
pub static TYPE_SCRIPT_EFFECT_SCHEMA_OPTIONS: &[RendererOption] =
    &[RendererOption::Boolean(JUST_SCHEMA)];

/// TS `typeScriptEffectSchemaLanguageConfig`.
pub const TYPE_SCRIPT_EFFECT_SCHEMA_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "TypeScript Effect Schema",
    names: &["typescript-effect-schema"],
    extension: "ts",
};

/// The TypeScript Effect Schema target language (TS `TypeScriptEffectSchemaTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct TypeScriptEffectSchemaTargetLanguage;

// TODO(renderer): port the hooks TypeScriptEffectSchemaTargetLanguage overrides:
// - makeRenderer
// - stringTypeMapping: uuid -> uuid, bool-string -> bool-string, date -> date, time -> time, date-time -> date-time, integer-string -> integer-string
// - supportsOptionalClassProperties: true
// - getSupportedIntegerRange: JS_SAFE_INTEGER_RANGE
impl TargetLanguage for TypeScriptEffectSchemaTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &TYPE_SCRIPT_EFFECT_SCHEMA_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        TYPE_SCRIPT_EFFECT_SCHEMA_OPTIONS
    }
}
