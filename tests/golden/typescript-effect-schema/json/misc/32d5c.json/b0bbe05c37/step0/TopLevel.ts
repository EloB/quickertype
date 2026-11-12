import * as S from "effect/Schema";


export class TopLevelElement extends S.Class<TopLevelElement>("TopLevelElement")({
    "BirthDate": S.NullOr(S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/))),
    "BirthDateIsProtected": S.Boolean,
    "GenderTypeID": S.Int,
    "Notes": S.String,
    "ParliamentaryName": S.String,
    "PersonID": S.Int,
    "PhotoURL": S.String,
    "PreferredName": S.String,
}) {}

export const TopLevel = S.Array(TopLevelElement);
export type TopLevel = S.Schema.Type<typeof TopLevel>;
