import * as z from "zod";


export const TextClassificationOutputElementSchema = z.object({
    "label": z.string(),
    "score": z.number(),
});
export type TextClassificationOutputElement = z.infer<typeof TextClassificationOutputElementSchema>;

export const TopLevelSchema = z.array(TextClassificationOutputElementSchema);
export type TopLevel = z.infer<typeof TopLevelSchema>;
