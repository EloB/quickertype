import * as S from "effect/Schema";


export class Description extends S.Class<Description>("Description")({
    "base_period": S.String,
    "missing": S.Int,
    "title": S.String,
}) {}

export class Datum extends S.Class<Datum>("Datum")({
    "anomaly": S.String,
    "value": S.String,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "data": S.Record({ key: S.String, value: Datum}),
    "description": Description,
}) {}
