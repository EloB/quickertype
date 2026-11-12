import * as z from "zod";

// Comment delimiters:
// */
// {-
// -}
// """
// }
// }

export const KindSchema = z.enum([
    "ok",
]);
export type Kind = z.infer<typeof KindSchema>;

export const TopLevelSchema = z.object({
    "kind": KindSchema,
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
