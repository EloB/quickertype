import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "optional-date": S.optional(S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}$/))),
    "optional-date-time": S.optional(S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/))),
    "optional-time": S.optional(S.String.pipe(S.pattern(/^\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/))),
    "required-date": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}$/)),
    "required-date-time": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
    "required-time": S.String.pipe(S.pattern(/^\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
}) {}
