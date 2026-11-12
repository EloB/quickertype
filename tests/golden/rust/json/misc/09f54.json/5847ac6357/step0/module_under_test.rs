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
    pub data: HashMap<String, Datum>,

    pub description: Description,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Datum {
    pub anomaly: String,

    pub value: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Description {
    pub base_period: String,

    pub missing: i64,

    pub title: String,

    pub units: String,
}
