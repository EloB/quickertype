import * as z from "zod";


export const TopLevelElementSchema = z.object({
    "BirthDate": z.union([z.null(), z.string().pipe(z.coerce.date())]),
    "BirthDateIsProtected": z.boolean(),
    "GenderTypeID": z.number().int(),
    "Notes": z.string(),
    "ParliamentaryName": z.string(),
    "PersonID": z.number().int(),
    "PhotoURL": z.string(),
    "PreferredName": z.string(),
});
export type TopLevelElement = z.infer<typeof TopLevelElementSchema>;

export const TopLevelSchema = z.array(TopLevelElementSchema);
export type TopLevel = z.infer<typeof TopLevelSchema>;
