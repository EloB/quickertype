//! Port of the parts of graphql-js 16.14.2 (the `graphql` npm package)
//! that quicktype uses: `parse` from `language/` and
//! `getIntrospectionQuery` from `utilities/`.
//!
//! The lexer and parser are hand-ported rather than taken from a Rust
//! GraphQL crate, because quicktype passes graphql-js's syntax errors on to
//! the user verbatim (`Syntax Error: Expected Name, found <EOF>.`) and
//! accepts exactly the documents graphql-js accepts (`docs/PARITY.md`,
//! dependency choices).

pub mod ast;
pub mod error;
pub mod lexer;
pub mod parser;

pub use ast::Document;
pub use error::GraphQlError;
pub use parser::parse;

/// `getIntrospectionQuery()` with the default options: the query
/// `--graphql-introspect` sends, byte for byte (1,927 characters, blank
/// lines with trailing spaces included).
pub fn get_introspection_query() -> &'static str {
    include_str!("introspection_query.graphql")
}
