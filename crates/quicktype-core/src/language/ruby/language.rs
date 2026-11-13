//! Port of `packages/quicktype-core/src/language/Ruby/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{
    BooleanOption, EnumOption, OptionKind, RendererOption, RendererOptions, StringOption,
};
use crate::support::integer_range::IntegerRange;
use crate::target_language::{LanguageConfig, TargetLanguage};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_builder_utils::StringTypeMapping;

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
impl TargetLanguage for RubyTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &RUBY_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        RUBY_OPTIONS
    }

    // Inference hooks.

    /// TS `getSupportedIntegerRange`: arbitrary-precision integers.
    fn get_supported_integer_range(
        &self,
        _renderer_options: &RendererOptions,
    ) -> Option<IntegerRange> {
        None
    }

    /// TS `stringTypeMapping`.
    fn string_type_mapping(&self) -> StringTypeMapping {
        [
            (TypeKind::Uuid, TypeKind::Uuid),
            (TypeKind::DateTime, TypeKind::DateTime),
        ]
        .into_iter()
        .collect()
    }

    /// TS `supportsOptionalClassProperties`.
    fn supports_optional_class_properties(&self) -> bool {
        true
    }

    // End of inference hooks.
}
