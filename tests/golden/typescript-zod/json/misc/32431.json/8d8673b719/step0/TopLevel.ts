import * as z from "zod";


export const GeometryTypeSchema = z.enum([
    "Point",
]);
export type GeometryType = z.infer<typeof GeometryTypeSchema>;


export const MagTypeSchema = z.enum([
    "md",
    "ml",
    "mb",
]);
export type MagType = z.infer<typeof MagTypeSchema>;


export const StatusSchema = z.enum([
    "automatic",
    "reviewed",
]);
export type Status = z.infer<typeof StatusSchema>;


export const PropertiesTypeSchema = z.enum([
    "earthquake",
]);
export type PropertiesType = z.infer<typeof PropertiesTypeSchema>;


export const FeatureTypeSchema = z.enum([
    "Feature",
]);
export type FeatureType = z.infer<typeof FeatureTypeSchema>;

export const GeometrySchema = z.object({
    "coordinates": z.array(z.number()),
    "type": GeometryTypeSchema,
});
export type Geometry = z.infer<typeof GeometrySchema>;

export const PropertiesSchema = z.object({
    "alert": z.null(),
    "cdi": z.null(),
    "code": z.string(),
    "detail": z.string(),
    "dmin": z.union([z.null(), z.number()]),
    "felt": z.null(),
    "gap": z.union([z.null(), z.number().int()]),
    "ids": z.string(),
    "mag": z.number(),
    "magType": MagTypeSchema,
    "mmi": z.null(),
    "net": z.string(),
    "nst": z.union([z.null(), z.number().int()]),
    "place": z.string(),
    "rms": z.number(),
    "sig": z.number().int(),
    "sources": z.string(),
    "status": StatusSchema,
    "time": z.number().int(),
    "title": z.string(),
    "tsunami": z.number().int(),
    "type": PropertiesTypeSchema,
    "types": z.string(),
    "tz": z.number().int(),
    "updated": z.number().int(),
    "url": z.string(),
});
export type Properties = z.infer<typeof PropertiesSchema>;

export const MetadataSchema = z.object({
    "api": z.string(),
    "count": z.number().int(),
    "generated": z.number().int(),
    "status": z.number().int(),
    "title": z.string(),
    "url": z.string(),
});
export type Metadata = z.infer<typeof MetadataSchema>;

export const FeatureSchema = z.object({
    "geometry": GeometrySchema,
    "id": z.string(),
    "properties": PropertiesSchema,
    "type": FeatureTypeSchema,
});
export type Feature = z.infer<typeof FeatureSchema>;

export const TopLevelSchema = z.object({
    "bbox": z.array(z.number()),
    "features": z.array(FeatureSchema),
    "metadata": MetadataSchema,
    "type": z.string(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
