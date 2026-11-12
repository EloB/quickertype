import * as z from "zod";


export const ItemSchema = z.object({
    "content": z.string().optional(),
    "id": z.string().optional(),
    "output": z.string().optional(),
    "summary": z.string().optional(),
});
export type Item = z.infer<typeof ItemSchema>;

export const TopLevelSchema = z.object({
    "input": z.array(ItemSchema),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
