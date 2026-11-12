import * as S from "effect/Schema";

export const TopLevel = S.Record({ key: S.String, value: S.String});
export type TopLevel = S.Schema.Type<typeof TopLevel>;
