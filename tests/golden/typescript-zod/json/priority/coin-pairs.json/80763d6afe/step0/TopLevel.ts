import * as z from "zod";


export const PairSchema = z.object({
    "decimal_places": z.number().int(),
    "fee": z.number(),
    "hidden": z.number().int(),
    "max_amount": z.number().int(),
    "max_price": z.number().int(),
    "min_amount": z.number(),
    "min_price": z.number(),
    "min_total": z.number(),
});
export type Pair = z.infer<typeof PairSchema>;

export const TopLevelSchema = z.object({
    "pairs": z.record(z.string(), PairSchema),
    "server_time": z.number().int(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
