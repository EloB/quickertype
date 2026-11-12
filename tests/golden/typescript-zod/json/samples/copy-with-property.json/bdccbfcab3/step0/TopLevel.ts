import * as z from "zod";


export const TopLevelSchema = z.object({
    "copyWith": z.number().int(),
    "name": z.string(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
