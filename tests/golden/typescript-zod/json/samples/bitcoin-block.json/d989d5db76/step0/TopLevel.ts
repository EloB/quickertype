import * as z from "zod";


export const TopLevelSchema = z.object({
    "block_index": z.number().int(),
    "hash": z.string(),
    "height": z.number().int(),
    "time": z.number().int(),
    "txIndexes": z.array(z.number().int()),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
