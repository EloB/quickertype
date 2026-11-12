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
    pub callsign: Callsign,

    pub priority: Priority,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Callsign {
    Alpha,

    Bravo,

    Charlie,

    Delta,

    Echo,

    Foxtrot,

    Golf,

    Hotel,

    India,

    Juliett,

    Kilo,

    Lima,

    Mike,

    November,

    Oscar,

    Papa,

    Quebec,

    Romeo,

    Sierra,

    Tango,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Priority {
    Low,

    Medium,

    High,
}
