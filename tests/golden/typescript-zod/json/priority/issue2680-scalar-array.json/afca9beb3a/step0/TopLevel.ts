import * as z from "zod";

export const TopLevelSchema = z.array(z.number().int());
export type TopLevel = z.infer<typeof TopLevelSchema>;
