import * as S from "effect/Schema";


export class TopLevelElement extends S.Class<TopLevelElement>("TopLevelElement")({
    "ID": S.Int,
    "Name": S.String,
    "Notes": S.String,
}) {}

export const TopLevel = S.Array(TopLevelElement);
export type TopLevel = S.Schema.Type<typeof TopLevel>;
