import * as z from "zod";


export const TopLevelSchema = z.object({
    "minMaxLength": z.string().refine(value => Array.from(value).length >= 5).refine(value => Array.from(value).length <= 5),
    "percent": z.number().min(0).max(1),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
