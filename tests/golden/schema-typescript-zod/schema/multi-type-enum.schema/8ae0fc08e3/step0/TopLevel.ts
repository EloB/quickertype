import * as z from "zod";


export const FooEnumSchema = z.enum([
    "a",
    "b",
    "c",
]);
export type FooEnum = z.infer<typeof FooEnumSchema>;

export const TopLevelSchema = z.object({
    "foo": z.union([z.boolean(), z.number(), FooEnumSchema]),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
