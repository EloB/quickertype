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

/// Postman collection
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TopLevel {
    pub item: Option<Vec<TopLevel>>,

    pub name: Option<String>,

    pub response: Option<Vec<Response>>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Response {
    pub body: Option<String>,
}
