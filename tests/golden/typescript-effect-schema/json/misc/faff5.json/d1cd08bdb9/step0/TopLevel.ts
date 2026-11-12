import * as S from "effect/Schema";


export class Response extends S.Class<Response>("Response")({
    "player_count": S.Int,
    "result": S.Int,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "response": Response,
}) {}
