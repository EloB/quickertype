import * as S from "effect/Schema";


export class Address extends S.Class<Address>("Address")({
    "city": S.String,
    "country": S.String,
    "street": S.String,
}) {}

export class Item extends S.Class<Item>("Item")({
    "address": S.optional(Address),
    "created_at": S.optional(S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/))),
    "name": S.String,
    "sex": S.NullOr(S.Int),
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "item": S.Array(Item),
}) {}
