import * as z from "zod";


export const FrequencySchema = z.enum([
    "Weekly",
    "Monthly",
    "Annually",
]);
export type Frequency = z.infer<typeof FrequencySchema>;


export const TypeSchema = z.enum([
    "GrossSalaryAmount",
    "Overtime",
]);
export type Type = z.infer<typeof TypeSchema>;

export const TopLevelSchema = z.object({
    "amount": z.number(),
    "frequency": FrequencySchema,
    "description": z.string().optional(),
    "type": TypeSchema,
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
