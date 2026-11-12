import * as S from "effect/Schema";


export const Id = S.Literal(
    "IN",
    "SP.POP.TOTL",
);
export type Id = S.Schema.Type<typeof Id>;


export const Value = S.Literal(
    "India",
    "Population, total",
);
export type Value = S.Schema.Type<typeof Value>;

export class FluffyTopLevel extends S.Class<FluffyTopLevel>("FluffyTopLevel")({
    "page": S.Int,
    "pages": S.Int,
    "per_page": S.String.pipe(S.pattern(/^-?\d+$/)),
    "total": S.Int,
}) {}

export class Country extends S.Class<Country>("Country")({
    "id": Id,
    "value": Value,
}) {}

export class PurpleTopLevel extends S.Class<PurpleTopLevel>("PurpleTopLevel")({
    "country": Country,
    "date": S.String.pipe(S.pattern(/^-?\d+$/)),
    "decimal": S.String.pipe(S.pattern(/^-?\d+$/)),
    "indicator": Country,
    "value": S.String.pipe(S.pattern(/^-?\d+$/)),
}) {}

export const TopLevel = S.Array(S.Union(S.Array(PurpleTopLevel), FluffyTopLevel));
export type TopLevel = S.Schema.Type<typeof TopLevel>;
