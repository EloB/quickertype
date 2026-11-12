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
    pub intersection: String,

    pub in_union: InUnion,

    pub maxlength: String,

    pub minlength: String,

    pub min_max_intersection: String,

    pub minmaxlength: String,

    pub min_max_union: String,

    #[serde(rename = "union")]
    pub top_level_union: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum InUnion {
    Double(f64),

    PurpleString(String),
}
