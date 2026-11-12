import * as S from "effect/Schema";


export const Value = S.Literal(
    "c0\u0001\u001b\u001f",
    "c1\u007f\u0080\u0085\u009f",
);
export type Value = S.Schema.Type<typeof Value>;

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "literal": S.String,
    "#{1+1}": S.Int,
    "values": S.Array(Value),
}) {}
