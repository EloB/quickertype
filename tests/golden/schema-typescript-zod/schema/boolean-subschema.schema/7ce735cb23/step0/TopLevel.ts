import * as z from "zod";


export const TopLevelSchema = z.object({
    "disallowed": z.any().optional(),
    "empty": z.array(z.any()),
    "foo": z.string(),
    "impossible": z.any().optional(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
