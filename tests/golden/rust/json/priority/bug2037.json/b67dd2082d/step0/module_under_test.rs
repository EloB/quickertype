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

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TopLevel {
    pub mission_specs: HashMap<String, MissionSpec>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MissionSpec {
    pub objectives: HashMap<String, Objective>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Objective {
    pub rewards: HashMap<String, Reward>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Reward {
}
