import * as z from "zod";


export const BarEnumSchema = z.enum([
    "quux",
]);
export type BarEnum = z.infer<typeof BarEnumSchema>;

export const TopLevelSchema = z.object({
    "bar": z.union([BarEnumSchema, z.string().pipe(z.coerce.date())]),
    "foo": z.string(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
