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
    pub details: String,

    pub rates: Vec<Rate>,

    pub version: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Rate {
    pub code: String,

    pub country_code: String,

    pub name: String,

    pub periods: Vec<Period>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Period {
    pub effective_from: String,

    pub rates: Rates,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Rates {
    pub parking: Option<f64>,

    pub reduced: Option<f64>,

    pub reduced1: Option<f64>,

    pub reduced2: Option<f64>,

    pub standard: f64,

    pub super_reduced: Option<f64>,
}
