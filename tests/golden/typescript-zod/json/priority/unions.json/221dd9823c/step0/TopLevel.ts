import * as z from "zod";


export const ZClassSchema = z.object({
    "a": z.boolean(),
});
export type ZClass = z.infer<typeof ZClassSchema>;

export const TopLevelSchema = z.object({
    "x": z.array(z.union([z.null(), z.number().int(), z.string()])),
    "y": z.array(z.union([z.null(), z.number().int()])),
    "z": z.array(z.union([z.array(z.number().int()), ZClassSchema, z.number().int()])),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
