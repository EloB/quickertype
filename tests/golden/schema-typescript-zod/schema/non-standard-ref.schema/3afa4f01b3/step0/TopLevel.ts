import * as z from "zod";


export const TopLevelSchema = z.object({
    "bar": z.number().int(),
    "foo": z.number().int(),
    "quux": z.boolean(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
