import * as z from "zod";


export const DifferentThingClassSchema = z.object({
    "name": z.string(),
});
export type DifferentThingClass = z.infer<typeof DifferentThingClassSchema>;

export const PersonElementSchema = z.object({
    "intOrString": z.union([z.number().int(), z.string().regex(/^-?\d+$/).transform(Number)]),
    "name": z.string(),
    "optionalValue": z.boolean().optional(),
});
export type PersonElement = z.infer<typeof PersonElementSchema>;

export const PurplePersonSchema = z.object({
    "intOrString": z.number().int(),
    "name": z.string(),
});
export type PurplePerson = z.infer<typeof PurplePersonSchema>;

export const TopLevelSchema = z.object({
    "booleanValue": z.boolean(),
    "dateValue": z.string(),
    "differentThings": z.array(z.union([DifferentThingClassSchema, z.number().int(), z.string().regex(/^-?\d+$/).transform(Number)])),
    "doubleValue": z.number(),
    "intValue": z.number().int(),
    "mapValue": z.record(z.string(), z.union([z.null(), z.number().int()])),
    "name with spaces": z.null(),
    "nullValue": z.null(),
    "nullableMapValue": z.record(z.string(), z.union([z.null(), z.number().int()])),
    "people": z.array(PersonElementSchema),
    "person": PurplePersonSchema,
    "stringValue": z.string(),
    "tuples": z.array(z.array(z.union([z.number().int(), z.string()]))),
    "uuidValue": z.string(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
