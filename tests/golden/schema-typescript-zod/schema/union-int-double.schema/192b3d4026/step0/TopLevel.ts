import * as z from "zod";


export const TopLevelSchema = z.object({
    "value": z.union([z.number(), z.string()]),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
