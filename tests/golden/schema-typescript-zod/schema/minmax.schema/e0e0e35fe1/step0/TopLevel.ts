import * as z from "zod";


export const TopLevelSchema = z.object({
    "free": z.number(),
    "intersection": z.number().min(4).max(5),
    "max": z.number().max(5),
    "min": z.number().min(3),
    "minmax": z.number().min(3).max(5),
    "minMaxIntersection": z.number().min(3).max(5),
    "minMaxUnion": z.number(),
    "union": z.number().min(3).max(6),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
