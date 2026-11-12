import * as S from "effect/Schema";


export class OutcomeStatus extends S.Class<OutcomeStatus>("OutcomeStatus")({
    "category": S.String,
    "date": S.String,
}) {}

export class Street extends S.Class<Street>("Street")({
    "id": S.Int,
    "name": S.String,
}) {}

export class Location extends S.Class<Location>("Location")({
    "latitude": S.String,
    "longitude": S.String,
    "street": Street,
}) {}

export class TopLevelElement extends S.Class<TopLevelElement>("TopLevelElement")({
    "category": S.String,
    "context": S.String,
    "id": S.Int,
    "location": Location,
    "location_subtype": S.String,
    "location_type": S.String,
    "month": S.String,
    "outcome_status": OutcomeStatus,
    "persistent_id": S.String,
}) {}

export const TopLevel = S.Array(TopLevelElement);
export type TopLevel = S.Schema.Type<typeof TopLevel>;
