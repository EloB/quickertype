import * as S from "effect/Schema";


export const UnionWithIntAndEnumEnum = S.Literal(
    "foo",
);
export type UnionWithIntAndEnumEnum = S.Schema.Type<typeof UnionWithIntAndEnumEnum>;

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "arrNullable": S.optional(S.Array(S.NullOr(S.String.pipe(S.pattern(/^-?\d+$/))))),
    "arrOne": S.optional(S.Array(S.String.pipe(S.pattern(/^-?\d+$/)))),
    "nullable": S.NullOr(S.String.pipe(S.pattern(/^-?\d+$/))),
    "one": S.String.pipe(S.pattern(/^-?\d+$/)),
    "optional": S.optional(S.String.pipe(S.pattern(/^-?\d+$/))),
    "unionWithInt": S.Union(S.Int, S.NumberFromString.pipe(S.int())),
    "unionWithIntAndEnum": S.Union(UnionWithIntAndEnumEnum, S.Int, S.NumberFromString.pipe(S.int())),
}) {}
