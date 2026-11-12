import * as S from "effect/Schema";


export class FooClass extends S.Class<FooClass>("FooClass")({
    "bar": S.Int,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "foo": S.Union(S.Array(S.Int), S.Boolean, S.Number, S.Int, S.String, FooClass, S.Null),
}) {}
