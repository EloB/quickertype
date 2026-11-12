import * as z from "zod";


export const TopLevelSchema = z.object({
    "bar": z.boolean(),
    "foo": z.any().optional(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
