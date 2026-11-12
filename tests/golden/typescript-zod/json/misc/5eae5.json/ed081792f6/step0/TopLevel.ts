import * as z from "zod";


export const TopLevelElementSchema = z.object({
    "Date": z.string().pipe(z.coerce.date()),
    "ID": z.number().int(),
    "Sponsor": z.string(),
    "Title": z.string(),
});
export type TopLevelElement = z.infer<typeof TopLevelElementSchema>;

export const TopLevelSchema = z.array(TopLevelElementSchema);
export type TopLevel = z.infer<typeof TopLevelSchema>;
