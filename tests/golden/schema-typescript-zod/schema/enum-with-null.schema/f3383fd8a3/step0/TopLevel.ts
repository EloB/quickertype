import * as z from "zod";


export const EnumSchema = z.enum([
    "foo",
    "bar",
]);
export type Enum = z.infer<typeof EnumSchema>;

export const TopLevelSchema = z.object({
    "enum": z.union([z.null(), EnumSchema]),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
