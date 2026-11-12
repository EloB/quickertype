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

    pub keywords: Vec<Keyword>,

    pub links: Vec<Link>,

    pub name: String,

    pub other_names: Vec<Option<serde_json::Value>>,

    pub superseded_by: String,

    pub text: Vec<Text>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Identifier {
    pub identifier: String,

    pub scheme: Scheme,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Scheme {
    #[serde(rename = "SPDX")]
    Spdx,

    #[serde(rename = "DEP5")]
    Dep5,

    Trove,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "kebab-case")]
pub enum Keyword {
    Discouraged,

    Obsolete,

    #[serde(rename = "osi-approved")]
    OsiApproved,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Link {
    pub note: String,

    pub url: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Text {
    pub media_type: String,

    pub title: String,

    pub url: String,
}
