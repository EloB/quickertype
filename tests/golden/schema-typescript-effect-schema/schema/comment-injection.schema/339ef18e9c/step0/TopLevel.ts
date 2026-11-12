import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "trailingBackslash": S.optional(S.String),
    "trailingQuote": S.optional(S.String),
    "trailingTripleQuote": S.optional(S.String),
    "value": S.String,
}) {}
