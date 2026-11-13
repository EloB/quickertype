//! Port of `packages/quicktype-core/src/language/JavaScript/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{
    BooleanOption, EnumOption, OptionKind, RendererOption, acronym_option, converters_option,
};
use crate::target_language::{LanguageConfig, TargetLanguage};

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

// TODO(renderer): port the hooks JavaScriptTargetLanguage overrides:
// - makeRenderer
// - stringTypeMapping: date -> date-time, date-time -> date-time, uuid -> uuid
// - supportsOptionalClassProperties: true
// - supportsFullObjectType: true
// - getSupportedIntegerRange: JS_SAFE_INTEGER_RANGE
impl TargetLanguage for JavaScriptTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &JAVA_SCRIPT_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        JAVA_SCRIPT_OPTIONS
    }
}
