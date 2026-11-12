import * as z from "zod";


export const TextSchema = z.enum([
    "Showers",
    "Mostly Sunny",
    "Partly Cloudy",
]);
export type Text = z.infer<typeof TextSchema>;

export const AstronomySchema = z.object({
    "sunrise": z.string(),
    "sunset": z.string(),
});
export type Astronomy = z.infer<typeof AstronomySchema>;

export const AtmosphereSchema = z.object({
    "humidity": z.string().regex(/^-?\d+$/),
    "pressure": z.string(),
    "rising": z.string().regex(/^-?\d+$/),
    "visibility": z.string(),
});
export type Atmosphere = z.infer<typeof AtmosphereSchema>;

export const ImageSchema = z.object({
    "height": z.string().regex(/^-?\d+$/),
    "link": z.string(),
    "title": z.string(),
    "url": z.string(),
    "width": z.string().regex(/^-?\d+$/),
});
export type Image = z.infer<typeof ImageSchema>;

export const ConditionSchema = z.object({
    "code": z.string().regex(/^-?\d+$/),
    "date": z.string(),
    "temp": z.string().regex(/^-?\d+$/),
    "text": z.string(),
});
export type Condition = z.infer<typeof ConditionSchema>;

export const ForecastSchema = z.object({
    "code": z.string().regex(/^-?\d+$/),
    "date": z.string(),
    "day": z.string(),
    "high": z.string().regex(/^-?\d+$/),
    "low": z.string().regex(/^-?\d+$/),
    "text": TextSchema,
});
export type Forecast = z.infer<typeof ForecastSchema>;

export const GuidSchema = z.object({
    "isPermaLink": z.enum(["true", "false"]),
});
export type Guid = z.infer<typeof GuidSchema>;

export const LocationSchema = z.object({
    "city": z.string(),
    "country": z.string(),
    "region": z.string(),
});
export type Location = z.infer<typeof LocationSchema>;

export const UnitsSchema = z.object({
    "distance": z.string(),
    "pressure": z.string(),
    "speed": z.string(),
    "temperature": z.string(),
});
export type Units = z.infer<typeof UnitsSchema>;

export const WindSchema = z.object({
    "chill": z.string().regex(/^-?\d+$/),
    "direction": z.string().regex(/^-?\d+$/),
    "speed": z.string().regex(/^-?\d+$/),
});
export type Wind = z.infer<typeof WindSchema>;

export const ItemSchema = z.object({
    "condition": ConditionSchema,
    "description": z.string(),
    "forecast": z.array(ForecastSchema),
    "guid": GuidSchema,
    "lat": z.string(),
    "link": z.string(),
    "long": z.string(),
    "pubDate": z.string(),
    "title": z.string(),
});
export type Item = z.infer<typeof ItemSchema>;

export const ChannelSchema = z.object({
    "astronomy": AstronomySchema,
    "atmosphere": AtmosphereSchema,
    "description": z.string(),
    "image": ImageSchema,
    "item": ItemSchema,
    "language": z.string(),
    "lastBuildDate": z.string(),
    "link": z.string(),
    "location": LocationSchema,
    "title": z.string(),
    "ttl": z.string().regex(/^-?\d+$/),
    "units": UnitsSchema,
    "wind": WindSchema,
});
export type Channel = z.infer<typeof ChannelSchema>;

export const ResultsSchema = z.object({
    "channel": ChannelSchema,
});
export type Results = z.infer<typeof ResultsSchema>;

export const QuerySchema = z.object({
    "count": z.number().int(),
    "created": z.string().pipe(z.coerce.date()),
    "lang": z.string(),
    "results": ResultsSchema,
});
export type Query = z.infer<typeof QuerySchema>;

export const TopLevelSchema = z.object({
    "query": QuerySchema,
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
