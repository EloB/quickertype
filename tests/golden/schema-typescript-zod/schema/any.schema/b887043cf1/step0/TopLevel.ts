import * as z from "zod";


export const TopLevelSchema = z.object({
    "foo": z.any(),
    "values": z.record(z.string(), z.any()),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
