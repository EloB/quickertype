import * as z from "zod";


export const CoordinateSchema = z.object({
    "latitude": z.number(),
    "longitude": z.number(),
});
export type Coordinate = z.infer<typeof CoordinateSchema>;

export const TopLevelSchema = z.object({
    "coordinates": z.array(CoordinateSchema).optional(),
    "count": z.number().int().min(1).max(100).optional(),
    "label": z.string().refine(value => Array.from(value).length >= 2).refine(value => Array.from(value).length <= 16).optional(),
    "requiredCoordinates": z.array(CoordinateSchema),
    "requiredCount": z.number().int().min(1).max(100),
    "requiredLabel": z.string().refine(value => Array.from(value).length >= 2).refine(value => Array.from(value).length <= 16),
    "weight": z.number().min(0.5).max(99.5).optional(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
