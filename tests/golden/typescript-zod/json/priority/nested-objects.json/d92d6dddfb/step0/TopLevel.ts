import * as z from "zod";


export const TopLevelSchema = z.object({
    "a": z.record(z.string(), z.number().int()),
    "b": z.record(z.string(), z.number().int()),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
