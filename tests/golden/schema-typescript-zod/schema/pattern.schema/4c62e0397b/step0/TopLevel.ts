import * as z from "zod";


export const RegExpSchema = z.object({
    "pattern3": z.string().regex(new RegExp("d[.]*")),
});
export type RegExp = z.infer<typeof RegExpSchema>;

export const TopLevelSchema = z.object({
    "pattern1": z.string().regex(new RegExp("a[.]*")),
    "pattern2": z.string().regex(new RegExp("b[.]*")),
    "RegExp": RegExpSchema.optional(),
    "union": z.string().regex(new RegExp("(b[.]*)|(c[.]*)")),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
