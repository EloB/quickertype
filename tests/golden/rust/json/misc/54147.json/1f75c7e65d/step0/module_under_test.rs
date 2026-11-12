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
    pub args: Args,

    pub data: String,

    pub files: Args,

    pub form: Args,

    pub headers: Headers,

    pub origin: String,

    pub url: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Args {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct Headers {
    #[serde(rename = "Accept-Encoding")]
    pub accept_encoding: String,

    pub connection: String,

    pub host: String,

    #[serde(rename = "User-Agent")]
    pub user_agent: String,
}
