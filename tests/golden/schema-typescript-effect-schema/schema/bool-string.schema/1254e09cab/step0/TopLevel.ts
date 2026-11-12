import * as S from "effect/Schema";


export const UnionWithBoolAndEnumEnum = S.Literal(
    "foo",
);
export type UnionWithBoolAndEnumEnum = S.Schema.Type<typeof UnionWithBoolAndEnumEnum>;

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "arrNullable": S.optional(S.Array(S.NullOr(S.Literal("true", "false")))),
    "arrOne": S.optional(S.Array(S.Literal("true", "false"))),
    "nullable": S.NullOr(S.Literal("true", "false")),
    "one": S.Literal("true", "false"),
    "optional": S.optional(S.Literal("true", "false")),
    "unionWithBool": S.Union(S.Boolean, S.transform(S.Literal("true", "false"), S.Boolean, { strict: true, decode: (value) => value === "true", encode: (value) => value ? "true" : "false" })),
    "unionWithBoolAndEnum": S.Union(S.Boolean, S.transform(S.Literal("true", "false"), S.Boolean, { strict: true, decode: (value) => value === "true", encode: (value) => value ? "true" : "false" }), UnionWithBoolAndEnumEnum),
}) {}
