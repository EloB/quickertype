import * as z from "zod";


export const UnionClassSchema = z.object({
    "quux": z.number().int().optional(),
});
export type UnionClass = z.infer<typeof UnionClassSchema>;

export const TopLevelSchema = z.object({
    "union": z.record(z.string(), z.union([z.boolean(), UnionClassSchema, z.number(), z.string()])).optional(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
