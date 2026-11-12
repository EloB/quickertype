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
#[serde(rename_all = "camelCase")]
pub struct TopLevel {
    pub coordinates: Option<Vec<Coordinate>>,

    pub count: Option<i32>,

    pub label: Option<String>,

    pub required_coordinates: Vec<Coordinate>,

    pub required_count: i32,

    pub required_label: String,

    pub weight: Option<f64>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Coordinate {
    pub latitude: f64,

    pub longitude: f64,
}
