import * as z from "zod";


export const MixedClassSchema = z.object({
    "nested": z.string(),
});
export type MixedClass = z.infer<typeof MixedClassSchema>;

export const TopLevelSchema = z.object({
    "mixed": z.array(z.union([z.null(), z.boolean(), MixedClassSchema, z.number().int(), z.string()])),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
