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
    pub prizes: Vec<Prize>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Prize {
    pub category: Category,

    pub laureates: Vec<Laureate>,

    pub overall_motivation: Option<String>,

    pub year: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Category {
    Physics,

    Chemistry,

    Medicine,

    Literature,

    Peace,

    Economics,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Laureate {
    pub firstname: String,

    pub id: String,

    pub motivation: Option<String>,

    pub share: String,

    pub surname: String,
}
