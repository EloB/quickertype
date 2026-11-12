import * as z from "zod";


export const TopLevelSchema = z.object({
    "foo": z.number().int(),
    "bar": z.boolean().optional(),
    "quux": z.string().optional(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
