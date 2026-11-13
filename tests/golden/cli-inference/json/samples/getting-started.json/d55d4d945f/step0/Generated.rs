// Example code that deserializes and serializes the model.
// extern crate serde;
// #[macro_use]
// extern crate serde_derive;
// extern crate serde_json;
//
// use generated_module::Generated;
//
// fn main() {
//     let json = r#"{"answer": 42}"#;
//     let model: Generated = serde_json::from_str(&json).unwrap();
// }

use serde::{Serialize, Deserialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Generated {
    pub greeting: String,

    pub instructions: Vec<String>,
}
