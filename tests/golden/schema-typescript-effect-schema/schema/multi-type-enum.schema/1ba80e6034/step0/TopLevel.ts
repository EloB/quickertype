import * as S from "effect/Schema";


export const FooEnum = S.Literal(
    "a",
    "b",
    "c",
);
export type FooEnum = S.Schema.Type<typeof FooEnum>;

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "foo": S.Union(S.Boolean, S.Number, FooEnum),
}) {}
