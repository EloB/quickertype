import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "a": S.Record({ key: S.String, value: S.Int}),
    "b": S.Record({ key: S.String, value: S.Int}),
}) {}
