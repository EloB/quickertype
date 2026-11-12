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

/// Nested block comment openers:
/// {-
/// /*
/// This text must remain inside the generated documentation comment.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TopLevel {
    /// Nested property block comment openers:
    /// {-
    /// /*
    /// This text must remain inside the generated property documentation comment.
    pub value: String,
}
