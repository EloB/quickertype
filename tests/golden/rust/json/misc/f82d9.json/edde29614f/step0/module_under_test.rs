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
    pub report: Report,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Report {
    pub properties: Properties,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Properties {
    pub click_url: ClickUrl,

    pub country: ClickUrl,

    pub description: ClickUrl,

    pub expiration_date: ClickUrl,

    pub id: ClickUrl,

    pub industry: ClickUrl,

    pub report_type: ClickUrl,

    pub source_industry: ClickUrl,

    pub title: ClickUrl,

    pub url: ClickUrl,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ClickUrl {
    #[serde(rename = "type")]
    pub click_url_type: Type,

    pub description: String,
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
    #[serde(rename = "/market_research_library/search")]
    pub market_research_library_search: MarketResearchLibrarySearch,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MarketResearchLibrarySearch {
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
    pub parameter_in: String,

    #[serde(rename = "type")]
    pub parameter_type: Type,

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
    pub items: Items,

    #[serde(rename = "type")]
    pub schema_type: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Items {
    #[serde(rename = "$ref")]
    pub items_ref: String,
}
