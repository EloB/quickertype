import * as S from "effect/Schema";


export class Result extends S.Class<Result>("Result")({
    "created_at": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
    "id": S.Int,
    "items": S.Int,
    "name": S.String,
    "parent": S.NullOr(S.Int),
    "updated_at": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
    "uri": S.String,
}) {}

export class Facets extends S.Class<Facets>("Facets")(S.Struct({}).pipe(S.filter(value => typeof value === "object" && value !== null && !Array.isArray(value)))
) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "count": S.Int,
    "facets": Facets,
    "limit": S.Int,
    "next": S.Boolean,
    "offset": S.Int,
    "previous": S.Boolean,
    "results": S.Array(Result),
}) {}
