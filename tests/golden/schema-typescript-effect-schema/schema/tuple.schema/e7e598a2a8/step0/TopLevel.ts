import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "tuple": S.Array(S.Union(S.Boolean, S.Int)),
}) {}
