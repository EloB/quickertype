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
#[serde(untagged)]
pub enum TopLevel {
    AnythingMap(HashMap<String, Option<serde_json::Value>>),

    Bool(bool),

    Double(f64),

    Integer(i64),

    PurpleString(String),

    UnionArray(Vec<Option<TopLevelElement>>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum TopLevelElement {
    AnythingArray(Vec<Option<serde_json::Value>>),

    Bool(bool),

    Double(f64),

    PurpleString(String),

    TopLevelClass(TopLevelClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TopLevelClass {
    pub x: Option<X>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct XClass {
    pub x: Option<X>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum XElement {
    AnythingArray(Vec<Option<serde_json::Value>>),

    Bool(bool),

    Double(f64),

    PurpleString(String),

    XClass(XClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum X {
    AnythingMap(HashMap<String, Option<serde_json::Value>>),

    Bool(bool),

    Double(f64),

    PurpleString(String),

    UnionArray(Vec<Option<XElement>>),
}
