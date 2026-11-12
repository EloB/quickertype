import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "free": S.Int,
    "intersection": S.Int.pipe(S.greaterThanOrEqualTo(4)).pipe(S.lessThanOrEqualTo(5)),
    "max": S.Int.pipe(S.lessThanOrEqualTo(5)),
    "min": S.Int.pipe(S.greaterThanOrEqualTo(3)),
    "minmax": S.Int.pipe(S.greaterThanOrEqualTo(3)).pipe(S.lessThanOrEqualTo(5)),
    "minMaxIntersection": S.Int.pipe(S.greaterThanOrEqualTo(3)).pipe(S.lessThanOrEqualTo(5)),
    "minMaxUnion": S.Int,
    "union": S.Int.pipe(S.greaterThanOrEqualTo(3)).pipe(S.lessThanOrEqualTo(6)),
}) {}
