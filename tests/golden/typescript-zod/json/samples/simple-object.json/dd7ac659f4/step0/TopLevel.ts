import * as z from "zod";


export const TopLevelSchema = z.object({
    "date": z.number().int(),
    "title": z.string(),
    "validity": z.boolean(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
