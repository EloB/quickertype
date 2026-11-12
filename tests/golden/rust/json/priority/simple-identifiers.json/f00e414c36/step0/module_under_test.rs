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
    #[serde(rename = "")]
    pub empty: String,

    pub null: String,

    #[serde(rename = "x'")]
    pub purple_x: String,

    #[serde(rename = "{}")]
    pub top_level: String,

    #[serde(rename = "continue")]
    pub top_level_continue: String,

    #[serde(rename = "x\"")]
    pub top_level_x: String,

    pub undefined: String,

    pub x: String,

    #[serde(rename = "x y")]
    pub x_y: String,
}
