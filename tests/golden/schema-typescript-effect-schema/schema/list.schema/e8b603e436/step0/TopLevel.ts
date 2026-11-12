import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "next": S.optional(S.suspend(() => TopLevel)),
}) {}
