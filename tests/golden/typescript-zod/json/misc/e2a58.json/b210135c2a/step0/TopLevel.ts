import * as z from "zod";


export const TopLevelElementSchema = z.object({
    "date": z.string(),
    "stop-and-search": z.array(z.string()),
});
export type TopLevelElement = z.infer<typeof TopLevelElementSchema>;

export const TopLevelSchema = z.array(TopLevelElementSchema);
export type TopLevel = z.infer<typeof TopLevelSchema>;
