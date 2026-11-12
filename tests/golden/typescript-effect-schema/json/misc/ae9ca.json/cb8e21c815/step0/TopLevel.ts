import * as S from "effect/Schema";


export const GeometryType = S.Literal(
    "Point",
);
export type GeometryType = S.Schema.Type<typeof GeometryType>;


export const ClassEnum = S.Literal(
    "No Code Allocated",
    "OS-District",
    "OS-Neighbourhood",
    "OS-Regional",
);
export type ClassEnum = S.Schema.Type<typeof ClassEnum>;


export const MaintainingAuthority = S.Literal(
    "City of Ballarat",
);
export type MaintainingAuthority = S.Schema.Type<typeof MaintainingAuthority>;


export const Ward = S.Literal(
    "South",
    "North",
    "Central",
);
export type Ward = S.Schema.Type<typeof Ward>;


export const FeatureType = S.Literal(
    "Feature",
);
export type FeatureType = S.Schema.Type<typeof FeatureType>;

export class Properties extends S.Class<Properties>("Properties")({
    "Area": S.String,
    "Central Asset ID": S.String,
    "Class": ClassEnum,
    "Feature Location": S.String,
    "lat": S.String,
    "long": S.String,
    "Maintaining Authority": MaintainingAuthority,
    "Number": S.String.pipe(S.pattern(/^-?\d+$/)),
    "Site Name": S.String,
    "Ward": Ward,
}) {}

export class Geometry extends S.Class<Geometry>("Geometry")({
    "coordinates": S.Array(S.Number),
    "type": GeometryType,
}) {}

export class Feature extends S.Class<Feature>("Feature")({
    "geometry": Geometry,
    "properties": Properties,
    "type": FeatureType,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "features": S.Array(Feature),
    "name": S.String,
    "type": S.String,
}) {}
