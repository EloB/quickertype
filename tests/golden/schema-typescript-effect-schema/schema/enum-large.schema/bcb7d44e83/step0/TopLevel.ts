import * as S from "effect/Schema";


export const Callsign = S.Literal(
    "alpha",
    "bravo",
    "charlie",
    "delta",
    "echo",
    "foxtrot",
    "golf",
    "hotel",
    "india",
    "juliett",
    "kilo",
    "lima",
    "mike",
    "november",
    "oscar",
    "papa",
    "quebec",
    "romeo",
    "sierra",
    "tango",
);
export type Callsign = S.Schema.Type<typeof Callsign>;


export const Priority = S.Literal(
    "low",
    "medium",
    "high",
);
export type Priority = S.Schema.Type<typeof Priority>;

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "callsign": Callsign,
    "priority": Priority,
}) {}
