import * as z from "zod";


export const StatusSchema = z.object({
    "avgDelay": z.string(),
    "closureBegin": z.string(),
    "closureEnd": z.string(),
    "endTime": z.string(),
    "maxDelay": z.string(),
    "minDelay": z.string(),
    "reason": z.string(),
    "trend": z.string(),
    "type": z.string(),
});
export type Status = z.infer<typeof StatusSchema>;

export const MetaSchema = z.object({
    "credit": z.string(),
    "updated": z.string(),
    "url": z.string(),
});
export type Meta = z.infer<typeof MetaSchema>;

export const WeatherSchema = z.object({
    "meta": MetaSchema,
    "temp": z.string(),
    "visibility": z.number(),
    "weather": z.string(),
    "wind": z.string(),
});
export type Weather = z.infer<typeof WeatherSchema>;

export const TopLevelSchema = z.object({
    "city": z.string(),
    "delay": z.enum(["true", "false"]),
    "IATA": z.string(),
    "ICAO": z.string(),
    "name": z.string(),
    "state": z.string(),
    "status": StatusSchema,
    "weather": WeatherSchema,
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
