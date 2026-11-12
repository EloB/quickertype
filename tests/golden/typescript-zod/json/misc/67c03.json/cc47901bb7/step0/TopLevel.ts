import * as z from "zod";


export const PersonSchema = z.object({
    "craft": z.string(),
    "name": z.string(),
});
export type Person = z.infer<typeof PersonSchema>;

export const TopLevelSchema = z.object({
    "message": z.string(),
    "number": z.number().int(),
    "people": z.array(PersonSchema),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
