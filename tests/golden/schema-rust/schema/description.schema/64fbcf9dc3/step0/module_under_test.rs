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

/// The top-level class.
/// Its description has two lines.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "kebab-case")]
pub struct TopLevel {
    /// A pretty boolean
    pub bar: Option<bool>,

    /// An enumeration
    #[serde(rename = "enum")]
    pub top_level_enum: Enum,

    pub foo: Option<f64>,

    pub object_or_string: ObjectOrStringUnion,

    /// Either a number or a string
    #[serde(rename = "union")]
    pub top_level_union: Union,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum ObjectOrStringUnion {
    ObjectOrStringClass(ObjectOrStringClass),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ObjectOrStringClass {
    /// This must not get lost
    pub prop: f64,
}

/// An enumeration
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Enum {
    Foo,

    Bar,
}

/// Either a number or a string
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Union {
    Double(f64),

    PurpleString(String),
}
