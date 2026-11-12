import * as z from "zod";


export const TopLevelSchema = z.object({
    "intersection": z.string().refine(value => Array.from(value).length >= 4).refine(value => Array.from(value).length <= 5),
    "inUnion": z.union([z.number(), z.string().refine(value => Array.from(value).length >= 3).refine(value => Array.from(value).length <= 5)]),
    "maxlength": z.string().refine(value => Array.from(value).length <= 5),
    "minlength": z.string().refine(value => Array.from(value).length >= 3),
    "minMaxIntersection": z.string().refine(value => Array.from(value).length >= 3).refine(value => Array.from(value).length <= 5),
    "minmaxlength": z.string().refine(value => Array.from(value).length >= 3).refine(value => Array.from(value).length <= 5),
    "minMaxUnion": z.string(),
    "union": z.string().refine(value => Array.from(value).length >= 3).refine(value => Array.from(value).length <= 6),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
