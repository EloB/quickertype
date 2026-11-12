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
    pub cost_absolute: Option<i64>,

    pub cost_max: Option<i64>,

    pub cost_min: Option<i64>,

    pub created_at: String,

    #[serde(rename = "customIncomes")]
    pub custom_incomes: Vec<CustomIncome>,

    pub direct_rep_costs_max: Option<serde_json::Value>,

    pub direct_rep_costs_min: Option<serde_json::Value>,

    pub end_date: String,

    pub eur_sources_grants: i64,

    pub eur_sources_grants_src: Option<String>,

    pub eur_sources_procurement: i64,

    pub eur_sources_procurement_src: Option<String>,

    pub id: String,

    pub new_organisation: Option<serde_json::Value>,

    pub no_clients: Option<String>,

    pub other_financial_information: Option<String>,

    pub other_sources_contributions: Option<i64>,

    pub other_sources_donation: Option<i64>,

    pub other_sources_total: Option<i64>,

    pub public_financing_infranational: Option<i64>,

    pub public_financing_national: Option<i64>,

    pub public_financing_total: Option<i64>,

    pub representative: String,

    #[serde(rename = "type")]
    pub result_type: ResultType,

    pub start_date: String,

    pub status: Status,

    pub total_budget: Option<i64>,

    pub turnover_absolute: Option<i64>,

    pub turnover_max: Option<i64>,

    pub turnover_min: Option<i64>,

    pub updated_at: String,

    pub uri: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CustomIncome {
    pub amount: i64,

    pub created_at: String,

    #[serde(rename = "type")]
    pub custom_income_type: CustomIncomeType,

    pub id: String,

    pub name: String,

    pub status: Status,

    pub updated_at: String,

    pub uri: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum CustomIncomeType {
    Public,

    Other,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Status {
    Active,

    Inactive,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum ResultType {
    #[serde(rename = "FinancialDataNGO")]
    FinancialDataNgo,

    #[serde(rename = "FinancialDataLawyer")]
    FinancialDataLawyer,

    #[serde(rename = "FinancialDataTradeAssociation")]
    FinancialDataTradeAssociation,
}
