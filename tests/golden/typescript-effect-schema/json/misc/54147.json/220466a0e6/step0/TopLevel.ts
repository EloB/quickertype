import * as S from "effect/Schema";


export class Headers extends S.Class<Headers>("Headers")({
    "Accept-Encoding": S.String,
    "Connection": S.String,
    "Host": S.String,
    "User-Agent": S.String,
}) {}

export class Args extends S.Class<Args>("Args")(S.Struct({}).pipe(S.filter(value => typeof value === "object" && value !== null && !Array.isArray(value)))
) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "args": Args,
    "data": S.String,
    "files": Args,
    "form": Args,
    "headers": Headers,
    "origin": S.String,
    "url": S.String,
}) {}
