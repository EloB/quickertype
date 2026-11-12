import * as z from "zod";

export const TopLevelSchema = z.union([z.number(), z.number().int()]);
export type TopLevel = z.infer<typeof TopLevelSchema>;
