import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "bar": S.Boolean,
    "foo": S.optional(S.Any),
}) {}
