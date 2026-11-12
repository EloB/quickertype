import * as z from "zod";


export const DescriptionSchema = z.object({
    "base_period": z.string(),
    "missing": z.string(),
    "title": z.string(),
    "units": z.string(),
});
export type Description = z.infer<typeof DescriptionSchema>;

export const TopLevelSchema = z.object({
    "data": z.record(z.string(), z.string()),
    "description": DescriptionSchema,
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
