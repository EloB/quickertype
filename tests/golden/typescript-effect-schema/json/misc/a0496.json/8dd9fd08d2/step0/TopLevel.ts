import * as S from "effect/Schema";


export class Errors extends S.Class<Errors>("Errors")(S.Struct({}).pipe(S.filter(value => typeof value === "object" && value !== null && !Array.isArray(value)))
) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "code": S.String,
    "column_names": S.Array(S.String),
    "data": S.Array(S.Array(S.Union(S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}$/)), S.Number, S.Null))),
    "description": S.String,
    "display_url": S.String,
    "errors": Errors,
    "frequency": S.String,
    "from_date": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}$/)),
    "id": S.Int,
    "name": S.String,
    "premium": S.Boolean,
    "source_code": S.String,
    "source_name": S.String,
    "to_date": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}$/)),
    "type": S.String,
    "updated_at": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
    "urlize_name": S.String,
}) {}
