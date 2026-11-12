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
    pub count: i64,

    pub facets: Facets,

    pub limit: i64,

    pub next: String,

    pub offset: i64,

    pub previous: bool,

    pub results: Vec<ResultElement>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Facets {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ResultElement {
    pub acronym: Option<String>,

    pub created_at: String,

    pub id: String,

    pub name: String,

    pub updated_at: String,

    pub uri: String,
}
