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
    pub pairs: HashMap<String, Pair>,

    pub server_time: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Pair {
    pub decimal_places: i64,

    pub fee: f64,

    pub hidden: i64,

    pub max_amount: i64,

    pub max_price: i64,

    pub min_amount: f64,

    pub min_price: f64,

    pub min_total: f64,
}
