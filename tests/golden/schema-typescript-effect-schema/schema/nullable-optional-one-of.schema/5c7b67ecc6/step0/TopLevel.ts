import * as S from "effect/Schema";


export const Kind = S.Literal(
    "one",
    "two",
);
export type Kind = S.Schema.Type<typeof Kind>;

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "b": S.optional(S.NullOr(S.String)),
    "kind": Kind,
}) {}
