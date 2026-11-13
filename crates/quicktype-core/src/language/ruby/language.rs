//! Port of `packages/quicktype-core/src/language/Ruby/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{
    BooleanOption, EnumOption, OptionKind, RendererOption, StringOption,
};
use crate::target_language::{LanguageConfig, TargetLanguage};

/// TS `rubyOptions.justTypes`.
pub const JUST_TYPES: BooleanOption =
    BooleanOption::new("just-types", "Plain types only", false, OptionKind::Primary);

/// TS `rubyOptions.strictness`.
pub const STRICTNESS: EnumOption = EnumOption::new(
    "strictness",
    "Type strictness",
    &["strict", "coercible", "none"],
    "strict",
    OptionKind::Primary,
);

/// TS `rubyOptions.namespace`.
pub const NAMESPACE: StringOption = StringOption::new(
    "namespace",
    "Specify a wrapping Namespace",
    "NAME",
    "",
    OptionKind::Secondary,
);

/// TS `rubyOptions`, in declaration order.
pub static RUBY_OPTIONS: &[RendererOption] = &[
    RendererOption::Boolean(JUST_TYPES),
    RendererOption::Enum(STRICTNESS),
    RendererOption::String(NAMESPACE),
];

/// TS `rubyLanguageConfig`.
pub const RUBY_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "Ruby",
    names: &["ruby"],
    extension: "rb",
};

/// The Ruby target language (TS `RubyTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct RubyTargetLanguage;

// TODO(renderer): port the hooks RubyTargetLanguage overrides:
// - makeRenderer
// - defaultIndentation: "  "
// - stringTypeMapping: uuid -> uuid, date-time -> date-time
// - supportsOptionalClassProperties: true
// - getSupportedIntegerRange: null
impl TargetLanguage for RubyTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &RUBY_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        RUBY_OPTIONS
    }
}
