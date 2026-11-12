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
    pub amount: f64,

    pub frequency: Frequency,

    pub description: Option<String>,

    #[serde(rename = "type")]
    pub top_level_type: Type,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Frequency {
    Weekly,

    Monthly,

    Annually,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Type {
    #[serde(rename = "GrossSalaryAmount")]
    GrossSalaryAmount,

    Overtime,
}
