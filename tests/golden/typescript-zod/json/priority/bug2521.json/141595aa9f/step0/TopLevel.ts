import * as z from "zod";


export const OptionSchema = z.object({
    "foo": z.string().optional(),
    "name": z.string(),
});
export type Option = z.infer<typeof OptionSchema>;

export const TopLevelSchema = z.object({
    "options": z.array(OptionSchema),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
