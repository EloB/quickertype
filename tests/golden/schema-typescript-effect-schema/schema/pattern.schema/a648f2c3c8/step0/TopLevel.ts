import * as S from "effect/Schema";


export class RegExpClass extends S.Class<RegExpClass>("RegExpClass")({
    "pattern3": S.String.pipe(S.pattern(new RegExp("d[.]*"))),
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "pattern1": S.String.pipe(S.pattern(new RegExp("a[.]*"))),
    "pattern2": S.String.pipe(S.pattern(new RegExp("b[.]*"))),
    "RegExp": S.optional(RegExpClass),
    "union": S.String.pipe(S.pattern(new RegExp("(b[.]*)|(c[.]*)"))),
}) {}
