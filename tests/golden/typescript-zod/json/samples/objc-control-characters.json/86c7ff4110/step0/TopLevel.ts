import * as z from "zod";


export const ValueSchema = z.enum([
    "c0\u0001\u001b\u001f",
    "c1\u007f\u0080\u0085\u009f",
]);
export type Value = z.infer<typeof ValueSchema>;

export const TopLevelSchema = z.object({
    "literal": z.string(),
    "#{1+1}": z.number().int(),
    "values": z.array(ValueSchema),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
