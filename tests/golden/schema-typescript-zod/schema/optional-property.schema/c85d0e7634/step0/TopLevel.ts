import * as z from "zod";


export const TopLevelSchema = z.object({
    "value": z.string().optional(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
