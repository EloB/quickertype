import * as z from "zod";


export const ClosedClassSchema = z.object({
});
export type ClosedClass = z.infer<typeof ClosedClassSchema>;

export const ItemSchema = z.object({
    "key": z.string(),
    "value": z.string(),
});
export type Item = z.infer<typeof ItemSchema>;

export const ConfigSchema = z.object({
    "closed": z.union([z.null(), z.array(z.any()), z.boolean(), ClosedClassSchema, z.number(), z.number().int(), z.string()]).optional(),
    "name": z.string().optional(),
    "settings": z.record(z.string(), z.array(ItemSchema)).optional(),
});
export type Config = z.infer<typeof ConfigSchema>;

export const TopLevelSchema = z.object({
    "config": ConfigSchema.optional(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
