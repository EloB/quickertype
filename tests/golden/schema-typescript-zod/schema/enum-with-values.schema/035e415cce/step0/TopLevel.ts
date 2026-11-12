import * as z from "zod";


export const WeekdaysSchema = z.enum([
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
]);
export type Weekdays = z.infer<typeof WeekdaysSchema>;

export const TopLevelSchema = z.object({
    "weekdays": WeekdaysSchema,
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
