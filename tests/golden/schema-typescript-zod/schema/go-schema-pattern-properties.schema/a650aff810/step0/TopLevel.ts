import * as z from "zod";


export const TopLevelSchema = z.object({
    "map": z.record(z.string(), z.number().int()),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
