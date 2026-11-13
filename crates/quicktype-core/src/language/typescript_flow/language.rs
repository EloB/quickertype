//! Port of `packages/quicktype-core/src/language/TypeScriptFlow/language.ts`.
//!
//! Language metadata and renderer option declarations for TypeScript and
//! Flow, which share one option set.

use crate::language::javascript::language as javascript;
use crate::renderer_options::{BooleanOption, OptionKind, RendererOption, RendererOptions};
use crate::support::integer_range::{IntegerRange, JS_SAFE_INTEGER_RANGE};
use crate::target_language::{LanguageConfig, TargetLanguage};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_builder_utils::StringTypeMapping;

/// TS `tsFlowOptions.justTypes`.
pub const JUST_TYPES: BooleanOption =
    BooleanOption::new("just-types", "Interfaces only", false, OptionKind::Primary);

/// TS `tsFlowOptions.nicePropertyNames`.
pub const NICE_PROPERTY_NAMES: BooleanOption = BooleanOption::new(
    "nice-property-names",
    "Transform property names to be JavaScripty",
    false,
    OptionKind::Primary,
);

/// TS `tsFlowOptions.declareUnions`.
pub const DECLARE_UNIONS: BooleanOption = BooleanOption::new(
    "explicit-unions",
    "Explicitly name unions",
    false,
    OptionKind::Primary,
);

/// TS `tsFlowOptions.preferUnions`.
pub const PREFER_UNIONS: BooleanOption = BooleanOption::new(
    "prefer-unions",
    "Use union type instead of enum",
    true,
    OptionKind::Primary,
);

/// TS `tsFlowOptions.preferTypes`.
pub const PREFER_TYPES: BooleanOption = BooleanOption::new(
    "prefer-types",
    "Use types instead of interfaces",
    false,
    OptionKind::Primary,
);

/// TS `tsFlowOptions.preferConstValues`.
pub const PREFER_CONST_VALUES: BooleanOption = BooleanOption::new(
    "prefer-const-values",
    "Use string instead of enum for string enums with single value",
    false,
    OptionKind::Primary,
);

/// TS `tsFlowOptions.readonly`.
pub const READONLY: BooleanOption = BooleanOption::new(
    "readonly",
    "Use readonly type members",
    false,
    OptionKind::Primary,
);

/// TS `tsFlowOptions.preferUnknown`.
pub const PREFER_UNKNOWN: BooleanOption = BooleanOption::new(
    "prefer-unknown",
    "Use unknown (TypeScript) or mixed (Flow) instead of any",
    true,
    OptionKind::Primary,
);

/// TS `tsFlowOptions`: the `javaScriptOptions` followed by the TypeScript/Flow
/// options, in declaration order.
pub static TS_FLOW_OPTIONS: &[RendererOption] = &[
    RendererOption::Enum(javascript::ACRONYM_STYLE),
    RendererOption::Boolean(javascript::RUNTIME_TYPECHECK),
    RendererOption::Boolean(javascript::RUNTIME_TYPECHECK_IGNORE_UNKNOWN_PROPERTIES),
    RendererOption::Enum(javascript::CONVERTERS),
    RendererOption::Enum(javascript::RAW_TYPE),
    RendererOption::Boolean(JUST_TYPES),
    RendererOption::Boolean(NICE_PROPERTY_NAMES),
    RendererOption::Boolean(DECLARE_UNIONS),
    RendererOption::Boolean(PREFER_UNIONS),
    RendererOption::Boolean(PREFER_TYPES),
    RendererOption::Boolean(PREFER_CONST_VALUES),
    RendererOption::Boolean(READONLY),
    RendererOption::Boolean(PREFER_UNKNOWN),
];

/// TS `typeScriptLanguageConfig`.
pub const TYPE_SCRIPT_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "TypeScript",
    names: &["typescript", "ts", "tsx"],
    extension: "ts",
};

/// The TypeScript target language (TS `TypeScriptTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct TypeScriptTargetLanguage;

// TODO(renderer): port the hooks TypeScriptTargetLanguage overrides:
// - makeRenderer
// - supportsFullObjectType: true
impl TargetLanguage for TypeScriptTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &TYPE_SCRIPT_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        TS_FLOW_OPTIONS
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
}

/// TS `flowLanguageConfig`.
pub const FLOW_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "Flow",
    names: &["flow"],
    extension: "js",
};

/// The Flow target language (TS `FlowTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct FlowTargetLanguage;

// TODO(renderer): port the hooks FlowTargetLanguage overrides:
// - makeRenderer
// - supportsFullObjectType: true
impl TargetLanguage for FlowTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &FLOW_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        TS_FLOW_OPTIONS
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
}
