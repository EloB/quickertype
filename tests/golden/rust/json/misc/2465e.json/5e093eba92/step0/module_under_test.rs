// Example code that deserializes and serializes the model.
// extern crate serde;
// #[macro_use]
// extern crate serde_derive;
// extern crate serde_json;
//
// use generated_module::TopLevel;
//
// fn main() {
//     let json = r#"{"answer": 42}"#;
//     let model: TopLevel = serde_json::from_str(&json).unwrap();
// }

use serde::{Serialize, Deserialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct TopLevel {
    pub base_path: String,

    pub definitions: Definitions,

    pub host: String,

    pub info: Info,

    pub paths: Paths,

    pub produces: Vec<String>,

    pub schemes: Vec<String>,

    pub swagger: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct Definitions {
    pub taxonomy: Taxonomy,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Taxonomy {
    pub properties: Properties,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Properties {
    pub annotations: Annotations,

    pub datatype_properties: Annotations,

    pub id: Annotations,

    pub label: Annotations,

    #[serde(rename = "type")]
    pub properties_type: Annotations,

    pub sub_class_of: Annotations,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Annotations {
    #[serde(rename = "type")]
    pub annotations_type: String,

    pub description: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Info {
    pub description: String,

    pub title: String,

    pub version: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Paths {
    #[serde(rename = "/ita_taxonomies/search")]
    pub ita_taxonomies_search: ItaTaxonomiesSearch,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ItaTaxonomiesSearch {
    pub get: Get,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Get {
    pub description: String,

    pub parameters: Vec<Parameter>,

    pub responses: Responses,

    pub summary: String,

    pub tags: Vec<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Parameter {
    pub description: String,

    pub format: String,

    pub name: String,

    #[serde(rename = "in")]
    pub parameter_in: String,

    #[serde(rename = "type")]
    pub parameter_type: String,

    pub required: bool,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Responses {
    #[serde(rename = "200")]
    pub the_200: The200,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct The200 {
    pub description: String,

    pub schema: Schema,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Schema {
    #[serde(rename = "$ref")]
    pub schema_ref: String,
}
