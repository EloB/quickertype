//! Port of `packages/quicktype-core/src/language/TypeScriptZod/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{BooleanOption, OptionKind, RendererOption};
use crate::target_language::{LanguageConfig, TargetLanguage};

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

// TODO(renderer): port the hooks TypeScriptZodTargetLanguage overrides:
// - makeRenderer
// - stringTypeMapping: date-time -> date-time, uuid -> uuid, bool-string -> bool-string, integer-string -> integer-string
// - supportsOptionalClassProperties: true
// - getSupportedIntegerRange: JS_SAFE_INTEGER_RANGE
impl TargetLanguage for TypeScriptZodTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &TYPE_SCRIPT_ZOD_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        TYPE_SCRIPT_ZOD_OPTIONS
    }
}
