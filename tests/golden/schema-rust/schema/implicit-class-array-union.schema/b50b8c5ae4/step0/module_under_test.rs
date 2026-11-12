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
    pub foo: Option<FooUnion>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum FooUnion {
    Bool(bool),

    Double(f64),

    FooClass(FooClass),

    Integer(i64),

    IntegerArray(Vec<i64>),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FooClass {
    pub bar: i64,
}
