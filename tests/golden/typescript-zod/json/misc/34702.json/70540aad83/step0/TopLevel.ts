import * as z from "zod";


export const GeometryTypeSchema = z.enum([
    "Point",
]);
export type GeometryType = z.infer<typeof GeometryTypeSchema>;


export const GeometryNameSchema = z.enum([
    "geom",
]);
export type GeometryName = z.infer<typeof GeometryNameSchema>;


export const FireBanRSchema = z.enum([
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
]);
export type FireBanR = z.infer<typeof FireBanRSchema>;


export const RegionSchema = z.enum([
    "Eastern",
    "Northern Metro",
    "Western",
    "Southern Metro",
]);
export type Region = z.infer<typeof RegionSchema>;


export const PropertiesTypeSchema = z.enum([
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
    "coordinates": z.array(z.number()),
    "type": GeometryTypeSchema,
});
export type Geometry = z.infer<typeof GeometrySchema>;

export const FeaturePropertiesSchema = z.object({
    "division": z.string().regex(/^-?\d+$/),
    "fax": z.number(),
    "fire_ban_r": z.union([z.null(), FireBanRSchema]),
    "latitude": z.number(),
    "local_govt": z.string(),
    "longitude": z.number(),
    "no": z.union([z.null(), z.string()]),
    "phone": z.number(),
    "postcode": z.number().int(),
    "psa": z.string(),
    "region": RegionSchema,
    "station": z.string(),
    "street": z.string(),
    "suburb": z.string(),
    "type": z.union([z.null(), PropertiesTypeSchema]),
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
