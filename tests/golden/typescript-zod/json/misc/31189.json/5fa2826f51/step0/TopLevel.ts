import * as z from "zod";


export const RatesSchema = z.object({
    "parking": z.number().optional(),
    "reduced": z.number().optional(),
    "reduced1": z.number().optional(),
    "reduced2": z.number().optional(),
    "standard": z.number(),
    "super_reduced": z.number().optional(),
});
export type Rates = z.infer<typeof RatesSchema>;

export const PeriodSchema = z.object({
    "effective_from": z.string(),
    "rates": RatesSchema,
});
export type Period = z.infer<typeof PeriodSchema>;

export const RateSchema = z.object({
    "code": z.string(),
    "country_code": z.string(),
    "name": z.string(),
    "periods": z.array(PeriodSchema),
});
export type Rate = z.infer<typeof RateSchema>;

export const TopLevelSchema = z.object({
    "details": z.string(),
    "rates": z.array(RateSchema),
    "version": z.null(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
