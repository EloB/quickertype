import * as z from "zod";


export const CountrySchema = z.object({
    "code": z.string(),
    "name": z.string(),
});
export type Country = z.infer<typeof CountrySchema>;

export const TopLevelSchema = z.object({
    "countries": z.array(CountrySchema),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
