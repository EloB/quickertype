//! Port of `quicktype/src/TypeSource.ts`: the sources the CLI collects
//! before it builds the engine's input.

use crate::node_io::Readable;

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

/// TS `SchemaTypeSource` (`JSONSchemaSourceData`): JSON Schema, given by
/// address or as text.
// TODO(json-schema-input): read by the JSON Schema input.
#[allow(dead_code)]
#[derive(Debug)]
pub struct SchemaTypeSource {
    /// The top-level's name.
    pub name: String,
    /// The schema's addresses.
    pub uris: Option<Vec<String>>,
    /// The schema text (TypeScript input).
    pub schema: Option<String>,
    /// Whether the schema was converted from another language.
    pub is_converted: bool,
}

/// TS `GraphQLTypeSource`: a GraphQL query and the schema it runs against.
// TODO(graphql): read by the GraphQL input (Phase 5).
#[allow(dead_code)]
#[derive(Debug)]
pub struct GraphQlTypeSource {
    /// The top-level's name.
    pub name: String,
    /// The text of the introspection schema (TS: the parsed schema).
    pub schema: String,
    /// The query.
    pub query: String,
}

/// TS `TypeSource`.
#[derive(Debug)]
pub enum TypeSource {
    /// `kind: "json"`.
    Json(JsonTypeSource),
    /// `kind: "schema"`.
    Schema(SchemaTypeSource),
    /// `kind: "graphql"`.
    GraphQl(GraphQlTypeSource),
}
