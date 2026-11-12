import * as z from "zod";


export const TopLevelSchema = z.object({
    "number": z.number(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
