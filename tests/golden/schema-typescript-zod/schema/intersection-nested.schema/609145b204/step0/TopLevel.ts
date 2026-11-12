import * as z from "zod";


export const TopLevelSchema = z.object({
    "intersection": z.number().optional(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
