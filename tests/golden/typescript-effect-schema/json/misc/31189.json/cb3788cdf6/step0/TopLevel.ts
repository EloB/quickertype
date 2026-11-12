import * as S from "effect/Schema";


export const EffectiveFromEnum = S.Literal(
    "0000-01-01",
);
export type EffectiveFromEnum = S.Schema.Type<typeof EffectiveFromEnum>;

export class Rates extends S.Class<Rates>("Rates")({
    "parking": S.optional(S.Number),
    "reduced": S.optional(S.Number),
    "reduced1": S.optional(S.Number),
    "reduced2": S.optional(S.Number),
    "standard": S.Number,
    "super_reduced": S.optional(S.Number),
}) {}

export class Period extends S.Class<Period>("Period")({
    "effective_from": S.Union(S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}$/)), EffectiveFromEnum),
    "rates": Rates,
}) {}

export class Rate extends S.Class<Rate>("Rate")({
    "code": S.String,
    "country_code": S.String,
    "name": S.String,
    "periods": S.Array(Period),
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "details": S.String,
    "rates": S.Array(Rate),
    "version": S.Null,
}) {}
