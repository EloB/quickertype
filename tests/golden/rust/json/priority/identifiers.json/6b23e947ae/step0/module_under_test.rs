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
    pub bla: TopLevelBla,

    #[serde(rename = "")]
    pub empty: Empty,

    pub foo: Foo,

    #[serde(rename = "ThisIsA\u{01f61c}Tough\"\n\nOne")]
    pub this_is_a_tough_one: ThisIsAToughOne,

    #[serde(rename = "!")]
    pub top_level: i64,

    #[serde(rename = "Empty")]
    pub top_level_empty: EmptyClass,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TopLevelBla {
    pub bar: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Empty {
    pub x: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Foo {
    pub bla: FooBla,

    #[serde(rename = "_")]
    pub empty: i64,

    #[serde(rename = "__")]
    pub foo: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FooBla {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ThisIsAToughOne {
    #[serde(rename = "\n\n\n")]
    pub empty: i64,

    #[serde(rename = "\"")]
    pub this_is_a_tough_one: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EmptyClass {
    pub y: i64,
}
