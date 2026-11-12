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
    /// Nested enum block comment openers:
    /// {-
    /// /*
    /// This text must remain inside the generated enum documentation comment.
    pub kind: Kind,
}

/// Nested enum block comment openers:
/// {-
/// /*
/// This text must remain inside the generated enum documentation comment.
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Kind {
    #[serde(rename = "ok")]
    KindOk,
}
