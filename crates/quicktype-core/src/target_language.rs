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
