import * as z from "zod";


export const TopLevelElementSchema = z.object({
    "one": z.number().int().optional(),
    "two": z.boolean(),
    "three": z.number().optional(),
});
export type TopLevelElement = z.infer<typeof TopLevelElementSchema>;

export const TopLevelSchema = z.array(TopLevelElementSchema);
export type TopLevel = z.infer<typeof TopLevelSchema>;
