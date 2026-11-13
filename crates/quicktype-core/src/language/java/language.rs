//! Port of `packages/quicktype-core/src/language/Java/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{
    BooleanOption, EnumOption, OptionKind, RendererOption, StringOption, acronym_option,
};
use crate::target_language::{LanguageConfig, TargetLanguage};

/// TS `javaOptions.useList`.
pub const USE_LIST: EnumOption = EnumOption::new(
    "array-type",
    "Use T[] or List<T>",
    &["array", "list"],
    "list",
    OptionKind::Primary,
);

/// TS `javaOptions.justTypes`.
pub const JUST_TYPES: BooleanOption =
    BooleanOption::new("just-types", "Plain types only", false, OptionKind::Primary);

/// TS `javaOptions.dateTimeProvider`.
pub const DATE_TIME_PROVIDER: EnumOption = EnumOption::new(
    "datetime-provider",
    "Date time provider type",
    &["java8", "legacy"],
    "java8",
    OptionKind::Primary,
);

/// TS `javaOptions.acronymStyle`.
pub const ACRONYM_STYLE: EnumOption = acronym_option("pascal");

/// TS `javaOptions.packageName`.
pub const PACKAGE_NAME: StringOption = StringOption::new(
    "package",
    "Generated package name",
    "NAME",
    "io.quicktype",
    OptionKind::Primary,
);

/// TS `javaOptions.lombok`.
pub const LOMBOK: BooleanOption =
    BooleanOption::new("lombok", "Use lombok", false, OptionKind::Primary);

/// TS `javaOptions.lombokCopyAnnotations`.
pub const LOMBOK_COPY_ANNOTATIONS: BooleanOption = BooleanOption::new(
    "lombok-copy-annotations",
    "Copy accessor annotations",
    true,
    OptionKind::Secondary,
);

/// TS `javaOptions`, in declaration order.
pub static JAVA_OPTIONS: &[RendererOption] = &[
    RendererOption::Enum(USE_LIST),
    RendererOption::Boolean(JUST_TYPES),
    RendererOption::Enum(DATE_TIME_PROVIDER),
    RendererOption::Enum(ACRONYM_STYLE),
    RendererOption::String(PACKAGE_NAME),
    RendererOption::Boolean(LOMBOK),
    RendererOption::Boolean(LOMBOK_COPY_ANNOTATIONS),
];

/// TS `javaLanguageConfig`.
pub const JAVA_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "Java",
    names: &["java"],
    extension: "java",
};

/// The Java target language (TS `JavaTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct JavaTargetLanguage;

// TODO(renderer): port the hooks JavaTargetLanguage overrides:
// - makeRenderer
// - stringTypeMapping: date -> date, time -> time, date-time -> date-time, uuid -> uuid
// - supportsUnionsWithBothNumberTypes: true
impl TargetLanguage for JavaTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &JAVA_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        JAVA_OPTIONS
    }
}
