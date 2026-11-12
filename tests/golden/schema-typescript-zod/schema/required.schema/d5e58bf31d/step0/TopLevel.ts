import * as z from "zod";


export const TopLevelSchema = z.object({
    "longitude": z.number(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
