import * as z from "zod";


export const KindSchema = z.enum([
    "one",
    "two",
]);
export type Kind = z.infer<typeof KindSchema>;

export const TopLevelSchema = z.object({
    "b": z.union([z.null(), z.string()]).optional(),
    "kind": KindSchema,
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
