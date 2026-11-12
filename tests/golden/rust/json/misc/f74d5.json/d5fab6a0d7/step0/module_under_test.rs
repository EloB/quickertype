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
    pub data: Vec<Vec<Datum>>,

    pub meta: Meta,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Datum {
    Integer(i64),

    PurpleString(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Meta {
    pub view: View,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct View {
    pub average_rating: i64,

    pub category: String,

    pub columns: Vec<Column>,

    pub created_at: i64,

    pub display_type: String,

    pub download_count: i64,

    pub flags: Vec<String>,

    pub grants: Vec<Grant>,

    pub hide_from_catalog: bool,

    pub hide_from_data_json: bool,

    pub id: String,

    pub index_updated_at: i64,

    pub license: License,

    pub license_id: String,

    pub locale: String,

    pub metadata: Metadata,

    pub name: String,

    pub new_backend: bool,

    pub number_of_comments: i64,

    pub oid: i64,

    pub owner: Owner,

    pub provenance: String,

    pub publication_append_enabled: bool,

    pub publication_date: i64,

    pub publication_group: i64,

    pub publication_stage: String,

    pub query: Query,

    pub rights: Vec<String>,

    pub row_class: String,

    pub rows_updated_at: i64,

    pub rows_updated_by: String,

    pub table_author: Owner,

    pub table_id: i64,

    pub total_times_rated: i64,

    pub view_count: i64,

    pub view_last_modified: i64,

    pub view_type: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Column {
    pub cached_contents: Option<CachedContents>,

    pub data_type_name: TypeName,

    pub field_name: String,

    pub flags: Option<Vec<String>>,

    pub format: Query,

    pub id: i64,

    pub name: String,

    pub position: i64,

    pub render_type_name: TypeName,

    pub table_column_id: Option<i64>,

    pub width: Option<i64>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CachedContents {
    pub average: Option<String>,

    pub largest: String,

    pub non_null: i64,

    pub null: i64,

    pub smallest: String,

    pub sum: Option<String>,

    pub top: Vec<Top>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Top {
    pub count: i64,

    pub item: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum TypeName {
    #[serde(rename = "meta_data")]
    MetaData,

    Number,

    Text,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Query {
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Grant {
    pub flags: Vec<String>,

    #[serde(rename = "type")]
    pub grant_type: String,

    pub inherited: bool,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct License {
    pub name: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Metadata {
    pub available_display_types: Vec<String>,

    pub rdf_class: String,

    pub rdf_subject: String,

    pub render_type_config: RenderTypeConfig,

    pub row_identifier: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RenderTypeConfig {
    pub visible: Visible,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Visible {
    pub table: bool,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Owner {
    pub display_name: String,

    pub id: String,

    pub screen_name: String,
}
