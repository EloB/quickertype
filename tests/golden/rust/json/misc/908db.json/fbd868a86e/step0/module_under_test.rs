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
    pub states: Vec<StateElement>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StateElement {
    pub state: StateState,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StateState {
    pub state_id: String,

    pub state_name: String,
}
