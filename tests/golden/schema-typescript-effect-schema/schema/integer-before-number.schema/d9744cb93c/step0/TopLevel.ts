import * as S from "effect/Schema";

export const TopLevel = S.Union(S.Number, S.Int);
export type TopLevel = S.Schema.Type<typeof TopLevel>;
