import * as S from "effect/Schema";


export class Description extends S.Class<Description>("Description")({
    "base_period": S.String,
    "missing": S.String,
    "title": S.String,
    "units": S.String,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "data": S.Record({ key: S.String, value: S.String}),
    "description": Description,
}) {}
