import * as z from "zod";


export const ShortcutSchema = z.enum([
    "hidden",
    "visible",
]);
export type Shortcut = z.infer<typeof ShortcutSchema>;

export const TopLevelSchema = z.object({
    "name": z.string(),
    "shortcut": ShortcutSchema.optional(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
