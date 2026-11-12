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
    pub category: Category,

    pub details: Details,

    pub page: i64,

    pub product: Vec<ProductElement>,

    pub schk: bool,

    #[serde(rename = "match")]
    pub top_level_match: String,

    pub totallooseoffers: i64,

    pub totalpages: i64,

    pub totalresultsavailable: i64,

    pub totalresultsreturned: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Category {
    pub concatenatecategoryname: bool,

    pub hasoffer: bool,

    pub id: i64,

    pub isfinal: bool,

    pub links: Vec<LinkElement>,

    pub name: String,

    pub parentcategoryid: i64,

    pub thumbnail: CategoryThumbnail,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct LinkElement {
    pub link: LinkLink,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct LinkLink {
    #[serde(rename = "type")]
    pub link_type: String,

    pub url: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CategoryThumbnail {
    pub url: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Details {
    pub applicationid: String,

    pub applicationversion: String,

    pub code: i64,

    pub date: Date,

    pub elapsedtime: i64,

    pub message: String,

    pub status: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Date {
    pub day: i64,

    pub eonandyear: Eonandyear,

    pub hour: i64,

    pub millisecond: i64,

    pub minute: i64,

    pub month: i64,

    pub second: i64,

    pub timezone: i64,

    pub valid: bool,

    pub xmlschematype: Xmlschematype,

    pub year: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Eonandyear {
    pub lowestsetbit: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Xmlschematype {
    pub localpart: String,

    pub namespaceuri: String,

    pub prefix: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ProductElement {
    pub product: ProductProduct,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ProductProduct {
    pub categoryid: i64,

    pub currency: Currency,

    pub eco: bool,

    pub fulldescription: bool,

    pub hasmetasearch: bool,

    pub id: i64,

    pub links: Vec<LinkElement>,

    pub numoffers: i64,

    pub pricemax: String,

    pub pricemin: String,

    pub productname: String,

    pub quantity: i64,

    pub rating: Rating,

    pub specification: Specification,

    pub thumbnail: FormatsClass,

    pub totalsellers: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Currency {
    pub abbreviation: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Rating {
    pub useraveragerating: Useraveragerating,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Useraveragerating {
    pub links: Vec<LinkElement>,

    pub numcomments: i64,

    pub rating: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Specification {
    pub links: Vec<LinkElement>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Format {
    pub formats: FormatsClass,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FormatsClass {
    pub formats: Option<Vec<Format>>,

    pub height: i64,

    pub url: String,

    pub width: i64,
}
