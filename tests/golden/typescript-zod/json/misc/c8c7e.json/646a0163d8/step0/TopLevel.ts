import * as z from "zod";


export const IdSchema = z.enum([
    "IN",
    "NY.GDP.MKTP.CD",
]);
export type Id = z.infer<typeof IdSchema>;


export const ValueSchema = z.enum([
    "India",
    "GDP (current US$)",
]);
export type Value = z.infer<typeof ValueSchema>;

export const CountrySchema = z.object({
    "id": IdSchema,
    "value": ValueSchema,
});
export type Country = z.infer<typeof CountrySchema>;

export const FluffyTopLevelSchema = z.object({
    "page": z.number().int(),
    "pages": z.number().int(),
    "per_page": z.string().regex(/^-?\d+$/),
    "total": z.number().int(),
});
export type FluffyTopLevel = z.infer<typeof FluffyTopLevelSchema>;

export const PurpleTopLevelSchema = z.object({
    "country": CountrySchema,
    "date": z.string().regex(/^-?\d+$/),
    "decimal": z.string().regex(/^-?\d+$/),
    "indicator": CountrySchema,
    "value": z.string(),
});
export type PurpleTopLevel = z.infer<typeof PurpleTopLevelSchema>;

export const TopLevelSchema = z.array(z.union([z.array(PurpleTopLevelSchema), FluffyTopLevelSchema]));
export type TopLevel = z.infer<typeof TopLevelSchema>;
