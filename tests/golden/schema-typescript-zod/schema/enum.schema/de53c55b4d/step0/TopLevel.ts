import * as z from "zod";


export const OtherArrSchema = z.enum([
    "foo",
    "bar",
    "if",
]);
export type OtherArr = z.infer<typeof OtherArrSchema>;


export const GveSchema = z.enum([
    "good",
    "neutral",
    "evil",
]);
export type Gve = z.infer<typeof GveSchema>;


export const LvcSchema = z.enum([
    "lawful",
    "neutral",
    "chaotic",
]);
export type Lvc = z.infer<typeof LvcSchema>;

export const TopLevelSchema = z.object({
    "arr": z.array(z.union([OtherArrSchema, z.number().int()])).optional(),
    "for": z.string().optional(),
    "gve": GveSchema,
    "lvc": LvcSchema.optional(),
    "otherArr": z.array(OtherArrSchema).optional(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
