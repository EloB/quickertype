import * as S from "effect/Schema";


export class XClass extends S.Class<XClass>("XClass")({
    "x": S.optional(S.Union(S.Array(S.Union(S.Array(S.Any), S.Boolean, S.Number, S.String, S.suspend(() => XClass), S.Null)), S.Boolean, S.Number, S.Record({ key: S.String, value: S.Any}), S.String, S.Null)),
}) {}

export class TopLevelClass extends S.Class<TopLevelClass>("TopLevelClass")({
    "x": S.optional(S.Union(S.Array(S.Union(S.Array(S.Any), S.Boolean, S.Number, S.String, XClass, S.Null)), S.Boolean, S.Number, S.Record({ key: S.String, value: S.Any}), S.String, S.Null)),
}) {}

export const TopLevel = S.Union(S.Array(S.Union(S.Array(S.Any), S.Boolean, S.Number, S.String, TopLevelClass, S.Null)), S.Boolean, S.Number, S.Int, S.Record({ key: S.String, value: S.Any}), S.String, S.Null);
export type TopLevel = S.Schema.Type<typeof TopLevel>;
