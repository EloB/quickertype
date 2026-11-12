import * as z from "zod";


export const TopLevelSchema = z.object({
    "value": z.number().min(0.1).max(0.9),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
