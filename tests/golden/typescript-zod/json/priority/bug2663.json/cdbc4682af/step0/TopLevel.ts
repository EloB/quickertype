import * as z from "zod";


export const TopLevelSchema = z.object({
    "birthday": z.string(),
    "lastSeen": z.string().pipe(z.coerce.date()),
    "name": z.string(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
