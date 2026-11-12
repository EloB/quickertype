import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "value": S.Union(S.Number, S.String),
}) {}
