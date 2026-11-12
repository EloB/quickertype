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
    pub pattern1: String,

    pub pattern2: String,

    #[serde(rename = "RegExp")]
    pub reg_exp: Option<RegExp>,

    #[serde(rename = "union")]
    pub top_level_union: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RegExp {
    pub pattern3: String,
}
