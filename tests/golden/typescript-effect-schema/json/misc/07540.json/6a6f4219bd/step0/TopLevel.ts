import * as S from "effect/Schema";


export class Cookies extends S.Class<Cookies>("Cookies")(S.Struct({}).pipe(S.filter(value => typeof value === "object" && value !== null && !Array.isArray(value)))
) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "cookies": Cookies,
}) {}
