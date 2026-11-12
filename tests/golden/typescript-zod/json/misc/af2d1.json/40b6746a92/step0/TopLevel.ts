import * as z from "zod";


export const GeometryTypeSchema = z.enum([
    "MultiPolygon",
]);
export type GeometryType = z.infer<typeof GeometryTypeSchema>;


export const GeometryNameSchema = z.enum([
    "geom",
]);
export type GeometryName = z.infer<typeof GeometryNameSchema>;


export const AddImprovSchema = z.enum([
    "f",
    "F",
    "t",
]);
export type AddImprov = z.infer<typeof AddImprovSchema>;


export const FundingBaSchema = z.enum([
    "Non GCCC",
    "Capex",
    "Initial",
    "Contribute",
]);
export type FundingBa = z.infer<typeof FundingBaSchema>;


export const LevelAccuSchema = z.enum([
    "GPS Corrected 1.0M",
    "APPROX",
    "GPS COrrected 1.0M",
]);
export type LevelAccu = z.infer<typeof LevelAccuSchema>;


export const MaterialSchema = z.enum([
    "Gravel",
    "Concrete",
    "Bitumen",
    "Interlock Conc Block",
    "Other",
    "Earth",
]);
export type Material = z.infer<typeof MaterialSchema>;


export const MiSymboloSchema = z.enum([
    "Pen (2, 2, 65535) Brush (1, 0, 16777215)",
]);
export type MiSymbolo = z.infer<typeof MiSymboloSchema>;


export const StatusSchema = z.enum([
    "CURRENT",
]);
export type Status = z.infer<typeof StatusSchema>;


export const PropertiesTypeSchema = z.enum([
    "Boat Ramp",
]);
export type PropertiesType = z.infer<typeof PropertiesTypeSchema>;


export const FeatureTypeSchema = z.enum([
    "Feature",
]);
export type FeatureType = z.infer<typeof FeatureTypeSchema>;

export const CrsPropertiesSchema = z.object({
    "name": z.string(),
});
export type CrsProperties = z.infer<typeof CrsPropertiesSchema>;

export const GeometrySchema = z.object({
    "coordinates": z.array(z.array(z.array(z.array(z.number())))),
    "type": GeometryTypeSchema,
});
export type Geometry = z.infer<typeof GeometrySchema>;

export const FeaturePropertiesSchema = z.object({
    "add_improv": z.union([z.null(), AddImprovSchema]),
    "area_": z.number(),
    "asset_numb": z.string(),
    "comments": z.union([z.null(), z.string()]),
    "condition": z.number().int(),
    "constructi": z.union([z.null(), z.string()]),
    "createdate": z.null(),
    "createuser": z.null(),
    "disposal_d": z.null(),
    "documents": z.string(),
    "drawing_nu": z.union([z.null(), z.string()]),
    "file_numbe": z.union([z.null(), z.string()]),
    "folder_num": z.union([z.null(), z.string().regex(/^-?\d+$/)]),
    "funding_ba": z.union([z.null(), FundingBaSchema]),
    "historic_c": z.number().int(),
    "inspection": z.string(),
    "inspectors": z.null(),
    "last_updat": z.null(),
    "level_accu": z.union([z.null(), LevelAccuSchema]),
    "material": MaterialSchema,
    "mi_prinx": z.number().int(),
    "mi_symbolo": MiSymboloSchema,
    "number_lan": z.number().int(),
    "owner": z.union([z.null(), z.string()]),
    "positional": z.union([z.null(), LevelAccuSchema]),
    "project_nu": z.union([z.null(), z.string()]),
    "rec_id": z.number().int(),
    "record_cre": z.union([z.null(), z.string()]),
    "shape_area": z.number(),
    "shape_leng": z.number(),
    "status": StatusSchema,
    "survey_num": z.null(),
    "toe_rl": z.number(),
    "top_rl": z.number(),
    "type": z.union([z.null(), PropertiesTypeSchema]),
    "update_dat": z.string(),
    "updatedate": z.null(),
    "updateuser": z.null(),
});
export type FeatureProperties = z.infer<typeof FeaturePropertiesSchema>;

export const CrsSchema = z.object({
    "properties": CrsPropertiesSchema,
    "type": z.string(),
});
export type Crs = z.infer<typeof CrsSchema>;

export const FeatureSchema = z.object({
    "geometry": GeometrySchema,
    "geometry_name": GeometryNameSchema,
    "id": z.string(),
    "properties": FeaturePropertiesSchema,
    "type": FeatureTypeSchema,
});
export type Feature = z.infer<typeof FeatureSchema>;

export const TopLevelSchema = z.object({
    "crs": CrsSchema,
    "features": z.array(FeatureSchema),
    "totalFeatures": z.number().int(),
    "type": z.string(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
