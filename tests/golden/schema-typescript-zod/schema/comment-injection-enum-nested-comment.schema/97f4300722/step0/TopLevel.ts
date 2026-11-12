import * as z from "zod";

// Nested enum block comment openers:
// {-
// /*
// This text must remain inside the generated enum documentation comment.

export const KindSchema = z.enum([
    "ok",
]);
export type Kind = z.infer<typeof KindSchema>;

export const TopLevelSchema = z.object({
    "kind": KindSchema,
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
