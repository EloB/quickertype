//! Port of `packages/quicktype-core/src/language/Dart/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{BooleanOption, OptionKind, RendererOption, StringOption};
use crate::target_language::{LanguageConfig, TargetLanguage};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_builder_utils::StringTypeMapping;

/// TS `dartOptions.justTypes`.
pub const JUST_TYPES: BooleanOption =
    BooleanOption::new("just-types", "Types only", false, OptionKind::Primary);

/// TS `dartOptions.codersInClass`.
pub const CODERS_IN_CLASS: BooleanOption = BooleanOption::new(
    "coders-in-class",
    "Put encoder & decoder in Class",
    false,
    OptionKind::Primary,
);

/// TS `dartOptions.methodNamesWithMap`.
pub const METHOD_NAMES_WITH_MAP: BooleanOption = BooleanOption::new(
    "from-map",
    "Use method names fromMap() & toMap()",
    false,
    OptionKind::Secondary,
);

/// TS `dartOptions.requiredProperties`.
pub const REQUIRED_PROPERTIES: BooleanOption = BooleanOption::new(
    "required-props",
    "Make all properties required",
    false,
    OptionKind::Primary,
);

/// TS `dartOptions.finalProperties`.
pub const FINAL_PROPERTIES: BooleanOption = BooleanOption::new(
    "final-props",
    "Make all properties final",
    true,
    OptionKind::Primary,
);

/// TS `dartOptions.generateCopyWith`.
pub const GENERATE_COPY_WITH: BooleanOption = BooleanOption::new(
    "copy-with",
    "Generate CopyWith method",
    false,
    OptionKind::Primary,
);

/// TS `dartOptions.useFreezed`.
pub const USE_FREEZED: BooleanOption = BooleanOption::new(
    "use-freezed",
    "Generate class definitions with @freezed compatibility",
    false,
    OptionKind::Secondary,
);

/// TS `dartOptions.useHive`.
pub const USE_HIVE: BooleanOption = BooleanOption::new(
    "use-hive",
    "Generate annotations for Hive type adapters",
    false,
    OptionKind::Secondary,
);

/// TS `dartOptions.useJsonAnnotation`.
pub const USE_JSON_ANNOTATION: BooleanOption = BooleanOption::new(
    "use-json-annotation",
    "Generate annotations for json_serializable",
    false,
    OptionKind::Secondary,
);

/// TS `dartOptions.partName`.
pub const PART_NAME: StringOption = StringOption::new(
    "part-name",
    "Use this name in `part` directive",
    "NAME",
    "",
    OptionKind::Secondary,
);

/// TS `dartOptions`, in declaration order.
pub static DART_OPTIONS: &[RendererOption] = &[
    RendererOption::Boolean(JUST_TYPES),
    RendererOption::Boolean(CODERS_IN_CLASS),
    RendererOption::Boolean(METHOD_NAMES_WITH_MAP),
    RendererOption::Boolean(REQUIRED_PROPERTIES),
    RendererOption::Boolean(FINAL_PROPERTIES),
    RendererOption::Boolean(GENERATE_COPY_WITH),
    RendererOption::Boolean(USE_FREEZED),
    RendererOption::Boolean(USE_HIVE),
    RendererOption::Boolean(USE_JSON_ANNOTATION),
    RendererOption::String(PART_NAME),
];

/// TS `dartLanguageConfig`.
pub const DART_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "Dart",
    names: &["dart"],
    extension: "dart",
};

/// The Dart target language (TS `DartTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct DartTargetLanguage;

impl TargetLanguage for DartTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &DART_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        DART_OPTIONS
    }

    // Inference hooks.

    /// TS `supportsUnionsWithBothNumberTypes`.
    fn supports_unions_with_both_number_types(&self) -> bool {
        true
    }

    /// TS `stringTypeMapping`.
    fn string_type_mapping(&self) -> StringTypeMapping {
        [
            (TypeKind::Date, TypeKind::Date),
            (TypeKind::Uuid, TypeKind::Uuid),
            (TypeKind::DateTime, TypeKind::DateTime),
        ]
        .into_iter()
        .collect()
    }

    // End of inference hooks.

    // Renderer hooks.

    /// TS `makeRenderer` + `render`.
    fn render(
        &self,
        render_context: crate::renderer::RenderContext<'_>,
        renderer_options: &crate::renderer_options::RendererOptions,
        given_output_filename: &str,
        alphabetize_properties: bool,
    ) -> crate::messages::Result<crate::renderer::RenderResult> {
        let options = super::dart_renderer::DartOptions::parse(renderer_options)?;
        let renderer = super::dart_renderer::DartRenderer::new(self, render_context, options);
        crate::convenience_renderer::render_with(
            renderer,
            given_output_filename,
            alphabetize_properties,
        )
    }
}
