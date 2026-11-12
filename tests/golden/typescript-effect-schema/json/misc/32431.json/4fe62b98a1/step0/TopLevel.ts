import * as S from "effect/Schema";


export const GeometryType = S.Literal(
    "Point",
);
export type GeometryType = S.Schema.Type<typeof GeometryType>;


export const MagType = S.Literal(
    "md",
    "ml",
    "mb",
);
export type MagType = S.Schema.Type<typeof MagType>;


export const Status = S.Literal(
    "automatic",
    "reviewed",
);
export type Status = S.Schema.Type<typeof Status>;


export const PropertiesType = S.Literal(
    "earthquake",
);
export type PropertiesType = S.Schema.Type<typeof PropertiesType>;


export const FeatureType = S.Literal(
    "Feature",
);
export type FeatureType = S.Schema.Type<typeof FeatureType>;

export class Metadata extends S.Class<Metadata>("Metadata")({
    "api": S.String,
    "count": S.Int,
    "generated": S.Int,
    "status": S.Int,
    "title": S.String,
    "url": S.String,
}) {}

export class Properties extends S.Class<Properties>("Properties")({
    "alert": S.Null,
    "cdi": S.Null,
    "code": S.String,
    "detail": S.String,
    "dmin": S.NullOr(S.Number),
    "felt": S.Null,
    "gap": S.NullOr(S.Int),
    "ids": S.String,
    "mag": S.Number,
    "magType": MagType,
    "mmi": S.Null,
    "net": S.String,
    "nst": S.NullOr(S.Int),
    "place": S.String,
    "rms": S.Number,
    "sig": S.Int,
    "sources": S.String,
    "status": Status,
    "time": S.Int,
    "title": S.String,
    "tsunami": S.Int,
    "type": PropertiesType,
    "types": S.String,
    "tz": S.Int,
    "updated": S.Int,
    "url": S.String,
}) {}

export class Geometry extends S.Class<Geometry>("Geometry")({
    "coordinates": S.Array(S.Number),
    "type": GeometryType,
}) {}

export class Feature extends S.Class<Feature>("Feature")({
    "geometry": Geometry,
    "id": S.String,
    "properties": Properties,
    "type": FeatureType,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "bbox": S.Array(S.Number),
    "features": S.Array(Feature),
    "metadata": Metadata,
    "type": S.String,
}) {}
