import * as S from "effect/Schema";


export const GeometryType = S.Literal(
    "MultiPoint",
);
export type GeometryType = S.Schema.Type<typeof GeometryType>;


export const GeometryName = S.Literal(
    "geom",
);
export type GeometryName = S.Schema.Type<typeof GeometryName>;


export const FeatureType = S.Literal(
    "Feature",
);
export type FeatureType = S.Schema.Type<typeof FeatureType>;

export class FeatureProperties extends S.Class<FeatureProperties>("FeatureProperties")({
    "facebookaccount": S.String,
    "frequencyfinderurl": S.String,
    "name": S.String,
    "siteurl": S.String,
    "streetaddress": S.String,
    "twitteraccount": S.String,
}) {}

export class Geometry extends S.Class<Geometry>("Geometry")({
    "coordinates": S.Array(S.Array(S.Number)),
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
