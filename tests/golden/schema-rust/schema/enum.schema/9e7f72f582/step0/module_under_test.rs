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
    pub arr: Option<Vec<Arr>>,

    #[serde(rename = "for")]
    pub top_level_for: Option<String>,

    pub gve: Gve,

    pub lvc: Option<Lvc>,

    pub other_arr: Option<Vec<OtherArr>>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Arr {
    Enum(OtherArr),

    Integer(i64),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum OtherArr {
    Foo,

    Bar,

    If,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Gve {
    Good,

    Neutral,

    Evil,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Lvc {
    Lawful,

    Neutral,

    Chaotic,
}
