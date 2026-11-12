import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "open": S.Array(S.Union(S.Boolean, S.Int)),
    "tuple": S.Array(S.Union(S.Boolean, S.Int)),
}) {}
