//! Port of `packages/quicktype-core/src/language/Php/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{
    BooleanOption, EnumOption, OptionKind, RendererOption, acronym_option,
};
use crate::target_language::{LanguageConfig, TargetLanguage};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_builder_utils::StringTypeMapping;

/// TS `phpOptions.withGet`.
pub const WITH_GET: BooleanOption =
    BooleanOption::new("with-get", "Create Getter", true, OptionKind::Primary);

/// TS `phpOptions.fastGet`.
pub const FAST_GET: BooleanOption = BooleanOption::new(
    "fast-get",
    "getter without validation",
    false,
    OptionKind::Primary,
);

/// TS `phpOptions.withSet`.
pub const WITH_SET: BooleanOption =
    BooleanOption::new("with-set", "Create Setter", false, OptionKind::Primary);

/// TS `phpOptions.withClosing`.
pub const WITH_CLOSING: BooleanOption = BooleanOption::new(
    "with-closing",
    "PHP Closing Tag",
    false,
    OptionKind::Primary,
);

/// TS `phpOptions.acronymStyle`.
pub const ACRONYM_STYLE: EnumOption = acronym_option("pascal");

/// TS `phpOptions`, in declaration order.
pub static PHP_OPTIONS: &[RendererOption] = &[
    RendererOption::Boolean(WITH_GET),
    RendererOption::Boolean(FAST_GET),
    RendererOption::Boolean(WITH_SET),
    RendererOption::Boolean(WITH_CLOSING),
    RendererOption::Enum(ACRONYM_STYLE),
];

/// TS `phpLanguageConfig`.
pub const PHP_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "PHP",
    names: &["php"],
    extension: "php",
};

/// The PHP target language (TS `PhpTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct PhpTargetLanguage;

impl TargetLanguage for PhpTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &PHP_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        PHP_OPTIONS
    }

    // Inference hooks.

    /// TS `supportsUnionsWithBothNumberTypes`.
    fn supports_unions_with_both_number_types(&self) -> bool {
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
        let options = super::php_renderer::PhpOptions::parse(renderer_options)?;
        let renderer = super::php_renderer::PhpRenderer::new(self, render_context, options);
        crate::convenience_renderer::render_with(
            renderer,
            given_output_filename,
            alphabetize_properties,
        )
    }
}
