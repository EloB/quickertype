import * as z from "zod";


export type TopLevel = {
    "also"?: TopLevel;
    "bar": boolean;
    "foo": number;
    "moo": number;
    "quux": string;
};
export const TopLevelSchema: z.ZodType<TopLevel> = z.lazy(() =>
    z.object({
        "also": TopLevelSchema.optional(),
        "bar": z.boolean(),
        "foo": z.number().int(),
        "moo": z.number(),
        "quux": z.string(),
    })
);
