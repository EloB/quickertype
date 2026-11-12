import * as z from "zod";


export const UnionWithBoolAndEnumEnumSchema = z.enum([
    "foo",
]);
export type UnionWithBoolAndEnumEnum = z.infer<typeof UnionWithBoolAndEnumEnumSchema>;

export const TopLevelSchema = z.object({
    "arrNullable": z.array(z.union([z.null(), z.enum(["true", "false"])])).optional(),
    "arrOne": z.array(z.enum(["true", "false"])).optional(),
    "nullable": z.union([z.null(), z.enum(["true", "false"])]),
    "one": z.enum(["true", "false"]),
    "optional": z.enum(["true", "false"]).optional(),
    "unionWithBool": z.union([z.boolean(), z.enum(["true", "false"]).transform(x => x === "true")]),
    "unionWithBoolAndEnum": z.union([z.boolean(), z.enum(["true", "false"]).transform(x => x === "true"), UnionWithBoolAndEnumEnumSchema]),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
