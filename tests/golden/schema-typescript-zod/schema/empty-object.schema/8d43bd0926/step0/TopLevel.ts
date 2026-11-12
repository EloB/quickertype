import * as z from "zod";

export const TopLevelSchema = z.record(z.string(), z.any());
export type TopLevel = z.infer<typeof TopLevelSchema>;
