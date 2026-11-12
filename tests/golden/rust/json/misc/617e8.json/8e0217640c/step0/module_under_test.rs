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
    pub data: Vec<Vec<Option<Datum>>>,

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
    pub attribution: String,

    pub attribution_link: String,

    pub average_rating: i64,

    pub category: String,

    pub columns: Vec<Column>,

    pub created_at: i64,

    pub description: String,

    pub display_type: String,

    pub download_count: i64,

    pub flags: Vec<String>,

    pub grants: Vec<Grant>,

    pub hide_from_catalog: bool,

    pub hide_from_data_json: bool,

    pub id: String,

    pub index_updated_at: i64,

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

    pub rows_updated_at: i64,

    pub rows_updated_by: String,

    pub table_author: Owner,

    pub table_id: i64,

    pub tags: Vec<String>,

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

    pub description: Option<String>,

    pub field_name: String,

    pub flags: Option<Vec<String>>,

    pub format: Format,

    pub id: i64,

    pub name: String,

    pub position: i64,

    pub render_type_name: TypeName,

    pub table_column_id: Option<i64>,

    pub width: Option<i64>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CachedContents {
    pub largest: String,

    pub non_null: i64,

    pub null: i64,

    pub smallest: String,

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

    #[serde(rename = "calendar_date")]
    CalendarDate,

    Text,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Format {
    pub align: Option<String>,

    pub view: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Grant {
    pub flags: Vec<String>,

    #[serde(rename = "type")]
    pub grant_type: String,

    pub inherited: bool,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Metadata {
    pub attachments: Vec<Attachment>,

    pub available_display_types: Vec<String>,

    #[serde(rename = "custom_fields")]
    pub custom_fields: CustomFields,

    pub json_query: JsonQuery,

    pub rdf_subject: String,

    pub render_type_config: RenderTypeConfig,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Attachment {
    pub asset_id: String,

    pub blob_id: String,

    pub filename: String,

    pub name: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct CustomFields {
    #[serde(rename = "Additional Resources")]
    pub additional_resources: AdditionalResources,

    #[serde(rename = "Common Core")]
    pub common_core: CommonCore,

    #[serde(rename = "Dataset Information")]
    pub dataset_information: DatasetInformation,

    #[serde(rename = "Dataset Summary")]
    pub dataset_summary: DatasetSummary,

    pub notes: Notes,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AdditionalResources {
    #[serde(rename = "See Also")]
    pub see_also: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct CommonCore {
    #[serde(rename = "Contact Email")]
    pub contact_email: String,

    #[serde(rename = "Contact Name")]
    pub contact_name: String,

    pub publisher: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct DatasetInformation {
    pub agency: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct DatasetSummary {
    #[serde(rename = "Contact Information")]
    pub contact_information: String,

    pub coverage: String,

    #[serde(rename = "Data Frequency")]
    pub data_frequency: String,

    #[serde(rename = "Dataset Owner")]
    pub dataset_owner: String,

    pub granularity: String,

    pub organization: String,

    #[serde(rename = "Posting Frequency")]
    pub posting_frequency: String,

    #[serde(rename = "Time Period")]
    pub time_period: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct Notes {
    pub notes: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct JsonQuery {
    pub order: Vec<Order>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Order {
    pub ascending: bool,

    pub column_field_name: String,
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

    pub profile_image_url_large: String,

    pub profile_image_url_medium: String,

    pub profile_image_url_small: String,

    pub rights: Vec<String>,

    pub role_name: String,

    pub screen_name: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Query {
    pub order_bys: Vec<OrderBy>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct OrderBy {
    pub ascending: bool,

    pub expression: Expression,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Expression {
    pub column_id: i64,

    #[serde(rename = "type")]
    pub expression_type: String,
}
