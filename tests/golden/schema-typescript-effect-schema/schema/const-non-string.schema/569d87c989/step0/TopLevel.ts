import * as S from "effect/Schema";


export const Kind = S.Literal(
    "widget",
);
export type Kind = S.Schema.Type<typeof Kind>;

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "amount": S.Int,
    "enabled": S.Boolean,
    "kind": Kind,
    "ratio": S.Number,
    "version": S.Number,
}) {}
