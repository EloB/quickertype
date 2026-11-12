import * as z from "zod";


export const TopLevelSchema = z.object({
    "above_i32_max": z.number().int().min(0).max(2147483648),
    "below_i32_min": z.number().int().min(-2147483649).max(0),
    "i32_range": z.number().int().min(-2147483648).max(2147483647),
    "large_bounds": z.number().int().min(-9007199254740991).max(9007199254740991),
    "only_maximum": z.number().int().max(0),
    "only_minimum": z.number().int().min(0),
    "small_negative": z.number().int().min(-100).max(0),
    "small_positive": z.number().int().min(0).max(100),
    "unbounded": z.number().int(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
