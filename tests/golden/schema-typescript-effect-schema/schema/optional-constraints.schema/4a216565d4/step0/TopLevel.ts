import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "optDouble": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0.5)).pipe(S.lessThanOrEqualTo(99.5))),
    "optInt": S.optional(S.Int.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(100))),
    "optPattern": S.optional(S.String.pipe(S.pattern(new RegExp("^[a-z]+$")))),
    "optString": S.optional(S.String.pipe(S.filter(value => Array.from(value).length >= 3)).pipe(S.filter(value => Array.from(value).length <= 10))),
    "reqZeroMin": S.Int.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(100)),
}) {}
