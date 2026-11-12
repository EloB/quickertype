import * as z from "zod";


export const TopLevelSchema = z.object({
    "boolean": z.boolean(),
    "integer": z.number().int(),
    "integers": z.array(z.number().int()),
    "number": z.number(),
    "string": z.string(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
