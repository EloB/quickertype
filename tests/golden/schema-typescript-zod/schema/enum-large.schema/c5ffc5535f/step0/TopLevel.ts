import * as z from "zod";


export const CallsignSchema = z.enum([
    "alpha",
    "bravo",
    "charlie",
    "delta",
    "echo",
    "foxtrot",
    "golf",
    "hotel",
    "india",
    "juliett",
    "kilo",
    "lima",
    "mike",
    "november",
    "oscar",
    "papa",
    "quebec",
    "romeo",
    "sierra",
    "tango",
]);
export type Callsign = z.infer<typeof CallsignSchema>;


export const PrioritySchema = z.enum([
    "low",
    "medium",
    "high",
]);
export type Priority = z.infer<typeof PrioritySchema>;

export const TopLevelSchema = z.object({
    "callsign": CallsignSchema,
    "priority": PrioritySchema,
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
