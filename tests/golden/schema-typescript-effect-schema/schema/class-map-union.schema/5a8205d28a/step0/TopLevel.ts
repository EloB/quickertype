import * as S from "effect/Schema";


export class UnionClass extends S.Class<UnionClass>("UnionClass")({
    "quux": S.optional(S.Int),
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "union": S.optional(S.Record({ key: S.String, value: S.Union(S.Boolean, S.Number, S.String, UnionClass)})),
}) {}
