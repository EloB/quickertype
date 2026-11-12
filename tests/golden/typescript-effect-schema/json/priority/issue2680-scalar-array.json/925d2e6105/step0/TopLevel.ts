import * as S from "effect/Schema";

export const TopLevel = S.Array(S.Int);
export type TopLevel = S.Schema.Type<typeof TopLevel>;
