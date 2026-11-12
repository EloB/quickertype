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

pub type TopLevel = Vec<TopLevelElement>;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TopLevelElement {
    pub age: i64,

    pub country: Country,

    pub females: i64,

    pub males: i64,

    pub total: i64,

    pub year: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Country {
    #[serde(rename = "United States")]
    UnitedStates,
}
