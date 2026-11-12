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

    pub superseded_by: Option<String>,

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

    Trove,

    #[serde(rename = "DEP5")]
    Dep5,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "kebab-case")]
pub enum Keyword {
    #[serde(rename = "osi-approved")]
    OsiApproved,

    Discouraged,

    Redundant,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Link {
    pub note: Note,

    pub url: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Note {
    #[serde(rename = "OSI Page")]
    OsiPage,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Text {
    pub media_type: MediaType,

    pub title: Title,

    pub url: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum MediaType {
    #[serde(rename = "text/html")]
    TextHtml,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Title {
    #[serde(rename = "HTML")]
    Html,
}
