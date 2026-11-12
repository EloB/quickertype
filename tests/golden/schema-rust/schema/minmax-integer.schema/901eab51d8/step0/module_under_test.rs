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
#[serde(rename_all = "camelCase")]
pub struct TopLevel {
    pub free: i32,

    pub intersection: i32,

    pub max: i32,

    pub min: i32,

    pub minmax: i32,

    pub min_max_intersection: i32,

    pub min_max_union: i32,

    #[serde(rename = "union")]
    pub top_level_union: i32,
}
