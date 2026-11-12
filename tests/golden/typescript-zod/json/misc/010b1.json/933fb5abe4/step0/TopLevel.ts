import * as z from "zod";


export const CountrySchema = z.enum([
    "United States",
]);
export type Country = z.infer<typeof CountrySchema>;

export const TopLevelElementSchema = z.object({
    "age": z.number().int(),
    "country": CountrySchema,
    "females": z.number().int(),
    "males": z.number().int(),
    "total": z.number().int(),
    "year": z.number().int(),
});
export type TopLevelElement = z.infer<typeof TopLevelElementSchema>;

export const TopLevelSchema = z.array(TopLevelElementSchema);
export type TopLevel = z.infer<typeof TopLevelSchema>;
