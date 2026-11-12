import * as S from "effect/Schema";


export class Response extends S.Class<Response>("Response")({
    "body": S.optional(S.String),
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "item": S.optional(S.Array(S.suspend(() => TopLevel))),
    "name": S.optional(S.String),
    "response": S.optional(S.Array(Response)),
}) {}
