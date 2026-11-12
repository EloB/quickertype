import * as z from "zod";


export const CategorySchema = z.enum([
    " ",
    "",
]);
export type Category = z.infer<typeof CategorySchema>;

export const TopLevelElementSchema = z.object({
    "category": CategorySchema,
});
export type TopLevelElement = z.infer<typeof TopLevelElementSchema>;

export const TopLevelSchema = z.array(TopLevelElementSchema);
export type TopLevel = z.infer<typeof TopLevelSchema>;
