import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "foo": S.Int,
    "bar": S.optional(S.Boolean),
    "quux": S.optional(S.String),
}) {}
