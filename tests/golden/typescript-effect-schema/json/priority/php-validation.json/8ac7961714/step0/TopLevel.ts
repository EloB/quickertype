import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "boolean": S.Boolean,
    "integer": S.Int,
    "integers": S.Array(S.Int),
    "number": S.Number,
    "string": S.String,
}) {}
