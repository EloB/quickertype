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
    pub metadata: Metadata,

    pub results: Vec<ResultElement>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Metadata {
    pub execution_time: f64,

    pub response_info: ResponseInfo,

    pub resultset: Resultset,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ResponseInfo {
    pub developer_message: String,

    pub status: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Resultset {
    pub count: i64,

    pub page: i64,

    pub pagesize: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ResultElement {
    pub attachments: Vec<Option<serde_json::Value>>,

    pub body: String,

    pub changed: String,

    pub component: Vec<Component>,

    pub created: String,

    pub date: String,

    pub image: Vec<Option<serde_json::Value>>,

    pub teaser: Vec<Option<serde_json::Value>>,

    pub title: String,

    pub topic: Vec<Option<serde_json::Value>>,

    pub url: String,

    pub uuid: String,

    pub vuuid: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Component {
    pub name: Name,

    pub uuid: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Name {
    #[serde(rename = "Office on Violence Against Women")]
    OfficeOnViolenceAgainstWomen,
}
