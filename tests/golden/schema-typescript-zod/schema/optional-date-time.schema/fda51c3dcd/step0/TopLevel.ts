import * as z from "zod";


export const TopLevelSchema = z.object({
    "optional-date": z.string().optional(),
    "optional-date-time": z.string().pipe(z.coerce.date()).optional(),
    "optional-time": z.string().optional(),
    "required-date": z.string(),
    "required-date-time": z.string().pipe(z.coerce.date()),
    "required-time": z.string(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
