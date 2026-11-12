import * as z from "zod";


export const XSchema = z.enum([
    "three",
    "one",
    "two",
]);
export type X = z.infer<typeof XSchema>;

export const BarSchema = z.object({
    "x": XSchema,
});
export type Bar = z.infer<typeof BarSchema>;

export const TopLevelSchema = z.object({
    "bar": z.array(BarSchema),
    "foo": z.array(BarSchema),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
