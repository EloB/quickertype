import * as S from "effect/Schema";


export class Invoice extends S.Class<Invoice>("Invoice")({
    "createdAt": S.NullOr(S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/))),
    "dueDate": S.NullOr(S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}$/))),
    "name": S.String,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "invoices": S.Array(Invoice),
}) {}
