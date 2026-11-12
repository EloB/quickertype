import * as z from "zod";


export const BoolInUnionSchema = z.object({
    "a": z.boolean(),
});
export type BoolInUnion = z.infer<typeof BoolInUnionSchema>;

export const TopLevelSchema = z.object({
    "BoolInUnion": BoolInUnionSchema,
    "union": z.array(z.union([z.boolean(), z.number().int()])),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
