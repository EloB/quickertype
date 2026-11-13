//! Port of `packages/quicktype-core/src/language/Python/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{BooleanOption, EnumOption, OptionKind, RendererOption};
use crate::target_language::{LanguageConfig, TargetLanguage};

/// TS `pythonOptions.features`.
pub const FEATURES: EnumOption = EnumOption::new(
    "python-version",
    "Python version",
    &["3.5", "3.6", "3.7", "3.9", "3.10"],
    "3.10",
    OptionKind::Primary,
);

/// TS `pythonOptions.justTypes`.
pub const JUST_TYPES: BooleanOption =
    BooleanOption::new("just-types", "Classes only", false, OptionKind::Primary);

/// TS `pythonOptions.nicePropertyNames`.
pub const NICE_PROPERTY_NAMES: BooleanOption = BooleanOption::new(
    "nice-property-names",
    "Transform property names to be Pythonic",
    true,
    OptionKind::Primary,
);

/// TS `pythonOptions.pydanticBaseModel`.
pub const PYDANTIC_BASE_MODEL: BooleanOption = BooleanOption::new(
    "pydantic-base-model",
    "Uses pydantic BaseModel",
    false,
    OptionKind::Primary,
);

/// TS `pythonOptions`, in declaration order.
pub static PYTHON_OPTIONS: &[RendererOption] = &[
    RendererOption::Enum(FEATURES),
    RendererOption::Boolean(JUST_TYPES),
    RendererOption::Boolean(NICE_PROPERTY_NAMES),
    RendererOption::Boolean(PYDANTIC_BASE_MODEL),
];

/// TS `pythonLanguageConfig`.
pub const PYTHON_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "Python",
    names: &["python", "py"],
    extension: "py",
};

/// The Python target language (TS `PythonTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct PythonTargetLanguage;

// TODO(renderer): port the hooks PythonTargetLanguage overrides:
// - makeRenderer
// - stringTypeMapping: date -> date, time -> time, date-time -> date-time, uuid -> uuid, integer-string -> integer-string, bool-string -> bool-string
// - supportsOptionalClassProperties: false
// - supportsUnionsWithBothNumberTypes: true
// - needsTransformerForType
// - getSupportedIntegerRange: null
impl TargetLanguage for PythonTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &PYTHON_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        PYTHON_OPTIONS
    }
}
