import * as S from "effect/Schema";


export class Coordinate extends S.Class<Coordinate>("Coordinate")({
    "latitude": S.Number,
    "longitude": S.Number,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "coordinates": S.optional(S.Array(Coordinate)),
    "count": S.optional(S.Int.pipe(S.greaterThanOrEqualTo(1)).pipe(S.lessThanOrEqualTo(100))),
    "label": S.optional(S.String.pipe(S.filter(value => Array.from(value).length >= 2)).pipe(S.filter(value => Array.from(value).length <= 16))),
    "requiredCoordinates": S.Array(Coordinate),
    "requiredCount": S.Int.pipe(S.greaterThanOrEqualTo(1)).pipe(S.lessThanOrEqualTo(100)),
    "requiredLabel": S.String.pipe(S.filter(value => Array.from(value).length >= 2)).pipe(S.filter(value => Array.from(value).length <= 16)),
    "weight": S.optional(S.Number.pipe(S.greaterThanOrEqualTo(0.5)).pipe(S.lessThanOrEqualTo(99.5))),
}) {}
