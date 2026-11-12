import * as z from "zod";


export const StateStateSchema = z.object({
    "state_id": z.string(),
    "state_name": z.string(),
});
export type StateState = z.infer<typeof StateStateSchema>;

export const StateElementSchema = z.object({
    "state": StateStateSchema,
});
export type StateElement = z.infer<typeof StateElementSchema>;

export const TopLevelSchema = z.object({
    "states": z.array(StateElementSchema),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
