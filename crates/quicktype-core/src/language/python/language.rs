//! Port of `packages/quicktype-core/src/language/Python/language.ts`.
//!
//! Language metadata and renderer option declarations.

use crate::messages::Result;
use crate::renderer_options::{
    BooleanOption, EnumOption, OptionKind, RendererOption, RendererOptions,
};
use crate::support::integer_range::IntegerRange;
use crate::target_language::{LanguageConfig, TargetLanguage};
use crate::ty::transformed_string_type::TypeKind;
use crate::ty::type_builder_utils::StringTypeMapping;
use crate::ty::type_graph::TypeGraph;
use crate::ty::type_ref::TypeRef;

/// TS `pythonOptions.features`.
pub const FEATURES: EnumOption = EnumOption::new(
    "python-version",
    "Python version",
    &["3.5", "3.6", "3.7", "3.9", "3.10"],
    "3.10",
    OptionKind::Primary,
);

/// TS `pythonOptions.justTypes`.
pub const JUST_TYPES: BooleanOption =
    BooleanOption::new("just-types", "Classes only", false, OptionKind::Primary);

/// TS `pythonOptions.nicePropertyNames`.
pub const NICE_PROPERTY_NAMES: BooleanOption = BooleanOption::new(
    "nice-property-names",
    "Transform property names to be Pythonic",
    true,
    OptionKind::Primary,
);

/// TS `pythonOptions.pydanticBaseModel`.
pub const PYDANTIC_BASE_MODEL: BooleanOption = BooleanOption::new(
    "pydantic-base-model",
    "Uses pydantic BaseModel",
    false,
    OptionKind::Primary,
);

/// TS `pythonOptions`, in declaration order.
pub static PYTHON_OPTIONS: &[RendererOption] = &[
    RendererOption::Enum(FEATURES),
    RendererOption::Boolean(JUST_TYPES),
    RendererOption::Boolean(NICE_PROPERTY_NAMES),
    RendererOption::Boolean(PYDANTIC_BASE_MODEL),
];

/// TS `pythonLanguageConfig`.
pub const PYTHON_LANGUAGE_CONFIG: LanguageConfig = LanguageConfig {
    display_name: "Python",
    names: &["python", "py"],
    extension: "py",
};

/// The Python target language (TS `PythonTargetLanguage`).
#[derive(Clone, Copy, Debug, Default)]
pub struct PythonTargetLanguage;

impl TargetLanguage for PythonTargetLanguage {
    fn config(&self) -> &'static LanguageConfig {
        &PYTHON_LANGUAGE_CONFIG
    }

    fn options(&self) -> &'static [RendererOption] {
        PYTHON_OPTIONS
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
            (TypeKind::Date, TypeKind::Date),
            (TypeKind::Time, TypeKind::Time),
            (TypeKind::DateTime, TypeKind::DateTime),
            (TypeKind::Uuid, TypeKind::Uuid),
            (TypeKind::IntegerString, TypeKind::IntegerString),
            (TypeKind::BoolString, TypeKind::BoolString),
        ]
        .into_iter()
        .collect()
    }

    /// TS `supportsUnionsWithBothNumberTypes`.
    fn supports_unions_with_both_number_types(&self) -> bool {
        true
    }

    /// TS `needsTransformerForType`: a union if any member needs one,
    /// otherwise stringified integers and booleans.
    fn needs_transformer_for_type(&self, graph: &TypeGraph, t: TypeRef) -> Result<bool> {
        let ty = graph.type_at(t)?;
        if ty.is_union() {
            for &member in ty.members()? {
                if self.needs_transformer_for_type(graph, member)? {
                    return Ok(true);
                }
            }
            return Ok(false);
        }
        Ok(matches!(
            ty.kind(),
            TypeKind::IntegerString | TypeKind::BoolString
        ))
    }

    // End of inference hooks.

    // Renderer hooks.

    /// TS `makeRenderer`: a [`PythonPlainRenderer`](super::python_renderer::PythonPlainRenderer)
    /// with `just-types`, otherwise a
    /// [`JsonPythonRenderer`](super::json_python_renderer::JsonPythonRenderer).
    fn render(
        &self,
        render_context: crate::renderer::RenderContext<'_>,
        renderer_options: &RendererOptions,
        given_output_filename: &str,
        alphabetize_properties: bool,
    ) -> Result<crate::renderer::RenderResult> {
        let options = super::python_renderer::PythonOptions::parse(renderer_options)?;
        if options.just_types {
            let renderer =
                super::python_renderer::PythonPlainRenderer::new(self, render_context, options);
            return crate::convenience_renderer::render_with(
                renderer,
                given_output_filename,
                alphabetize_properties,
            );
        }

        let renderer =
            super::json_python_renderer::JsonPythonRenderer::new(self, render_context, options);
        crate::convenience_renderer::render_with(
            renderer,
            given_output_filename,
            alphabetize_properties,
        )
    }
}
