import * as S from "effect/Schema";


export class ZClass extends S.Class<ZClass>("ZClass")({
    "a": S.Boolean,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "x": S.Array(S.Union(S.Int, S.String, S.Null)),
    "y": S.Array(S.NullOr(S.Int)),
    "z": S.Array(S.Union(S.Array(S.Int), S.Int, ZClass)),
}) {}
