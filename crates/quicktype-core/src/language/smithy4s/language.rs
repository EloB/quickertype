//! Port of `packages/quicktype-core/src/language/Smithy4s/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{BooleanOption, OptionKind, RendererOption, StringOption};
use crate::target_language::{LanguageConfig, TargetLanguage};

/// TS `smithyOptions.justTypes`.
pub const JUST_TYPES: BooleanOption =
    BooleanOption::new("just-types", "Plain types only", false, OptionKind::Primary);

/// TS `smithyOptions.packageName`.
pub const PACKAGE_NAME: StringOption = StringOption::new(
    "package",
    "Package",
    "PACKAGE",
    "quicktype",
    OptionKind::Primary,
);

/// TS `smithyOptions`, in declaration order.
pub static SMITHY_OPTIONS: &[RendererOption] = &[
    RendererOption::Boolean(JUST_TYPES),
    RendererOption::String(PACKAGE_NAME),
];

/// TS `smithyLanguageConfig`.
pub const SMITHY_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "Smithy",
    names: &["smithy4a"],
    extension: "smithy",
};

/// The Smithy target language (TS `SmithyTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct SmithyTargetLanguage;

// TODO(renderer): port the hooks SmithyTargetLanguage overrides:
// - makeRenderer
impl TargetLanguage for SmithyTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &SMITHY_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        SMITHY_OPTIONS
    }

    // Inference hooks.

    /// TS `supportsOptionalClassProperties`.
    fn supports_optional_class_properties(&self) -> bool {
        true
    }

    /// TS `supportsUnionsWithBothNumberTypes`.
    fn supports_unions_with_both_number_types(&self) -> bool {
        true
    }

    // End of inference hooks.
}
