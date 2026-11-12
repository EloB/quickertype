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
pub struct TopLevel {
    pub literal: String,

    #[serde(rename = "#{1+1}")]
    pub the_11: i64,

    pub values: Vec<Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Value {
    #[serde(rename = "c0\u{0001}\u{001b}\u{001f}")]
    C0,

    #[serde(rename = "c1\u{007f}\u{0080}\u{0085}\u{009f}")]
    C1,
}
