import * as S from "effect/Schema";


export class UnionListClass extends S.Class<UnionListClass>("UnionListClass")({
    "next": S.Union(S.Number, S.suspend(() => UnionListClass)),
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "list": S.Union(S.Number, UnionListClass),
}) {}
