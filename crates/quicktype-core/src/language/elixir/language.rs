//! Port of `packages/quicktype-core/src/language/Elixir/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{BooleanOption, OptionKind, RendererOption, StringOption};
use crate::target_language::{LanguageConfig, TargetLanguage};

/// TS `elixirOptions.justTypes`.
pub const JUST_TYPES: BooleanOption =
    BooleanOption::new("just-types", "Plain types only", false, OptionKind::Primary);

/// TS `elixirOptions.namespace`.
pub const NAMESPACE: StringOption = StringOption::new(
    "namespace",
    "Specify a module namespace",
    "NAME",
    "",
    OptionKind::Primary,
);

/// TS `elixirOptions`, in declaration order.
pub static ELIXIR_OPTIONS: &[RendererOption] = &[
    RendererOption::Boolean(JUST_TYPES),
    RendererOption::String(NAMESPACE),
];

/// TS `elixirLanguageConfig`.
pub const ELIXIR_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "Elixir",
    names: &["elixir"],
    extension: "ex",
};

/// The Elixir target language (TS `ElixirTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct ElixirTargetLanguage;

// TODO(renderer): port the hooks ElixirTargetLanguage overrides:
// - makeRenderer
// - defaultIndentation: "  "
// - supportsOptionalClassProperties: true
// - getSupportedIntegerRange: null
impl TargetLanguage for ElixirTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &ELIXIR_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        ELIXIR_OPTIONS
    }
}
