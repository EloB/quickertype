import * as z from "zod";


export const UnionWithEnumEnumSchema = z.enum([
    "foo",
]);
export type UnionWithEnumEnum = z.infer<typeof UnionWithEnumEnumSchema>;

export const TopLevelSchema = z.object({
    "arrNullable": z.array(z.union([z.null(), z.string().uuid()])).optional(),
    "arrOne": z.array(z.string().uuid()).optional(),
    "nullable": z.union([z.null(), z.string().uuid()]),
    "one": z.string().uuid(),
    "optional": z.string().uuid().optional(),
    "unionWithEnum": z.union([UnionWithEnumEnumSchema, z.string().uuid()]),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
