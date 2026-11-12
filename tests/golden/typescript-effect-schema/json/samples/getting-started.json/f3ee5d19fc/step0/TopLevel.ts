import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "greeting": S.String,
    "instructions": S.Array(S.String),
}) {}
