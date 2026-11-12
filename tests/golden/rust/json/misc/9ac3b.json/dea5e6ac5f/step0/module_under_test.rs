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
    pub created_at: String,

    pub entity: String,

    pub first_name: String,

    pub id: String,

    pub last_name: String,

    pub name: String,

    pub position: Option<String>,

    pub status: Status,

    pub title: Option<Title>,

    pub updated_at: String,

    pub uri: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Status {
    Inactive,

    Active,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Title {
    Mr,

    Ms,
}
