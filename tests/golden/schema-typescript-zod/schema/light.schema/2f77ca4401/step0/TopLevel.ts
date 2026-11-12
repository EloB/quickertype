import * as z from "zod";


export const LightParamsSchema = z.object({
    "app_id": z.string(),
    "outlet_id": z.string(),
    "rgba": z.string(),
});
export type LightParams = z.infer<typeof LightParamsSchema>;

export const TopLevelSchema = z.object({
    "LightParams": LightParamsSchema,
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
