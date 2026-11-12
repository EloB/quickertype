import * as z from "zod";


export const TopLevelElementSchema = z.object({
    "ID": z.number().int(),
    "Name": z.string(),
    "Notes": z.string(),
});
export type TopLevelElement = z.infer<typeof TopLevelElementSchema>;

export const TopLevelSchema = z.array(TopLevelElementSchema);
export type TopLevel = z.infer<typeof TopLevelSchema>;
