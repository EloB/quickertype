import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "intersection": S.optional(S.Number),
}) {}
