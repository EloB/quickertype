import * as S from "effect/Schema";


export class Intersection extends S.Class<Intersection>("Intersection")({
    "foo": S.Number,
    "bar": S.optional(S.String),
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "intersection": S.optional(Intersection),
}) {}
