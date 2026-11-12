import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "disallowed": S.optional(S.Any),
    "empty": S.Array(S.Any),
    "foo": S.String,
    "impossible": S.optional(S.Any),
}) {}
