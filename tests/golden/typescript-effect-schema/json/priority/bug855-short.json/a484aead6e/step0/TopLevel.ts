import * as S from "effect/Schema";


export class TopLevelValue extends S.Class<TopLevelValue>("TopLevelValue")({
    "channel_id": S.String.pipe(S.pattern(/^-?\d+$/)),
    "channel_name": S.String,
    "code": S.String,
    "emoticon_set": S.Int,
    "id": S.Int,
}) {}

export const TopLevel = S.Record({ key: S.String, value: TopLevelValue});
export type TopLevel = S.Schema.Type<typeof TopLevel>;
