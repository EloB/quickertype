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
use std::collections::HashMap;

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
    pub list: List,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct List {
    pub properties: HashMap<String, Property>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Property {
    pub description: String,

    #[serde(rename = "type")]
    pub property_type: Type,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Type {
    #[serde(rename = "string")]
    TypeString,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Info {
    pub description: String,

    pub title: String,

    pub version: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Paths {
    #[serde(rename = "/consolidated_screening_list/search")]
    pub consolidated_screening_list_search: ConsolidatedScreeningListSearch,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ConsolidatedScreeningListSearch {
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

    pub format: Type,

    pub name: String,

    #[serde(rename = "in")]
    pub parameter_in: In,

    #[serde(rename = "type")]
    pub parameter_type: Type,

    pub required: bool,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum In {
    Query,
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
    pub items: Items,

    #[serde(rename = "type")]
    pub schema_type: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Items {
    #[serde(rename = "$ref")]
    pub items_ref: String,
}
