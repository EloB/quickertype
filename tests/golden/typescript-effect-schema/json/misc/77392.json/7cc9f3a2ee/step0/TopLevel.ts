import * as S from "effect/Schema";


export const OrbitClass = S.Literal(
    "Apollo",
    "Amor",
    "Aten",
    "Comet",
    "Jupiter-family Comet",
    "Halley-type Comet*",
    "Parabolic Comet",
    "Jupiter-family Comet*",
    "Encke-type Comet",
);
export type OrbitClass = S.Schema.Type<typeof OrbitClass>;


export const Pha = S.Literal(
    "Y",
    "N",
    "n/a",
);
export type Pha = S.Schema.Type<typeof Pha>;

export class TopLevelElement extends S.Class<TopLevelElement>("TopLevelElement")({
    "designation": S.String,
    "discovery_date": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
    "h_mag": S.optional(S.String),
    "i_deg": S.String,
    "moid_au": S.String,
    "orbit_class": OrbitClass,
    "period_yr": S.optional(S.String),
    "pha": Pha,
    "q_au_1": S.String,
    "q_au_2": S.optional(S.String),
}) {}

export const TopLevel = S.Array(TopLevelElement);
export type TopLevel = S.Schema.Type<typeof TopLevel>;
