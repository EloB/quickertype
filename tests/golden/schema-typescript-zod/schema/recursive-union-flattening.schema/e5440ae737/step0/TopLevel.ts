import * as z from "zod";


export type XClass = {
    "x"?: Array<Array<any> | boolean | XClass | number | null | string> | boolean | number | Record<string, any> | null | string;
};
export const XClassSchema: z.ZodType<XClass> = z.lazy(() =>
    z.object({
        "x": z.union([z.null(), z.array(z.union([z.null(), z.array(z.any()), z.boolean(), XClassSchema, z.number(), z.string()])), z.boolean(), z.number(), z.record(z.string(), z.any()), z.string()]).optional(),
    })
);

export const TopLevelClassSchema = z.object({
    "x": z.union([z.null(), z.array(z.union([z.null(), z.array(z.any()), z.boolean(), XClassSchema, z.number(), z.string()])), z.boolean(), z.number(), z.record(z.string(), z.any()), z.string()]).optional(),
});
export type TopLevelClass = z.infer<typeof TopLevelClassSchema>;

export const TopLevelSchema = z.union([z.null(), z.array(z.union([z.null(), z.array(z.any()), z.boolean(), TopLevelClassSchema, z.number(), z.string()])), z.boolean(), z.number(), z.number().int(), z.record(z.string(), z.any()), z.string()]);
export type TopLevel = z.infer<typeof TopLevelSchema>;
