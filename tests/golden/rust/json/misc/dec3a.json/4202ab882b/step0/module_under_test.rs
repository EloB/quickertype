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
    pub about_office: String,

    pub application_process: String,

    pub body: String,

    pub changed: String,

    pub created: String,

    pub deadline: Option<serde_json::Value>,

    pub hiring_office: Option<serde_json::Value>,

    pub hiring_org: HiringOrg,

    pub job_id: Option<serde_json::Value>,

    pub language: String,

    pub location: Location,

    pub num_positions: String,

    pub position: String,

    pub practice_area: String,

    pub qualifications: String,

    pub relocation_expenses: Option<serde_json::Value>,

    pub salary: String,

    pub title: String,

    pub travel: String,

    pub url: String,

    pub uuid: String,

    pub vuuid: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct HiringOrg {
    pub name: String,

    pub uuid: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Location {
    pub administrative_area: String,

    pub country: String,

    pub fax_number: String,

    pub locality: String,

    pub mobile_number: String,

    pub phone_number: String,

    pub phone_number_extension: String,

    pub postal_code: String,

    pub sub_premise: Option<serde_json::Value>,

    pub thoroughfare: String,
}
