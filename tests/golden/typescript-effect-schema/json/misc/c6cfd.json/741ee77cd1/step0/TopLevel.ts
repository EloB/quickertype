import * as S from "effect/Schema";


export class Country extends S.Class<Country>("Country")({
    "code": S.String,
    "name": S.String,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "countries": S.Array(Country),
}) {}
