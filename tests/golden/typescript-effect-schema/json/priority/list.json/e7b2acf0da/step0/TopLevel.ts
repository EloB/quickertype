import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "data": S.Int,
    "next": S.NullOr(S.suspend(() => TopLevel)),
}) {}
