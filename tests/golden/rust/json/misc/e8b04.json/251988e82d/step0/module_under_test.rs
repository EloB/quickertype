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

pub type TopLevel = Vec<TopLevelElement>;

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct TopLevelElement {
    pub average_rating: i64,

    pub category: Option<String>,

    pub created_at: i64,

    pub description: Option<String>,

    pub display_type: Option<DisplayType>,

    pub download_count: i64,

    pub flags: Option<Vec<TopLevelFlag>>,

    pub grants: Vec<Grant>,

    pub hide_from_catalog: bool,

    pub hide_from_data_json: bool,

    pub id: String,

    pub index_updated_at: Option<i64>,

    pub locale: String,

    pub metadata: TopLevelMetadata,

    pub moderation_status: Option<bool>,

    pub modifying_view_uid: Option<ModifyingViewUid>,

    pub name: String,

    pub new_backend: bool,

    pub number_of_comments: i64,

    pub oid: i64,

    pub owner: Owner,

    pub provenance: Provenance,

    pub publication_append_enabled: bool,

    pub publication_date: Option<i64>,

    pub publication_group: i64,

    pub publication_stage: PublicationStage,

    pub ratings: Option<Ratings>,

    pub resource_name: Option<String>,

    pub rights: Vec<Right>,

    pub row_class: Option<String>,

    pub row_identifier_column_id: Option<i64>,

    pub rows_updated_at: Option<i64>,

    pub rows_updated_by: Option<RowsUpdatedBy>,

    pub table_author: TableAuthor,

    pub table_id: i64,

    pub tags: Option<Vec<String>>,

    pub total_times_rated: i64,

    pub view_count: i64,

    pub view_last_modified: i64,

    pub view_type: ViewType,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum DisplayType {
    Table,

    #[serde(rename = "data_lens")]
    DataLens,

    Fatrow,

    Page,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub enum TopLevelFlag {
    Default,

    Restorable,

    #[serde(rename = "restorePossibleForType")]
    RestorePossibleForType,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Grant {
    pub flags: Vec<GrantFlag>,

    #[serde(rename = "type")]
    pub grant_type: GrantType,

    pub inherited: bool,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum GrantFlag {
    Public,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum GrantType {
    Viewer,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct TopLevelMetadata {
    pub available_display_types: Option<Vec<DisplayType>>,

    #[serde(rename = "custom_fields")]
    pub custom_fields: Option<CustomFields>,

    pub json_query: Option<JsonQuery>,

    pub rdf_class: Option<String>,

    pub rdf_subject: Option<String>,

    pub render_type_config: Option<MetadataRenderTypeConfig>,

    pub rich_renderer_configs: Option<RichRendererConfigs>,

    pub row_identifier: Option<String>,

    pub row_label: Option<String>,

    #[serde(rename = "v1_archived_properties")]
    pub v1_archived_properties: Option<V1ArchivedProperties>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "SCREAMING_SNAKE_CASE")]
pub struct CustomFields {
    pub test: Test,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "SCREAMING_SNAKE_CASE")]
pub struct Test {
    pub cfpb1: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct JsonQuery {
    pub group: Option<Vec<Group>>,

    #[serde(rename = "where")]
    pub json_query_where: Option<Where>,

    pub order: Option<Vec<Order>>,

    pub select: Option<Vec<Select>>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Group {
    pub column_field_name: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Where {
    pub children: Option<Vec<Child>>,

    pub column_field_name: Option<ChildColumnFieldName>,

    pub metadata: Option<ChildMetadata>,

    pub operator: WhereOperator,

    pub value: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Child {
    pub column_field_name: ChildColumnFieldName,

    pub metadata: Option<ChildMetadata>,

    pub operator: ChildOperator,

    pub value: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum ChildColumnFieldName {
    Product,

    #[serde(rename = "complaint_what_happened")]
    ComplaintWhatHappened,

    #[serde(rename = "sub_product")]
    SubProduct,

    Issue,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ChildMetadata {
    pub custom_values: Option<Vec<String>>,

    pub freeform: Option<bool>,

    pub include_auto: Option<i64>,

    pub operator: Option<MetadataOperator>,

    pub table_column_id: Option<TableColumnId>,

    pub unified_version: Option<i64>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum MetadataOperator {
    #[serde(rename = "EQUALS")]
    Equals,

    #[serde(rename = "blank?")]
    Blank,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TableColumnId {
    #[serde(rename = "2819740")]
    pub the_2819740: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "SCREAMING_SNAKE_CASE")]
pub enum ChildOperator {
    Equals,

    #[serde(rename = "IS_NOT_BLANK")]
    IsNotBlank,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum WhereOperator {
    #[serde(rename = "EQUALS")]
    Equals,

    #[serde(rename = "AND")]
    And,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Order {
    pub ascending: bool,

    pub column_field_name: OrderColumnFieldName,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum OrderColumnFieldName {
    #[serde(rename = "date_received")]
    DateReceived,

    #[serde(rename = "agreement_date")]
    AgreementDate,

    #[serde(rename = "in_effect_as_of_1_1_2012")]
    InEffectAsOf1_1_2012,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Select {
    pub aggregate: Option<String>,

    pub column_field_name: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MetadataRenderTypeConfig {
    pub visible: PurpleVisible,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PurpleVisible {
    pub fatrow: Option<bool>,

    pub table: Option<bool>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct RichRendererConfigs {
    pub fat_row: FatRow,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FatRow {
    pub columns: Vec<Column>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Column {
    pub rows: Vec<Row>,

    pub styles: Styles,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Row {
    pub fields: Vec<Field>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Field {
    #[serde(rename = "type")]
    pub field_type: FieldType,

    pub table_column_id: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub enum FieldType {
    #[serde(rename = "columnLabel")]
    ColumnLabel,

    #[serde(rename = "columnData")]
    ColumnData,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Styles {
    pub width: Width,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Width {
    #[serde(rename = "27%")]
    The27,

    #[serde(rename = "40%")]
    The40,

    #[serde(rename = "30%")]
    The30,

    #[serde(rename = "33%")]
    The33,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct V1ArchivedProperties {
    pub access_points: AccessPoints,

    #[serde(rename = "blist_id")]
    pub blist_id: String,

    pub render_type_config: V1ArchivedPropertiesRenderTypeConfig,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AccessPoints {
    pub new_view: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct V1ArchivedPropertiesRenderTypeConfig {
    pub visible: FluffyVisible,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FluffyVisible {
    pub href: bool,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "kebab-case")]
pub enum ModifyingViewUid {
    #[serde(rename = "s6ew-h6mp")]
    S6EwH6Mp,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Owner {
    pub display_name: String,

    pub flags: Option<Vec<String>>,

    pub id: String,

    pub last_notification_seen_at: Option<i64>,

    pub profile_image_url_large: Option<String>,

    pub profile_image_url_medium: Option<String>,

    pub profile_image_url_small: Option<String>,

    pub rights: Option<Vec<String>>,

    pub role_name: Option<RoleName>,

    pub screen_name: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum RoleName {
    Administrator,

    Publisher,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Provenance {
    Official,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum PublicationStage {
    Published,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Ratings {
    pub rating: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Right {
    Read,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "kebab-case")]
pub enum RowsUpdatedBy {
    #[serde(rename = "pjxg-ve4m")]
    PjxgVe4M,

    #[serde(rename = "54a3-qyun")]
    The54A3Qyun,

    #[serde(rename = "9e3m-2843")]
    The9E3M2843,

    #[serde(rename = "vvca-fr6g")]
    VvcaFr6G,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct TableAuthor {
    pub display_name: String,

    pub id: String,

    pub rights: Option<Vec<String>>,

    pub role_name: Option<RoleName>,

    pub screen_name: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum ViewType {
    Tabular,
}
