import * as z from "zod";


export const TopLevelSchema = z.object({
    "free": z.number().int(),
    "intersection": z.number().int().min(4).max(5),
    "max": z.number().int().max(5),
    "min": z.number().int().min(3),
    "minmax": z.number().int().min(3).max(5),
    "minMaxIntersection": z.number().int().min(3).max(5),
    "minMaxUnion": z.number().int(),
    "union": z.number().int().min(3).max(6),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
