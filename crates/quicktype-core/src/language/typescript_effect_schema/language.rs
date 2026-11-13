//! Port of `packages/quicktype-core/src/language/TypeScriptEffectSchema/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{BooleanOption, OptionKind, RendererOption, RendererOptions};
use crate::support::integer_range::{IntegerRange, JS_SAFE_INTEGER_RANGE};
use crate::target_language::{LanguageConfig, TargetLanguage};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_builder_utils::StringTypeMapping;

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
impl TargetLanguage for TypeScriptEffectSchemaTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &TYPE_SCRIPT_EFFECT_SCHEMA_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        TYPE_SCRIPT_EFFECT_SCHEMA_OPTIONS
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
            (TypeKind::BoolString, TypeKind::BoolString),
            (TypeKind::Date, TypeKind::Date),
            (TypeKind::Time, TypeKind::Time),
            (TypeKind::DateTime, TypeKind::DateTime),
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
}
