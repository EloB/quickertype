import * as z from "zod";


export type TopLevel = {
    "data": number;
    "next": TopLevel | null;
};
export const TopLevelSchema: z.ZodType<TopLevel> = z.lazy(() =>
    z.object({
        "data": z.number().int(),
        "next": z.union([z.null(), TopLevelSchema]),
    })
);
