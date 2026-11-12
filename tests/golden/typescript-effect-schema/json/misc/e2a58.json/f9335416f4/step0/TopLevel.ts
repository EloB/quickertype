import * as S from "effect/Schema";


export class TopLevelElement extends S.Class<TopLevelElement>("TopLevelElement")({
    "date": S.String,
    "stop-and-search": S.Array(S.String),
}) {}

export const TopLevel = S.Array(TopLevelElement);
export type TopLevel = S.Schema.Type<typeof TopLevel>;
