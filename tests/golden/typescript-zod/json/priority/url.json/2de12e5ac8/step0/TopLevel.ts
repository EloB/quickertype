import * as z from "zod";


export const TopLevelSchema = z.object({
    "fromURL": z.string(),
    "url": z.string(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
