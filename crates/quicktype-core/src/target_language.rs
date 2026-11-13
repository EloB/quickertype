//! Port of `packages/quicktype-core/src/TargetLanguage.ts`.
//!
//! Only the language *metadata* is ported so far: names, display name,
//! output extension and the renderer option declarations, which is all the
//! CLI needs to parse arguments and print `--help`.

use crate::renderer_options::{CliOptionDefinitions, OptionDefinition, RendererOption};

/// The identity of a target language (TS `LanguageConfig`).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct LanguageConfig {
    /// Human-readable name, e.g. `"C++"`.
    pub display_name: &'static str,
    /// Names accepted by `--lang`; the first one is the canonical name.
    pub names: &'static [&'static str],
    /// File extension of the generated code, without the dot.
    pub extension: &'static str,
}

/// A language quicktype can generate code for (TS abstract class
/// `TargetLanguage`).
///
/// Every built-in language implements this trait in its `language` module;
/// [`crate::language::all`] is the registry. Implementors provide the
/// [`config`](Self::config) and the [`options`](Self::options) declarations;
/// everything else is derived from them.
// TODO(renderer): port the remaining TargetLanguage members once the type
// graph and renderer exist: `makeRenderer`, `renderGraphAndSerialize`,
// `defaultIndentation`, `stringTypeMapping`, `supportsOptionalClassProperties`,
// `supportsUnionsWithBothNumberTypes`, `supportsFullObjectType`,
// `needsTransformerForType`, `dateTimeRecognizer` and
// `getSupportedIntegerRange`. Each language module notes its overrides.
pub trait TargetLanguage: Sync {
    /// Names, display name and extension.
    fn config(&self) -> &'static LanguageConfig;

    /// The renderer option declarations (TS `getOptions()`), in declaration
    /// order.
    fn options(&self) -> &'static [RendererOption];

    // ---- Renderer hooks -------------------------------------------------
    //
    // Everything a language needs to render a type graph. A language ports
    // TS `makeRenderer` as [`render`](Self::render); see docs/RENDERERS.md.

    /// TS `supportsFullObjectType`: whether the language renders `object`
    /// types (kind `"object"`) itself instead of having them replaced by
    /// classes or maps.
    fn supports_full_object_type(&self) -> bool {
        false
    }

    /// TS `defaultIndentation`: one level of indentation when the caller
    /// gives none.
    fn default_indentation(&self) -> &'static str {
        "    "
    }

    /// TS `makeRenderer(renderContext, optionValues)`, then
    /// `setAlphabetizeProperties` and `render(givenOutputFilename)`: parses
    /// the renderer options and renders the graph.
    ///
    /// Implementations construct their renderer and hand it to
    /// [`render_with`](crate::convenience_renderer::render_with). The
    /// default reports that the language's renderer is not ported yet.
    fn render(
        &self,
        render_context: crate::renderer::RenderContext<'_>,
        renderer_options: &crate::renderer_options::RendererOptions,
        given_output_filename: &str,
        alphabetize_properties: bool,
    ) -> crate::messages::Result<crate::renderer::RenderResult> {
        let _ = (
            render_context,
            renderer_options,
            given_output_filename,
            alphabetize_properties,
        );
        crate::support::support::panic(format!(
            "The {} renderer is not ported yet",
            self.display_name()
        ))
    }

    /// TS `renderGraphAndSerialize(typeGraph, givenOutputFilename,
    /// alphabetizeProperties, leadingComments, rendererOptions,
    /// indentation)`: renders and serializes every file, indenting with
    /// `indentation` or the [default](Self::default_indentation).
    fn render_graph_and_serialize(
        &self,
        type_graph: &crate::ty::type_graph::TypeGraph,
        given_output_filename: &str,
        alphabetize_properties: bool,
        leading_comments: Option<&[crate::support::comments::Comment]>,
        renderer_options: &crate::renderer_options::RendererOptions,
        indentation: Option<&str>,
    ) -> crate::messages::Result<MultiFileRenderResult> {
        let indentation = indentation.unwrap_or_else(|| self.default_indentation());
        let render_context = crate::renderer::RenderContext {
            type_graph,
            leading_comments,
        };
        let render_result = self.render(
            render_context,
            renderer_options,
            given_output_filename,
            alphabetize_properties,
        )?;
        let mut result = MultiFileRenderResult::new();
        for (filename, source) in &render_result.sources {
            let serialized =
                crate::source::serialize_render_result(source, &render_result.names, indentation)?;
            result.insert(filename.clone(), serialized);
        }
        Ok(result)
    }

    // ---- End of renderer hooks ------------------------------------------

    /// Human-readable name, e.g. `"C#"`.
    fn display_name(&self) -> &'static str {
        self.config().display_name
    }

    /// All names accepted by `--lang`.
    fn names(&self) -> &'static [&'static str] {
        self.config().names
    }

    /// The canonical name (the first of [`names`](Self::names)).
    fn name(&self) -> &'static str {
        self.config().names.first().copied().unwrap_or_default()
    }

    /// File extension of the generated code, without the dot.
    fn extension(&self) -> &'static str {
        self.config().extension
    }

    /// The option definitions (TS `optionDefinitions`).
    fn option_definitions(&self) -> Vec<OptionDefinition> {
        self.options()
            .iter()
            .map(RendererOption::definition)
            .collect()
    }

    /// The command-line definitions of all options, concatenated in
    /// declaration order (TS `cliOptionDefinitions`).
    fn cli_option_definitions(&self) -> CliOptionDefinitions {
        let mut result = CliOptionDefinitions::default();
        for option in self.options() {
            let CliOptionDefinitions { actual, display } = option.cli_definitions();
            result.actual.extend(actual);
            result.display.extend(display);
        }
        result
    }
}

impl std::fmt::Debug for dyn TargetLanguage {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("TargetLanguage")
            .field("name", &self.name())
            .finish_non_exhaustive()
    }
}

/// `MultiFileRenderResult`: the serialized files by file name, in the order
/// the renderer finished them.
pub type MultiFileRenderResult = indexmap::IndexMap<String, crate::source::SerializedRenderResult>;
