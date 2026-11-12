import * as z from "zod";


export const TotalPopulationSchema = z.object({
    "date": z.string(),
    "population": z.number().int(),
});
export type TotalPopulation = z.infer<typeof TotalPopulationSchema>;

export const TopLevelSchema = z.object({
    "total_population": z.array(TotalPopulationSchema),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
