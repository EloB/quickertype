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

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct TopLevel {
    pub base_path: String,

    pub definitions: Definitions,

    pub host: String,

    pub info: Info,

    pub paths: Paths,

    pub produces: Vec<String>,

    pub schemes: Vec<String>,

    pub swagger: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct Definitions {
    pub article: Article,

    pub center: Article,

    pub de_minimis: DeMinimis,

    pub event: Article,

    #[serde(rename = "FAQ")]
    pub faq: Faq,

    pub lead: Article,

    pub list: Article,

    pub market_intelligence: Article,

    pub office: Article,

    pub provider: Article,

    pub rate: Article,

    pub report: Report,

    pub taxonomy: Taxonomy,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Article {
    pub properties: HashMap<String, Property>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Property {
    pub description: String,

    #[serde(rename = "type")]
    pub property_type: FormatEnum,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum FormatEnum {
    #[serde(rename = "string")]
    TypeString,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DeMinimis {
    pub properties: DeMinimisProperties,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DeMinimisProperties {
    pub countries: Property,

    pub country: Property,

    pub de_minimis_currency: Property,

    pub de_minimis_value: Property,

    pub notes: Property,

    pub vat_amount: Property,

    pub vat_currency: Property,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Faq {
    pub properties: FaqProperties,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FaqProperties {
    pub answer: Property,

    pub countries: Property,

    pub first_published_date: Property,

    pub id: Property,

    pub industries: Property,

    pub last_published_date: Property,

    pub question: Property,

    pub topics: Property,

    pub trade_regions: Property,

    pub url: Property,

    pub world_regions: Property,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Report {
    pub properties: ReportProperties,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ReportProperties {
    pub countries: Property,

    pub description: Property,

    pub expiration_date: Property,

    pub id: Property,

    pub industries: Property,

    pub ita_industries: Property,

    pub report_type: Property,

    pub title: Property,

    pub url: Property,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Taxonomy {
    pub properties: TaxonomyProperties,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TaxonomyProperties {
    pub annotations: Property,

    pub datatype_properties: Property,

    pub id: Property,

    pub label: Property,

    #[serde(rename = "type")]
    pub properties_type: Property,

    pub sub_class_of: Property,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Info {
    pub description: String,

    pub title: String,

    pub version: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Paths {
    #[serde(rename = "/business_service_providers/search")]
    pub business_service_providers_search: BusinessServiceProvidersSearchClass,

    #[serde(rename = "/consolidated_screening_list/search")]
    pub consolidated_screening_list_search: ConsolidatedScreeningListSearchClass,

    #[serde(rename = "/de_minimis/search")]
    pub de_minimis_search: ConsolidatedScreeningListSearchClass,

    #[serde(rename = "/ita_faqs/search")]
    pub ita_faqs_search: ConsolidatedScreeningListSearchClass,

    #[serde(rename = "/ita_office_locations/search")]
    pub ita_office_locations_search: ConsolidatedScreeningListSearchClass,

    #[serde(rename = "/ita_taxonomies/search")]
    pub ita_taxonomies_search: BusinessServiceProvidersSearchClass,

    #[serde(rename = "/ita_zipcode_to_post/search")]
    pub ita_zipcode_to_post_search: BusinessServiceProvidersSearchClass,

    #[serde(rename = "/market_intelligence/search")]
    pub market_intelligence_search: ConsolidatedScreeningListSearchClass,

    #[serde(rename = "/market_research_library/search")]
    pub market_research_library_search: ConsolidatedScreeningListSearchClass,

    #[serde(rename = "/tariff_rates/search")]
    pub tariff_rates_search: ConsolidatedScreeningListSearchClass,

    #[serde(rename = "/trade_articles/search")]
    pub trade_articles_search: ConsolidatedScreeningListSearchClass,

    #[serde(rename = "/trade_events/search")]
    pub trade_events_search: ConsolidatedScreeningListSearchClass,

    #[serde(rename = "/trade_leads/search")]
    pub trade_leads_search: ConsolidatedScreeningListSearchClass,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct BusinessServiceProvidersSearchClass {
    pub get: BusinessServiceProvidersSearchGet,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct BusinessServiceProvidersSearchGet {
    pub description: String,

    pub parameters: Vec<Parameter>,

    pub responses: PurpleResponses,

    pub summary: String,

    pub tags: Vec<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Parameter {
    pub description: String,

    pub format: FormatEnum,

    pub name: String,

    #[serde(rename = "in")]
    pub parameter_in: In,

    #[serde(rename = "type")]
    pub parameter_type: FormatEnum,

    pub required: bool,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum In {
    Query,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PurpleResponses {
    #[serde(rename = "200")]
    pub the_200: Purple200,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Purple200 {
    pub description: String,

    pub schema: ItemsClass,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ItemsClass {
    #[serde(rename = "$ref")]
    pub schema_ref: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ConsolidatedScreeningListSearchClass {
    pub get: ConsolidatedScreeningListSearchGet,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ConsolidatedScreeningListSearchGet {
    pub description: String,

    pub parameters: Vec<Parameter>,

    pub responses: FluffyResponses,

    pub summary: String,

    pub tags: Vec<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FluffyResponses {
    #[serde(rename = "200")]
    pub the_200: Fluffy200,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Fluffy200 {
    pub description: String,

    pub schema: PurpleSchema,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PurpleSchema {
    pub items: ItemsClass,

    #[serde(rename = "type")]
    pub schema_type: SchemaType,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum SchemaType {
    Array,
}
