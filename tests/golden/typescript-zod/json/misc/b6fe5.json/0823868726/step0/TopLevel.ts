import * as z from "zod";


export const TopLevelSchema = z.object({
    "group": z.string(),
    "movie": z.string(),
    "movie-image": z.string(),
    "theater": z.string(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
