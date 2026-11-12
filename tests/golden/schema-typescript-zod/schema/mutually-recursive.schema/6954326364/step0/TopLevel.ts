import * as z from "zod";


export type Bar = {
    "foo": Array<TopLevel> | TopLevel;
};
export const BarSchema: z.ZodType<Bar> = z.lazy(() =>
    z.object({
        "foo": z.union([z.array(TopLevelSchema), TopLevelSchema]),
    })
);

export type TopLevel = {
    "bar"?: Bar;
};
export const TopLevelSchema: z.ZodType<TopLevel> = z.lazy(() =>
    z.object({
        "bar": BarSchema.optional(),
    })
);
