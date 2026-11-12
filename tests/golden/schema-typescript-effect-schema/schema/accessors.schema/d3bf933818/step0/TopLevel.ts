import * as S from "effect/Schema";


export const Enum = S.Literal(
    "red",
    "green",
    "blue",
);
export type Enum = S.Schema.Type<typeof Enum>;

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "bar": S.String,
    "enum": Enum,
    "foo": S.String,
    "union": S.Union(S.Boolean, S.Number),
}) {}
