import * as S from "effect/Schema";


export class MixedClass extends S.Class<MixedClass>("MixedClass")({
    "nested": S.String,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "mixed": S.Array(S.Union(S.Boolean, S.Int, S.String, MixedClass, S.Null)),
}) {}
