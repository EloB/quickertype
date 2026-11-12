import * as z from "zod";


export const IssPositionSchema = z.object({
    "latitude": z.string(),
    "longitude": z.string(),
});
export type IssPosition = z.infer<typeof IssPositionSchema>;

export const TopLevelSchema = z.object({
    "iss_position": IssPositionSchema,
    "message": z.string(),
    "timestamp": z.number().int(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
