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
use std::collections::HashMap;

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct TopLevel {
    pub boolean_value: bool,

    pub date_value: String,

    pub different_things: Vec<DifferentThingElement>,

    pub double_value: f64,

    pub int_value: i64,

    pub map_value: HashMap<String, Option<i64>>,

    #[serde(rename = "name with spaces")]
    pub name_with_spaces: Option<serde_json::Value>,

    pub null_value: Option<serde_json::Value>,

    pub nullable_map_value: HashMap<String, Option<i64>>,

    pub people: Vec<PersonElement>,

    pub person: PurplePerson,

    pub string_value: String,

    pub tuples: Vec<Vec<IntOrString>>,

    pub uuid_value: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum DifferentThingElement {
    DifferentThingClass(DifferentThingClass),

    Integer(i64),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DifferentThingClass {
    pub name: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct PersonElement {
    pub int_or_string: IntOrString,

    pub name: String,

    pub optional_value: Option<bool>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum IntOrString {
    Integer(i64),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct PurplePerson {
    pub int_or_string: i64,

    pub name: String,
}
