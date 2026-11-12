import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "map": S.optional(S.Record({ key: S.String, value: S.Union(S.Boolean, S.Number)})),
}) {}
