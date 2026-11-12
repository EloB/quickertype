import * as S from "effect/Schema";


export const GeometryType = S.Literal(
    "Point",
);
export type GeometryType = S.Schema.Type<typeof GeometryType>;


export const GeometryName = S.Literal(
    "geom",
);
export type GeometryName = S.Schema.Type<typeof GeometryName>;


export const FireBanR = S.Literal(
    "North Central",
    "Central",
    "South West",
    "Wimmera",
    "Northern Country",
    "East Gippsland",
    "North East",
    "Mallee",
    "West &South Gippsland",
    "Ballarat",
);
export type FireBanR = S.Schema.Type<typeof FireBanR>;


export const Region = S.Literal(
    "Eastern",
    "Northern Metro",
    "Western",
    "Southern Metro",
);
export type Region = S.Schema.Type<typeof Region>;


export const PropertiesType = S.Literal(
    "STREET",
    "AVENUE",
    "ROAD",
    "HIGHWAY",
    "BOULEVARD",
    "COURT",
    "WAY",
    "DRIVE",
    "SOUTH",
    "HILL",
    "LANE",
    "CLOSE",
    "PARADE",
    "Road",
    "PLACE",
    "RD",
);
export type PropertiesType = S.Schema.Type<typeof PropertiesType>;


export const FeatureType = S.Literal(
    "Feature",
);
export type FeatureType = S.Schema.Type<typeof FeatureType>;

export class FeatureProperties extends S.Class<FeatureProperties>("FeatureProperties")({
    "division": S.String.pipe(S.pattern(/^-?\d+$/)),
    "fax": S.Number,
    "fire_ban_r": S.NullOr(FireBanR),
    "latitude": S.Number,
    "local_govt": S.String,
    "longitude": S.Number,
    "no": S.NullOr(S.String),
    "phone": S.Number,
    "postcode": S.Int,
    "psa": S.String,
    "region": Region,
    "station": S.String,
    "street": S.String,
    "suburb": S.String,
    "type": S.NullOr(PropertiesType),
}) {}

export class Geometry extends S.Class<Geometry>("Geometry")({
    "coordinates": S.Array(S.Number),
    "type": GeometryType,
}) {}

export class Feature extends S.Class<Feature>("Feature")({
    "geometry": Geometry,
    "geometry_name": GeometryName,
    "id": S.String,
    "properties": FeatureProperties,
    "type": FeatureType,
}) {}

export class CrsProperties extends S.Class<CrsProperties>("CrsProperties")({
    "name": S.String,
}) {}

export class Crs extends S.Class<Crs>("Crs")({
    "properties": CrsProperties,
    "type": S.String,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "crs": Crs,
    "features": S.Array(Feature),
    "totalFeatures": S.Int,
    "type": S.String,
}) {}
