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
    pub x: Vec<Option<X>>,

    pub y: Vec<Option<i64>>,

    pub z: Vec<ZElement>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum X {
    Integer(i64),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum ZElement {
    Integer(i64),

    IntegerArray(Vec<i64>),

    ZClass(ZClass),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ZClass {
    pub a: bool,
}
