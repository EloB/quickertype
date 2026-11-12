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

pub type TopLevel = Vec<TopLevelElement>;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TopLevelElement {
    pub id: String,

    pub identifiers: Vec<Identifier>,

    pub keywords: Vec<String>,

    pub links: Vec<Link>,

    pub name: String,

    pub other_names: Vec<OtherName>,

    pub superseded_by: Option<serde_json::Value>,

    pub text: Vec<Text>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Identifier {
    pub identifier: String,

    pub scheme: Scheme,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Scheme {
    #[serde(rename = "DEP5")]
    Dep5,

    #[serde(rename = "SPDX")]
    Spdx,

    Trove,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Link {
    pub note: String,

    pub url: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct OtherName {
    pub name: String,

    pub note: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Text {
    pub media_type: String,

    pub title: String,

    pub url: String,
}
