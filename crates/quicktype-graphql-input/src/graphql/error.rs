//! Port of graphql-js 16.14.2 `error/syntaxError.js` and the part of
//! `error/GraphQLError.js` a syntax error has.

use std::fmt;

use quicktype_core::{JsErrorName, QuickTypeError};

/// A `GraphQLError` from the parser: its `message` and the position (in
/// UTF-16 code units) it points at.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct GraphQlError {
    message: String,
    position: usize,
}

impl GraphQlError {
    /// The error's `message`, e.g. `Syntax Error: Expected Name, found
    /// <EOF>.` (graphql-js shows the location only in `toString()`).
    pub fn message(&self) -> &str {
        &self.message
    }

    /// The offset in the source, in UTF-16 code units.
    pub fn position(&self) -> usize {
        self.position
    }
}

impl fmt::Display for GraphQlError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.write_str(&self.message)
    }
}

impl std::error::Error for GraphQlError {}

/// The exception as it escapes `graphql.parse`: a `GraphQLError` with the
/// same message.
impl From<GraphQlError> for QuickTypeError {
    fn from(e: GraphQlError) -> Self {
        QuickTypeError::js_exception(JsErrorName::GraphQLError, e.message)
    }
}

/// `syntaxError(source, position, description)`.
pub fn syntax_error(position: usize, description: impl Into<String>) -> GraphQlError {
    GraphQlError {
        message: format!("Syntax Error: {}", description.into()),
        position,
    }
}
