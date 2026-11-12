import * as S from "effect/Schema";


export class Item extends S.Class<Item>("Item")({
    "content": S.optional(S.String),
    "id": S.optional(S.String),
    "output": S.optional(S.String),
    "summary": S.optional(S.String),
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "input": S.Array(Item),
}) {}
