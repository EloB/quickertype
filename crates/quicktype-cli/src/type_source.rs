//! Port of `quicktype/src/TypeSource.ts`: the sources the CLI collects
//! before it builds the engine's input.

use quicktype_core::{JsonSchemaSourceData, Readable};
use quicktype_graphql_input::GraphQlSourceData;

/// TS `JSONTypeSource`: JSON samples for one top-level. The samples are
/// opened but not read yet, as in TypeScript, where they are Node streams
/// read only when the input parses them.
#[derive(Debug)]
pub struct JsonTypeSource {
    /// The top-level's name.
    pub name: String,
    /// The samples.
    pub samples: Vec<Readable>,
    /// A description of the top-level (Postman collections).
    pub description: Option<String>,
}

/// TS `TypeSource`.
#[derive(Debug)]
pub enum TypeSource {
    /// `kind: "json"`.
    Json(JsonTypeSource),
    /// `kind: "schema"` (TS `SchemaTypeSource`).
    Schema(JsonSchemaSourceData),
    /// `kind: "graphql"` (TS `GraphQLTypeSource`): a query and the
    /// introspection schema it runs against.
    GraphQl(GraphQlSourceData),
}
