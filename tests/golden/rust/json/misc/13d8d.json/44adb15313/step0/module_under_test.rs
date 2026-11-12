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
    pub category: String,

    pub context: String,

    pub id: i64,

    pub location: Location,

    pub location_subtype: String,

    pub location_type: String,

    pub month: String,

    pub outcome_status: OutcomeStatus,

    pub persistent_id: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Location {
    pub latitude: String,

    pub longitude: String,

    pub street: Street,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Street {
    pub id: i64,

    pub name: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct OutcomeStatus {
    pub category: String,

    pub date: String,
}
