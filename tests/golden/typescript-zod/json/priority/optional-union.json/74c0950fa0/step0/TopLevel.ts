import * as z from "zod";


export const TopLevelElementSchema = z.object({
    "a": z.union([z.number().int(), z.string()]).optional(),
});
export type TopLevelElement = z.infer<typeof TopLevelElementSchema>;

export const TopLevelSchema = z.array(TopLevelElementSchema);
export type TopLevel = z.infer<typeof TopLevelSchema>;
