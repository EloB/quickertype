import * as z from "zod";


export type TopLevel = {
    "next"?: TopLevel;
};
export const TopLevelSchema: z.ZodType<TopLevel> = z.lazy(() =>
    z.object({
        "next": TopLevelSchema.optional(),
    })
);
