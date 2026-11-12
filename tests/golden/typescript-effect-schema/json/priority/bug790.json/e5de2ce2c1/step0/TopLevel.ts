import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "children_data": S.Array(S.suspend(() => TopLevel)),
    "id": S.Int,
    "is_active": S.Boolean,
    "level": S.Int,
    "name": S.String,
    "parent_id": S.Int,
    "position": S.Int,
    "product_count": S.Int,
}) {}
