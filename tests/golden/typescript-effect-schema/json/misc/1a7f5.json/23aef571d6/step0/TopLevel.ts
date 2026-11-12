import * as S from "effect/Schema";


export const Country = S.Literal(
    "United States",
);
export type Country = S.Schema.Type<typeof Country>;

export class TopLevelElement extends S.Class<TopLevelElement>("TopLevelElement")({
    "age": S.Int,
    "country": Country,
    "females": S.Int,
    "males": S.Int,
    "total": S.Int,
    "year": S.Int,
}) {}

export const TopLevel = S.Array(TopLevelElement);
export type TopLevel = S.Schema.Type<typeof TopLevel>;
