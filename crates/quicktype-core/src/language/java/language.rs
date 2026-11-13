//! Port of `packages/quicktype-core/src/language/Java/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{
    BooleanOption, EnumOption, OptionKind, RendererOption, StringOption,
};
use crate::support::acronyms::acronym_option;
use crate::target_language::{LanguageConfig, TargetLanguage};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_builder_utils::StringTypeMapping;

/// TS `javaOptions.useList`.
pub const USE_LIST: EnumOption = EnumOption::new(
    "array-type",
    "Use T[] or List<T>",
    &["array", "list"],
    "list",
    OptionKind::Primary,
);

/// TS `javaOptions.justTypes`.
pub const JUST_TYPES: BooleanOption =
    BooleanOption::new("just-types", "Plain types only", false, OptionKind::Primary);

/// TS `javaOptions.dateTimeProvider`.
pub const DATE_TIME_PROVIDER: EnumOption = EnumOption::new(
    "datetime-provider",
    "Date time provider type",
    &["java8", "legacy"],
    "java8",
    OptionKind::Primary,
);

/// TS `javaOptions.acronymStyle`.
pub const ACRONYM_STYLE: EnumOption = acronym_option("pascal");

/// TS `javaOptions.packageName`.
pub const PACKAGE_NAME: StringOption = StringOption::new(
    "package",
    "Generated package name",
    "NAME",
    "io.quicktype",
    OptionKind::Primary,
);

/// TS `javaOptions.lombok`.
pub const LOMBOK: BooleanOption =
    BooleanOption::new("lombok", "Use lombok", false, OptionKind::Primary);

/// TS `javaOptions.lombokCopyAnnotations`.
pub const LOMBOK_COPY_ANNOTATIONS: BooleanOption = BooleanOption::new(
    "lombok-copy-annotations",
    "Copy accessor annotations",
    true,
    OptionKind::Secondary,
);

/// TS `javaOptions`, in declaration order.
pub static JAVA_OPTIONS: &[RendererOption] = &[
    RendererOption::Enum(USE_LIST),
    RendererOption::Boolean(JUST_TYPES),
    RendererOption::Enum(DATE_TIME_PROVIDER),
    RendererOption::Enum(ACRONYM_STYLE),
    RendererOption::String(PACKAGE_NAME),
    RendererOption::Boolean(LOMBOK),
    RendererOption::Boolean(LOMBOK_COPY_ANNOTATIONS),
];

/// TS `javaLanguageConfig`.
pub const JAVA_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "Java",
    names: &["java"],
    extension: "java",
};

/// The Java target language (TS `JavaTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct JavaTargetLanguage;

impl TargetLanguage for JavaTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &JAVA_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        JAVA_OPTIONS
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
            (TypeKind::Time, TypeKind::Time),
            (TypeKind::DateTime, TypeKind::DateTime),
            (TypeKind::Uuid, TypeKind::Uuid),
        ]
        .into_iter()
        .collect()
    }

    // End of inference hooks.

    // Renderer hooks.

    /// TS `makeRenderer` + `render`: [`JavaPlainRenderer`] with
    /// `--just-types`, else [`JacksonRenderer`].
    ///
    /// [`JavaPlainRenderer`]: super::java_renderer::JavaPlainRenderer
    /// [`JacksonRenderer`]: super::java_jackson_renderer::JacksonRenderer
    fn render(
        &self,
        render_context: crate::renderer::RenderContext<'_>,
        renderer_options: &crate::renderer_options::RendererOptions,
        given_output_filename: &str,
        alphabetize_properties: bool,
    ) -> crate::messages::Result<crate::renderer::RenderResult> {
        let options = super::java_renderer::JavaOptions::parse(renderer_options)?;
        if options.just_types {
            let renderer =
                super::java_renderer::JavaPlainRenderer::new(self, render_context, options);
            return crate::convenience_renderer::render_with(
                renderer,
                given_output_filename,
                alphabetize_properties,
            );
        }
        let renderer =
            super::java_jackson_renderer::JacksonRenderer::new(self, render_context, options);
        crate::convenience_renderer::render_with(
            renderer,
            given_output_filename,
            alphabetize_properties,
        )
    }
}

/// TS `javaOptions.dateTimeProvider` values: which date-time API the
/// generated code uses.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum DateTimeProviderKind {
    /// `"java8"`: `java.time` (TS `Java8DateTimeProvider`).
    Java8,
    /// `"legacy"`: `java.util.Date` (TS `JavaLegacyDateTimeProvider`).
    Legacy,
}

/// The value of TS `javaOptions.dateTimeProvider`, as the renderers compare
/// it.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum DateTimeProviderOption {
    /// `"java8"`.
    Java8,
    /// `"legacy"`.
    Legacy,
    /// An `Object.prototype` member: the constructor's `switch` takes its
    /// default (the Java 8 provider), but it is not `=== "java8"` where the
    /// Jackson renderer asks.
    Other(crate::renderer_options::PrototypeMember),
}

impl DateTimeProviderOption {
    /// The provider the `JavaRenderer` constructor's `switch` creates.
    pub fn provider_kind(self) -> DateTimeProviderKind {
        match self {
            DateTimeProviderOption::Legacy => DateTimeProviderKind::Legacy,
            DateTimeProviderOption::Java8 | DateTimeProviderOption::Other(_) => {
                DateTimeProviderKind::Java8
            }
        }
    }
}
