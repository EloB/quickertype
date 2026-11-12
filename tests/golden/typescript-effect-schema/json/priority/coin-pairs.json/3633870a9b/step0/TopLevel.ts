import * as S from "effect/Schema";


export class Pair extends S.Class<Pair>("Pair")({
    "decimal_places": S.Int,
    "fee": S.Number,
    "hidden": S.Int,
    "max_amount": S.Int,
    "max_price": S.Int,
    "min_amount": S.Number,
    "min_price": S.Number,
    "min_total": S.Number,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "pairs": S.Record({ key: S.String, value: Pair}),
    "server_time": S.Int,
}) {}
