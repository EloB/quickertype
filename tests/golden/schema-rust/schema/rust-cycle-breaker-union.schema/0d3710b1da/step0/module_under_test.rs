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
    pub next: Option<Box<Next>>,

    pub value: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Node {
    pub next: Option<Box<Next>>,

    pub value: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Next {
    Node(Node),

    PurpleString(String),
}
