import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "copyWith": S.Int,
    "name": S.String,
}) {}
