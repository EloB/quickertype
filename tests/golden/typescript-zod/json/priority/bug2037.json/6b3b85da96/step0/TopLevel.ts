import * as z from "zod";


export const RewardSchema = z.object({
});
export type Reward = z.infer<typeof RewardSchema>;

export const ObjectiveSchema = z.object({
    "rewards": z.record(z.string(), RewardSchema),
});
export type Objective = z.infer<typeof ObjectiveSchema>;

export const MissionSpecSchema = z.object({
    "objectives": z.record(z.string(), ObjectiveSchema),
});
export type MissionSpec = z.infer<typeof MissionSpecSchema>;

export const TopLevelSchema = z.object({
    "mission_specs": z.record(z.string(), MissionSpecSchema),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
