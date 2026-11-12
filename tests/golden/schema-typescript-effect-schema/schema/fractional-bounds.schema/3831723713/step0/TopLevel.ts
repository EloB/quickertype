import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "value": S.Number.pipe(S.greaterThanOrEqualTo(0.1)).pipe(S.lessThanOrEqualTo(0.9)),
}) {}
