//! Port of `packages/quicktype-core/src/language/Elm/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{
    BooleanOption, EnumOption, OptionKind, RendererOption, StringOption,
};
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

// TODO(renderer): port the hooks ElmTargetLanguage overrides:
// - makeRenderer
// - supportsOptionalClassProperties: true
// - supportsUnionsWithBothNumberTypes: true
// - getSupportedIntegerRange: JS_SAFE_INTEGER_RANGE
impl TargetLanguage for ElmTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &ELM_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        ELM_OPTIONS
    }
}
