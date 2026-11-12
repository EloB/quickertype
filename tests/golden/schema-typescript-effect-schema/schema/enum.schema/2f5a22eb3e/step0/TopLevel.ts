import * as S from "effect/Schema";


export const OtherArr = S.Literal(
    "foo",
    "bar",
    "if",
);
export type OtherArr = S.Schema.Type<typeof OtherArr>;


export const Gve = S.Literal(
    "good",
    "neutral",
    "evil",
);
export type Gve = S.Schema.Type<typeof Gve>;


export const Lvc = S.Literal(
    "lawful",
    "neutral",
    "chaotic",
);
export type Lvc = S.Schema.Type<typeof Lvc>;

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "arr": S.optional(S.Array(S.Union(OtherArr, S.Int))),
    "for": S.optional(S.String),
    "gve": Gve,
    "lvc": S.optional(Lvc),
    "otherArr": S.optional(S.Array(OtherArr)),
}) {}
