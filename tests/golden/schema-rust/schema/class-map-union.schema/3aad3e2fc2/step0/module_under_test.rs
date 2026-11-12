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
    #[serde(rename = "union")]
    pub top_level_union: Option<HashMap<String, UnionValue>>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum UnionValue {
    Bool(bool),

    Double(f64),

    PurpleString(String),

    UnionClass(UnionClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UnionClass {
    pub quux: Option<i64>,
}
