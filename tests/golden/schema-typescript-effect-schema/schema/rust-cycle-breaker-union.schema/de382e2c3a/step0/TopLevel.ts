import * as S from "effect/Schema";


export class Node extends S.Class<Node>("Node")({
    "next": S.optional(S.Union(S.String, S.suspend(() => Node), S.Null)),
    "value": S.String,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "next": S.optional(S.Union(S.String, Node, S.Null)),
    "value": S.String,
}) {}
