import * as z from "zod";


export const TopLevelElementSchema = z.object({
    "DirectorateID": z.number().int(),
    "Id": z.number().int(),
    "Name": z.string(),
});
export type TopLevelElement = z.infer<typeof TopLevelElementSchema>;

export const TopLevelSchema = z.array(TopLevelElementSchema);
export type TopLevel = z.infer<typeof TopLevelSchema>;
