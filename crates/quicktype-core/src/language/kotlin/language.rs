//! Port of `packages/quicktype-core/src/language/Kotlin/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{
    BooleanOption, EnumOption, OptionKind, RendererOption, StringOption, acronym_option,
};
use crate::target_language::{LanguageConfig, TargetLanguage};

/// TS `kotlinOptions.justTypes`.
pub const JUST_TYPES: BooleanOption =
    BooleanOption::new("just-types", "Plain types only", false, OptionKind::Primary);

/// TS `kotlinOptions.framework`.
pub const FRAMEWORK: EnumOption = EnumOption::new(
    "framework",
    "Serialization framework",
    &["jackson", "klaxon", "kotlinx"],
    "jackson",
    OptionKind::Primary,
);

/// TS `kotlinOptions.acronymStyle`.
pub const ACRONYM_STYLE: EnumOption = acronym_option("pascal");

/// TS `kotlinOptions.packageName`.
pub const PACKAGE_NAME: StringOption = StringOption::new(
    "package",
    "Package",
    "PACKAGE",
    "quicktype",
    OptionKind::Primary,
);

/// TS `kotlinOptions`, in declaration order.
pub static KOTLIN_OPTIONS: &[RendererOption] = &[
    RendererOption::Boolean(JUST_TYPES),
    RendererOption::Enum(FRAMEWORK),
    RendererOption::Enum(ACRONYM_STYLE),
    RendererOption::String(PACKAGE_NAME),
];

/// TS `kotlinLanguageConfig`.
pub const KOTLIN_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "Kotlin",
    names: &["kotlin"],
    extension: "kt",
};

/// The Kotlin target language (TS `KotlinTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct KotlinTargetLanguage;

// TODO(renderer): port the hooks KotlinTargetLanguage overrides:
// - makeRenderer
// - stringTypeMapping: date -> date, time -> time, date-time -> date-time
// - supportsOptionalClassProperties: true
// - supportsUnionsWithBothNumberTypes: true
// - dateTimeRecognizer: KotlinDateTimeRecognizer
impl TargetLanguage for KotlinTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &KOTLIN_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        KOTLIN_OPTIONS
    }
}
