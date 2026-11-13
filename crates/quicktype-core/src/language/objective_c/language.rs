//! Port of `packages/quicktype-core/src/language/Objective-C/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{
    BooleanOption, EnumOption, OptionKind, RendererOption, StringOption,
};
use crate::target_language::{LanguageConfig, TargetLanguage};

/// TS `objectiveCOptions.features`.
pub const FEATURES: EnumOption = EnumOption::new(
    "features",
    "Interface and implementation",
    &["all", "interface", "implementation"],
    "all",
    OptionKind::Primary,
);

/// TS `objectiveCOptions.justTypes`.
pub const JUST_TYPES: BooleanOption =
    BooleanOption::new("just-types", "Plain types only", false, OptionKind::Primary);

/// TS `objectiveCOptions.marshallingFunctions`.
pub const MARSHALLING_FUNCTIONS: BooleanOption =
    BooleanOption::new("functions", "C-style functions", false, OptionKind::Primary);

/// TS `objectiveCOptions.classPrefix` (default `DEFAULT_CLASS_PREFIX`).
pub const CLASS_PREFIX: StringOption = StringOption::new(
    "class-prefix",
    "Class prefix",
    "PREFIX",
    "QT",
    OptionKind::Primary,
);

/// TS `objectiveCOptions.extraComments`.
pub const EXTRA_COMMENTS: BooleanOption = BooleanOption::new(
    "extra-comments",
    "Extra comments",
    false,
    OptionKind::Primary,
);

/// TS `objectiveCOptions`, in declaration order.
pub static OBJECTIVE_C_OPTIONS: &[RendererOption] = &[
    RendererOption::Enum(FEATURES),
    RendererOption::Boolean(JUST_TYPES),
    RendererOption::Boolean(MARSHALLING_FUNCTIONS),
    RendererOption::String(CLASS_PREFIX),
    RendererOption::Boolean(EXTRA_COMMENTS),
];

/// TS `objectiveCLanguageConfig`.
pub const OBJECTIVE_C_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "Objective-C",
    names: &["objc", "objective-c", "objectivec"],
    extension: "m",
};

/// The Objective-C target language (TS `ObjectiveCTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct ObjectiveCTargetLanguage;

// TODO(renderer): port the hooks ObjectiveCTargetLanguage overrides:
// - makeRenderer
// - stringTypeMapping: uuid -> uuid, date-time -> date-time
impl TargetLanguage for ObjectiveCTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &OBJECTIVE_C_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        OBJECTIVE_C_OPTIONS
    }
}
