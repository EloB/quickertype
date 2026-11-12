import * as S from "effect/Schema";


export class Item extends S.Class<Item>("Item")({
    "key": S.String,
    "value": S.String,
}) {}

export class ClosedClass extends S.Class<ClosedClass>("ClosedClass")(S.Struct({}).pipe(S.filter(value => typeof value === "object" && value !== null && !Array.isArray(value)))
) {}

export class Config extends S.Class<Config>("Config")({
    "closed": S.optional(S.Union(S.Array(S.Any), S.Boolean, S.Number, S.Int, S.String, ClosedClass, S.Null)),
    "name": S.optional(S.String),
    "settings": S.optional(S.Record({ key: S.String, value: S.Array(Item)})),
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "config": S.optional(Config),
}) {}
