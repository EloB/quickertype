import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "exact": S.String.pipe(S.filter(value => Array.from(value).length >= 2)).pipe(S.filter(value => Array.from(value).length <= 2)).pipe(S.pattern(new RegExp("^[^!]+$"))),
    "maximum": S.String.pipe(S.filter(value => Array.from(value).length <= 1)),
    "minimum": S.String.pipe(S.filter(value => Array.from(value).length >= 2)),
}) {}
