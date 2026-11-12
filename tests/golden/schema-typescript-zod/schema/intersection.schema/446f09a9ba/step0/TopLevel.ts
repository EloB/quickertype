import * as z from "zod";


export const IntersectionSchema = z.object({
    "foo": z.number(),
    "bar": z.string().optional(),
});
export type Intersection = z.infer<typeof IntersectionSchema>;

export const TopLevelSchema = z.object({
    "intersection": IntersectionSchema.optional(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
