import * as z from "zod";


export const TopLevelSchema = z.object({
    "foo": z.number().int(),
    "bar": z.boolean(),
    "quux": z.string(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
