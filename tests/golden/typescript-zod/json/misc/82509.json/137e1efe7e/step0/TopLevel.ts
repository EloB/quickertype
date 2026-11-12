import * as z from "zod";


export const TopLevelSchema = z.object({
    "origin": z.string(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
