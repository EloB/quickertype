import * as z from "zod";


export const TopLevelSchema = z.object({
    "optDouble": z.number().min(0.5).max(99.5).optional(),
    "optInt": z.number().int().min(0).max(100).optional(),
    "optPattern": z.string().regex(new RegExp("^[a-z]+$")).optional(),
    "optString": z.string().refine(value => Array.from(value).length >= 3).refine(value => Array.from(value).length <= 10).optional(),
    "reqZeroMin": z.number().int().min(0).max(100),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
