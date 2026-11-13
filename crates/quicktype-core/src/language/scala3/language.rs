//! Port of `packages/quicktype-core/src/language/Scala3/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{
    BooleanOption, EnumOption, OptionKind, RendererOption, StringOption,
};
use crate::target_language::{LanguageConfig, TargetLanguage};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_builder_utils::StringTypeMapping;

/// TS `scala3Options.justTypes`.
pub const JUST_TYPES: BooleanOption =
    BooleanOption::new("just-types", "Plain types only", false, OptionKind::Primary);

/// TS `scala3Options.framework`.
pub const FRAMEWORK: EnumOption = EnumOption::new(
    "framework",
    "Serialization framework",
    &["circe", "upickle"],
    "circe",
    OptionKind::Primary,
);

/// TS `scala3Options.packageName`.
pub const PACKAGE_NAME: StringOption = StringOption::new(
    "package",
    "Package",
    "PACKAGE",
    "quicktype",
    OptionKind::Primary,
);

/// TS `scala3Options`, in declaration order.
pub static SCALA3_OPTIONS: &[RendererOption] = &[
    RendererOption::Boolean(JUST_TYPES),
    RendererOption::Enum(FRAMEWORK),
    RendererOption::String(PACKAGE_NAME),
];

/// TS `scala3LanguageConfig`.
pub const SCALA3_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "Scala3",
    names: &["scala3"],
    extension: "scala",
};

/// The Scala3 target language (TS `Scala3TargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct Scala3TargetLanguage;

impl TargetLanguage for Scala3TargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &SCALA3_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        SCALA3_OPTIONS
    }

    // Inference hooks.

    /// TS `supportsOptionalClassProperties`.
    fn supports_optional_class_properties(&self) -> bool {
        true
    }

    /// TS `stringTypeMapping`.
    fn string_type_mapping(&self) -> StringTypeMapping {
        [
            (TypeKind::DateTime, TypeKind::DateTime),
            (TypeKind::Uuid, TypeKind::Uuid),
        ]
        .into_iter()
        .collect()
    }

    /// TS `supportsUnionsWithBothNumberTypes`.
    fn supports_unions_with_both_number_types(&self) -> bool {
        true
    }

    // End of inference hooks.

    // Renderer hooks.

    /// `makeRenderer`: `--just-types` wins over whatever `--framework`
    /// says.
    fn render(
        &self,
        render_context: crate::renderer::RenderContext<'_>,
        renderer_options: &crate::renderer_options::RendererOptions,
        given_output_filename: &str,
        alphabetize_properties: bool,
    ) -> crate::messages::Result<crate::renderer::RenderResult> {
        use super::scala3_renderer::{Framework, Scala3Options, Scala3Renderer};
        use crate::convenience_renderer::render_with;
        let options = Scala3Options::parse(renderer_options)?;
        if options.just_types {
            let renderer = Scala3Renderer::new(self, render_context, options);
            return render_with(renderer, given_output_filename, alphabetize_properties);
        }
        match options.framework {
            Framework::Upickle => {
                let renderer =
                    super::upickle_renderer::UpickleRenderer::new(self, render_context, options);
                render_with(renderer, given_output_filename, alphabetize_properties)
            }
            Framework::Circe => {
                let renderer =
                    super::circe_renderer::CirceRenderer::new(self, render_context, options);
                render_with(renderer, given_output_filename, alphabetize_properties)
            }
            Framework::Other(member) => crate::support::support::assert_never(member),
        }
    }
}
