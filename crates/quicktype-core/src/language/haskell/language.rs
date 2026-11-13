//! Port of `packages/quicktype-core/src/language/Haskell/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{
    BooleanOption, EnumOption, OptionKind, RendererOption, StringOption,
};
use crate::target_language::{LanguageConfig, TargetLanguage};

/// TS `haskellOptions.justTypes`.
pub const JUST_TYPES: BooleanOption =
    BooleanOption::new("just-types", "Plain types only", false, OptionKind::Primary);

/// TS `haskellOptions.useList`.
pub const USE_LIST: EnumOption = EnumOption::new(
    "array-type",
    "Use Array or List",
    &["array", "list"],
    "list",
    OptionKind::Primary,
);

/// TS `haskellOptions.moduleName`.
pub const MODULE_NAME: StringOption = StringOption::new(
    "module",
    "Generated module name",
    "NAME",
    "QuickType",
    OptionKind::Primary,
);

/// TS `haskellOptions`, in declaration order.
pub static HASKELL_OPTIONS: &[RendererOption] = &[
    RendererOption::Boolean(JUST_TYPES),
    RendererOption::Enum(USE_LIST),
    RendererOption::String(MODULE_NAME),
];

/// TS `haskellLanguageConfig`.
pub const HASKELL_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "Haskell",
    names: &["haskell"],
    extension: "haskell",
};

/// The Haskell target language (TS `HaskellTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct HaskellTargetLanguage;

// TODO(renderer): port the hooks HaskellTargetLanguage overrides:
// - makeRenderer
// - supportsOptionalClassProperties: true
// - supportsUnionsWithBothNumberTypes: true
impl TargetLanguage for HaskellTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &HASKELL_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        HASKELL_OPTIONS
    }
}
