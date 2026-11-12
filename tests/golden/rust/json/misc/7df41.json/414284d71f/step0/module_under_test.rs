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
    pub pc: Pc,

    pub ps3: Pc,

    pub ps4: Pc,

    pub xbox: Pc,

    pub xone: Pc,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Pc {
    pub count: i64,

    pub label: String,

    pub peak24: i64,
}
