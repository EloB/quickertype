import * as z from "zod";


export const EmptySchema = z.object({
});
export type Empty = z.infer<typeof EmptySchema>;

export const TopLevelSchema = z.object({
    "empty": EmptySchema,
    "foo": z.string(),
    "bar": z.string().optional(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;
