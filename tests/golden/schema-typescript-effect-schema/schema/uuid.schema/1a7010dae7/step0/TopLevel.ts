import * as S from "effect/Schema";


export const UnionWithEnumEnum = S.Literal(
    "foo",
);
export type UnionWithEnumEnum = S.Schema.Type<typeof UnionWithEnumEnum>;

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "arrNullable": S.optional(S.Array(S.NullOr(S.UUID))),
    "arrOne": S.optional(S.Array(S.UUID)),
    "nullable": S.NullOr(S.UUID),
    "one": S.UUID,
    "optional": S.optional(S.UUID),
    "unionWithEnum": S.Union(UnionWithEnumEnum, S.UUID),
}) {}
