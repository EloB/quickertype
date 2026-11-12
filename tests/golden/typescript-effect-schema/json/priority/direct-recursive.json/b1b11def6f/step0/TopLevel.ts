import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "also": S.optional(S.suspend(() => TopLevel)),
    "bar": S.Boolean,
    "foo": S.Int,
    "moo": S.Number,
    "quux": S.String,
}) {}
