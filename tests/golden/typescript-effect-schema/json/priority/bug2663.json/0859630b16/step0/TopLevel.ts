import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "birthday": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}$/)),
    "lastSeen": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
    "name": S.String,
}) {}
