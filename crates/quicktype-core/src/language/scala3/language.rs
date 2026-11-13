//! Port of `packages/quicktype-core/src/language/Scala3/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{
    BooleanOption, EnumOption, OptionKind, RendererOption, StringOption,
};
use crate::target_language::{LanguageConfig, TargetLanguage};

/// TS `scala3Options.justTypes`.
pub const JUST_TYPES: BooleanOption =
    BooleanOption::new("just-types", "Plain types only", false, OptionKind::Primary);

/// TS `scala3Options.framework`.
pub const FRAMEWORK: EnumOption = EnumOption::new(
    "framework",
    "Serialization framework",
    &["circe", "upickle"],
    "circe",
    OptionKind::Primary,
);

/// TS `scala3Options.packageName`.
pub const PACKAGE_NAME: StringOption = StringOption::new(
    "package",
    "Package",
    "PACKAGE",
    "quicktype",
    OptionKind::Primary,
);

/// TS `scala3Options`, in declaration order.
pub static SCALA3_OPTIONS: &[RendererOption] = &[
    RendererOption::Boolean(JUST_TYPES),
    RendererOption::Enum(FRAMEWORK),
    RendererOption::String(PACKAGE_NAME),
];

/// TS `scala3LanguageConfig`.
pub const SCALA3_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "Scala3",
    names: &["scala3"],
    extension: "scala",
};

/// The Scala3 target language (TS `Scala3TargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct Scala3TargetLanguage;

// TODO(renderer): port the hooks Scala3TargetLanguage overrides:
// - makeRenderer
// - stringTypeMapping: date-time -> date-time, uuid -> uuid
// - supportsOptionalClassProperties: true
// - supportsUnionsWithBothNumberTypes: true
impl TargetLanguage for Scala3TargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &SCALA3_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        SCALA3_OPTIONS
    }
}
