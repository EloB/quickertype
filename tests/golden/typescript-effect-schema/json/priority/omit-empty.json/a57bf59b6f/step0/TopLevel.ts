import * as S from "effect/Schema";


export class Result extends S.Class<Result>("Result")({
    "age": S.Int,
    "name": S.optional(S.Null),
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "results": S.Array(Result),
}) {}
