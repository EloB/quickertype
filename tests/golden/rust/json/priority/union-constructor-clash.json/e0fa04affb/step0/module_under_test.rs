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
    #[serde(rename = "BoolInUnion")]
    pub bool_in_union: BoolInUnion,

    #[serde(rename = "union")]
    pub top_level_union: Vec<Union>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct BoolInUnion {
    pub a: bool,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Union {
    Bool(bool),

    Integer(i64),
}
