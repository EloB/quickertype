//! Port of `packages/quicktype-core/src/language/Golang/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{BooleanOption, OptionKind, RendererOption, StringOption};
use crate::target_language::{LanguageConfig, TargetLanguage};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_builder_utils::StringTypeMapping;

/// TS `goOptions.justTypes`.
pub const JUST_TYPES: BooleanOption =
    BooleanOption::new("just-types", "Plain types only", false, OptionKind::Primary);

/// TS `goOptions.justTypesAndPackage`.
pub const JUST_TYPES_AND_PACKAGE: BooleanOption = BooleanOption::new(
    "just-types-and-package",
    "Plain types with package only",
    false,
    OptionKind::Primary,
);

/// TS `goOptions.packageName`.
pub const PACKAGE_NAME: StringOption = StringOption::new(
    "package",
    "Generated package name",
    "NAME",
    "main",
    OptionKind::Primary,
);

/// TS `goOptions.multiFileOutput`.
pub const MULTI_FILE_OUTPUT: BooleanOption = BooleanOption::new(
    "multi-file-output",
    "Renders each top-level object in its own Go file",
    false,
    OptionKind::Primary,
);

/// TS `goOptions.fieldTags`.
pub const FIELD_TAGS: StringOption = StringOption::new(
    "field-tags",
    "list of tags which should be generated for fields",
    "TAGS",
    "json",
    OptionKind::Primary,
);

/// TS `goOptions.omitEmpty`.
pub const OMIT_EMPTY: BooleanOption = BooleanOption::new(
    "omit-empty",
    "If set, all non-required objects will be tagged with \",omitempty\"",
    false,
    OptionKind::Primary,
);

/// TS `goOptions.enumTypeNameSuffix`.
pub const ENUM_TYPE_NAME_SUFFIX: BooleanOption = BooleanOption::new(
    "enum-type-name-suffix",
    "Append the enum type name to enum constant names",
    false,
    OptionKind::Primary,
);

/// TS `goOptions`, in declaration order.
pub static GO_OPTIONS: &[RendererOption] = &[
    RendererOption::Boolean(JUST_TYPES),
    RendererOption::Boolean(JUST_TYPES_AND_PACKAGE),
    RendererOption::String(PACKAGE_NAME),
    RendererOption::Boolean(MULTI_FILE_OUTPUT),
    RendererOption::String(FIELD_TAGS),
    RendererOption::Boolean(OMIT_EMPTY),
    RendererOption::Boolean(ENUM_TYPE_NAME_SUFFIX),
];

/// TS `golangLanguageConfig`.
pub const GOLANG_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "Go",
    names: &["go", "golang"],
    extension: "go",
};

/// The Go target language (TS `GoTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct GoTargetLanguage;

impl TargetLanguage for GoTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &GOLANG_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        GO_OPTIONS
    }

    // Inference hooks.

    /// TS `supportsUnionsWithBothNumberTypes`.
    fn supports_unions_with_both_number_types(&self) -> bool {
        true
    }

    /// TS `stringTypeMapping`.
    fn string_type_mapping(&self) -> StringTypeMapping {
        [(TypeKind::DateTime, TypeKind::DateTime)]
            .into_iter()
            .collect()
    }

    /// TS `supportsOptionalClassProperties`.
    fn supports_optional_class_properties(&self) -> bool {
        true
    }

    // End of inference hooks.

    /// TS `defaultIndentation`: a tab.
    fn default_indentation(&self) -> &'static str {
        "\t"
    }

    /// TS `makeRenderer`: a `GoRenderer`.
    fn render(
        &self,
        render_context: crate::renderer::RenderContext<'_>,
        renderer_options: &crate::renderer_options::RendererOptions,
        given_output_filename: &str,
        alphabetize_properties: bool,
    ) -> crate::messages::Result<crate::renderer::RenderResult> {
        let options = super::golang_renderer::GoOptions::parse(renderer_options)?;
        let renderer = super::golang_renderer::GoRenderer::new(self, render_context, options);
        crate::convenience_renderer::render_with(
            renderer,
            given_output_filename,
            alphabetize_properties,
        )
    }
}
