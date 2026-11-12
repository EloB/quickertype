import * as z from "zod";


export const TopLevelSchema = z.object({
    "exact": z.string().regex(new RegExp("^[^!]+$")).refine(value => Array.from(value).length >= 2).refine(value => Array.from(value).length <= 2),
    "maximum": z.string().refine(value => Array.from(value).length <= 1),
    "minimum": z.string().refine(value => Array.from(value).length >= 2),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
