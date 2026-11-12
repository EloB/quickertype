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
#[serde(rename_all = "kebab-case")]
pub struct TopLevel {
    pub complex_union_array: Vec<ComplexUnionArray>,

    pub date: String,

    pub date_time: String,

    pub local_date_class: Option<LocalDate>,

    pub offset_date_time_class: Option<OffsetDateTime>,

    pub offset_time_class: Option<OffsetTime>,

    pub time: String,

    pub union_array: Vec<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum ComplexUnionArray {
    Integer(i64),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct LocalDate {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct OffsetDateTime {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct OffsetTime {
}
