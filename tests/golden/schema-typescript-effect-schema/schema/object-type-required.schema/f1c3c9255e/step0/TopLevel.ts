import * as S from "effect/Schema";


export class Empty extends S.Class<Empty>("Empty")(S.Struct({}).pipe(S.filter(value => typeof value === "object" && value !== null && !Array.isArray(value)))
) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "empty": Empty,
    "foo": S.String,
    "bar": S.optional(S.String),
}) {}
