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
pub struct TopLevelElement {
    pub id: String,

    pub identifiers: Vec<Identifier>,

    pub keywords: Vec<Keyword>,

    pub links: Vec<Link>,

    pub name: String,

    pub other_names: Vec<OtherName>,

    pub superseded_by: Option<String>,

    pub text: Vec<Text>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Identifier {
    pub identifier: String,

    pub scheme: Scheme,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Scheme {
    #[serde(rename = "SPDX")]
    Spdx,

    Trove,

    #[serde(rename = "DEP5")]
    Dep5,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "kebab-case")]
pub enum Keyword {
    #[serde(rename = "osi-approved")]
    OsiApproved,

    Discouraged,

    Redundant,

    Miscellaneous,

    #[serde(rename = "non-reusable")]
    NonReusable,

    Obsolete,

    Popular,

    Permissive,

    Retired,

    #[serde(rename = "special-purpose")]
    SpecialPurpose,

    Copyleft,

    International,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Link {
    pub note: Note,

    pub url: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Note {
    #[serde(rename = "OSI Page")]
    OsiPage,

    #[serde(rename = "tl;dr legal")]
    TlDrLegal,

    #[serde(rename = "Wikipedia page")]
    WikipediaPage,

    #[serde(rename = "Wikipedia Page")]
    NoteWikipediaPage,

    #[serde(rename = "Mozilla Page")]
    MozillaPage,

    #[serde(rename = "OSET Foundation Page")]
    OsetFoundationPage,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct OtherName {
    pub name: String,

    pub note: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Text {
    pub media_type: MediaType,

    pub title: Title,

    pub url: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum MediaType {
    #[serde(rename = "text/html")]
    TextHtml,

    #[serde(rename = "text/plain")]
    TextPlain,

    #[serde(rename = "application/pdf")]
    ApplicationPdf,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Title {
    #[serde(rename = "HTML")]
    Html,

    #[serde(rename = "Plain Text")]
    PlainText,

    #[serde(rename = "PDF")]
    Pdf,
}
