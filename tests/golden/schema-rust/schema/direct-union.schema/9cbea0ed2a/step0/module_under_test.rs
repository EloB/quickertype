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
    pub array_node: Option<ArrayNode>,

    pub boolean_node: Option<BooleanNode>,

    pub double_node: Option<DoubleNode>,

    pub int_node: Option<IntNode>,

    pub long_node: Option<LongNode>,

    pub null_node: Option<NullNode>,

    pub object_node: Option<ObjectNode>,

    pub stuff: HashMap<String, Thing>,

    pub text_node: Option<TextNode>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ArrayNode {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct BooleanNode {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DoubleNode {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct IntNode {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct LongNode {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct NullNode {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ObjectNode {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Thing {
    pub optional: Option<Anything>,

    pub required: Option<Anything>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Anything {
    AnythingArray(Vec<Option<serde_json::Value>>),

    AnythingMap(HashMap<String, Option<serde_json::Value>>),

    Bool(bool),

    Double(f64),

    Integer(i64),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TextNode {
}
