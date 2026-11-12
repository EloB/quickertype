import * as z from "zod";

export const TopLevelSchema = z.record(z.string(), z.string());
export type TopLevel = z.infer<typeof TopLevelSchema>;
