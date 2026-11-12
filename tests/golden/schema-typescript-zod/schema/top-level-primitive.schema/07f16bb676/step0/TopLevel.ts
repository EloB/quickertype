import * as z from "zod";

export const TopLevelSchema = z.number();
export type TopLevel = z.infer<typeof TopLevelSchema>;
