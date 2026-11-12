import * as z from "zod";


export const TopLevelSchema = z.object({
    "trailingBackslash": z.string().optional(),
    "trailingQuote": z.string().optional(),
    "trailingTripleQuote": z.string().optional(),
    "value": z.string(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
