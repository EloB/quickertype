//! Port of `packages/quicktype-core/src/language/CPlusPlus/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{
    BooleanOption, EnumOption, OptionKind, RendererOption, StringOption,
};
use crate::support::strings::NamingStyle;
use crate::target_language::{LanguageConfig, TargetLanguage};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_builder_utils::StringTypeMapping;

/// TS `namingStyles`: the naming style of a `type-style`, `member-style`
/// or `enumerator-style` value.
pub fn naming_style_for_option(value: &str) -> NamingStyle {
    match value {
        "pascal-case" => NamingStyle::Pascal,
        "original-case" => NamingStyle::Original,
        "underscore-case" => NamingStyle::Underscore,
        "camel-case" => NamingStyle::Camel,
        "upper-underscore-case" => NamingStyle::UpperUnderscore,
        "pascal-case-upper-acronyms" => NamingStyle::PascalUpperAcronyms,
        _ => NamingStyle::CamelUpperAcronyms,
    }
}

/// TS `cPlusPlusOptions.typeSourceStyle`.
pub const TYPE_SOURCE_STYLE: EnumOption = EnumOption::new(
    "source-style",
    "Source code generation type,  whether to generate single or multiple source files",
    &["single-source", "multi-source"],
    "single-source",
    OptionKind::Secondary,
);

/// TS `cPlusPlusOptions.includeLocation`.
pub const INCLUDE_LOCATION: EnumOption = EnumOption::new(
    "include-location",
    "Whether json.hpp is to be located globally or locally",
    &["local-include", "global-include"],
    "local-include",
    OptionKind::Secondary,
);

/// TS `cPlusPlusOptions.codeFormat`.
pub const CODE_FORMAT: EnumOption = EnumOption::new(
    "code-format",
    "Generate classes with getters/setters, instead of structs",
    &["with-struct", "with-getter-setter"],
    "with-getter-setter",
    OptionKind::Primary,
);

/// TS `cPlusPlusOptions.wstring`.
pub const WSTRING: EnumOption = EnumOption::new(
    "wstring",
    "Store strings using Utf-16 std::wstring, rather than Utf-8 std::string",
    &["use-string", "use-wstring"],
    "use-string",
    OptionKind::Primary,
);

/// TS `cPlusPlusOptions.westConst`.
pub const WEST_CONST: EnumOption = EnumOption::new(
    "const-style",
    "Put const to the left/west (const T) or right/east (T const)",
    &["west-const", "east-const"],
    "west-const",
    OptionKind::Primary,
);

/// TS `cPlusPlusOptions.justTypes`.
pub const JUST_TYPES: BooleanOption =
    BooleanOption::new("just-types", "Plain types only", false, OptionKind::Primary);

/// TS `cPlusPlusOptions.namespace`.
pub const NAMESPACE: StringOption = StringOption::new(
    "namespace",
    "Name of the generated namespace(s)",
    "NAME",
    "quicktype",
    OptionKind::Primary,
);

/// TS `cPlusPlusOptions.enumType`.
pub const ENUM_TYPE: StringOption = StringOption::new(
    "enum-type",
    "Type of enum class",
    "NAME",
    "int",
    OptionKind::Secondary,
);

/// TS `cPlusPlusOptions.typeNamingStyle`.
pub const TYPE_NAMING_STYLE: EnumOption = EnumOption::new(
    "type-style",
    "Naming style for types",
    &[
        "pascal-case",
        "original-case",
        "underscore-case",
        "camel-case",
        "upper-underscore-case",
        "pascal-case-upper-acronyms",
        "camel-case-upper-acronyms",
    ],
    "pascal-case",
    OptionKind::Primary,
);

/// TS `cPlusPlusOptions.memberNamingStyle`.
pub const MEMBER_NAMING_STYLE: EnumOption = EnumOption::new(
    "member-style",
    "Naming style for members",
    &[
        "pascal-case",
        "original-case",
        "underscore-case",
        "camel-case",
        "upper-underscore-case",
        "pascal-case-upper-acronyms",
        "camel-case-upper-acronyms",
    ],
    "underscore-case",
    OptionKind::Primary,
);

/// TS `cPlusPlusOptions.enumeratorNamingStyle`.
pub const ENUMERATOR_NAMING_STYLE: EnumOption = EnumOption::new(
    "enumerator-style",
    "Naming style for enumerators",
    &[
        "pascal-case",
        "original-case",
        "underscore-case",
        "camel-case",
        "upper-underscore-case",
        "pascal-case-upper-acronyms",
        "camel-case-upper-acronyms",
    ],
    "upper-underscore-case",
    OptionKind::Primary,
);

/// TS `cPlusPlusOptions.boost`.
pub const BOOST: BooleanOption = BooleanOption::new(
    "boost",
    "Require a dependency on boost. Without boost, C++17 is required",
    false,
    OptionKind::Primary,
);

/// TS `cPlusPlusOptions.hideNullOptional`.
pub const HIDE_NULL_OPTIONAL: BooleanOption = BooleanOption::new(
    "hide-null-optional",
    "Hide null value for optional field",
    false,
    OptionKind::Primary,
);

/// TS `cPlusPlusOptions`, in declaration order.
pub static C_PLUS_PLUS_OPTIONS: &[RendererOption] = &[
    RendererOption::Enum(TYPE_SOURCE_STYLE),
    RendererOption::Enum(INCLUDE_LOCATION),
    RendererOption::Enum(CODE_FORMAT),
    RendererOption::Enum(WSTRING),
    RendererOption::Enum(WEST_CONST),
    RendererOption::Boolean(JUST_TYPES),
    RendererOption::String(NAMESPACE),
    RendererOption::String(ENUM_TYPE),
    RendererOption::Enum(TYPE_NAMING_STYLE),
    RendererOption::Enum(MEMBER_NAMING_STYLE),
    RendererOption::Enum(ENUMERATOR_NAMING_STYLE),
    RendererOption::Boolean(BOOST),
    RendererOption::Boolean(HIDE_NULL_OPTIONAL),
];

/// TS `cPlusPlusLanguageConfig`.
pub const C_PLUS_PLUS_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "C++",
    names: &["c++", "cpp", "cplusplus"],
    extension: "cpp",
};

/// The C++ target language (TS `CPlusPlusTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct CPlusPlusTargetLanguage;

impl TargetLanguage for CPlusPlusTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &C_PLUS_PLUS_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        C_PLUS_PLUS_OPTIONS
    }

    // Inference hooks.

    /// TS `supportsUnionsWithBothNumberTypes`.
    fn supports_unions_with_both_number_types(&self) -> bool {
        true
    }

    /// TS `supportsOptionalClassProperties`.
    fn supports_optional_class_properties(&self) -> bool {
        true
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

    // End of inference hooks.

    // Renderer hooks.

    fn render(
        &self,
        render_context: crate::renderer::RenderContext<'_>,
        renderer_options: &crate::renderer_options::RendererOptions,
        given_output_filename: &str,
        alphabetize_properties: bool,
    ) -> crate::messages::Result<crate::renderer::RenderResult> {
        let options = super::c_plus_plus_renderer::CPlusPlusOptions::parse(renderer_options)?;
        let renderer =
            super::c_plus_plus_renderer::CPlusPlusRenderer::new(self, render_context, options);
        crate::convenience_renderer::render_with(
            renderer,
            given_output_filename,
            alphabetize_properties,
        )
    }
}
