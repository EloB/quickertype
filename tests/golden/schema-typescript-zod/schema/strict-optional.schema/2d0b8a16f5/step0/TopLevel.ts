import * as z from "zod";


export const TopLevelSchema = z.object({
    "foo": z.union([z.null(), z.number()]),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
