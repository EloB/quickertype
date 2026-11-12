import * as z from "zod";


export const KindSchema = z.enum([
    "widget",
]);
export type Kind = z.infer<typeof KindSchema>;

export const TopLevelSchema = z.object({
    "amount": z.number().int(),
    "enabled": z.boolean(),
    "kind": KindSchema,
    "ratio": z.number(),
    "version": z.number(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
