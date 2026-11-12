import * as z from "zod";


export const TopLevelSchema = z.object({
    "open": z.array(z.union([z.boolean(), z.number().int()])),
    "tuple": z.array(z.union([z.boolean(), z.number().int()])),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
