import * as S from "effect/Schema";


export class Headers extends S.Class<Headers>("Headers")({
    "Accept-Encoding": S.String,
    "Connection": S.String,
    "Host": S.String,
    "User-Agent": S.String,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "headers": Headers,
}) {}
