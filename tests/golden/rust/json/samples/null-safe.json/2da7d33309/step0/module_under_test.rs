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
    pub item: Vec<Item>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Item {
    pub address: Option<Address>,

    pub created_at: Option<String>,

    pub name: String,

    pub sex: Option<i64>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Address {
    pub city: String,

    pub country: String,

    pub street: String,
}
