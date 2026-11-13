//! Why a CLI run fails, and how the failure is reported.
//!
//! TypeScript's `main(argv).catch` prints every rejection as
//! `Error: <message>.` and exits with code 1. The rejections are
//! quicktype's own errors (`messageError`, here [`QuickTypeError`] from
//! quicktype-core) and plain JavaScript `Error`s thrown by Node or a
//! library (`ENOENT: …` from `fs`, chalk-template's errors).

use std::fmt;

use quicktype_core::{ErrorKind, IoError, MessageValue, QuickTypeError};

use crate::chalk::TemplateError;

/// `messageError(kind, properties)` as a value.
pub fn message_error(kind: ErrorKind, properties: Vec<(&str, MessageValue)>) -> CliError {
    CliError::Quicktype(QuickTypeError::new(kind, properties))
}

/// Why a CLI run failed.
#[derive(Clone, Debug, PartialEq)]
pub enum CliError {
    /// A quicktype error, printed as `Error: <message>.` with exit code 1.
    Quicktype(QuickTypeError),
    /// An exception from Node's `fs` (`ENOENT: …, open 'x'`), printed as
    /// `Error: <message>.` with exit code 1.
    Io(IoError),
    /// A plain JS `Error` thrown by a library (e.g. chalk-template),
    /// printed as `Error: <message>.` with exit code 1.
    Thrown(String),
    /// Something the Rust port cannot do yet; printed as an internal error
    /// with exit code 2, which quicktype itself never uses.
    NotImplemented(String),
}

impl CliError {
    /// The process exit code for this error.
    pub fn exit_code(&self) -> u8 {
        match self {
            Self::Quicktype(_) | Self::Io(_) | Self::Thrown(_) => 1,
            Self::NotImplemented(_) => 2,
        }
    }
}

impl fmt::Display for CliError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Quicktype(e) => f.write_str(e.user_message()),
            Self::Io(e) => e.fmt(f),
            Self::Thrown(message) => f.write_str(message),
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

impl From<QuickTypeError> for CliError {
    fn from(e: QuickTypeError) -> Self {
        Self::Quicktype(e)
    }
}

impl From<TemplateError> for CliError {
    fn from(e: TemplateError) -> Self {
        match e {
            TemplateError::Thrown(message) => Self::Thrown(message),
            TemplateError::Unsupported(_) => Self::NotImplemented(e.to_string()),
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn messages_follow_message_error() {
        let e = message_error(
            ErrorKind::DriverUnknownOutputLanguage,
            vec![("lang", "$&".into())],
        );
        assert_eq!(e.to_string(), "Unknown output language ${lang}");
        assert_eq!(e.exit_code(), 1);
        let e = message_error(
            ErrorKind::DriverCLIOptionParsingFailed,
            vec![("message", "UNKNOWN_OPTION: Unknown option: --foo".into())],
        );
        assert_eq!(
            e.to_string(),
            "Option parsing failed: UNKNOWN_OPTION: Unknown option: --foo"
        );
        assert_eq!(CliError::NotImplemented("x".into()).exit_code(), 2);
    }
}
