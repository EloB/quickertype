import * as z from "zod";


export const TopLevelSchema = z.object({
    "maxOnly": z.array(z.number().int()).max(3),
    "minAndMax": z.array(z.number()).min(1).max(4),
    "minOnly": z.array(z.string()).min(2),
    "plain": z.array(z.string()),
    "unionItems": z.array(z.union([z.number().int(), z.string()])).min(2),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
