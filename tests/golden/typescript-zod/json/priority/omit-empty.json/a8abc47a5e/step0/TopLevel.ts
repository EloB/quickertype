import * as z from "zod";


export const ResultSchema = z.object({
    "age": z.number().int(),
    "name": z.null().optional(),
});
export type Result = z.infer<typeof ResultSchema>;

export const TopLevelSchema = z.object({
    "results": z.array(ResultSchema),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
