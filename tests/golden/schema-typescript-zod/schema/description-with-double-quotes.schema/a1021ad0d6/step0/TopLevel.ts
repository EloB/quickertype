import * as z from "zod";


export const TopLevelSchema = z.object({
    "foo": z.boolean().optional(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
