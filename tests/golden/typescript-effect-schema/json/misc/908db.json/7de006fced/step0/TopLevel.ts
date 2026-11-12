import * as S from "effect/Schema";


export class StateState extends S.Class<StateState>("StateState")({
    "state_id": S.String,
    "state_name": S.String,
}) {}

export class StateElement extends S.Class<StateElement>("StateElement")({
    "state": StateState,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "states": S.Array(StateElement),
}) {}
