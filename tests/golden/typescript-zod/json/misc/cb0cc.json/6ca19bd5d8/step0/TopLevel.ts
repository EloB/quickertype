import * as z from "zod";


export const CategorySchema = z.enum([
    "physics",
    "chemistry",
    "medicine",
    "literature",
    "peace",
    "economics",
]);
export type Category = z.infer<typeof CategorySchema>;

export const LaureateSchema = z.object({
    "firstname": z.string(),
    "id": z.string().regex(/^-?\d+$/),
    "motivation": z.string().optional(),
    "share": z.string().regex(/^-?\d+$/),
    "surname": z.string(),
});
export type Laureate = z.infer<typeof LaureateSchema>;

export const PrizeSchema = z.object({
    "category": CategorySchema,
    "laureates": z.array(LaureateSchema),
    "overallMotivation": z.string().optional(),
    "year": z.string().regex(/^-?\d+$/),
});
export type Prize = z.infer<typeof PrizeSchema>;

export const TopLevelSchema = z.object({
    "prizes": z.array(PrizeSchema),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
