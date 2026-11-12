import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "free": S.Number,
    "intersection": S.Number.pipe(S.greaterThanOrEqualTo(4)).pipe(S.lessThanOrEqualTo(5)),
    "max": S.Number.pipe(S.lessThanOrEqualTo(5)),
    "min": S.Number.pipe(S.greaterThanOrEqualTo(3)),
    "minmax": S.Number.pipe(S.greaterThanOrEqualTo(3)).pipe(S.lessThanOrEqualTo(5)),
    "minMaxIntersection": S.Number.pipe(S.greaterThanOrEqualTo(3)).pipe(S.lessThanOrEqualTo(5)),
    "minMaxUnion": S.Number,
    "union": S.Number.pipe(S.greaterThanOrEqualTo(3)).pipe(S.lessThanOrEqualTo(6)),
}) {}
