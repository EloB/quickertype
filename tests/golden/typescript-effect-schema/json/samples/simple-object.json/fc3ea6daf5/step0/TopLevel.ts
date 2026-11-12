import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "date": S.Int,
    "title": S.String,
    "validity": S.Boolean,
}) {}
