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
    pub children_data: Vec<TopLevel>,

    pub id: i64,

    pub is_active: bool,

    pub level: i64,

    pub name: String,

    pub parent_id: i64,

    pub position: i64,

    pub product_count: i64,
}
