import * as z from "zod";


export const HintsSchema = z.object({
});
export type Hints = z.infer<typeof HintsSchema>;

export const LabelsSchema = z.object({
    "AccountNumber": z.string(),
    "Title": z.string(),
});
export type Labels = z.infer<typeof LabelsSchema>;

export const TopLevelSchema = z.object({
    "Hints": HintsSchema,
    "Labels": LabelsSchema,
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
