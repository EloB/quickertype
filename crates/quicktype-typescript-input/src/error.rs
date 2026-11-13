//! Errors of the TypeScript input.

use std::fmt;

/// Why a set of TypeScript sources could not be turned into a JSON Schema.
#[derive(Clone, Debug, PartialEq, Eq)]
pub enum Error {
    /// quicktype's `TypeScriptCompilerError` (a TypeScript diagnostic, or an
    /// unsupported built-in type). `message` is the part after
    /// `TypeScript error: `.
    TypeScript {
        /// The message quicktype puts into the error.
        message: String,
    },
    /// An exception thrown by typescript-json-schema (for example
    /// `Unsupported type: 10n`), carrying JavaScript's `error.message`.
    Generator(String),
    /// No usable TypeScript 7 compiler was found. The reference cannot fail
    /// this way: it is this port's one deliberate divergence.
    TscNotFound(String),
    /// The compiler process failed or broke the protocol.
    Tsc(String),
}

impl Error {
    /// The `message` of the JavaScript error the reference would throw.
    pub fn message(&self) -> String {
        match self {
            Error::TypeScript { message } => format!("TypeScript error: {message}"),
            Error::Generator(m) | Error::TscNotFound(m) | Error::Tsc(m) => m.clone(),
        }
    }
}

impl fmt::Display for Error {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.write_str(&self.message())
    }
}

impl std::error::Error for Error {}

/// Result alias for this crate.
pub type Result<T> = std::result::Result<T, Error>;
