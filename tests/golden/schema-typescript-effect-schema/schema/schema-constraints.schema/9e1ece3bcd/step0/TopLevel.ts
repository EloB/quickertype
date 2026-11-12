import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "minMaxLength": S.String.pipe(S.filter(value => Array.from(value).length >= 5)).pipe(S.filter(value => Array.from(value).length <= 5)),
    "percent": S.Number.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(1)),
}) {}
