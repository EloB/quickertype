import * as S from "effect/Schema";


export const Enum = S.Literal(
    "foo",
    "bar",
);
export type Enum = S.Schema.Type<typeof Enum>;

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "enum": S.NullOr(Enum),
}) {}
