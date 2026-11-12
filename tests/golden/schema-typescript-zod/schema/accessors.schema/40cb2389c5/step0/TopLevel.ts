import * as z from "zod";


export const EnumSchema = z.enum([
    "red",
    "green",
    "blue",
]);
export type Enum = z.infer<typeof EnumSchema>;

export const TopLevelSchema = z.object({
    "bar": z.string(),
    "enum": EnumSchema,
    "foo": z.string(),
    "union": z.union([z.boolean(), z.number()]),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
