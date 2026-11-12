import * as z from "zod";


export const TopLevelSchema = z.object({
    "booleanValue": z.boolean(),
    "doubleValue": z.number(),
    "intValue": z.number().int(),
    "stringValue": z.string(),
    "uuidValue": z.string().uuid(),
    "uuidValues": z.array(z.string().uuid()),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
