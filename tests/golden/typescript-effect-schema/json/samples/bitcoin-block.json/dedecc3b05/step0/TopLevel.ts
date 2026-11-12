import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "block_index": S.Int,
    "hash": S.String,
    "height": S.Int,
    "time": S.Int,
    "txIndexes": S.Array(S.Int),
}) {}
