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
    #[serde(rename = "bar")]
    pub barre: String,

    #[serde(rename = "enum")]
    pub enumerification: Enum,

    pub foo: String,

    #[serde(rename = "union")]
    pub unionization: Union,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Enum {
    #[serde(rename = "red")]
    Fire,

    #[serde(rename = "green")]
    Grass,

    Blue,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Union {
    Amount(f64),

    Presence(bool),
}
