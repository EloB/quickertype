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
    pub above_i32_max: i64,

    pub below_i32_min: i64,

    pub i32_range: i32,

    pub large_bounds: i64,

    pub only_maximum: i64,

    pub only_minimum: i64,

    pub small_negative: i32,

    pub small_positive: i32,

    pub unbounded: i64,
}
