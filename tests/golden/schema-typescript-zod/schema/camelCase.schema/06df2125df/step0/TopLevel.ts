import * as z from "zod";


export const TopLevelSchema = z.object({
    "myProperty": z.string().optional(),
    "secondProperty": z.string().optional(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
