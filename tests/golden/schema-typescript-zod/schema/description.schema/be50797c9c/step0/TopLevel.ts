import * as z from "zod";

// An enumeration

export const EnumSchema = z.enum([
    "foo",
    "bar",
]);
export type Enum = z.infer<typeof EnumSchema>;

export const ObjectOrStringClassSchema = z.object({
    "prop": z.number(),
});
export type ObjectOrStringClass = z.infer<typeof ObjectOrStringClassSchema>;

export const TopLevelSchema = z.object({
    "bar": z.boolean().optional(),
    "enum": EnumSchema,
    "foo": z.number().optional(),
    "object-or-string": z.union([ObjectOrStringClassSchema, z.string()]),
    "union": z.union([z.number(), z.string()]),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
