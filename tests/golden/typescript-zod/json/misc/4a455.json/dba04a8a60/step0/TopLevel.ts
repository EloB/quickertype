import * as z from "zod";


export const GeometryTypeSchema = z.enum([
    "MultiPoint",
]);
export type GeometryType = z.infer<typeof GeometryTypeSchema>;


export const GeometryNameSchema = z.enum([
    "geom",
]);
export type GeometryName = z.infer<typeof GeometryNameSchema>;


export const FeatureTypeSchema = z.enum([
    "Feature",
]);
export type FeatureType = z.infer<typeof FeatureTypeSchema>;

export const CrsPropertiesSchema = z.object({
    "name": z.string(),
});
export type CrsProperties = z.infer<typeof CrsPropertiesSchema>;

export const GeometrySchema = z.object({
    "coordinates": z.array(z.array(z.number())),
    "type": GeometryTypeSchema,
});
export type Geometry = z.infer<typeof GeometrySchema>;

export const FeaturePropertiesSchema = z.object({
    "facebookaccount": z.string(),
    "frequencyfinderurl": z.string(),
    "name": z.string(),
    "siteurl": z.string(),
    "streetaddress": z.string(),
    "twitteraccount": z.string(),
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
