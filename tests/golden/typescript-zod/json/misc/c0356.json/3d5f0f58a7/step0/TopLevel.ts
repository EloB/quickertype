import * as z from "zod";


export const DatumSchema = z.object({
    "anomaly": z.string(),
    "value": z.string(),
});
export type Datum = z.infer<typeof DatumSchema>;

export const DescriptionSchema = z.object({
    "base_period": z.string(),
    "missing": z.number().int(),
    "title": z.string(),
});
export type Description = z.infer<typeof DescriptionSchema>;

export const TopLevelSchema = z.object({
    "data": z.record(z.string(), DatumSchema),
    "description": DescriptionSchema,
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
