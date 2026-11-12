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

pub type TopLevel = HashMap<String, TopLevelValue>;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TopLevelValue {
    pub channel_id: String,

    pub channel_name: String,

    pub code: String,

    pub emoticon_set: i64,

    pub id: i64,
}
