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
    pub code: String,

    pub column_names: Vec<String>,

    pub data: Vec<Vec<Option<Datum>>>,

    pub description: String,

    pub display_url: String,

    pub errors: Errors,

    pub frequency: String,

    pub from_date: String,

    pub id: i64,

    pub name: String,

    pub premium: bool,

    pub source_code: String,

    pub source_name: String,

    pub to_date: String,

    #[serde(rename = "type")]
    pub top_level_type: String,

    pub updated_at: String,

    pub urlize_name: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Datum {
    Double(f64),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Errors {
}
