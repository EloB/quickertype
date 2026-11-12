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
    pub query: Query,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Query {
    pub count: i64,

    pub created: String,

    pub lang: String,

    pub results: Results,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Results {
    pub channel: Channel,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Channel {
    pub astronomy: Astronomy,

    pub atmosphere: Atmosphere,

    pub description: String,

    pub image: Image,

    pub item: Item,

    pub language: String,

    pub last_build_date: String,

    pub link: String,

    pub location: Location,

    pub title: String,

    pub ttl: String,

    pub units: Units,

    pub wind: Wind,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Astronomy {
    pub sunrise: String,

    pub sunset: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Atmosphere {
    pub humidity: String,

    pub pressure: String,

    pub rising: String,

    pub visibility: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Image {
    pub height: String,

    pub link: String,

    pub title: String,

    pub url: String,

    pub width: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Item {
    pub condition: Condition,

    pub description: String,

    pub forecast: Vec<Forecast>,

    pub guid: Guid,

    pub lat: String,

    pub link: String,

    pub long: String,

    pub pub_date: String,

    pub title: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Condition {
    pub code: String,

    pub date: String,

    pub temp: String,

    pub text: Text,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Text {
    #[serde(rename = "Mostly Sunny")]
    MostlySunny,

    Sunny,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Forecast {
    pub code: String,

    pub date: String,

    pub day: String,

    pub high: String,

    pub low: String,

    pub text: Text,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Guid {
    pub is_perma_link: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Location {
    pub city: String,

    pub country: String,

    pub region: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Units {
    pub distance: String,

    pub pressure: String,

    pub speed: String,

    pub temperature: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Wind {
    pub chill: String,

    pub direction: String,

    pub speed: String,
}
