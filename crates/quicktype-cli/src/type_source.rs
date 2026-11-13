//! Port of `quicktype/src/TypeSource.ts`: the sources the CLI collects
//! before it builds the engine's input.

use quicktype_core::{JsonSchemaSourceData, Readable};
use quicktype_js_compat::json::JsonValue;

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

/// TS `GraphQLTypeSource`: a GraphQL query and the schema it runs against.
// TODO(graphql): read by the GraphQL input (Phase 5).
#[allow(dead_code)]
#[derive(Debug)]
pub struct GraphQlTypeSource {
    /// The top-level's name.
    pub name: String,
    /// The introspection schema.
    pub schema: JsonValue,
    /// The query.
    pub query: String,
}

/// TS `TypeSource`.
#[derive(Debug)]
pub enum TypeSource {
    /// `kind: "json"`.
    Json(JsonTypeSource),
    /// `kind: "schema"` (TS `SchemaTypeSource`).
    Schema(JsonSchemaSourceData),
    /// `kind: "graphql"`.
    GraphQl(GraphQlTypeSource),
}
