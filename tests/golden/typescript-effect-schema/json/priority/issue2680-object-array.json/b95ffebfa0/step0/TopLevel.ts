import * as S from "effect/Schema";


export class TopLevelElement extends S.Class<TopLevelElement>("TopLevelElement")({
    "key": S.String,
}) {}

export const TopLevel = S.Array(TopLevelElement);
export type TopLevel = S.Schema.Type<typeof TopLevel>;
