//! The quicktype errors the CLI front end raises: the `Driver*` kinds of
//! `packages/quicktype-core/src/Messages.ts`, with `messageError`'s message
//! substitution.
// TODO(messages): use quicktype_core::messages once it is ported; these are
// local copies of the few kinds the front end needs.

use std::fmt;

use crate::js;

/// A `QuickTypeError` raised by the CLI front end.
#[derive(Clone, Debug, PartialEq, Eq)]
pub enum DriverError {
    /// `DriverUnknownSourceLanguage`.
    UnknownSourceLanguage {
        /// The `--src-lang` value.
        lang: String,
    },
    /// `DriverUnknownOutputLanguage`.
    UnknownOutputLanguage {
        /// The `--lang` value or `--out` extension.
        lang: String,
    },
    /// `DriverSourceLangMustBeGraphQL`.
    SourceLangMustBeGraphQL,
    /// `DriverGraphQLSchemaNeeded`.
    GraphQLSchemaNeeded,
    /// `DriverNoLanguageOrExtension`.
    NoLanguageOrExtension,
    /// `DriverCLIOptionParsingFailed`.
    CliOptionParsingFailed {
        /// What went wrong.
        message: String,
    },
}

impl DriverError {
    /// The message template (TS `errorMessage`).
    pub fn error_message(&self) -> &'static str {
        match self {
            Self::UnknownSourceLanguage { .. } => "Unknown source language ${lang}",
            Self::UnknownOutputLanguage { .. } => "Unknown output language ${lang}",
            Self::SourceLangMustBeGraphQL => {
                "If a GraphQL schema is specified, the source language must be GraphQL"
            }
            Self::GraphQLSchemaNeeded => {
                "Please specify a GraphQL schema with --graphql-schema or --graphql-introspect"
            }
            Self::NoLanguageOrExtension => {
                "Please specify a language (--lang) or an output file extension"
            }
            Self::CliOptionParsingFailed { .. } => "Option parsing failed: ${message}",
        }
    }

    fn properties(&self) -> Vec<(&'static str, &str)> {
        match self {
            Self::UnknownSourceLanguage { lang } | Self::UnknownOutputLanguage { lang } => {
                vec![("lang", lang)]
            }
            Self::CliOptionParsingFailed { message } => vec![("message", message)],
            Self::SourceLangMustBeGraphQL
            | Self::GraphQLSchemaNeeded
            | Self::NoLanguageOrExtension => vec![],
        }
    }

    /// The substituted message (TS `userMessage`): each `${name}` is
    /// replaced like JS `String.prototype.replace` does, so only the first
    /// occurrence, with `$&`-style patterns in the value expanded.
    pub fn user_message(&self) -> String {
        let mut message = self.error_message().to_owned();
        for (name, value) in self.properties() {
            message = js::replace_first(&message, &format!("${{{name}}}"), value);
        }
        message
    }
}

impl fmt::Display for DriverError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.write_str(&self.user_message())
    }
}

impl std::error::Error for DriverError {}

/// Why a CLI run failed.
#[derive(Clone, Debug, PartialEq, Eq)]
pub enum CliError {
    /// A quicktype error, printed as `Error: <message>.` with exit code 1.
    Driver(DriverError),
    /// Something the Rust port cannot do yet; printed as an internal error
    /// with exit code 2, which quicktype itself never uses.
    NotImplemented(&'static str),
}

impl CliError {
    /// The process exit code for this error.
    pub fn exit_code(&self) -> u8 {
        match self {
            Self::Driver(_) => 1,
            Self::NotImplemented(_) => 2,
        }
    }
}

impl fmt::Display for CliError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Driver(e) => e.fmt(f),
            Self::NotImplemented(what) => {
                write!(
                    f,
                    "Internal error: not implemented in the Rust port yet: {what}"
                )
            }
        }
    }
}

impl std::error::Error for CliError {}

impl From<DriverError> for CliError {
    fn from(e: DriverError) -> Self {
        Self::Driver(e)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn substitution_follows_js_replace() {
        let e = DriverError::UnknownOutputLanguage { lang: "$&".into() };
        assert_eq!(e.user_message(), "Unknown output language ${lang}");
        let e = DriverError::CliOptionParsingFailed {
            message: "UNKNOWN_OPTION: Unknown option: --foo".into(),
        };
        assert_eq!(
            e.to_string(),
            "Option parsing failed: UNKNOWN_OPTION: Unknown option: --foo"
        );
    }
}
