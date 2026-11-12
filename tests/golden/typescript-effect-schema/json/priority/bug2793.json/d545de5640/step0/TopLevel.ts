import * as S from "effect/Schema";


export class Labels extends S.Class<Labels>("Labels")({
    "AccountNumber": S.String,
    "Title": S.String,
}) {}

export class Hints extends S.Class<Hints>("Hints")(S.Struct({}).pipe(S.filter(value => typeof value === "object" && value !== null && !Array.isArray(value)))
) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "Hints": Hints,
    "Labels": Labels,
}) {}
