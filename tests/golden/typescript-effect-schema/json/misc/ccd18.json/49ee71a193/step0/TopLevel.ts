import * as S from "effect/Schema";


export class Meta extends S.Class<Meta>("Meta")({
    "credit": S.String,
    "updated": S.String,
    "url": S.String,
}) {}

export class Weather extends S.Class<Weather>("Weather")({
    "meta": Meta,
    "temp": S.String,
    "visibility": S.Number,
    "weather": S.String,
    "wind": S.String,
}) {}

export class Status extends S.Class<Status>("Status")({
    "avgDelay": S.String,
    "closureBegin": S.String,
    "closureEnd": S.String,
    "endTime": S.String,
    "maxDelay": S.String,
    "minDelay": S.String,
    "reason": S.String,
    "trend": S.String,
    "type": S.String,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "city": S.String,
    "delay": S.Literal("true", "false"),
    "IATA": S.String,
    "ICAO": S.String,
    "name": S.String,
    "state": S.String,
    "status": Status,
    "weather": Weather,
}) {}
