import * as S from "effect/Schema";


export class Foo extends S.Class<Foo>("Foo")({
    "bar": S.optional(S.String),
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "foo": S.Array(Foo),
}) {}
