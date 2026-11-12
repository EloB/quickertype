import * as S from "effect/Schema";


export class Footnote extends S.Class<Footnote>("Footnote")({
    "code": S.optional(S.String),
    "text": S.optional(S.String),
}) {}

export class Datum extends S.Class<Datum>("Datum")({
    "footnotes": S.Array(Footnote),
    "period": S.String,
    "periodName": S.String,
    "value": S.String,
    "year": S.String.pipe(S.pattern(/^-?\d+$/)),
}) {}

export class Series extends S.Class<Series>("Series")({
    "data": S.Array(Datum),
    "seriesID": S.String,
}) {}

export class Results extends S.Class<Results>("Results")({
    "series": S.Array(Series),
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "message": S.Array(S.Any),
    "responseTime": S.Int,
    "Results": Results,
    "status": S.String,
}) {}
