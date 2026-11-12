import * as S from "effect/Schema";


export const Text = S.Literal(
    "Thunderstorms",
);
export type Text = S.Schema.Type<typeof Text>;

export class Wind extends S.Class<Wind>("Wind")({
    "chill": S.String.pipe(S.pattern(/^-?\d+$/)),
    "direction": S.String.pipe(S.pattern(/^-?\d+$/)),
    "speed": S.String.pipe(S.pattern(/^-?\d+$/)),
}) {}

export class Units extends S.Class<Units>("Units")({
    "distance": S.String,
    "pressure": S.String,
    "speed": S.String,
    "temperature": S.String,
}) {}

export class Location extends S.Class<Location>("Location")({
    "city": S.String,
    "country": S.String,
    "region": S.String,
}) {}

export class Guid extends S.Class<Guid>("Guid")({
    "isPermaLink": S.Literal("true", "false"),
}) {}

export class Forecast extends S.Class<Forecast>("Forecast")({
    "code": S.String.pipe(S.pattern(/^-?\d+$/)),
    "date": S.String,
    "day": S.String,
    "high": S.String.pipe(S.pattern(/^-?\d+$/)),
    "low": S.String.pipe(S.pattern(/^-?\d+$/)),
    "text": Text,
}) {}

export class Condition extends S.Class<Condition>("Condition")({
    "code": S.String.pipe(S.pattern(/^-?\d+$/)),
    "date": S.String,
    "temp": S.String.pipe(S.pattern(/^-?\d+$/)),
    "text": S.String,
}) {}

export class Item extends S.Class<Item>("Item")({
    "condition": Condition,
    "description": S.String,
    "forecast": S.Array(Forecast),
    "guid": Guid,
    "lat": S.String,
    "link": S.String,
    "long": S.String,
    "pubDate": S.String,
    "title": S.String,
}) {}

export class Image extends S.Class<Image>("Image")({
    "height": S.String.pipe(S.pattern(/^-?\d+$/)),
    "link": S.String,
    "title": S.String,
    "url": S.String,
    "width": S.String.pipe(S.pattern(/^-?\d+$/)),
}) {}

export class Atmosphere extends S.Class<Atmosphere>("Atmosphere")({
    "humidity": S.String.pipe(S.pattern(/^-?\d+$/)),
    "pressure": S.String,
    "rising": S.String.pipe(S.pattern(/^-?\d+$/)),
    "visibility": S.String,
}) {}

export class Astronomy extends S.Class<Astronomy>("Astronomy")({
    "sunrise": S.String,
    "sunset": S.String,
}) {}

export class Channel extends S.Class<Channel>("Channel")({
    "astronomy": Astronomy,
    "atmosphere": Atmosphere,
    "description": S.String,
    "image": Image,
    "item": Item,
    "language": S.String,
    "lastBuildDate": S.String,
    "link": S.String,
    "location": Location,
    "title": S.String,
    "ttl": S.String.pipe(S.pattern(/^-?\d+$/)),
    "units": Units,
    "wind": Wind,
}) {}

export class Results extends S.Class<Results>("Results")({
    "channel": Channel,
}) {}

export class Query extends S.Class<Query>("Query")({
    "count": S.Int,
    "created": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
    "lang": S.String,
    "results": Results,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "query": Query,
}) {}
