import * as z from "zod";


export const TopLevelSchema = z.object({
    "greeting": z.string(),
    "instructions": z.array(z.string()),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
