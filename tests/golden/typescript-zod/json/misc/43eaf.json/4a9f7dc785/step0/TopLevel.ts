import * as z from "zod";


export const TopLevelSchema = z.object({
    "base": z.string(),
    "date": z.string(),
    "rates": z.record(z.string(), z.number()),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
