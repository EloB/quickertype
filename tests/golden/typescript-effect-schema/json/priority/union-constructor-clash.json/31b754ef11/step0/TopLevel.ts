import * as S from "effect/Schema";


export class BoolInUnion extends S.Class<BoolInUnion>("BoolInUnion")({
    "a": S.Boolean,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "BoolInUnion": BoolInUnion,
    "union": S.Array(S.Union(S.Boolean, S.Int)),
}) {}
