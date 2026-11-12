import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "maxOnly": S.Array(S.Int).pipe(S.maxItems(3)),
    "minAndMax": S.Array(S.Number).pipe(S.minItems(1)).pipe(S.maxItems(4)),
    "minOnly": S.Array(S.String).pipe(S.minItems(2)),
    "plain": S.Array(S.String),
    "unionItems": S.Array(S.Union(S.Int, S.String)).pipe(S.minItems(2)),
}) {}
