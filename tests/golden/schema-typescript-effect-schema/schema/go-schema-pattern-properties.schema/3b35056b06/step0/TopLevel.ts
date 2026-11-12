import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "map": S.Record({ key: S.String, value: S.Int}),
}) {}
