import * as z from "zod";


export const PcSchema = z.object({
    "count": z.number().int(),
    "label": z.string(),
    "peak24": z.number().int(),
});
export type Pc = z.infer<typeof PcSchema>;

export const TopLevelSchema = z.object({
    "pc": PcSchema,
    "ps3": PcSchema,
    "ps4": PcSchema,
    "xbox": PcSchema,
    "xone": PcSchema,
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
