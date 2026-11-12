import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "fromURL": S.String,
    "url": S.String,
}) {}
