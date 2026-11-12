import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "above_i32_max": S.Int.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(2147483648)),
    "below_i32_min": S.Int.pipe(S.greaterThanOrEqualTo(-2147483649)).pipe(S.lessThanOrEqualTo(0)),
    "i32_range": S.Int.pipe(S.greaterThanOrEqualTo(-2147483648)).pipe(S.lessThanOrEqualTo(2147483647)),
    "large_bounds": S.Int.pipe(S.greaterThanOrEqualTo(-9007199254740991)).pipe(S.lessThanOrEqualTo(9007199254740991)),
    "only_maximum": S.Int.pipe(S.lessThanOrEqualTo(0)),
    "only_minimum": S.Int.pipe(S.greaterThanOrEqualTo(0)),
    "small_negative": S.Int.pipe(S.greaterThanOrEqualTo(-100)).pipe(S.lessThanOrEqualTo(0)),
    "small_positive": S.Int.pipe(S.greaterThanOrEqualTo(0)).pipe(S.lessThanOrEqualTo(100)),
    "unbounded": S.Int,
}) {}
