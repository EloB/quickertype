import * as z from "zod";


export const HealthSchema = z.enum([
    "ok",
    "error",
]);
export type Health = z.infer<typeof HealthSchema>;

export const TopLevelSchema = z.object({
    "health": HealthSchema,
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
