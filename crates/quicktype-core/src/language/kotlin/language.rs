//! Port of `packages/quicktype-core/src/language/Kotlin/language.ts`.
//!
//! Language metadata and renderer option declarations.

use super::utils::KotlinDateTimeRecognizer;
use crate::date_time::DateTimeRecognizer;
use crate::renderer_options::{
    BooleanOption, EnumOption, OptionKind, RendererOption, StringOption, acronym_option,
};
use crate::target_language::{LanguageConfig, TargetLanguage};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_builder_utils::StringTypeMapping;

/// TS `kotlinOptions.justTypes`.
pub const JUST_TYPES: BooleanOption =
    BooleanOption::new("just-types", "Plain types only", false, OptionKind::Primary);

/// TS `kotlinOptions.framework`.
pub const FRAMEWORK: EnumOption = EnumOption::new(
    "framework",
    "Serialization framework",
    &["jackson", "klaxon", "kotlinx"],
    "jackson",
    OptionKind::Primary,
);

/// TS `kotlinOptions.acronymStyle`.
pub const ACRONYM_STYLE: EnumOption = acronym_option("pascal");

/// TS `kotlinOptions.packageName`.
pub const PACKAGE_NAME: StringOption = StringOption::new(
    "package",
    "Package",
    "PACKAGE",
    "quicktype",
    OptionKind::Primary,
);

/// TS `kotlinOptions`, in declaration order.
pub static KOTLIN_OPTIONS: &[RendererOption] = &[
    RendererOption::Boolean(JUST_TYPES),
    RendererOption::Enum(FRAMEWORK),
    RendererOption::Enum(ACRONYM_STYLE),
    RendererOption::String(PACKAGE_NAME),
];

/// TS `kotlinLanguageConfig`.
pub const KOTLIN_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "Kotlin",
    names: &["kotlin"],
    extension: "kt",
};

/// The Kotlin target language (TS `KotlinTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct KotlinTargetLanguage;

impl TargetLanguage for KotlinTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &KOTLIN_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        KOTLIN_OPTIONS
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

    /// TS `stringTypeMapping`.
    fn string_type_mapping(&self) -> StringTypeMapping {
        [
            (TypeKind::Date, TypeKind::Date),
            (TypeKind::Time, TypeKind::Time),
            (TypeKind::DateTime, TypeKind::DateTime),
        ]
        .into_iter()
        .collect()
    }

    /// TS `dateTimeRecognizer`: [`KotlinDateTimeRecognizer`].
    fn date_time_recognizer(&self) -> Box<dyn DateTimeRecognizer> {
        Box::new(KotlinDateTimeRecognizer)
    }

    // End of inference hooks.

    // Renderer hooks.

    /// TS `makeRenderer` + `render`: `--just-types` wins over whatever
    /// `--framework` says.
    fn render(
        &self,
        render_context: crate::renderer::RenderContext<'_>,
        renderer_options: &crate::renderer_options::RendererOptions,
        given_output_filename: &str,
        alphabetize_properties: bool,
    ) -> crate::messages::Result<crate::renderer::RenderResult> {
        use super::kotlin_renderer::{KotlinOptions, KotlinPlainRenderer};
        use crate::convenience_renderer::render_with;

        let options = KotlinOptions::parse(renderer_options)?;
        if options.just_types {
            let renderer = KotlinPlainRenderer::new(self, render_context, options);
            return render_with(renderer, given_output_filename, alphabetize_properties);
        }

        match options.framework {
            Framework::Jackson => render_with(
                super::kotlin_jackson_renderer::KotlinJacksonRenderer::new(
                    self,
                    render_context,
                    options,
                ),
                given_output_filename,
                alphabetize_properties,
            ),
            Framework::Klaxon => render_with(
                super::kotlin_klaxon_renderer::KotlinKlaxonRenderer::new(
                    self,
                    render_context,
                    options,
                ),
                given_output_filename,
                alphabetize_properties,
            ),
            Framework::KotlinX => render_with(
                super::kotlin_x_renderer::KotlinXRenderer::new(self, render_context, options),
                given_output_filename,
                alphabetize_properties,
            ),
            Framework::Other(member) => crate::support::support::assert_never(member),
        }
    }
}

/// TS `kotlinOptions.framework` values: the serialization framework.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Framework {
    /// `"jackson"` (the default).
    Jackson,
    /// `"klaxon"`.
    Klaxon,
    /// `"kotlinx"`: kotlinx.serialization.
    KotlinX,
    /// An `Object.prototype` member: `makeRenderer`'s `switch` falls
    /// through to `assertNever` (unless `--just-types` comes first).
    Other(crate::renderer_options::PrototypeMember),
}
