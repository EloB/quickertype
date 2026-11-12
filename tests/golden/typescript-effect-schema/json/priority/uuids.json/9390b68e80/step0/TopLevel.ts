import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "booleanValue": S.Boolean,
    "doubleValue": S.Number,
    "intValue": S.Int,
    "stringValue": S.String,
    "uuidValue": S.UUID,
    "uuidValues": S.Array(S.UUID),
}) {}
