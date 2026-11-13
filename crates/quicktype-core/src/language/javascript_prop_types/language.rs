//! Port of `packages/quicktype-core/src/language/JavaScriptPropTypes/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{
    EnumOption, OptionKind, RendererOption, acronym_option, converters_option,
};
use crate::target_language::{LanguageConfig, TargetLanguage};

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

// TODO(renderer): port the hooks JavaScriptPropTypesTargetLanguage overrides:
// - makeRenderer
// - stringTypeMapping: uuid -> uuid, date -> date-time, date-time -> date-time
// - getSupportedIntegerRange: JS_SAFE_INTEGER_RANGE
impl TargetLanguage for JavaScriptPropTypesTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &JAVA_SCRIPT_PROP_TYPES_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        JAVA_SCRIPT_PROP_TYPES_OPTIONS
    }
}
