import * as z from "zod";


export const UnionWithIntAndEnumEnumSchema = z.enum([
    "foo",
]);
export type UnionWithIntAndEnumEnum = z.infer<typeof UnionWithIntAndEnumEnumSchema>;

export const TopLevelSchema = z.object({
    "arrNullable": z.array(z.union([z.null(), z.string().regex(/^-?\d+$/)])).optional(),
    "arrOne": z.array(z.string().regex(/^-?\d+$/)).optional(),
    "nullable": z.union([z.null(), z.string().regex(/^-?\d+$/)]),
    "one": z.string().regex(/^-?\d+$/),
    "optional": z.string().regex(/^-?\d+$/).optional(),
    "unionWithInt": z.union([z.number().int(), z.string().regex(/^-?\d+$/).transform(Number)]),
    "unionWithIntAndEnum": z.union([UnionWithIntAndEnumEnumSchema, z.number().int(), z.string().regex(/^-?\d+$/).transform(Number)]),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
