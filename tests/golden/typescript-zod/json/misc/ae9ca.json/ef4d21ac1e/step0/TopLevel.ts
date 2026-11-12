import * as z from "zod";


export const GeometryTypeSchema = z.enum([
    "Point",
]);
export type GeometryType = z.infer<typeof GeometryTypeSchema>;


export const ClassEnumSchema = z.enum([
    "No Code Allocated",
    "OS-District",
    "OS-Neighbourhood",
    "OS-Regional",
]);
export type ClassEnum = z.infer<typeof ClassEnumSchema>;


export const MaintainingAuthoritySchema = z.enum([
    "City of Ballarat",
]);
export type MaintainingAuthority = z.infer<typeof MaintainingAuthoritySchema>;


export const WardSchema = z.enum([
    "South",
    "North",
    "Central",
]);
export type Ward = z.infer<typeof WardSchema>;


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
    "Area": z.string(),
    "Central Asset ID": z.string(),
    "Class": ClassEnumSchema,
    "Feature Location": z.string(),
    "lat": z.string(),
    "long": z.string(),
    "Maintaining Authority": MaintainingAuthoritySchema,
    "Number": z.string().regex(/^-?\d+$/),
    "Site Name": z.string(),
    "Ward": WardSchema,
});
export type Properties = z.infer<typeof PropertiesSchema>;

export const FeatureSchema = z.object({
    "geometry": GeometrySchema,
    "properties": PropertiesSchema,
    "type": FeatureTypeSchema,
});
export type Feature = z.infer<typeof FeatureSchema>;

export const TopLevelSchema = z.object({
    "features": z.array(FeatureSchema),
    "name": z.string(),
    "type": z.string(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
