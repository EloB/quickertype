import * as z from "zod";


export const TopLevelSchema = z.object({
    "map": z.record(z.string(), z.union([z.boolean(), z.number()])).optional(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
