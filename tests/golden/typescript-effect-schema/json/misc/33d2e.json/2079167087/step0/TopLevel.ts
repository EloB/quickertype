import * as S from "effect/Schema";


export const BornEnum = S.Literal(
    "0000-00-00",
    "1898-00-00",
    "1943-00-00",
);
export type BornEnum = S.Schema.Type<typeof BornEnum>;


export const Gender = S.Literal(
    "male",
    "female",
    "org",
);
export type Gender = S.Schema.Type<typeof Gender>;


export const Category = S.Literal(
    "physics",
    "chemistry",
    "peace",
    "medicine",
    "literature",
    "economics",
);
export type Category = S.Schema.Type<typeof Category>;

export class AffiliationClass extends S.Class<AffiliationClass>("AffiliationClass")({
    "city": S.optional(S.String),
    "country": S.optional(S.String),
    "name": S.optional(S.String),
}) {}

export class Prize extends S.Class<Prize>("Prize")({
    "affiliations": S.Array(S.Union(S.Array(S.Any), AffiliationClass)),
    "category": S.optional(Category),
    "motivation": S.optional(S.String),
    "overallMotivation": S.optional(S.String),
    "share": S.optional(S.String.pipe(S.pattern(/^-?\d+$/))),
    "year": S.optional(S.String.pipe(S.pattern(/^-?\d+$/))),
}) {}

export class Laureate extends S.Class<Laureate>("Laureate")({
    "born": S.Union(S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}$/)), BornEnum),
    "bornCity": S.optional(S.String),
    "bornCountry": S.optional(S.String),
    "bornCountryCode": S.optional(S.String),
    "died": S.Union(S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}$/)), BornEnum),
    "diedCity": S.optional(S.String),
    "diedCountry": S.optional(S.String),
    "diedCountryCode": S.optional(S.String),
    "firstname": S.optional(S.String),
    "gender": Gender,
    "id": S.String.pipe(S.pattern(/^-?\d+$/)),
    "prizes": S.Array(Prize),
    "surname": S.optional(S.String),
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "laureates": S.Array(Laureate),
}) {}
