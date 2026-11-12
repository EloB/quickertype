import * as z from "zod";


export const FallSchema = z.enum([
    "Fell",
    "Found",
]);
export type Fall = z.infer<typeof FallSchema>;


export const TypeSchema = z.enum([
    "Point",
]);
export type Type = z.infer<typeof TypeSchema>;


export const NametypeSchema = z.enum([
    "Valid",
]);
export type Nametype = z.infer<typeof NametypeSchema>;

export const GeolocationSchema = z.object({
    "coordinates": z.array(z.number()),
    "type": TypeSchema,
});
export type Geolocation = z.infer<typeof GeolocationSchema>;

export const TopLevelElementSchema = z.object({
    ":@computed_region_cbhk_fwbd": z.string().regex(/^-?\d+$/).optional(),
    ":@computed_region_nnqa_25f4": z.string().regex(/^-?\d+$/).optional(),
    "fall": FallSchema,
    "geolocation": GeolocationSchema.optional(),
    "id": z.string().regex(/^-?\d+$/),
    "mass": z.string().optional(),
    "name": z.string(),
    "nametype": NametypeSchema,
    "recclass": z.string(),
    "reclat": z.string().optional(),
    "reclong": z.string().optional(),
    "year": z.string().pipe(z.coerce.date()).optional(),
});
export type TopLevelElement = z.infer<typeof TopLevelElementSchema>;

export const TopLevelSchema = z.array(TopLevelElementSchema);
export type TopLevel = z.infer<typeof TopLevelSchema>;
