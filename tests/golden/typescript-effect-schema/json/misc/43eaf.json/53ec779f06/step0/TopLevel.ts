import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "base": S.String,
    "date": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}$/)),
    "rates": S.Record({ key: S.String, value: S.Number}),
}) {}
