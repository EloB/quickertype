import * as S from "effect/Schema";


export class Option extends S.Class<Option>("Option")({
    "foo": S.optional(S.String),
    "name": S.String,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "options": S.Array(Option),
}) {}
