import * as z from "zod";


export const TopLevelSchema = z.object({
    "countries": z.array(z.string()),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
