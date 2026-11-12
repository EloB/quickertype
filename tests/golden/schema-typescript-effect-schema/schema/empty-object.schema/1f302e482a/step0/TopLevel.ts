import * as S from "effect/Schema";

export const TopLevel = S.Record({ key: S.String, value: S.Any});
export type TopLevel = S.Schema.Type<typeof TopLevel>;
