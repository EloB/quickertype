import * as z from "zod";


export const TopLevelSchema = z.object({
    "user-agent": z.string(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
