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

    pub activity_consult_committees: String,

    pub activity_eu_legislative: String,

    pub activity_expert_groups: String,

    pub activity_high_level_groups: String,

    pub activity_industry_forums: String,

    pub activity_inter_groups: String,

    pub activity_other: Option<String>,

    pub activity_relevant_comm: String,

    pub be_office_country: Option<String>,

    pub be_office_lat: Option<f64>,

    pub be_office_lon: Option<f64>,

    pub be_office_phone: Option<String>,

    pub be_office_post_code: Option<String>,

    pub be_office_postbox: Option<String>,

    pub be_office_street: Option<String>,

    pub be_office_town: Option<String>,

    pub code_of_conduct: String,

    pub contact_country: i64,

    pub created_at: String,

    pub entity: String,

    pub goals: String,

    pub head: String,

    pub head_office_country: String,

    pub head_office_lat: Option<f64>,

    pub head_office_lon: Option<f64>,

    pub head_office_phone: String,

    pub head_office_post_code: Option<String>,

    pub head_office_postbox: Option<String>,

    pub head_office_street: String,

    pub head_office_town: String,

    pub id: String,

    pub identification_code: String,

    pub info_members: String,

    pub last_update_date: String,

    pub legal: String,

    pub legal_status: String,

    pub main_category: i64,

    pub main_category_title: String,

    pub members: i64,

    pub members_100: Option<i64>,

    pub members_25: Option<i64>,

    pub members_50: Option<i64>,

    pub members_75: Option<i64>,

    pub members_fte: f64,

    pub name: String,

    pub native_name: Option<serde_json::Value>,

    pub networking: Option<String>,

    pub number_of_natural_persons: Option<i64>,

    pub other_code_of_conduct: Option<String>,

    pub registration_date: String,

    pub status: Status,

    pub structure_members: String,

    pub sub_category: i64,

    pub sub_category_title: String,

    pub updated_at: String,

    pub uri: String,

    pub web_site_url: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Status {
    Active,

    Inactive,
}
