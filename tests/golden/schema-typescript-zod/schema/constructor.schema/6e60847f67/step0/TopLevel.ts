import * as z from "zod";


export const ConstructorSchema = z.object({
});
export type Constructor = z.infer<typeof ConstructorSchema>;

export const TopLevelSchema = z.preprocess(value => typeof value === "object" && value !== null && !Array.isArray(value) ? Object.assign(Object.create(null), value) : value, z.object({
    "constructor": z.union([ConstructorSchema, z.number()]).optional(),
}));
export type TopLevel = z.infer<typeof TopLevelSchema>;
