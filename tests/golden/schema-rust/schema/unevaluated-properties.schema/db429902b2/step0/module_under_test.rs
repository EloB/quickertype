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
pub struct TopLevel {
    pub config: Option<Config>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Config {
    pub closed: Option<Closed>,

    pub name: Option<String>,

    pub settings: Option<HashMap<String, Vec<Item>>>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Closed {
    AnythingArray(Vec<Option<serde_json::Value>>),

    Bool(bool),

    ClosedClass(ClosedClass),

    Double(f64),

    Integer(i64),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ClosedClass {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Item {
    pub key: String,

    pub value: String,
}
