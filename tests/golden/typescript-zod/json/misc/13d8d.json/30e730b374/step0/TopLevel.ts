import * as z from "zod";


export const StreetSchema = z.object({
    "id": z.number().int(),
    "name": z.string(),
});
export type Street = z.infer<typeof StreetSchema>;

export const OutcomeStatusSchema = z.object({
    "category": z.string(),
    "date": z.string(),
});
export type OutcomeStatus = z.infer<typeof OutcomeStatusSchema>;

export const LocationSchema = z.object({
    "latitude": z.string(),
    "longitude": z.string(),
    "street": StreetSchema,
});
export type Location = z.infer<typeof LocationSchema>;

export const TopLevelElementSchema = z.object({
    "category": z.string(),
    "context": z.string(),
    "id": z.number().int(),
    "location": LocationSchema,
    "location_subtype": z.string(),
    "location_type": z.string(),
    "month": z.string(),
    "outcome_status": OutcomeStatusSchema,
    "persistent_id": z.string(),
});
export type TopLevelElement = z.infer<typeof TopLevelElementSchema>;

export const TopLevelSchema = z.array(TopLevelElementSchema);
export type TopLevel = z.infer<typeof TopLevelSchema>;
