import * as z from "zod";


export const GenderSchema = z.enum([
    "male",
    "female",
    "org",
]);
export type Gender = z.infer<typeof GenderSchema>;


export const CategorySchema = z.enum([
    "physics",
    "chemistry",
    "peace",
    "medicine",
    "literature",
    "economics",
]);
export type Category = z.infer<typeof CategorySchema>;

export const AffiliationClassSchema = z.object({
    "city": z.string().optional(),
    "country": z.string().optional(),
    "name": z.string().optional(),
});
export type AffiliationClass = z.infer<typeof AffiliationClassSchema>;

export const PrizeSchema = z.object({
    "affiliations": z.array(z.union([z.array(z.any()), AffiliationClassSchema])),
    "category": CategorySchema.optional(),
    "motivation": z.string().optional(),
    "overallMotivation": z.string().optional(),
    "share": z.string().regex(/^-?\d+$/).optional(),
    "year": z.string().regex(/^-?\d+$/).optional(),
});
export type Prize = z.infer<typeof PrizeSchema>;

export const LaureateSchema = z.object({
    "born": z.string(),
    "bornCity": z.string().optional(),
    "bornCountry": z.string().optional(),
    "bornCountryCode": z.string().optional(),
    "died": z.string(),
    "diedCity": z.string().optional(),
    "diedCountry": z.string().optional(),
    "diedCountryCode": z.string().optional(),
    "firstname": z.string().optional(),
    "gender": GenderSchema,
    "id": z.string().regex(/^-?\d+$/),
    "prizes": z.array(PrizeSchema),
    "surname": z.string().optional(),
});
export type Laureate = z.infer<typeof LaureateSchema>;

export const TopLevelSchema = z.object({
    "laureates": z.array(LaureateSchema),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
