import * as S from "effect/Schema";


export class Cookie extends S.Class<Cookie>("Cookie")({
    "name": S.String,
    "value": S.String,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "cookies": S.Array(Cookie),
}) {}
