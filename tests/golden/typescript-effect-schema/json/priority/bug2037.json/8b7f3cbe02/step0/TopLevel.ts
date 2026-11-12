import * as S from "effect/Schema";


export class Reward extends S.Class<Reward>("Reward")(S.Struct({}).pipe(S.filter(value => typeof value === "object" && value !== null && !Array.isArray(value)))
) {}

export class Objective extends S.Class<Objective>("Objective")({
    "rewards": S.Record({ key: S.String, value: Reward}),
}) {}

export class MissionSpec extends S.Class<MissionSpec>("MissionSpec")({
    "objectives": S.Record({ key: S.String, value: Objective}),
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "mission_specs": S.Record({ key: S.String, value: MissionSpec}),
}) {}
