import * as S from "effect/Schema";


export class Constructor extends S.Class<Constructor>("Constructor")(S.Struct({}).pipe(S.filter(value => typeof value === "object" && value !== null && !Array.isArray(value)))
) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "constructor": S.optional(S.Union(S.Number, Constructor)),
}) {}
