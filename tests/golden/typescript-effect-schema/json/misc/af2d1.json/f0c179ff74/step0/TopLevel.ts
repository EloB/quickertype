import * as S from "effect/Schema";


export const GeometryType = S.Literal(
    "MultiPolygon",
);
export type GeometryType = S.Schema.Type<typeof GeometryType>;


export const GeometryName = S.Literal(
    "geom",
);
export type GeometryName = S.Schema.Type<typeof GeometryName>;


export const AddImprov = S.Literal(
    "f",
    "F",
    "t",
);
export type AddImprov = S.Schema.Type<typeof AddImprov>;


export const FundingBa = S.Literal(
    "Non GCCC",
    "Capex",
    "Initial",
    "Contribute",
);
export type FundingBa = S.Schema.Type<typeof FundingBa>;


export const LevelAccu = S.Literal(
    "GPS Corrected 1.0M",
    "APPROX",
    "GPS COrrected 1.0M",
);
export type LevelAccu = S.Schema.Type<typeof LevelAccu>;


export const Material = S.Literal(
    "Gravel",
    "Concrete",
    "Bitumen",
    "Interlock Conc Block",
    "Other",
    "Earth",
);
export type Material = S.Schema.Type<typeof Material>;


export const MiSymbolo = S.Literal(
    "Pen (2, 2, 65535) Brush (1, 0, 16777215)",
);
export type MiSymbolo = S.Schema.Type<typeof MiSymbolo>;


export const Status = S.Literal(
    "CURRENT",
);
export type Status = S.Schema.Type<typeof Status>;


export const PropertiesType = S.Literal(
    "Boat Ramp",
);
export type PropertiesType = S.Schema.Type<typeof PropertiesType>;


export const FeatureType = S.Literal(
    "Feature",
);
export type FeatureType = S.Schema.Type<typeof FeatureType>;

export class FeatureProperties extends S.Class<FeatureProperties>("FeatureProperties")({
    "add_improv": S.NullOr(AddImprov),
    "area_": S.Number,
    "asset_numb": S.String,
    "comments": S.NullOr(S.String),
    "condition": S.Int,
    "constructi": S.NullOr(S.String),
    "createdate": S.Null,
    "createuser": S.Null,
    "disposal_d": S.Null,
    "documents": S.String,
    "drawing_nu": S.NullOr(S.String),
    "file_numbe": S.NullOr(S.String),
    "folder_num": S.NullOr(S.String.pipe(S.pattern(/^-?\d+$/))),
    "funding_ba": S.NullOr(FundingBa),
    "historic_c": S.Int,
    "inspection": S.String,
    "inspectors": S.Null,
    "last_updat": S.Null,
    "level_accu": S.NullOr(LevelAccu),
    "material": Material,
    "mi_prinx": S.Int,
    "mi_symbolo": MiSymbolo,
    "number_lan": S.Int,
    "owner": S.NullOr(S.String),
    "positional": S.NullOr(LevelAccu),
    "project_nu": S.NullOr(S.String),
    "rec_id": S.Int,
    "record_cre": S.NullOr(S.String),
    "shape_area": S.Number,
    "shape_leng": S.Number,
    "status": Status,
    "survey_num": S.Null,
    "toe_rl": S.Number,
    "top_rl": S.Number,
    "type": S.NullOr(PropertiesType),
    "update_dat": S.String,
    "updatedate": S.Null,
    "updateuser": S.Null,
}) {}

export class Geometry extends S.Class<Geometry>("Geometry")({
    "coordinates": S.Array(S.Array(S.Array(S.Array(S.Number)))),
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
