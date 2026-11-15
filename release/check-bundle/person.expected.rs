// Example code that deserializes and serializes the model.
// extern crate serde;
// #[macro_use]
// extern crate serde_derive;
// extern crate serde_json;
//
// use generated_module::Person;
//
// fn main() {
//     let json = r#"{"answer": 42}"#;
//     let model: Person = serde_json::from_str(&json).unwrap();
// }

use serde::{Serialize, Deserialize};
use std::collections::HashMap;

/// A person: what the TypeScript input reads from type definitions.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Person {
    /// The full name.
    pub name: String,

    pub age: Option<f64>,

    /// When the person joined.
    pub joined: String,

    pub tags: Vec<String>,

    pub role: Role,

    pub contact: Contact,

    pub scores: HashMap<String, f64>,

    pub friends: Vec<Person>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Contact {
    pub kind: ContactKind,

    pub address: Option<String>,

    pub number: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum ContactKind {
    Email,

    Phone,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Role {
    Admin,

    Member,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Email {
    pub kind: EmailKind,

    pub address: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum EmailKind {
    Email,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Phone {
    pub kind: PhoneKind,

    pub number: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum PhoneKind {
    Phone,
}
