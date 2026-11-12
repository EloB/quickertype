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

pub type TopLevel = Vec<TopLevelUnion>;

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum TopLevelUnion {
    FluffyTopLevel(FluffyTopLevel),

    PurpleTopLevelArray(Vec<PurpleTopLevel>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PurpleTopLevel {
    pub country: Country,

    pub date: String,

    pub decimal: String,

    pub indicator: Country,

    pub value: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Country {
    pub id: Id,

    pub value: Value,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Id {
    #[serde(rename = "CN")]
    Cn,

    #[serde(rename = "NY.GDP.MKTP.CD")]
    NyGdpMktpCd,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Value {
    China,

    #[serde(rename = "GDP (current US$)")]
    GdpCurrentUs,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FluffyTopLevel {
    pub page: i64,

    pub pages: i64,

    pub per_page: String,

    pub total: i64,
}
