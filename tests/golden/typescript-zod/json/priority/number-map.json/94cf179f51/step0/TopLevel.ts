import * as z from "zod";


export const TopLevelSchema = z.object({
    "foo": z.record(z.string(), z.number()),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
