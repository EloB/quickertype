import * as z from "zod";


export const CodeSchema = z.enum([
    "sf",
]);
export type Code = z.infer<typeof CodeSchema>;


export const EnglishSchema = z.enum([
    "SF",
]);
export type English = z.infer<typeof EnglishSchema>;


export const ThaiSchema = z.enum([
    "เอสเอฟ",
]);
export type Thai = z.infer<typeof ThaiSchema>;


export const LocationSchema = z.enum([
    "",
    "5th Fl. Emporium",
]);
export type Location = z.infer<typeof LocationSchema>;


export const TelSchema = z.enum([
    "",
    "02-268-8899",
]);
export type Tel = z.infer<typeof TelSchema>;

export const GroupSchema = z.object({
    "code": CodeSchema,
    "english": EnglishSchema,
    "thai": ThaiSchema,
    "website": z.string(),
});
export type Group = z.infer<typeof GroupSchema>;

export const ResultSchema = z.object({
    "code": z.string().regex(/^-?\d+$/),
    "english": z.string(),
    "fav": z.boolean(),
    "group": GroupSchema,
    "location": LocationSchema,
    "min_screens": z.number().int(),
    "num_views": z.number().int(),
    "showtimes": z.string(),
    "stars": z.number().int(),
    "tel": TelSchema,
    "thai": z.string(),
    "today_screens": z.number().int(),
    "url": z.string(),
    "website": z.string(),
});
export type Result = z.infer<typeof ResultSchema>;

export const TopLevelSchema = z.object({
    "count": z.number().int(),
    "next": z.string(),
    "previous": z.null(),
    "results": z.array(ResultSchema),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
