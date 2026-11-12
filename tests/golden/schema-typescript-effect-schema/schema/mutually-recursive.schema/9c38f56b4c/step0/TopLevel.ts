import * as S from "effect/Schema";


export class Bar extends S.Class<Bar>("Bar")({
    "foo": S.Union(S.Array(S.suspend(() => TopLevel)), S.suspend(() => TopLevel)),
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "bar": S.optional(Bar),
}) {}
