import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "intersection": S.String.pipe(S.filter(value => Array.from(value).length >= 4)).pipe(S.filter(value => Array.from(value).length <= 5)),
    "inUnion": S.Union(S.Number, S.String.pipe(S.filter(value => Array.from(value).length >= 3)).pipe(S.filter(value => Array.from(value).length <= 5))),
    "maxlength": S.String.pipe(S.filter(value => Array.from(value).length <= 5)),
    "minlength": S.String.pipe(S.filter(value => Array.from(value).length >= 3)),
    "minMaxIntersection": S.String.pipe(S.filter(value => Array.from(value).length >= 3)).pipe(S.filter(value => Array.from(value).length <= 5)),
    "minmaxlength": S.String.pipe(S.filter(value => Array.from(value).length >= 3)).pipe(S.filter(value => Array.from(value).length <= 5)),
    "minMaxUnion": S.String,
    "union": S.String.pipe(S.filter(value => Array.from(value).length >= 3)).pipe(S.filter(value => Array.from(value).length <= 6)),
}) {}
