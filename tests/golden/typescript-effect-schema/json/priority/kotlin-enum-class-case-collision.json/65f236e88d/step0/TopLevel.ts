import * as S from "effect/Schema";


export const Category = S.Literal(
    " ",
    "",
);
export type Category = S.Schema.Type<typeof Category>;

export class TopLevelElement extends S.Class<TopLevelElement>("TopLevelElement")({
    "category": Category,
}) {}

export const TopLevel = S.Array(TopLevelElement);
export type TopLevel = S.Schema.Type<typeof TopLevel>;
