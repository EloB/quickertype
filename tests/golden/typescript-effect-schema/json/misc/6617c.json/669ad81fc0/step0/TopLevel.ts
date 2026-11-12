import * as S from "effect/Schema";


export class IssPosition extends S.Class<IssPosition>("IssPosition")({
    "latitude": S.String,
    "longitude": S.String,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "iss_position": IssPosition,
    "message": S.String,
    "timestamp": S.Int,
}) {}
