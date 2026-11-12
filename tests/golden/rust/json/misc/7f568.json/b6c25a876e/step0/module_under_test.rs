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

pub type TopLevel = Vec<TopLevelElement>;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TopLevelElement {
    pub comments: i64,

    pub comments_url: String,

    pub commits_url: String,

    pub created_at: String,

    pub description: Option<String>,

    pub files: HashMap<String, File>,

    pub forks_url: String,

    pub git_pull_url: String,

    pub git_push_url: String,

    pub html_url: String,

    pub id: String,

    pub public: bool,

    pub truncated: bool,

    pub updated_at: String,

    pub url: String,

    pub user: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct File {
    #[serde(rename = "type")]
    pub file_type: Type,

    pub filename: String,

    pub language: Option<Language>,

    pub raw_url: String,

    pub size: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Type {
    #[serde(rename = "text/plain")]
    TextPlain,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Language {
    Markdown,
}
