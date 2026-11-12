import * as S from "effect/Schema";

export const TopLevel = S.Array(S.String);
export type TopLevel = S.Schema.Type<typeof TopLevel>;
