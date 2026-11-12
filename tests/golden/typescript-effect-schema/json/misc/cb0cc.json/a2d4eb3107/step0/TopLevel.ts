import * as S from "effect/Schema";


export const Category = S.Literal(
    "physics",
    "chemistry",
    "medicine",
    "literature",
    "peace",
    "economics",
);
export type Category = S.Schema.Type<typeof Category>;

export class Laureate extends S.Class<Laureate>("Laureate")({
    "firstname": S.String,
    "id": S.String.pipe(S.pattern(/^-?\d+$/)),
    "motivation": S.optional(S.String),
    "share": S.String.pipe(S.pattern(/^-?\d+$/)),
    "surname": S.String,
}) {}

export class Prize extends S.Class<Prize>("Prize")({
    "category": Category,
    "laureates": S.Array(Laureate),
    "overallMotivation": S.optional(S.String),
    "year": S.String.pipe(S.pattern(/^-?\d+$/)),
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "prizes": S.Array(Prize),
}) {}
