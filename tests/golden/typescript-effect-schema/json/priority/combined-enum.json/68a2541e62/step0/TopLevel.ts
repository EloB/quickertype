import * as S from "effect/Schema";


export const X = S.Literal(
    "three",
    "one",
    "two",
);
export type X = S.Schema.Type<typeof X>;

export class Bar extends S.Class<Bar>("Bar")({
    "x": X,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "bar": S.Array(Bar),
    "foo": S.Array(Bar),
}) {}
