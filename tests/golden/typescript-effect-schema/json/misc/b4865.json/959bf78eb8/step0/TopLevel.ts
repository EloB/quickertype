import * as S from "effect/Schema";


export const Fall = S.Literal(
    "Fell",
    "Found",
);
export type Fall = S.Schema.Type<typeof Fall>;


export const Type = S.Literal(
    "Point",
);
export type Type = S.Schema.Type<typeof Type>;


export const Nametype = S.Literal(
    "Valid",
);
export type Nametype = S.Schema.Type<typeof Nametype>;

export class Geolocation extends S.Class<Geolocation>("Geolocation")({
    "coordinates": S.Array(S.Number),
    "type": Type,
}) {}

export class TopLevelElement extends S.Class<TopLevelElement>("TopLevelElement")({
    ":@computed_region_cbhk_fwbd": S.optional(S.String.pipe(S.pattern(/^-?\d+$/))),
    ":@computed_region_nnqa_25f4": S.optional(S.String.pipe(S.pattern(/^-?\d+$/))),
    "fall": Fall,
    "geolocation": S.optional(Geolocation),
    "id": S.String.pipe(S.pattern(/^-?\d+$/)),
    "mass": S.optional(S.String),
    "name": S.String,
    "nametype": Nametype,
    "recclass": S.String,
    "reclat": S.optional(S.String),
    "reclong": S.optional(S.String),
    "year": S.optional(S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/))),
}) {}

export const TopLevel = S.Array(TopLevelElement);
export type TopLevel = S.Schema.Type<typeof TopLevel>;
