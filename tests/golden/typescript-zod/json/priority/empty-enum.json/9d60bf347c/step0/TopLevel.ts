import * as z from "zod";


export const FooSchema = z.object({
    "bar": z.string().optional(),
});
export type Foo = z.infer<typeof FooSchema>;

export const TopLevelSchema = z.object({
    "foo": z.array(FooSchema),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
