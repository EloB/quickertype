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
    pub version: Option<String>,

    pub fruits: Option<Vec<Fruit>>,

    pub vehicles: Option<Vec<Vehicle>>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Fruit {
    pub apple: Option<bool>,

    pub berries: Option<Vec<Berry>>,

    pub orange: Option<bool>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Berry {
    pub color: Option<Color>,

    pub name: Option<String>,

    pub shapes: Option<Vec<Shape>>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Color {
    pub rgb: Option<f64>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Shape {
    pub geometry: Option<Geometry>,

    pub history: Option<History>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Geometry {
    pub rect_shape: Option<RectShape>,

    pub circular_shape: Option<Vec<CircularShape>>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct CircularShape {
    pub shape_name: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RectShape {
    pub parts: Option<Vec<Part>>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Part {
    pub depth: Option<String>,

    pub length: Option<String>,

    pub width: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct History {
    pub class: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Vehicle {
    pub brand: Option<String>,

    pub id: Option<String>,

    pub speed: Option<Speed>,

    pub sub_module: Option<bool>,

    #[serde(rename = "type")]
    pub vehicle_type: Option<VehicleType>,

    pub year: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Speed {
    pub velocity: Option<Limit>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Limit {
    pub maximum: Option<f64>,

    pub minimum: Option<f64>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct VehicleType {
    pub name: Option<Name>,

    pub width: Option<Axis>,

    pub length: Option<Axis>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Axis {
    X,

    Y,

    Z,

    #[serde(rename = "XY")]
    Xy,

    #[serde(rename = "YZ")]
    Yz,

    #[serde(rename = "ZX")]
    Zx,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Name {
    Truck,

    Bus,

    Car,

    Van,

    Train,

    #[serde(rename = "Bike")]
    Bike,

    #[serde(rename = "Aeroplane")]
    Aeroplane,

    #[serde(rename = "Jeep")]
    Jeep,

    #[serde(rename = "Trolley")]
    Trolley,
}
