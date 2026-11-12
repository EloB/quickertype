import * as z from "zod";


export const FooClassSchema = z.object({
    "bar": z.number().int(),
});
export type FooClass = z.infer<typeof FooClassSchema>;

export const TopLevelSchema = z.object({
    "foo": z.union([z.null(), z.array(z.number().int()), z.boolean(), FooClassSchema, z.number(), z.number().int(), z.string()]),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
