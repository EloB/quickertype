import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "myProperty": S.optional(S.String),
    "secondProperty": S.optional(S.String),
}) {}
