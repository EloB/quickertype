import * as z from "zod";


export const TopLevelSchema = z.enum([
    "one",
    "three",
    "two",
]);
export type TopLevel = z.infer<typeof TopLevelSchema>;
