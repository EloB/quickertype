//! Port of `packages/quicktype-core/src/language/Objective-C/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::renderer_options::{
    BooleanOption, EnumOption, OptionKind, RendererOption, StringOption,
};
use crate::target_language::{LanguageConfig, TargetLanguage};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_builder_utils::StringTypeMapping;

/// TS `objectiveCOptions.features`.
pub const FEATURES: EnumOption = EnumOption::new(
    "features",
    "Interface and implementation",
    &["all", "interface", "implementation"],
    "all",
    OptionKind::Primary,
);

/// TS `objectiveCOptions.justTypes`.
pub const JUST_TYPES: BooleanOption =
    BooleanOption::new("just-types", "Plain types only", false, OptionKind::Primary);

/// TS `objectiveCOptions.marshallingFunctions`.
pub const MARSHALLING_FUNCTIONS: BooleanOption =
    BooleanOption::new("functions", "C-style functions", false, OptionKind::Primary);

/// TS `objectiveCOptions.classPrefix` (default `DEFAULT_CLASS_PREFIX`).
pub const CLASS_PREFIX: StringOption = StringOption::new(
    "class-prefix",
    "Class prefix",
    "PREFIX",
    super::utils::DEFAULT_CLASS_PREFIX,
    OptionKind::Primary,
);

/// TS `objectiveCOptions.extraComments`.
pub const EXTRA_COMMENTS: BooleanOption = BooleanOption::new(
    "extra-comments",
    "Extra comments",
    false,
    OptionKind::Primary,
);

/// TS `objectiveCOptions`, in declaration order.
pub static OBJECTIVE_C_OPTIONS: &[RendererOption] = &[
    RendererOption::Enum(FEATURES),
    RendererOption::Boolean(JUST_TYPES),
    RendererOption::Boolean(MARSHALLING_FUNCTIONS),
    RendererOption::String(CLASS_PREFIX),
    RendererOption::Boolean(EXTRA_COMMENTS),
];

/// TS `objectiveCLanguageConfig`.
pub const OBJECTIVE_C_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "Objective-C",
    names: &["objc", "objective-c", "objectivec"],
    extension: "m",
};

/// The Objective-C target language (TS `ObjectiveCTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct ObjectiveCTargetLanguage;

impl TargetLanguage for ObjectiveCTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &OBJECTIVE_C_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        OBJECTIVE_C_OPTIONS
    }

    // Inference hooks.

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

    /// TS `makeRenderer` + `render`.
    fn render(
        &self,
        render_context: crate::renderer::RenderContext<'_>,
        renderer_options: &crate::renderer_options::RendererOptions,
        given_output_filename: &str,
        alphabetize_properties: bool,
    ) -> crate::messages::Result<crate::renderer::RenderResult> {
        let options = super::objective_c_renderer::ObjectiveCOptions::parse(renderer_options)?;
        let renderer =
            super::objective_c_renderer::ObjectiveCRenderer::new(self, render_context, options)?;
        crate::convenience_renderer::render_with(
            renderer,
            given_output_filename,
            alphabetize_properties,
        )
    }
}

/// The values of the `features` option: `all` (both), `interface` or
/// `implementation`.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct Features {
    /// Whether to emit the interface (`.h`) file.
    pub interface: bool,
    /// Whether to emit the implementation (`.m`) file.
    pub implementation: bool,
}
