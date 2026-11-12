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
    pub free: f64,

    pub intersection: f64,

    pub max: f64,

    pub min: f64,

    pub minmax: f64,

    pub min_max_intersection: f64,

    pub min_max_union: f64,

    #[serde(rename = "union")]
    pub top_level_union: f64,
}
